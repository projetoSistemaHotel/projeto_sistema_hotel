USE classicmodels;

/*Stored Procedure*/
DELIMITER $$ 
CREATE PROCEDURE sp_resumo_cliente(IN p_customerNumber INT, IN p_ano INT) 
BEGIN 
 SELECT c.customerName AS Cliente, 
 COUNT(DISTINCT o.orderNumber) AS Qtde_Pedidos, 
 SUM(od.quantityOrdered * od.priceEach) AS Total_Vendas 
 FROM customers c 
 JOIN orders o ON c.customerNumber = o.customerNumber 
 JOIN orderdetails od ON o.orderNumber = od.orderNumber 
 WHERE c.customerNumber = p_customerNumber 
 AND YEAR(o.orderDate) = p_ano 
 GROUP BY c.customerName; 
END $$ 
DELIMITER ; 
-- Teste 
CALL sp_resumo_cliente(103, 2004);

/*Trigger*/ 
DELIMITER $$
CREATE TRIGGER trg_atualiza_estoque
AFTER INSERT ON orderdetails
FOR EACH ROW
BEGIN 
 UPDATE products 
 SET quantityInStock = quantityInStock - NEW.quantityOrdered 
 WHERE productCode = NEW.productCode; 
END $$ 
DELIMITER ; 
-- Verificação 
SELECT productCode, quantityInStock 
FROM products 
ORDER BY productCode 
LIMIT 5;
DELIMITER ;

/*Function*/
DELIMITER $$ 
CREATE FUNCTION fn_total_pedido(p_orderNumber INT) 
RETURNS DECIMAL(10,2) 
DETERMINISTIC 
BEGIN 
 DECLARE total DECIMAL(10,2); 
 SELECT SUM(quantityOrdered * priceEach) 
 INTO total 
 FROM orderdetails 
 WHERE orderNumber = p_orderNumber; 
 RETURN total; 
END $$ 
DELIMITER ; 
-- Teste 
SELECT fn_total_pedido(10100) AS valor_total;

/*View*/
CREATE OR REPLACE VIEW vw_faturamento_cliente AS 
SELECT c.customerName AS Cliente, 
 YEAR(o.orderDate) AS Ano, 
 SUM(od.quantityOrdered * od.priceEach) AS Total_Anual 
FROM customers c 
JOIN orders o ON c.customerNumber = o.customerNumber 
JOIN orderdetails od ON o.orderNumber = od.orderNumber 
GROUP BY c.customerName, YEAR(o.orderDate) 
ORDER BY Total_Anual DESC; 
-- Teste 
SELECT * FROM vw_faturamento_cliente WHERE Ano = 2004;

/*Procedure Desafio*/
DELIMITER $$ 
CREATE PROCEDURE sp_top_clientes(IN p_ano INT) 
BEGIN 
 SELECT Cliente, Total_Anual 
 FROM vw_faturamento_cliente 
 WHERE Ano = p_ano 
 ORDER BY Total_Anual DESC 
 LIMIT 5; 
END $$ 
DELIMITER ; 
-- Teste 
CALL sp_top_clientes(2004);