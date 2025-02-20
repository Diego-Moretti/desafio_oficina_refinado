INSERT INTO Cliente (Nome, Endereço, Telefone, Email) VALUES
('João da Silva', 'Rua das Flores, 123', '11999998888', 'joao.silva@email.com'),
('Maria Souza', 'Avenida Paulista, 456', '11988887777', 'maria.souza@email.com'),
('Carlos Pereira', 'Rua Augusta, 789', '11977776666', 'carlos.pereira@email.com'),
('Fernanda Lima', 'Rua das Acácias, 159', '11987654321', 'fernanda.lima@email.com'),
('Ricardo Oliveira', 'Avenida das Américas, 852', '11965432109', 'ricardo.oliveira@email.com');

INSERT INTO Veículo (Placa, Marca, Modelo, Ano, Cor, idCliente_Cliente) VALUES
('ABC1234', 'Fiat', 'Uno', 2015, 'Prata', 1),
('XYZ9876', 'Volkswagen', 'Gol', 2020, 'Branco', 2),
('DEF4567', 'Chevrolet', 'Onix', 2018, 'Preto', 3),
('GFH8901', 'Ford', 'Ka', 2019, 'Vermelho', 4),
('LKI2345', 'Hyundai', 'HB20', 2022, 'Cinza', 5);

INSERT INTO Equipe (Nome) VALUES
('Equipe Alfa'),
('Equipe Beta'),
('Equipe Gama');

INSERT INTO Mecânico (Nome, Endereço, Especialidade, idEquipe_Equipe) VALUES
('José Santos', 'Rua da Mooca, 100', 'Motor', 1),
('Ana Oliveira', 'Avenida Sumaré, 200', 'Freio', 2),
('Pedro Almeida', 'Rua Bela Vista, 300', 'Suspensão', 3),
('Carla Souza', 'Rua dos Pinheiros, 456', 'Elétrica', 2),
('Bruno Pereira', 'Avenida Brigadeiro Faria Lima, 789', 'Injeção Eletrônica', 3);

INSERT INTO Serviço (Descricao, ValorMaoDeObra) VALUES
('Troca de óleo', 150.00),
('Troca de freios', 300.00),
('Alinhamento e balanceamento', 200.00);


INSERT INTO Peça (Nome, ValorUnitario) VALUES
('Filtro de óleo', 50.00),
('Pastilha de freio', 100.00),
('Pneu', 250.00),
('Vela de ignição', 25.00),
('Filtro de ar', 40.00);

INSERT INTO OrdemDeServiço (DataEmissão, ValorTotal, Status, idVeículo_Veiculo, idEquipe_Equipe, DataConclusaoPrevista) VALUES
('2024-05-01', 0.00, 'Em aberto', 1, 1, '2024-05-05'),
('2024-05-02', 0.00, 'Em aberto', 2, 2, '2024-05-06'),
('2024-05-03', 0.00, 'Em aberto', 3, 3, '2024-05-07');

INSERT INTO PeçaDeServiço (idPeça_Peca, idServiço_Servico, Quantidade) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 4);

INSERT INTO PeçaDaOrdemDeServiço (idPeça_Peca, idOrdemDeServiço_OrdemDeServiço, Quantidade, ValorTotalPeca) VALUES
(1, 1, 1, 50.00),
(2, 2, 2, 200.00),
(3, 3, 4, 1000.00);

INSERT INTO ServiçosDaOrdemDeServiço (idOrdemDeServiço_OrdemDeServiço, idServiço_Servico, Quantidade, ValorTotal) VALUES
(1, 1, 1, 150.00),
(2, 2, 1, 300.00),
(3, 3, 1, 200.00);

-- Qual o número total de clientes cadastrados na oficina?
SELECT COUNT(*) AS total_clientes FROM Cliente;

desc Veículo;
-- Quais são as marcas e modelos dos veículos cadastrados na oficina?
SELECT Marca, Modelo FROM Veículo;

-- Quantos veículos cada cliente possui?
SELECT c.Nome, COUNT(v.idVeículo) AS quantidade_veiculos
FROM Cliente c
LEFT JOIN Veículo v ON c.idCliente = v.idCliente_Cliente
GROUP BY c.Nome;

-- Quais são os mecânicos especializados em "Motor"?
SELECT Nome FROM Mecânico WHERE Especialidade = 'Motor';

-- Quantas ordens de serviço foram emitidas por equipe?
SELECT e.Nome, COUNT(os.idOrdemDeServiço) AS quantidade_ordens
FROM Equipe e
LEFT JOIN Mecânico m ON e.idEquipe = m.idEquipe_Equipe
LEFT JOIN OrdemDeServiço os ON m.idEquipe_Equipe = os.idEquipe_Equipe
GROUP BY e.Nome;

-- Listar veículos dae uma determinada marca :
SELECT * FROM Veículo WHERE Marca = 'Fiat';

desc Veículo;

-- Listar nome do cliente e placa do veículo ordenados pelo nome do cliente:
SELECT Cliente.Nome, Veículo.Placa
FROM Cliente
INNER JOIN Veículo ON Cliente.idCliente = Veículo.idCliente_Cliente
Order by Cliente.Nome;

-- Listar equipes com 2 ou mais mecânicos:
SELECT Equipe.Nome, COUNT(*) AS NumeroMecanicos
FROM Mecânico
INNER JOIN Equipe ON Mecânico.idEquipe_Equipe = Equipe.idEquipe
GROUP BY Equipe.Nome
HAVING COUNT(*) >= 2;