DROP DATABASE IF EXISTS clinica_vet;
CREATE DATABASE clinica_vet CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE clinica_vet;

CREATE TABLE tutor (
    id_tutor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(15),
    email VARCHAR(100),
    data_cadastro DATE NOT NULL
);

-- 1:1 com tutor (a PK tambem e FK)
CREATE TABLE endereco_tutor (
    id_tutor INT PRIMARY KEY,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    bairro VARCHAR(60),
    cidade VARCHAR(60) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep CHAR(8),
    FOREIGN KEY (id_tutor) REFERENCES tutor(id_tutor)
        ON DELETE CASCADE
);

CREATE TABLE especie (
    id_especie INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

-- 1:N com tutor e com especie
CREATE TABLE pet (
    id_pet INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    data_nascimento DATE,
    sexo CHAR(1),
    peso DECIMAL(5,2),
    id_tutor INT NOT NULL,
    id_especie INT NOT NULL,
    FOREIGN KEY (id_tutor) REFERENCES tutor(id_tutor),
    FOREIGN KEY (id_especie) REFERENCES especie(id_especie)
);

CREATE TABLE veterinario (
    id_veterinario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crmv VARCHAR(15) NOT NULL UNIQUE,
    telefone VARCHAR(15)
);

CREATE TABLE especialidade (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL UNIQUE
);

-- N:N veterinario x especialidade
CREATE TABLE veterinario_especialidade (
    id_veterinario INT NOT NULL,
    id_especialidade INT NOT NULL,
    PRIMARY KEY (id_veterinario, id_especialidade),
    FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario),
    FOREIGN KEY (id_especialidade) REFERENCES especialidade(id_especialidade)
);

-- 1:N com pet e com veterinario
CREATE TABLE consulta (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    motivo VARCHAR(200),
    valor DECIMAL(8,2) NOT NULL,
    id_pet INT NOT NULL,
    id_veterinario INT NOT NULL,
    FOREIGN KEY (id_pet) REFERENCES pet(id_pet),
    FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario)
);

CREATE TABLE procedimento (
    id_procedimento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    preco DECIMAL(8,2) NOT NULL
);

-- N:N consulta x procedimento (com atributo proprio: quantidade)
CREATE TABLE consulta_procedimento (
    id_consulta INT NOT NULL,
    id_procedimento INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_consulta, id_procedimento),
    FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta),
    FOREIGN KEY (id_procedimento) REFERENCES procedimento(id_procedimento)
);
