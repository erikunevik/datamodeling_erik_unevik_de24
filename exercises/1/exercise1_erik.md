## 0. Hospital example

Going back to the hospital exercise from [exercise0, task 1](https://github.com/AIgineerAB/data_modeling_course/blob/main/exercises/exercise0.md), we will build logical and physical data models. This is the conceptual data model after we've added the composite entities to take care of many-to-many relationships.

a) Create a logical data model using lucidcharts

<img SRC = " ../../assets/exc1upp0a.png" width=300>

b) Identify different keys on the various entities

<img SRC = " ../../assets/exc1upp0b.png" width=300>

c) Identify child entities and parent entities. What makes them into parent/child relationships?

- A child entity always has the many endpoint connected.
- A parent entity is the "core entity" that enables the child entity to exist.
- A foreign entity refers to the parent entity.

d) Create a physical data model using dbdiagram

Table Hospital {
hospital_id integer [primary key]
name varchar(50) [not null]
address varchar(100) [not null]
}

Table HospitalDepartment {
hospital_department_id integer [primary key]
hospital_id integer [not null, ref: > Hospital.hospital_id]
department_id integer [not null, ref: > Department.department_id]
}

Table Department {
department_id integer [primary key]
name varchar(50) [not null]
}

Table DepartmentDoctor {
department_doctor_id integer [primary key]
doctor_id integer [not null, ref: > Doctor.doctor_id]
department_id integer [not null, ref: > Department.department_id]

}

Table Doctor {
doctor_id integer [primary key]
first_name varchar(50) [not null]
last_name varchar(50) [not null]
}

Table HospitalDoctor {
hospital_doctor_id integer [primary key]
doctor_id integer [not null, ref: > Doctor.doctor_id]
hospital_id integer [not null, ref: > Hospital.hospital_id]

}

<img SRC = " ../../assets/image.png" width=300>

e) Create a few tables manually, insert given data plus some more, and try to manually link foreign keys to primary keys. Can you satisfy that a doctor can work at several departments and several hospitals?

- Dr. Toni works at SÖS and Kardiologen
- Dr. Lundgren at Sjukhusstock at both kardiolgen and neurologen
- Dr. Larsson works at both SÖS and Sjukhusstock but only at Neurologen

hospital_table

| hosp_id | name         | address         |
| ------- | ------------ | --------------- |
| 1       | Sjukhusstock | Drottningatan 3 |
| 2       | SÖS          | Södergatan 1    |

hospital_department_table

| id  | hosp_id | dep_id |
| --- | ------- | ------ |
| 1   | 1       | 1      |
| 2   | 1       | 2      |
| 3   | 2       | 1      |
| 4   | 2       | 2      |
|     |         |        |

department_table

| dep_id | name       |
| ------ | ---------- |
| 1      | kardiologi |
| 2      | Neurologi  |
|        |            |
|        |            |

department_doctor_table

| id  | dep_id | dr_id |
| --- | ------ | ----- |
| 1   | 1      | 3     |
| 2   | 1      | 2     |
| 3   | 2      | 2     |
| 4   | 2      | 1     |

doctor_table

| dr_id | name         |
| ----- | ------------ |
| 1     | Lars Larsson |
| 2     | Eva Lundgren |
| 3     | Luca Toni    |
|       |              |

hospital_doctor_table

| id  | hosp_id | dr_id |
| --- | ------- | ----- |
| 1   | 2       | 3     |
| 2   | 1       | 2     |
| 3   | 1       | 1     |
| 4   | 2       | 1     |

## 1. Implement hospital example in postgres

a) Now implement your physical model from e) and add the data from task 0e). Make sure that you have correctly specified different domain constraints.

See files create_tables.sql and insert_values.psql in sql folder for syntax.

b) Now lets try to add a row in HospitalDepartment with a hospital_id that doesn't exist in the hospital table. What happens here and why?

My atempt:

" SET search_path to health;

INSERT INTO health.hospitaldepartment (hospital_id, department_id)
values(3, 1); "

