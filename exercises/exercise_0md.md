## 0

## 1)

```json
{
  "hospital": "Sjukhusstock",
  "address": "Drottninggatan 3, Stockholm",
  "departments": [
    {
      "name": "Kardiologi",
      "doctors": [
        { "id": 1, "name": "Dr. Abra Abrahamson" },
        { "id": 2, "name": "Dr. Erika Eriksson" }
      ]
    },
    {
      "name": "Neurologi",
      "doctors": [{ "id": 3, "name": "Dr. Sven Svensson" }]
    }
  ]
}
```

###

Initial naive conceptual ERD

<img SRC = " ../assets/picture1.png" width=300>

**Initial 3 tables**

Hospital table

| hosp_id | name         | address         |
| ------- | ------------ | --------------- |
| 1       | Sjukhusstock | Drottningatan 3 |
| 2       | SÖS          | Södergatan 1    |

Department table

| dep_id | name       |     |
| ------ | ---------- | --- |
| 1      | kardiologi |     |
| 2      | Neurologi  |     |
|        |            |     |
|        |            |     |

Doctor table

| dr_id | name |     |
| ----- | ---- | --- |
| 1     | Lars |     |
| 2     | Eva  |     |
| 3     | Luca |     |
|       |      |     |

<img SRC = " ../assets/picture2.png" width=300>

## Expandera alt + shift + f

## Lägg till rader shift + alt ned

**Structure with 6 tables**

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

##Test a join##

- Dr. Toni works at SÖS and Kardiologen
- Dr. Lundgren at Sjukhusstock at both kardiolgen and neurologen
- Dr. Larsson works at both SÖS and Sjukhusstock but only at Neurologen

Want information on Sjukhusstock and its departments

- hospital_department can join with department_id on
  department table and hospital_id on hospital_table
- Query name from hospital table and name from department
  table

SELECT
d.name AS doctor_name,
h.name AS hospital_name,
dep.name AS department_name
FROM hospital_doctor hd
JOIN doctor d ON hd.dr_id = d.dr_id -- Get doctor name
JOIN hospital h ON hd.hosp_id = h.hosp_id -- Get hospital name
JOIN department_doctor dd ON d.dr_id = dd.dr_id -- Get department for doctor
JOIN hospital_department hdpt ON hd.hosp_id = hdpt.hosp_id -- Link hosp/dep
JOIN department dep ON dd.dep_id = dep.dep_id -- Get department name
ORDER BY doctor_name, hospital_name;

##2 Library Bookly

A library called Bookly keeps track of books and members who borrow them. Each book has a title, author, and ISBN number. Each member has a membership ID, name, and contact information. A member can borrow multiple books, but each book can be borrowed by only one member at a time.

##a) Identify the `entities` and `attributes` for each entity.

book_table

| book_id | title               | author       | ISBN |
| ------- | ------------------- | ------------ | ---- |
| 1       | Mein Kampf          | Adolf Hitler | 1111 |
| 2       | The art of the deal | Donald Trump | 2222 |
| 3       | Mina 1000 mål       | Luca Toni    | 3333 |

member_table

| memb_id | name           | contact_info         |
| ------- | -------------- | -------------------- |
| 1       | Karl Karlsson  | nazi@gmail.com       |
| 2       | Virgina Hansen | magamaga@gmail.com   |
| 3       | Luca Toni      | primapunta@gmail.com |

library_table

| borrow_id | book_id | memb_id |
| --------- | ------- | ------- |
| 1         | 1       | 1       |
| 2         | 2       | 2       |
| 3         | 3       | 3       |

book_table och member_table are entities, library tables is an associative entity. Title, author, ISBN are attributes in book_table and name and contact_info are attributes from member_table.

##b) Write out the relationship labels.

Cardinality:

1:M, One book can be borrowed multiple times but only by one member at a time
1:M, One member can borrow multiple books but only one book at a time

<img SRC = " ../assets/picture3.png" width=300>

##c) Describe the relationships between the entities (one-to-many, one-to-one and many-to-many).

1:M, One book can be borrowed multiple times but only by one member at a time (book)
1:1, One book can be linked to only one unique ISBN number (memb <-> lib)
M:N, Many members can borrow many books (but only one at a time) (book <-> lib <-> memb)

