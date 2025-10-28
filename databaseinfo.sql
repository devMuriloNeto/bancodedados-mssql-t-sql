-- Criar o banco de dados
CREATE DATABASE Informatica;
GO

USE Informatica;
GO

-- Criar as tabelas

-- Criar a tabela de Cargos
CREATE TABLE Cargos (
    id INT IDENTITY(1,1) NOT NULL,
    nome_cargo VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- Criar a tabela de Colaboradores
CREATE TABLE Colaboradores (
    id INT IDENTITY(1,1) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    id_cargo INT NOT NULL,
    FOREIGN KEY (id_cargo) REFERENCES Cargos(id),
    PRIMARY KEY (id)
);

-- Criar a tabela de equipamentos
CREATE TABLE Equipamentos (
    id INT IDENTITY(1,1) NOT NULL,
    nome_equipamento VARCHAR(255) NOT NULL,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('AF', 'Comum')),
    quantidade INT DEFAULT 0,
    PRIMARY KEY (id)
);

-- Criar a tabela de Ativos Fixos
CREATE TABLE AtivosFixos (
    id INT IDENTITY(1,1) NOT NULL,
    id_equipamento INT NOT NULL,
    ativo_fixo VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_equipamento) REFERENCES Equipamentos(id)
);

-- Realizar os inserts nas tabelas

INSERT INTO Cargos (nome_cargo)
VALUES
  ('Assistente de TI'), ('Analista de Sistemas'), ('Analista de Suporte'), ('Supervisor de TI'), ('Gerente de TI');

INSERT INTO Colaboradores (nome, sobrenome, id_cargo)
VALUES
  ('Bruno', 'Henrique', 1), ('Andre', 'Novais', 2), ('Alexandre', 'Ferreira', 2), ('Akiles', 'Goncalves', 3), ('Josimar', 'Neto', 4), ('Murilo', 'Mendes', 1), ('Jose', 'da Costa', 5);

INSERT INTO Equipamentos (nome_equipamento, tipo, quantidade)
VALUES
  ('Notebook', 'AF', 7), ('Monitor', 'AF', 8), ('Teclado', 'Comum', 7), ('Mouse', 'Comum', 7), ('Headset', 'Comum', 7);

INSERT INTO AtivosFixos (id_equipamento, ativo_fixo)
VALUES
  (1, 'AF-001'), (1, 'AF-002'), (1, 'AF-003'), (1, 'AF-004'), (1, 'AF-005'), (1, 'AF-006'), (1, 'AF-007'),
  (2, 'AF-008'), (2, 'AF-009'), (2, 'AF-010'), (2, 'AF-011'), (2, 'AF-012'), (2, 'AF-013'), (2, 'AF-014'),
  (2, 'AF-015');

-- Validar tabelas

SELECT * FROM Cargos;
SELECT * FROM Colaboradores;
SELECT * FROM Equipamentos;
SELECT * FROM AtivosFixos;

-- Consultar colaborador e cargo

SELECT (co.nome + ' ' + co.sobrenome) AS colaborador, co.id_cargo, ca.nome_cargo
FROM Colaboradores as co
JOIN Cargos ca ON co.id_cargo = ca.id;

-- Alocar itens para os colaboradores

CREATE TABLE ItensAlocados (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_colaborador INT NOT NULL,
    id_equipamento INT NOT NULL,
    quantidade INT DEFAULT 1,
    data_alocacao DATE DEFAULT GETDATE(),
    FOREIGN KEY (id_colaborador) REFERENCES Colaboradores(id),
    FOREIGN KEY (id_equipamento) REFERENCES Equipamentos(id)
);

