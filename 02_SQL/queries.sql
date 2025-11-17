-- Sistema de Gerenciamento de Hotel
-- Queries

USE HotelDB;

SELECT * FROM quarto;
SELECT * FROM reserva;
SELECT * FROM hospede;

-- Testes das consultas

	-- INNER JOIN com informações dos hóspedes e quartos
    SELECT 
		h.nome AS Nome_Hospede,
        h.telefone,
        r.data_entrada,
        r.data_saida,
        q.numero AS Numero_Quarto
	FROM
		hospede h
	INNER JOIN
		reserva r ON h.id_hospede = r.id_hospede
	INNER JOIN
        quarto q ON q.id_quarto = r.id_quarto;
        
    -- JOIN com o valor das reservas dos hóspedes
    SELECT
		h.nome AS Nome_Hospede,
        r.valor_total AS Valor_Da_Reserva
	FROM 
		hospede h
    JOIN 
		reserva r ON h.id_hospede = r.id_hospede;

	-- Filtro por data
    SELECT
		id_reserva,
        data_entrada,
        valor_total
	FROM
		reserva
	WHERE
		data_entrada > '2025-08-01'
	AND
		valor_total > 2000.00;

	-- Agregação por quantidade de reservas e valor gasto
    SELECT
		h.nome,
		COUNT(r.id_reserva) AS total_reservas,
		SUM(r.valor_total) AS valor_total_gasto
	FROM
		hospede h
	INNER JOIN
		reserva r ON h.id_hospede = r.id_hospede
	GROUP BY
		h.nome
	ORDER BY
		valor_total_gasto DESC;
