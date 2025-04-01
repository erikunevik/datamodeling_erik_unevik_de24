#Objective 0 - Data modeling

## a)

Done

## b)

<img src = "../assets/0b15.png">

## c)

School - Program Enrollment
- A school may have many program enrollments, but each program enrollment is linked to one individual school.

Program – Program Enrollment
- A program may have many program enrollments, but each program enrollment is linked to one individual program.

Program - Class
- A Program may have many classes, but each class are linked to one individual Program

Class – Course Enrollment
- A class may have many course enrollments, but each enrollment is linked to one Course.

Course – Course Enrollment
- A Course may have many course enrollments, but each enrollment are linked to one indivudal class.

Course – Course outside Program
- One or more courses may be listed in Courses outside Program , but each record Courses outside Program is linked to one Course.

School - Course outside Program
- A School may have many records in Courses outside Program, but each record in Courses outside Program is linked to one indivudal School.

Course - Student Enrollment
- A course may have many student enrollments, but each student enrollment is linked to an indivudal course.

Student Enrollment - Student
- A student may have many enrollments, but each enrollment is linked to one indivudal Student.

Student - Student Info
- Each student has an individual record in student info, and each Student Info record is linked to one indivudal Student.

Vocational Provider - School
- A Vocational Provider may work at many schools , but each School is linked to one Vocational Provider.

Vocational Provider - Staff Info
- Each Vocational Provider has one individual record in Staff Info, and each Staff Info record is linked to one Vocational Provider. 

Course Director - Class
- A Course Director manages three classes, but each class has one personal Course Director assigned to it. 

Course Director - Staff Info
- Each Course Director has an individual record in Staff Info, and each record in Staff Info is linked to one Director. 

Teacher - Teachers List
- One or many teachers may have a record in Teachers List, but each record in Teachers List refers to one teacher.

Course - Teachers List
- One or many courses may have a record in Teachers List, but only one teacher from Teachers List is linked to one course.

Teacher - Staff Info
- Each teacher has one individual record in Staff Info, and each record in Staff Info is linked to one teacher. 

Teacher - Consult Info
- If a teacher is a consultant they will have an individual record in Consult Info, and each record in Consult Info is linked to one teacher if she or he is an consultant. 

## d)

For unknown reason  when this file from from Lucid Charts, my double crossed crow´s feet notation between Teacher and Consult Info does not appear in the picture but at Lucis charts, even after multiple attempts to save it again.

<img src = "../assets/0d3.png">

## e)






























