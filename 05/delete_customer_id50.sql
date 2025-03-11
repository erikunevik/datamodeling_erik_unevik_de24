DELETE FROM ezecream_05.Orderline 
WHERE order_id IN (SELECT order_id FROM ezecream_05.Orders WHERE customer_id = 50);

DELETE FROM ezecream_05.Orders WHERE customer_id = 50;

DELETE FROM ezecream_05.Customer WHERE customer_id = 50;