I get the following error message: "insert or update on table "hospitaldepartment" violates foreign key constraint "hospitaldepartment_hospital_id_fkey".

That´s beacuse hospitaldepartment is a child table to the parent folder hospital where the primary key "hospital_id" resides, any alteration of that key needs to be done in that table prior to adding in the hospitaldepartment folder.

c) Do similar to b) but try adding a department_id to HospitalDepartment that doesn't exist in the Department.

My atempt:

"SET search_path to health;

INSERT INTO health.hospitaldepartment (hospital_id, department_id)
values(2, 3); "

I get the following error message: "insert or update on table "hospitaldepartment" violates foreign key constraint "hospitaldepartment_department_id_fkey".

That´s beacuse hospitaldepartment is a child table to the parent folder department where the primary key "hospital_id" resides, any alteration of that key needs to be done in that table prior to adding in the hospitaldepartment folder.

d) Now try to do normal delete a record in Hospital that the HospitalDepartment refers to. What happens?

My attempt:

"SET search_path to health;

DELETE from hospital
WHERE hospital_id = 1;"

I get this syntax: "update or delete on table "hospital" violates foreign key constraint "hospitaldepartment_hospital_id_fkey" on table "hospitaldepartment""

It´s beacuse the hospital table has child tables departmenthospital and hospitaldoctor that depends on the structure of hospital. Without special commands e.g. cascade or if I delete the id´s in the child tables - I can´t delete the ID´s.

e) Now use delete on cascade and check what happens.

I ran:

SET search_path to health;

"ALTER TABLE health.hospitaldepartment
DROP CONSTRAINT hospitaldepartment_hospital_id_fkey,
ADD CONSTRAINT hospitaldepartment_hospital_id_fkey
FOREIGN KEY (hospital_id) REFERENCES health.hospital(hospital_id) ON DELETE CASCADE;

ALTER TABLE health.hospitaldoctor
DROP CONSTRAINT hospitaldoctor_hospital_id_fkey,
ADD CONSTRAINT hospitaldoctor_hospital_id_fkey
FOREIGN KEY (hospital_id) REFERENCES health.hospital(hospital_id) ON DELETE CASCADE;

SET search_path to health;

DELETE FROM hospital

WHERE hospital_id = 1;"

With this syntax I dropped the Foreign key constraint and could thereafter delete hospital id.

A second approach would to do it manually first in the child tables:

SET search_path TO health;

DELETE FROM hospitaldepartment WHERE hospital_id = 1;
DELETE FROM hospitaldoctor WHERE hospital_id = 1;
DELETE FROM hospital WHERE hospital_id = 1;

f) Try to violate a domain constraint, what did you try and what result did you get?

INSERT INTO health.hospital (name, address) VALUES (NULL, 'Huddingevägen');

"null value in column "name" of relation "hospital" violates not-null constraint".

This is beacuse I made a not-null constraint on the hospital name column.

## 2. Identify keys

| EmployeeID | Förnamn | Efternamn | AvdelningID | E-post                       | Telefon     |
| ---------- | ------- | --------- | ----------- | ---------------------------- | ----------- |
| 201        | Erik    | Johansson | 1           | erik.johansson@coolfirma.se  | 070-1234567 |
| 202        | Anna    | Karlsson  | 2           | anna.karlsson@coolfirma.se   | 073-2345678 |
| 203        | Johan   | Andersson | 1           | johan.andersson@coolfirma.se | 072-3456789 |
| 204        | Sara    | Lindgren  | 3           | sara.lindgren@coolfirma.se   | 076-4567890 |
| 205        | Maria   | Svensson  | 2           | maria.svensson@coolfirma.se  | 070-5678901 |

a) Which columns could be candidate keys here?

EmployeeID, Epost, telefon

b) From this set of candidate keys, which one would you choose as primary key and which ones as alternate keys?

- Primary key: EmployeeID
- Alternate keys: Epost, telefon

c) Is your primary key considered as natural key or surrogate key?

It is a surrogate key since EmployeeID only exists in this company.

d) Create another table with a primary key where one of the columns in this table could act as a foreign key.

