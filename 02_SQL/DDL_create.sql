-- Sistema de Gerenciamento de Hotel
-- Script de Criação de Banco de Dados MySQL

CREATE DATABASE IF NOT EXISTS HotelDB;
USE HotelDB;

-- Tabela de Hóspedes
CREATE TABLE Hospede (
    id_hospede INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100)
);

-- Tabela de Quartos
CREATE TABLE Quarto (
    id_quarto INT PRIMARY KEY AUTO_INCREMENT,
    numero INT NOT NULL UNIQUE,
    tipo VARCHAR(50) NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL,
    status ENUM('disponível', 'ocupado', 'manutenção') DEFAULT 'disponível'
);

-- Tabela de Reservas
CREATE TABLE Reserva (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    data_entrada DATE NOT NULL,
    data_saida DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    id_hospede INT NOT NULL,
    id_quarto INT NOT NULL,
    FOREIGN KEY (id_hospede) REFERENCES Hospede(id_hospede)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_quarto) REFERENCES Quarto(id_quarto)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_datas CHECK (data_saida > data_entrada)
);

-- Trigger para atualizar o status do quarto quando uma reserva é criada
DELIMITER //
CREATE TRIGGER trg_atualiza_status_quarto
AFTER INSERT ON Reserva
FOR EACH ROW
BEGIN
    UPDATE Quarto
    SET status = 'ocupado'
    WHERE id_quarto = NEW.id_quarto;
END;
//
DELIMITER ;

-- Trigger para liberar o quarto após a data de saída
DELIMITER //
CREATE TRIGGER trg_libera_quarto
AFTER UPDATE ON Reserva
FOR EACH ROW
BEGIN
    IF NEW.data_saida <= CURDATE() THEN
        UPDATE Quarto
        SET status = 'disponível'
        WHERE id_quarto = NEW.id_quarto;
    END IF;
END;
//
DELIMITER ;
