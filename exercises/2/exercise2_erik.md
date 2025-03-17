# Exercise 2 - normalizing tables

These exercises are for you to learn fundamental concepts in data modeling. Many of them can be done with pen and paper, physical whiteboard or with an ERD software such as Lucidchart and dbdiagram. It is good practice to work analogue as an important part of data modeling is to align various stakeholders with a mix of technical and business knowledge. It is also advised to discuss with your peers as data modeling usually is not done in solitude.

## 0. Ezecream orders

Our beloved ice cream company Ezecream has a Sales table that looks like this

| order_id | order_date | customer_id | customer_name  | customer_address | product_id | product_name | quantity |
| -------- | ---------- | ----------- | -------------- | ---------------- | ---------- | ------------ | -------- |
| 101      | 2024-04-05 | 05          | Ragnar Lodbrok | Kattegatt 3      | 3          | Blåbärsmagi  | 20       |
| 101      | 2024-04-05 | 05          | Ragnar Lodbrok | Kattegatt 3      | 5          | Lakritsdröm  | 15       |
| 101      | 2024-04-05 | 05          | Ragnar Lodbrok | Kattegatt 3      | 1          | Lichipichi   | 35       |
| 105      | 2025-01-10 | 15          | Feliz Fernadu  | Madridugatan 2   | 8          | Gitlass      | 30       |
| ...      | ...        | ...         | ...            | ...              | ...        | ...          | ...      |

##a) Find different problems with this table, so that Ezecream will take you in for internship to fix it for them

1. - Data redundancy

     --Defintion: Impacts data consistency, increases storage use.Same series of values repeated accross multiple rows.

     --Example: Address and names repeated multiple times. Order_id, customer_id and product_id should be in seperated tables.

2. - Deletion anomaly

     --Definition: Deletion of a record leads to additional unintentional loss of data. You remove more data than you wanted to remove.

     --Example: If we remove row with order 101, and there is no other order linked to product, Blåbärs magi then we lose info about this product.

3. - Insertion anomaly

     --Definiton: Inserting data is not possible beacuse values and attributes are missing, depending on the the constraints of the database.

     --Example Adding a new customer without chosen product and/or quantity

4. - Update anomaly

     --Definiton: Updating/modifying one value leads to inconsitencies with other rows. In other words one would have to update the same info in several places.

     --Example: If we need to update name or address of a customer that is present in several rows, we would have to manually update in each row linked to this, or accept inconsistent data.

     ##-- Markus answer

     a)

you will get redundancy data  in customer_name if one cutomer wants more product, same with product_name. It will create a probelm if you wanna delete a product, the hal raw will be deleted.

1) data redundancy 
Defination: same values repeded leads to across multiple rows. Problems, consistnacy increase s storage usage 
Example: look order 101: name + address repeated 3 times.

2) deletion anomaly
 - defination: deletion of a records leads to unintentional loss of data. In other you remove data you wanted to remove PLUS data that you should have kept.
 - Example: if we remove row with order 101, and there is no ohter order linked to product Blåbärsmagi, then we lose info about this product.

3) Insertion anomaly 
- defination: iserting data is not possible because values an attributes are misssing (depends on the constraints an the DB).
- Example: adding a new customer without chosen product and/or quantity.

4) Update anomaly
- Defination: updating modifying are value leads to incositencies with other rows. In other words one would have to update same info in sevral pklaces.
- Example: If we need update name/address of a customer that is present in sevral rows, we would have to manually update it in each row linked to this customer or create  inconsistens data.

##b) Does this table satisfy 1NF, 2NF? Motivate.

Regarding 1 NF.

    --Correct: Row order does not matter

    --Correct: Only if we allow an implict PK in form of a
    composite key = order_id, product_id. What if a customer adds a new order, same product with a new quantity.

    --Correct: No repeating groups

    --Correct: Uniform data for the column values.

    2NF = Non-prime attributes must be functional dependent on entire primary key and just not part of it

    - Which columns are primary keys:
    - Which columns are not part of PK
    - Check if this column is functionally dependent on colums that makes a PK
    - IF Yes on All 2NF

    Since we assigned order_id and product_id as primary keys to form composite keys, this proves invalid when customer_name proves dependent on customer_id thats an invalid key.

    ##--Markus answer:

    checklist 1NF
- row order doesn't matter      (exists)
- PK in each table              (exists)   only if we allow an implicit PK in form of a composite key (order_id, product_id).
                                           Comment: it is not posible for a customer to adds to same order, product with a new quantity. 
- No repeting groups            (exists)   
- Unifor column data            (exists)   data type can't be mixed within a column, one attribute = one data type

checklist 2NF

- 1NF                            (exists) 
- Non prime attributes must 
  be functionally dependes on 
  entire primary key and not 
  just part of it.               (no)


***question*** 

1) Which column/columns are your primary key?
2) Go through each column thats is NOT a part of PK?
3) Check if this column is functionally dependes on column/columns that make a pk?
4) If Yes on all --> 2NF?

c) Normalize this table to 3NF, make conceptual diagram and relational schema notation for each relation. Relational schema notation is `RelationName(attribute1, attribute2, ...)`

Customer
- customer_id (PK)
- customer_name
- address


Order
- order_id (PK)
- order_date
- customer_id (FK)

Product
- product_id (PK)
- product_name
- product_price


Order_Detail
- Surrogate primary key order_detail
- order_id (FK)
- product_id (FK)
- quantity
- price

**conceptual ERD**

<img src = "../../assets/exc2que0c.png">


d) 

Adding price to product and order_detail table

e) Write SQL code to get the total price for Ragnar Lodbrok. Insert data into your tables and test it out.

I used my postgres database from lecture 05, here are my syntax:

SET search_path to ezecream_05;

SELECT 
    c.first_name, 
    c.last_name, 
    SUM(p.price * ol.quantity) AS total_price
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id  -- Join customer on orders
JOIN orderline ol ON o.order_id = ol.order_id  -- Get orders with orderlines
JOIN product p ON p.product_id = ol.product_id  -- Get product
WHERE c.first_name = 'Ivar' AND c.last_name = 'the Boneless'  
GROUP BY c.first_name, c.last_name;


## 1. Sakila

Use the same ERD from Sakila as in exercise1 task 3.

a) Is this normalized to 3NF?

b) Lets zoom in to the inventory, explain how it works for tracking films in each stores.

c) Do we have a way to know if a film is rented out or not?






