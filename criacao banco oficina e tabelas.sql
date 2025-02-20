create database oficinaRefinado;
use oficinaRefinado;
-- Tabela de Clientes
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Endereço VARCHAR(45),
    Telefone VARCHAR(45),
    Email VARCHAR(45)
);

-- Tabela de Veículos
CREATE TABLE Veículo (
    idVeículo INT AUTO_INCREMENT PRIMARY KEY,
    Placa VARCHAR(45) UNIQUE NOT NULL,
    Marca VARCHAR(45),
    Modelo VARCHAR(45),
    Ano INT,
    Cor VARCHAR(45),
    idCliente_Cliente INT NOT NULL,  
    FOREIGN KEY (idCliente_Cliente) REFERENCES Cliente(idCliente)
);

-- Tabela de Mecânicos
CREATE TABLE Mecânico (
    idMecânico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Endereço VARCHAR(45),
    Especialidade VARCHAR(45),
    idEquipe_Equipe INT NOT NULL,  
    FOREIGN KEY (idEquipe_Equipe) REFERENCES Equipe(idEquipe)
);

-- Tabela de Equipes
CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL
);

-- Tabela de Ordens de Serviço
CREATE TABLE OrdemDeServiço (
    idOrdemDeServiço INT AUTO_INCREMENT PRIMARY KEY,
    DataEmissão DATE NOT NULL,
    ValorTotal DECIMAL(10, 2),
    Status VARCHAR(45),
    idVeículo_Veiculo INT NOT NULL, 
    idEquipe_Equipe INT NOT NULL,  
    DataConclusaoPrevista DATE,
    FOREIGN KEY (idVeículo_Veiculo) REFERENCES Veículo(idVeículo),
    FOREIGN KEY (idEquipe_Equipe) REFERENCES Equipe(idEquipe)
);

-- Tabela de Serviços
CREATE TABLE Serviço (
    idServiço INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(45) NOT NULL,
    ValorMaoDeObra DECIMAL(10, 2)
);

-- Tabela de Peças
CREATE TABLE Peça (
    idPeça INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    ValorUnitario DECIMAL(10, 2)
);

-- Tabela de Peças de Serviço (tabela de ligação muitos-para-muitos)
CREATE TABLE PeçaDeServiço (
    idPeça_Peca INT NOT NULL,  
    idServiço_Servico INT NOT NULL,  
    Quantidade INT NOT NULL,
    FOREIGN KEY (idPeça_Peca) REFERENCES Peça(idPeça),
    FOREIGN KEY (idServiço_Servico) REFERENCES Serviço(idServiço),
    PRIMARY KEY (idPeça_Peca, idServiço_Servico)
);

-- Tabela de Peças da Ordem de Serviço (tabela de ligação muitos-para-muitos)
CREATE TABLE PeçaDaOrdemDeServiço (
    idPeça_Peca INT NOT NULL, 
    idOrdemDeServiço_OrdemDeServiço INT NOT NULL,  
    Quantidade INT NOT NULL,
    ValorTotalPeca DECIMAL(10, 2),
    FOREIGN KEY (idPeça_Peca) REFERENCES Peça(idPeça),
    FOREIGN KEY (idOrdemDeServiço_OrdemDeServiço) REFERENCES OrdemDeServiço(idOrdemDeServiço),
    PRIMARY KEY (idPeça_Peca, idOrdemDeServiço_OrdemDeServiço)
);

-- Tabela de Serviços da Ordem de Serviço (tabela de ligação muitos-para-muitos)
CREATE TABLE ServiçosDaOrdemDeServiço (
    idOrdemDeServiço_OrdemDeServiço INT NOT NULL,  
    idServiço_Servico INT NOT NULL, 
    Quantidade INT NOT NULL,
    ValorTotal DECIMAL(10, 2),
    FOREIGN KEY (idOrdemDeServiço_OrdemDeServiço) REFERENCES OrdemDeServiço(idOrdemDeServiço),
    FOREIGN KEY (idServiço_Servico) REFERENCES Serviço(idServiço),
    PRIMARY KEY (idOrdemDeServiço_OrdemDeServiço, idServiço_Servico)
);