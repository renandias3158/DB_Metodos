CREATE SCHEMA db_metodos;
USE db_metodos;

-- =========================
-- TABELAS
-- =========================

CREATE TABLE usuario(
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    email VARCHAR(80) UNIQUE
);

CREATE TABLE metodo(
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
    disciplina VARCHAR(50) UNIQUE NOT NULL,
    id_usuario INT NOT NULL,
    id_metodo INT NOT NULL,
    id_referencias INT NOT NULL,
    tempo_gasto INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_metodo) REFERENCES metodo(id_metodo),
    FOREIGN KEY (id_referencias) REFERENCES referencias(id)
);

CREATE TABLE assunto_playlist(
    combin INT PRIMARY KEY,
    id_play INT NOT NULL,
    id_m INT NOT NULL,
    FOREIGN KEY (id_play) REFERENCES playlist(id),
    FOREIGN KEY (id_m) REFERENCES assunto(ID_m)
);
