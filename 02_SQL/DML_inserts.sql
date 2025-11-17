-- Sistema de Gerenciamento de Hotel
-- Script de Inserção e Manipulação de Dados(DML)

USE HotelDB;

-- Inserts dos hóspedes
INSERT INTO hospede(nome, cpf, telefone, email) VALUES('vinicius', '01234567890', '11 01234-5678', 'vinicius@gmail.com'); 
INSERT INTO hospede(nome, cpf, telefone, email) VALUES('bernardo', '12345678901', '11 12345-6789', 'bernardo@gmail.com');
INSERT INTO hospede(nome, cpf, telefone, email) VALUES('kauan', '23456789012', '11 23456-7890', 'kauan@gmail.com');
INSERT INTO hospede(nome, cpf, telefone, email) VALUES('aaa', '12312312', '11 32534-7890', 'aaaaa@gmail.com');   

-- Inserts dos quartos
INSERT INTO quarto(numero, tipo, valor_diaria) VALUES(1,'standard', 50);
INSERT INTO quarto(numero, tipo, valor_diaria) VALUES(2,'superior', 100);
INSERT INTO quarto(numero, tipo, valor_diaria) VALUES(3,'luxuoso', 200);
INSERT INTO quarto(numero, tipo, valor_diaria) VALUES(4,'suite', 350);

-- Inserts das reservas
INSERT INTO reserva(data_entrada, data_saida, valor_total, id_hospede, id_quarto) 
VALUES(
STR_TO_DATE( "10/08/2025", "%d/%m/%Y" ),
STR_TO_DATE( "17/08/2025", "%d/%m/%Y" ), 
350*7,
1, -- vinicius
4 -- suite
);

INSERT INTO reserva(data_entrada, data_saida, valor_total, id_hospede, id_quarto) 
VALUES(
STR_TO_DATE( "14/08/2025", "%d/%m/%Y" ),
STR_TO_DATE( "28/08/2025", "%d/%m/%Y" ), 
100*14,
2,  -- bernardo
2  -- superior
);

INSERT INTO reserva(data_entrada, data_saida, valor_total, id_hospede, id_quarto) 
VALUES(
STR_TO_DATE( "20/09/2025", "%d/%m/%Y" ),
STR_TO_DATE( "23/09/2025", "%d/%m/%Y" ), 
200*3,
3,  -- kauan
3 -- luxuoso
);
