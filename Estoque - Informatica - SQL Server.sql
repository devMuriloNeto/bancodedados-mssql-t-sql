-- criar o database
CREATE DATABASE Informatica;
USE Informatica;

-- criar a tabela de Cargos
CREATE TABLE Cargos (
    id INT NOT NULL AUTO_INCREMENT,
    nome_cargo VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- criar a tabela de Colaboradores
CREATE TABLE Colaboradores (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    id_cargo INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_cargo) REFERENCES Cargos(id)
);

-- criar a tabela de Equipamentos
CREATE TABLE Equipamentos (
    id INT NOT NULL AUTO_INCREMENT,
    nome_equipamento VARCHAR(255) NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    quantidade INT DEFAULT 0,
    PRIMARY KEY (id),
    CHECK (tipo IN ('AF', 'Comum'))
);

-- criar a tabela de Ativos Fixos
CREATE TABLE AtivosFixos (
    id INT NOT NULL AUTO_INCREMENT,
    id_equipamento INT NOT NULL,
    ativo_fixo VARCHAR(50) NOT NULL,
    status VARCHAR(15) DEFAULT 'Disponível',
    PRIMARY KEY (id),
    FOREIGN KEY (id_equipamento) REFERENCES Equipamentos(id),
    CHECK (status IN ('Disponível', 'Em uso'))
);

-- criar a tabela de Itens Alocados
CREATE TABLE ItensAlocados (
    id INT NOT NULL AUTO_INCREMENT,
    id_colaborador INT NOT NULL,
    id_equipamento INT NOT NULL,
    quantidade INT DEFAULT 1,
    data_alocacao DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (id_colaborador) REFERENCES Colaboradores(id),
    FOREIGN KEY (id_equipamento) REFERENCES Equipamentos(id)
);

-- criar a tabela de Ativos Alocados
CREATE TABLE AtivosAlocados (
    id INT NOT NULL AUTO_INCREMENT,
    id_colaborador INT NOT NULL,
    id_ativo_fixo INT NOT NULL,
    data_alocacao DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (id_colaborador) REFERENCES Colaboradores(id),
    FOREIGN KEY (id_ativo_fixo) REFERENCES AtivosFixos(id)
);