| Lön (USD) | EmployeeID |
| --------- | ---------- |
| 10 000    | 201        |
| 13 000    | 202        |
| 25 000    | 203        |
| 18 000    | 204        |
| 21 000    | 205        |

## 3. Sakila exercise

In SQL course we have queried the sakila database a lot to learn various concepts such as joining, union, filtering. Now lets [download it from kaggle](https://www.kaggle.com/datasets/atanaskanev/sqlite-sakila-sample-database?resource=download) and try to understand its data model.

Study the ERD and try to answer the following questions

a) Is this a conceptual, logical or physical ERD, motivate?

It´s a logical since it has added PK and FK keys with attributes - thus taking the step from conceptual where key/parent entities are structured and their relationships, and the step before physical where the structure are implemented and tested in a database system where constraints, indexes and data types are defined.

b) How many entities are in the database?

15

c) Which are the composite entities?

film_actor
film_category
rental
payment
inventory

d) Try to find suitable relationship labels between entities

actor - film_actor (1:M)
film_actor - actor (M:1)
film_actor - film (M:1)

category - film_category (1:M)
film_category - category (M:1)

film_category - film (M:1)
film - film_category (1:M)

language - film (1:M)
film - language (M:1)

film - inventory (1:M)
inventory - film (M:1)

store - inventory (1:M)
inventory - store (M:1)

customer - rental (1:M)
rental - customer (M:1)

rental - inventory (M:1)
inventory - rental (1:M)

staff - rental (1:M)
rental - staff (M:1)

rental - payment (1:M)
payment - rental (M:1)

customer - payment (1:M)
payment - customer (M:1)

store - staff (1:M)
staff - store (M:1)

customer - address (M:1)
address - customer (1:M)

store - address (M:1)
address - store (1:M)

address - city (M:1)
city - address (1:M)

city - country (M:1)
country - city (1:M)

e) Try to write out some possible relationship statements between the entities.

An actor can appear in multiple film_actor records.

A film_actor record references a specific actor.

A film_actor record references a specific film.

A category can be associated with multiple film_category records.

A film_category record references a specific category.

A film_category record references a specific film.

A film can be associated with multiple film_category records.

A language can be assigned to multiple films.

A film is associated with a single language.

A film can have multiple copies in inventory.

An inventory record references a specific film.

A store can have multiple inventory items.

An inventory item belongs to a single store.

A specific rental can belong to many customers.

A rental references a specific inventory item.

An inventory item can be rented multiple times.

A staff member can process multiple payments.

A rental can have multiple payments.

A payment is linked to a specific rental.

A customer can make multiple payments.

A payment belongs to a specific customer.

A store can employ multiple staff members.

A staff member belongs to a single store.

A customer is associated with a specific address.

An address can be linked to multiple customers.

One or many stores are associated with a specific address.

An address can be linked to multiple stores.

An address is located in a specific city.

A city can have multiple addresses.

A city is located in a specific country.

A country can have multiple cities.

Some examples with composite entieties:

- A store can be placed within a specific country, city and with a specific address.
- A film can be played by a certain actor, witin a certain film_category in a particular language.
- A customer can have a rental, which can be paid through multiple payments, and the customer is associated with a specific store.

f) Can you find if there is any errors/mistakes in this ERD?

I find the label relations between stores and address confusing, can one or many stores share the same address?

A rental can have multiple payments?

I don´t se an attribute for quantity of films. Or is it inventory_ID (PK) in inventory table?

## 4. Theoretical questions

a) What are the following constraints that are commonly used in RDBMS:

- NOT NULL = Prevents NULL values from being inserted into a column, ensuring that every row has a valid value. Primary keys (PK) must always be NOT NULL.
- UNIQUE - Constraint ensures that a specific value in a column or a combination of these are distinct from each other and cannot be duplicated e.g. email address.
- CHECK - Set rules for a row in one or more columns that prevent invalid data from being inserted. E.g price >= 100 or age > 18.
- DEFAULT = Specifies a default value for a column if no value is explicitly provided. Does not apply to primary or foreign keys, which require explicit values.
- FOREIGN KEY = "A foreign key (FK) references the primary key of another table to establish relationships. By default, referenced values cannot be deleted unless CASCADE rules are applied."
- PRIMARY KEY = "A column (or combination of columns) that uniquely identifies each row in a table. A table can only have one primary key, and it cannot contain NULL values."

