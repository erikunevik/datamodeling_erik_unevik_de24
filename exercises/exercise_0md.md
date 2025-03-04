## 0

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

Hospital table

| hosp_id | name         | address         |
| ------- | ------------ | --------------- |
| 1       | Sjukhusstock | Drottningatan 3 |
| 2       | SÖS          | Södergatan 1    |

Hospital department table

| id  | hosp_id | dep_id |
| --- | ------- | ------ |
| 1   | 1       | 1      |
| 2   | 1       | 2      |
| 3   | 2       | 1      |
| 4   | 2       | 2      |
|     |         |        |

Department table

| dep_id | name       |     
| ------ | ---------- | 
| 1      | kardiologi |     
| 2      | Neurologi  |     
|        |            |     
|        |            |     

Department doctor table

| id  | dep_id | dr_id |
| --- | ------ | ----- |
| 1   | 1      | 3     |
| 2   | 1      | 2     |
| 3   | 2      | 2     |
| 4   | 2      | 1     |

Doctor table

| dr_id | name         |     
| ----- | ------------ | 
| 1     | Lars Larsson |   
| 2     | Eva Lundgren |    
| 3     | Luca Toni    |    
|       |              |     

Hospital doctor table

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
JOIN doctor d ON hd.dr_id = d.dr_id
JOIN hospital h ON hd.hosp_id = h.hosp_id
JOIN department_doctor dd ON d.dr_id = dd.dr_id
JOIN department dep ON dd.dep_id = dep.dep_id
ORDER BY doctor_name, hospital_name;
