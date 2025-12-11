CREATE SCHEMA db2_metodos;
USE db2_metodos;

-- Tabelas

CREATE TABLE usuario(
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    email VARCHAR(80) UNIQUE
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
    ID_m INT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL,
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
    combinacao INT PRIMARY KEY,
    id_play INT NOT NULL,
    id_m INT NOT NULL,
    FOREIGN KEY (id_play) REFERENCES playlist(id),
    FOREIGN KEY (id_m) REFERENCES assunto(ID_m)
);


-- INSERTS(povoamento do BD)

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

INSERT INTO metodo_estudo VALUES
(1,'Pomodoro','Trabalho focado com pausas','Revisão a cada ciclo',50,25,5,4),
(2,'Feynman','Explicar para aprender','Criar analogias',40,30,3,3),
(3,'Pareto','Focar nos 20% mais relevantes','Revisão semanal',80,30,10,1),
(4,'Mapas Mentais','Organização visual','Rever mapas',60,15,8,3),
(5,'Active Recall','Puxar da memória','Revisões espaçadas',95,20,2,0),
(6,'Flashcards','Estudo rápido','Revisão SRS',74,45,5,3),
(7,'SQ3R','Leitura estruturada','Reler e resumir',66,10,20,6),
(8,'Leitura Dinâmica','Aumento da velocidade','Prática guiada',93,23,6,7),
(9,'Cornell Notes','Notas estruturadas','Resumo final',67,10,55,1),
(10,'Repetição espaçada','Revisões longas','Aumentar intervalo',81,3,7,2);

INSERT INTO referencias VALUES
(1,'Guia Pomodoro','link1.com'),
(2,'Técnica Feynman','link2.com'),
(3,'Regra Pareto','link3.com'),
(4,'Mind Maps','link4.com'),
(5,'Active Recall Explicado','link5.com'),
(6,'Flashcards Anki','link6.com'),
(7,'Método SQ3R','link7.com'),
(8,'Curso Leitura Dinâmica','link8.com'),
(9,'Cornell Notes Tutorial','link9.com'),
(10,'Spaced Repetition','link10.com');

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

INSERT INTO assunto VALUES
(1,'Matemática Básica','Matemática',1,1,1,120),
(2,'Cálculo I','Matemática',2,2,2,90),
(3,'História Geral','História',3,3,3,80),
(4,'Física I','Física',4,4,4,150),
(5,'Química','Química',5,5,5,200),
(6,'Biologia Celular','Biologia',6,6,6,110),
(7,'Programação','Computação',7,7,7,300),
(8,'Banco de Dados','Computação',8,8,8,250),
(9,'Inglês','Idiomas',9,9,9,100),
(10,'Geografia','Geografia',10,10,10,130);

INSERT INTO assunto_playlist VALUES
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5),
(6,6,6),
(7,7,7),
(8,8,8),
(9,9,9),
(10,10,10);
