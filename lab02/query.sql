-- Create Person table - Item 1
create table Person (
Name char (20),
ID char (9) not null,
Address char (30),
DOB date,
Primary key (ID));

-- Create Instructor table - Item 2
create table Instructor (
InstructorID char (9) not null references Person(ID),
Rank char (12),
Salary int,
Primary key (InstructorID));

-- Create Student table - Item 3
create table Student (
StudentID char (9) not null references Person(ID),
Classification char (10),
GPA double,
MentorID char (9) references Instructor(InstructorID),
CreditHours int,
Primary key (StudentID));

-- Create Course table - Item 4
create table Course (
CourseCode char (6) not null,
CourseName char (50),
PreReq char (6),
Primary key (CourseCode, PreReq));

-- Create Offering table - Item 5
create table Offering (
CourseCode char(6) not null,
SectionNo int not null,
InstructorID char(9) not null references Instructor(InstructorID),
Primary key (CourseCode, SectionNo));

-- Create Enrollment table - Item 6
create table Enrollment (
CourseCode char(6) not null,
SectionNo int not null,
StudentID char(9) not null references Student,
Grade char(4) not null,
Primary key (CourseCode, StudentID), 
Foreign key (CourseCode, SectionNo) references Offering(CourseCode, SectionNo));

-- Populate Person table - Item 7 
load xml local infile 'U:\\COMS363\\coms363\\lab02\\UniversityXML\\Person.xml' 
into table Person 
rows identified by '<Person>';

-- Populate Instructor table - Item 8 
load xml local infile 'U:\\COMS363\\coms363\\lab02\\UniversityXML\\Instructor.xml' 
into table Instructor 
rows identified by '<Instructor>';

-- Populate Student table - Item 9 
load xml local infile 'U:\\COMS363\\coms363\\lab02\\UniversityXML\\Student.xml' 
into table Student 
rows identified by '<Student>';

-- Populate Course table - Item 10 
load xml local infile 'U:\\COMS363\\coms363\\lab02\\UniversityXML\\Course.xml' 
into table Course 
rows identified by '<Course>';

-- Populate Offering table - Item 11 
load xml local infile 'U:\\COMS363\\coms363\\lab02\\UniversityXML\\Offering.xml' 
into table Offering 
rows identified by '<Offering>';

-- Populate Enrollment table - Item 12 
load xml local infile 'U:\\COMS363\\coms363\\lab02\\UniversityXML\\Enrollment.xml' 
into table Enrollment 
rows identified by '<Enrollment>';

-- Item 13
select StudentID, MentorID from Student where 
(Classification = "Junior" or Classification = "Senior") and GPA > 3.8;

-- Item 14
select distinct e.CourseCode, e.SectionNo from Student s, Enrollment e where 
s.StudentID = e.StudentID and s.Classification = "Sophomore";

-- Item 15
select distinct p.Name, m.Salary from Instructor m, Student s, Person p where
s.MentorID = m.InstructorID and m.InstructorID = p.ID and s.Classification = "Freshman";

-- Item 16
select sum(Salary) from Instructor where InstructorID not in 
(select InstructorID from Offering);

-- Item 17
select p.Name, p.DOB from Person p, Student s where
s.StudentID = p.ID and year(p.DOB) = 1976;

-- Item 18
select distinct p.Name, i.Rank, p.ID from Person p, Instructor i where
p.ID = i.InstructorID and  
i.InstructorID not in (select InstructorID from Offering) and
i.InstructorID not in (select MentorID from Student);
 
-- Item 19
select p.ID, p.Name, p.DOB from Person p, Student s where
s.StudentID = p.ID and p.DOB = (select max(p.DOB) from Person p, Student s where
s.StudentID = p.ID);

-- Item 20
select p.ID, p.DOB, p.Name from Person p where
p.ID not in (select StudentID from Student) and
p.ID not in (select InstructorID from Instructor);

-- Item 21
select p.Name, count(*) as Mentees -- output name and number of rows in each group (4)
from Person p, Instructor i, Student s -- take cross product of all three relations (1)
where p.ID = i.InstructorID -- select only tuples where the person is the instructor (2)
and s.MentorID = i.InstructorID -- select only tuples where the instructor mentors the student (2)
group by p.ID -- grouping by instructor (group by p.ID, i.InstructorID, or s.MentorID identical) (3)
order by Mentees desc; -- sort by number of mentees (5)

-- Item 22
select Classification, count(*) as NumStudents, avg(s.GPA) as AvgGPA
from Student s
group by Classification;

-- Item 23
select CourseCode, NumEnrolled from
(select e.CourseCode, count(*) as NumEnrolled
from Enrollment e, Student s
where e.StudentID = s.StudentID
group by CourseCode) as CourseEnrollment
where NumEnrolled = (select min(NumEnrolled) from(
	select count(*) as NumEnrolled
	from Enrollment e, Student s
	where e.StudentID = s.StudentID
	group by CourseCode) as counts);
-- There has got to be a better way to do that, but at least it works.

-- Item 24
select distinct s.StudentID, o.InstructorID from 
Student s, Offering o, Enrollment e 
where o.InstructorID = s.MentorID and e.StudentID = s.StudentID
and e.CourseCode = o.CourseCode;

-- Item 25
select s.StudentID, p.Name, s.CreditHours from Student s, Person p
where s.Classification = "Freshman" and p.ID = s.StudentID and
year(p.DOB) >= 1976;

-- Item 26
insert into Person (Name, ID, Address, DOB)
values ("Briggs Jason", 480293439, 
"215, North Hyland Avenue", '1975-01-15');

insert into Student (StudentID, Classification, GPA, MentorID, CreditHours)
values (480293439, "Junior", 3.48, 201586985, 75);

insert into Enrollment (CourseCode, SectionNo, StudentID, Grade)
values ("CS311", 2, 480293439, "A");

insert into Enrollment (CourseCode, SectionNo, StudentID, Grade)
values ("CS330", 1, 480293439, "A-");

select * from Person where ID = 480293439;
select * from Student s where s.StudentID= 480293439;
select * from Enrollment e where e.StudentID = 480293439;

-- Item 27
delete Enrollment, Student from Enrollment inner join Student
where Student.GPA < 0.5 and Enrollment.StudentID = Student.StudentID;
 
select * from Student s where s.GPA < 0.5;

-- Item 28
-- skipped because it was optional

-- Item 29
insert into Person (Name, ID, Address, DOB)
values ("Trevor Horns", 000957303, "23 Canberra Street", '1964-11-23');
 
Select *
From Person P
Where P.Name = "Trevor Horns";

-- Item 30
delete Person, Student, Instructor from Person inner join Student, Instructor
where Person.Name = "Jan Austin";

Select *
From Person P
Where P.Name = "Jan Austin";



