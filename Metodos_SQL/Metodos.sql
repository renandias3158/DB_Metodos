create schema db_metodos;
use db_metodos;

create table usuario(
    id int primary key,
    nome varchar(30) not null,
    senha varchar(15) not null,
    email varchar(30) unique not null
);

create table metodo(
    id int primary key,
    nome varchar(30) not null
);

create table referencias(
    id int primary key,
    nome varchar(30) not null,
    referencias_link varchar(30) unique not null
);

create table playlist(
    id int primary key,
    nome varchar(30) unique not null,
    link_playlist varchar(30) not null
);

create table Assunto(
    ID_m int primary key,
    nome varchar(30) unique not null,
    disciplina varchar(30) unique not null,
    id_usuario int not null,
    foreign key (id_usuario) references usuario(id)
);

create table assunto_metodo(
    id_assunto int not null,
    id_metodo int not null,
    primary key (id_assunto, id_metodo),
    foreign key (id_assunto) references Assunto(ID_m),
    foreign key (id_metodo) references metodo(id)
);

create table assunto_referencias(
    id_assunto int not null,
    id_referencia int not null,
    primary key (id_assunto, id_referencia),
    foreign key (id_assunto) references Assunto(ID_m),
    foreign key (id_referencia) references referencias(id)
);

create table assunto_playlist(
    id_assunto int not null,
    id_playlist int not null,
    primary key (id_assunto, id_playlist),
    foreign key (id_assunto) references Assunto(ID_m),
    foreign key (id_playlist) references playlist(id)
);

create table pareto(
    id_metodo int primary key,
    percentual_foco float not null,
    impacto varchar(30) not null,
    foreign key (id_metodo) references metodo(id)
);

create table pomodoro(
    id_metodo int primary key,
    tempo_trabalho int not null,
    tempo_descanso int not null,
    ciclos int not null,
    foreign key (id_metodo) references metodo(id)
);

create table feyn(
    id_metodo int primary key,
    conceito varchar(300),
    modo_explicacao varchar(75),
    estrategia_revisao int, --carol, é inteiro porque existem passos da estrategia já numerados.
    foreign key (id_metodo) references metodo(id)
);
