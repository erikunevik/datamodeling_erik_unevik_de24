SET
    search_path TO ezecream_05;

-- cleans the table and resets the autogenerated pk value
TRUNCATE TABLE orderline RESTART IDENTITY CASCADE;

INSERT INTO
    orderline (order_id, product_id, quantity)
VALUES
    (3, 3, 20),
    (4, 2, 5);

SELECT
    *
FROM
    orderline;


-- Insert Luca to_bin

    -- INSERT INTO
    -- ezecream_05.orderline (
    --     orderline_id,
    --     order_id,
    --     product_id,
    --     quantity
        
    --     )
    -- VALUES
    -- (3, 5, 3, 2);

