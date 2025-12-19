
CREATE SCHEMA db2_metodos;
USE db2_metodos;

-- =====================
-- TABELAS
-- =====================

CREATE TABLE usuario(
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    email VARCHAR(80) UNIQUE NOT NULL
);

CREATE TABLE metodo_estudo(
    id_metodo INT PRIMARY KEY,
    nome_metodo VARCHAR(50) NOT NULL,
    conceito VARCHAR(300),
    estrategia_revisao VARCHAR(150),
    percentual_foco FLOAT,
    tempo_trabalho INT,
    tempo_descanso INT,
    ciclos INT
);

CREATE TABLE referencias(
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    referencias_link VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE playlist(
    id INT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL,
    link_p VARCHAR(150) NOT NULL
);

CREATE TABLE assunto(
    id_m INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    disciplina VARCHAR(50) NOT NULL,
    id_usuario INT NOT NULL,
    id_metodo INT NOT NULL,
    id_referencias INT NOT NULL,
    tempo_gasto INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_metodo) REFERENCES metodo_estudo(id_metodo),
    FOREIGN KEY (id_referencias) REFERENCES referencias(id)
);

CREATE TABLE assunto_playlist(
    combin INT PRIMARY KEY,
    id_play INT NOT NULL,
    id_m INT NOT NULL,
    FOREIGN KEY (id_play) REFERENCES playlist(id),
    FOREIGN KEY (id_m) REFERENCES assunto(id_m)
);

-- =====================
-- POVOAMENTO
-- =====================

INSERT INTO usuario VALUES
(1,'Renan','senha1','renan@email.com'),
(2,'Ana','senha2','ana@email.com'),
(3,'Lucas','senha3','lucas@email.com'),
(4,'Beatriz','senha4','bia@email.com'),
(5,'Marcos','senha5','marcos@email.com'),
(6,'João','senha6','joao@email.com'),
(7,'Clara','senha7','clara@email.com'),
(8,'Rafael','senha8','rafa@email.com'),
(9,'Livia','senha9','livia@email.com'),
(10,'Paulo','senha10','paulo@email.com');

-- SOMENTE 3 MÉTODOS

INSERT INTO metodo_estudo VALUES
(1,'Pomodoro','Trabalho focado com pausas','Revisão a cada ciclo',NULL,25,5,4),
(2,'Feynman','Explicar para aprender','Criar analogias',NULL,NULL,NULL,NULL),
(3,'Pareto','Focar nos 20% mais relevantes','Revisão semanal',80,NULL,NULL,NULL);

INSERT INTO referencias VALUES
(1,'Guia Pomodoro','link1.com'),
(2,'Técnica Feynman','link2.com'),
(3,'Regra Pareto','link3.com'),
(4,'Estudo Concentrado','link4.com'),
(5,'Aprendizado Ativo','link5.com'),
(6,'Organização de Estudos','link6.com'),
(7,'Planejamento de Tempo','link7.com'),
(8,'Rotina de Estudos','link8.com'),
(9,'Foco e Produtividade','link9.com'),
(10,'Revisão Eficiente','link10.com');

INSERT INTO playlist VALUES
(1,'Pomodoro 25/5','p1.com'),
(2,'Foco Total','p2.com'),
(3,'Músicas de Estudo','p3.com'),
(4,'Lo-fi Relax','p4.com'),
(5,'Barulho de chuva','p5.com'),
(6,'Instrumental','p6.com'),
(7,'Clássico','p7.com'),
(8,'Deep Focus','p8.com'),
(9,'Neurobeats','p9.com'),
(10,'Ambient Study','p10.com');

-- ASSUNTOS REPETINDO OS MESMOS MÉTODOS (1xN)

INSERT INTO assunto VALUES
(1,'Matemática Básica','Matemática',1,1,1,120),
(2,'Cálculo I','Matemática',1,1,1,90),
(3,'Álgebra','Matemática',2,1,4,80),
(4,'Física I','Física',3,2,2,150),
(5,'Física II','Física',3,2,5,200),
(6,'Programação I','Computação',4,3,3,300),
(7,'Programação II','Computação',4,3,6,280),
(8,'Banco de Dados','Computação',5,3,7,250),
(9,'História Geral','História',6,2,8,110),
(10,'Geografia','Geografia',7,1,9,130);

-- NxN: ASSUNTO ↔ PLAYLIST

INSERT INTO assunto_playlist VALUES
(1,1,1),
(2,1,2),
(3,2,1),
(4,2,6),
(5,3,6),
(6,4,4),
(7,5,4),
(8,6,3),
(9,6,7),
(10,7,7),
(11,8,2),
(12,8,3),
(13,9,5),
(14,10,1),
(15,10,5);

select * from assunto;
select * from metodo_estudo;

-- Nomes dos 3 assuntos com tempo gasto de aula menor que 125 em ordem do menor para o maior:
select nome from assunto where tempo_gasto < 125 ORDER BY tempo_gasto ASC LIMIT 3;


-- Nomes dos métodos não repetidos que possuem o tempo de trabalho registrado:
select distinct(nome_metodo) from metodo_estudo where tempo_trabalho is not null;


-- Nome dos usuários onde o tempo gasto de suas matérias seje maior ou igual a 120, porém entre 80 e 150
select nome from usuario where id in(select id_usuario from assunto where tempo_gasto >= 120 and tempo_gasto between 80 and 150);

-- Quais usuários fazem uso de métodos de estudo com tempo de trabalho menor ou igual a 30 minutos, diferentes do método Pomodoro e que possuam conceito cadastrado?
SELECT nome FROM usuario WHERE id IN (SELECT id_usuario FROM assunto WHERE id_metodo IN (SELECT id_metodo FROM metodo_estudo WHERE tempo_trabalho <= 30 AND nome_metodo <> 'Pomodoro' AND conceito IS NOT NULL));

-- Qual o nome da primeira pessoa em ordem alfabética ao contrário que aprende Matemática?
SELECT nome
FROM usuario
WHERE id IN (
    SELECT id_usuario
    FROM assunto
    WHERE disciplina = 'Matemática'
)
ORDER BY nome DESC
LIMIT 1;

-- Quantos usuários usam o método Pomodoro com um tempo de estudo ativo maior que 25 minutos?
SELECT COUNT(*) 
FROM usuario 
WHERE id 
IN (SELECT id_usuario 
FROM assunto 
WHERE tempo_gasto > 25 and id_metodo = 1);

-- Quais são os nomes e os e-mails dos usuários que estudaram pelo menos um assunto e cujo tempo total de estudo é maior que 200 minutos?
SELECT 
    u.nome,
    u.email
FROM usuario u
INNER JOIN assunto a
    ON u.id = a.id_usuario
GROUP BY u.id, u.nome, u.email
HAVING SUM(a.tempo_gasto) > 200
ORDER BY u.nome;

-- Quais usuários estudaram assuntos cujo tempo gasto foi menor ou igual a 120 minutos, que não pertencem à disciplina de Matemática e que utilizaram métodos de estudo diferentes do método Pomodoro?

SELECT nome
FROM usuario
WHERE id IN (
    SELECT id_usuario
    FROM assunto
    WHERE tempo_gasto <= 120
      AND NOT disciplina = 'Matemática'
      AND id_metodo IN (
          SELECT id_metodo
          FROM metodo_estudo
          WHERE nome_metodo <> 'Pomodoro'
      )
);

-- Quais métodos de estudo não possuem tempo de trabalho definido ou não possuem tempo de descanso definido?
SELECT nome_metodo FROM metodo_estudo WHERE tempo_trabalho IS NULL OR tempo_descanso IS NULL;