b) What does the physical modeling have that the logical data model don't have.

Setting data types, constraints, indexes, storage condsiderations implementing in a database.

c) How do you ensure referential integrity and why is it desirable to have it?

By creating foreign keys that links to primarykeys in tables. Its desirable beacuse it enables valid consistent relationships between tables and prevents linking of orphaned tables and redundant data.

d) How do the cardinality relationships in the modeling actually affect the implementations?

Without the relatinships i will be impossible to e.g. analyze or filter data with information from one table a time. And with insufficient set up cardinality there is risk for producing redundant data.

Cardinality affects the implementation i many ways:

- Determines the table structure and the need of foreign keys.
- Establishes how queires will be written
- Enforces rules on referential integrity
- Affects indexing

e) What does domain constraint mean?

A domain constraint ensures that a column contains only valid values by restricting the data type, valid range, or predefined set of values. It is implemented using CHECK constraints, ENUM types, or reference tables.

Examples are that prices are inserted in a given range, that only certain payment options are accepted,

f) What does composite key mean and when do you use it?

A composite key is a primary key that consists of two or more columns that together uniquely identify a row in a table. It is used when a single column is not sufficient to uniquely distinguish each row.

You use it in junction/bridging tables between tables with primary keys or when not a single column is enough to ensure uniquness.

g) What is dbml used for?

"Database markup language is used to define, document, and visualize database schemas. It helps design tables, relationships, and constraints before converting them into SQL for databases like PostgreSQL or MySQL. It is commonly used with tools like dbdiagram.io.

## Glossary

| Glossary                | Meaning                                                                                                                                                                      |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| composite entity        | A table used to represent a many-to-many relationship between two entities. It typically has a composite primary key consisting of the foreign keys from the related tables. |
| domain                  | The set of allowable values that an attribute (column) can take in a database.                                                                                               |
| constraint              | A rule enforced on a database to maintain data integrity and consistency (e.g., NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY).                                                 |
| domain constraint       | A restriction that limits the type of values that can be stored in a column (e.g., data type, range of values, format).                                                      |
| entity constraint       | Ensures that each row in a table has a unique primary key and that primary key values cannot be NULL.                                                                        |
| primary key             | A column (or a set of columns) that uniquely identifies each row in a table. It must contain unique values and cannot be NULL.                                               |
| foreign key             | A column (or a set of columns) in one table that references the primary key of another table to establish a relationship.                                                    |
| bridge table            | A table used to resolve many-to-many relationships between two entities by containing foreign keys referencing both tables.                                                  |
| information engineering | A methodology for database design that focuses on defining data structures, processes, and relationships in an enterprise.                                                   |
| attributes              | The columns in a table that store data about an entity, including primary keys, foreign keys, and other data fields.                                                         |
| data integrity          | The accuracy, consistency, and reliability of data within a database, ensured through constraints, cardinal rules and validation rules.                                      |
| entity integrity        | Ensures that each entity/table has a non null primary key to maintain data consitency throughout the database                                                                |
| referential integrity   | Ensures that foreign key values in a table must either match a primary key in another table or be NULL, preventing orphan records.                                           |
| relation instance       | A snapshot in time of the relationships between tables in a database.                                                                                                        |
| child entity            | A table with a foreign key thats dependent on the parent table for its existence                                                                                             |
| parent entity           | A table that contains a primary key referenced by a foreign key in a child entity.                                                                                           |
| natural key             | A primary key that exists outside of database, e.g. personal number                                                                                                          |
| surrogate key           | A primary key that only exists within the database                                                                                                                           |
| candidate key           | A set of keys that could work as a primary key                                                                                                                               |
| alternate key           | A candidate key that is not chosen as the primary key but could still uniquely identify rows in a table.                                                                     |
|                         |                                                                                                                                                                              |

