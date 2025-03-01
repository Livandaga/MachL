BEGIN;

DO $$ 
DECLARE user_balance NUMERIC;
DECLARE order_cost NUMERIC;
DECLARE stock_left INT;
DECLARE qty_requested INT := 
DECLARE selected_product INT := 1;  
DECLARE user_id INT := 5;  
    SELECT balance INTO user_balance FROM users WHERE user_id = user_id;

    SELECT price * qty_requested INTO order_cost FROM products WHERE product_id = selected_product;

    SELECT stock_quantity INTO stock_left FROM products WHERE product_id = selected_product;

    IF stock_left < qty_requested THEN
        RAISE EXCEPTION 'Недостаточно товара на складе!';
    END IF;

    IF user_balance < order_cost THEN
        RAISE EXCEPTION 'Недостаточно средств на счёте!';
    END IF;
END $$;

INSERT INTO orders (user_id, product_id, quantity, total_price)
VALUES (user_id, selected_product, qty_requested, order_cost);

UPDATE products
SET stock_quantity = stock_quantity - qty_requested
WHERE product_id = selected_product;
UPDATE users
SET balance = balance - order_cost
WHERE user_id = user_id;

COMMIT;