##d) Define the relationship statement for example: "A Customer can have one or more Rentals".

1:M

## 3. Conceptual ERD to words

This is an ERD conceptual diagram that a database designer and the business stakeholders agreed upon in a car rental company called Carent.

<img SRC = " ../assets/car_rental.png" width=300>

a) Describe the entities in this conceptual ERD.

Car and customer are object entities, rental associative.

b) Write out the relationship labels.

- Customer rents a car
- Rental gives a car

c) Describe the relationships between the entities (one-to-many, one-to-one and many-to-many).

- Customer <-> Rental one-to-many 0..1:M
- Rental <-> Car one-to-many 0..1:M

d) Define the relationship statement for example: "A Customer can have one or more Rentals".

Customer <-> Rental one-to-many 0..1:M - The customer can have one or zero rentals, but the rental may have one or many customers.
Rental <-> Car one-to-many M:0..1 - A rental may have one or many cars, but each car can only belong to a rental at a time or none at all.

## 4. Online store

You are designing a database for an online store that sells multiple products. Customers can place multiple orders, and each order contains multiple products.

a) Identify entities and their relationships

customer (customer_table), products (products_table) are object entities, whereas order_table and order_items_table are bridging tables/ associative enteties.

products_table

| prod_id | product    |
| ------- | ---------- |
| 1       | usb        |
| 2       | data mus   |
| 3       | datorskärm |

customer_table

| cust_id | name           |
| ------- | -------------- |
| 1       | Karl Karlsson  |
| 2       | Virgina Hansen |
| 3       | Luca Toni      |

order_table

| order_id | cust_id | order_date |
| -------- | ------- | ---------- |
| 1        | 1       | 2025-03-05 |
| 2        | 2       | 2025-03-04 |
| 3        | 3       | 2024-03-03 |

order_items_table

| order_item_id | order_id | prod_id |
| ------------- | -------- | ------- |
| 1             | 1        | 1       |
| 2             | 1        | 2       |
| 3             | 2        | 3       |
| 4             | 3        | 2       |

Karl Karlsson buys one usb mouse and one mouse
Virgina Hansen buys one datorskärm
Luca Toni buys one data mus

b) Create a conceptual ERD with cardinalities

- customer_table -> order_table 1:M
- order_table -> order_items_table 1:M
- order_items_table -> products_table 1:M

<img SRC = " ../assets/exc0que4.png" width=300>

## 5. University management system

A university needs a system to manage students, courses, and professors.

- each student can enroll in multiple courses.
- each course is taught by one professor.
- a teacher can teach multiple courses.

a) Identify entities and their relationships

Object enteties are students, courses and professors. Associte/bridging enteties are course_prof_table and course_stud_table

b) Come up with possible attributes for the entities

students_table

| stud_id | name              |
| ------- | ----------------- |
| 1       | Lars Larsson      |
| 2       | Harry Potter      |
| 3       | Fredrick Nietzche |

courses_table

| cour_id | name            |
| ------- | --------------- |
| 1       | Genus galenskap |
| 2       | Haxxor skillZ   |
| 3       | Memecoins       |

professor_table

| prof_id | name               |
| ------- | ------------------ |
| 1       | Aristoteles        |
| 2       | Anna Öhman         |
| 3       | Professor Mcnogall |

course_prof_table

| cour_prof_id | cour_id | prof_id |
| ------------ | ------- | ------- |
|              |         |         |
|              |         |         |
|              |         |         |

course_stud_table

| cour_stud_id | cour_id | stud_id |
| ------------ | ------- | ------- |
|              |         |         |
|              |         |         |
|              |         |         |

c) Draw conceptual ERD with cardinalities

- students_table -> course_stud_table 0:M
- course_stud_table -> courses_table 0:M
- courses_table -> course_prof_table 1:M
- course_prof_table -> professsor_table M:1

<img SRC = " ../assets/exc0que5.png" width=300>

d) Define business rules (e.g. a student can enroll in max 4 courses)


- 1. A student must be enrolled in at least 1 course to be active.
- 2. A course can have between 0 and 40 students.
- 3. Each course must have exactly one professor.
- 4. A professor can teach up to 5 courses.

