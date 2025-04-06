# Datamodellering – Övningstenta

**Tillåtna hjälpmedel:**  
Ett A4-papper med handskrivna anteckningar (båda sidor får användas).  
**Tid:** 4 timmar  
**Betygssättning:** Godkänt kräver minst 50% av totala poäng.

---

## 📘 Multiple Choice-frågor

### Question 1 (1p)
**A primary key must be a natural key?**  
- a) True  
- b) False

False, a primary key can as well be a surrogate key.
---

### Question 2 (1p)
**Physical ERD is closer to business than conceptual ERD**  
- a) True  
- b) False

False, beacuse a conceptual ERD are more clear and understandable for a business, and a conceptual and physical are as much important for the process for developing a cosistent database.

---

### Question 3 (2p)
**No transitive dependency is a requirement to comply with one of the following normal forms, which one?**  
- a) ONF  
- b) 1NF  
- c) 2NF  
- d) 3NF

3NF

---

### Question 4 (2p)
**Which of the following is _not_ a necessary property of a primary key in a relational database table?**  
- a) The values must be unique  
- b) The values can't be NULL  
- c) A primary key must be a single column  
- d) Each row must have a value for the primary key  
- e) A table can only have one primary key

c, False, in a composite primary key there will be two columns forming the key.

---

## ✏️ Frågor med utvecklat svar

### Question 5 (2p)
You have identified a **one-to-many** relationship between two entities in your conceptual data model.  
**How will it affect the actual implementation?**

Easier to describe with an example. In a store one customer can place many orders, but each order are related to only that customer. I.e. it describes a relation where one object has multiple relations on one way but on the other way only has a single relation. 

On the "many" side it should contain a foreign key and a primary key on the "one" side.

---

### Question 6 (2p)
You have identified a **many-to-many** relationship between two entities in your conceptual data model.  
**How will it affect the actual implementation?**

E.g. A Multiple courses may have many students, and multiple students may enlist to many courses between two object entities/tables. This will create an error if you try to run a query or filter the data beacuse it will not be possible to ascertain which indiviudal student that atends which individual course, you need to create a bridge table in between.

You need to create junction table between the primary entities where you will place foreign keys to create a one-to-many relation. This to assure referntial integrity (?).

---

### Question 7 (2p)
**How do you ensure referential integrity and why is it desirable to have it?**

You ascertain it by seeing to that any composite entity/child table has an assigned foreign key. 

It is desriable since you e.g. prevent orphaned records. Can use cascade delete. 

---

### Question 8 (2p)
**Your data is in this format:**

```json
[ 
  { 
    "user_id": 42145, 
    "first_name": "Kokchun", 
    "last_name": "Giang", 
    "about": "Data engineer, scientist, and educator passionate about turning messy data into valuable insights. Loves open-source projects and community contributions.", 
    "photo_url": "https://media.licdn.com/digitalprofile/kokchun", 
    "experiences": [ 
      { 
        "title": "Founder & Lead Consultant", 
        "organization": "AIgineer", 
        "start_date": "2024-01", 
        "end_date": "present", 
        "description": "Advising businesses on integrating AI solutions and developing custom data engineering pipelines." 
      } 
    ] 
  }, 
  { 
    "user_id": 45636, 
    ... 
  } 
]

## Is this structured, semi-structured, or unstructured data?
Describe how you would store this data.

The data is semistructured since it comes in Json format and would store it in mongodb

##)Question 9

This is an ERD for a hotel:

a) Which type of ERD is this? (1p)
Conceptual

b) Write out possible relationship statements for each entity. (2p)
- A hotel has one or many rooms, but each room belongs to one hotel
- A room hos zero or more reservations, a reservation belongs to one room
- A customer makes one or more reservations, each reservation belongs to one customer
- A hotel has zero or many customers, Customers has/stays/belongs (?) to zero or many hotels?

c) This diagram can't be implemented – which part needs to change and how should it be changed? (2p)

It needs a bridge table between customer and hotel called e.g. hotel_customer where the many side will be placed towards hotel_customer with foreign keys and the one side towards hotel and customer where primary keys are stored. 

d) Write in relational schema notation a few possible attributes for each entity. (2p)

Reservation(reservation_id, customer_id, room_id, start_date, end_date, ...)
Customer(customer_id, name, phone, email, ...)
Hotel(hotel_id, name, address, ...)
Rom(room_id, name, floor  ..)