INSERT INTO ItensAlocados (id_colaborador, id_equipamento)
VALUES
(1, 1), (1, 2), (1, 3), (1, 4),  -- Bruno recebe Notebook, Monitor, Teclado e Mouse
(2, 1), (2, 2), (2, 3), (2, 4),  -- Andre recebe Notebook, Monitor, Teclado e Mouse
(3, 1), (3, 2), (3, 3), (3, 4),  -- Alexandre recebe Notebook, Monitor, Teclado e Mouse
(4, 1), (4, 2), (4, 3), (4, 4),  -- Akiles recebe Notebook, Monitor, Teclado e Mouse
(5, 1), (5, 2), (5, 3), (5, 4),  -- Josimar recebe Notebook, Monitor, Teclado e Mouse
(6, 1), (6, 2), (6, 3), (6, 4),  -- Murilo recebe Notebook, Monitor, Teclado e Mouse
(7, 1), (7, 2), (7, 3), (7, 4);  -- Jose recebe Notebook, Monitor, Teclado e Mouse

CREATE TABLE AtivosAlocados (
    id INT IDENTITY(1,1) NOT NULL,
    id_colaborador INT NOT NULL,
    id_ativo_fixo INT NOT NULL,
    data_alocacao DATE DEFAULT GETDATE(),
    PRIMARY KEY (id),
    FOREIGN KEY (id_colaborador) REFERENCES Colaboradores(id),
    FOREIGN KEY (id_ativo_fixo) REFERENCES AtivosFixos(id)
);

INSERT INTO AtivosAlocados (id_colaborador, id_ativo_fixo)
VALUES
(1, 1), (1, 8),   -- Bruno
(2, 2), (2, 9),   -- Andre
(3, 3), (3, 10),  -- Alexandre
(4, 4), (4, 11),  -- Akiles
(5, 5), (5, 12),  -- Josimar
(6, 6), (6, 13),  -- Murilo
(7, 7), (7, 14);  -- Jose

-- Inserindo a coluna de status dos ativos fixos
ALTER TABLE AtivosFixos
ADD status VARCHAR(15) DEFAULT 'Disponível';

-- Adicionando a restrição CHECK separadamente
ALTER TABLE AtivosFixos
ADD CONSTRAINT CK_AtivosFixos_Status CHECK (status IN ('Disponível', 'Em uso'));

-- Classificando itens como 'Em uso'
UPDATE AtivosFixos
SET status = 'Em uso'
WHERE id IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ,11 ,12 ,13 ,14);

-- Atualizando status de itens que já estavam na tabela
UPDATE AtivosFixos
SET status = 'Disponível'
WHERE status IS NULL;

GO

-- Criar as views para consultas

-- Consultar de status dos ativos
CREATE VIEW StatusAtivoFixo AS
SELECT e.id, e.nome_equipamento, af.ativo_fixo, af.status
FROM equipamentos AS e
JOIN AtivosFixos AS af ON e.id = af.id_equipamento;
GO

-- Consultar de itens dos colaboradores
CREATE VIEW ConsultarItensAlocados AS
SELECT
    c.id,
    (c.nome + ' ' + c.sobrenome) AS colaborador,
    e.nome_equipamento,
    ia.quantidade,
    ia.data_alocacao
FROM ItensAlocados ia
JOIN Colaboradores c ON ia.id_colaborador = c.id
JOIN Equipamentos e ON ia.id_equipamento = e.id;
GO

-- Consultar ativos fixos dos colaboradores
CREATE VIEW ConsultarAtivosAlocados AS
SELECT
    e.id,
    e.nome_equipamento,
    e.tipo, -- Tipo do equipamento (Notebook, Monitor etc.)
    af.ativo_fixo,
    af.status,
    (c.nome + ' ' + c.sobrenome) AS colaborador -- Nome do colaborador que está com o ativo
FROM Equipamentos AS e
JOIN AtivosFixos AS af ON e.id = af.id_equipamento
LEFT JOIN AtivosAlocados AS aa ON af.id = aa.id_ativo_fixo
LEFT JOIN Colaboradores AS c ON aa.id_colaborador = c.id;
GO

-- Executar as views

SELECT * FROM StatusAtivoFixo;
SELECT * FROM ConsultarItensAlocados;
SELECT * FROM ConsultarAtivosAlocados;