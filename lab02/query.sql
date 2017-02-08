Drop table Enrollment;
Drop table Offering;
Drop table Course;
Drop table Student;
Drop table Instructor;
Drop table Person;

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
-- select StudentID, MentorID from Student where 
-- (Classification = "Junior" or Classification = "Senior") and GPA > 3.8;

-- Item 14
-- select distinct e.CourseCode, e.SectionNo from Student s, Enrollment e where 
-- s.StudentID = e.StudentID and s.Classification = "Sophomore";

-- Item 15
-- select distinct p.Name, m.Salary from Instructor m, Student s, Person p where
-- s.MentorID = m.InstructorID and m.InstructorID = p.ID and s.Classification = "Freshman";

-- Item 16
-- select sum(Salary) from Instructor where InstructorID not in 
-- (select InstructorID from Offering);

-- Item 17
-- select p.Name, p.DOB from Person p, Student s where
-- s.StudentID = p.ID and year(p.DOB) = 1976;

-- Item 18
-- select distinct p.Name, i.Rank, p.ID from Person p, Instructor i where
-- p.ID = i.InstructorID and  
-- i.InstructorID not in (select InstructorID from Offering) and
-- i.InstructorID not in (select MentorID from Student);
 
-- Item 19
-- select p.ID, p.Name, p.DOB from Person p, Student s where
-- s.StudentID = p.ID and p.DOB = (select max(p.DOB) from Person p, Student s where
-- s.StudentID = p.ID);

-- Item 20
-- select p.ID, p.DOB, p.Name from Person p where
-- p.ID not in (select StudentID from Student) and
-- p.ID not in (select InstructorID from Instructor);

-- Item 21
select p.Name, count(*) as Mentees from Person p, Instructor i, Student s
where p.ID = i.InstructorID -- select only tuples where the person is the instructor
and s.MentorID = i.InstructorID -- select only tuples where the instructor mentors the student
group by p.ID -- grouping by instructor (group by p.ID, i.InstructorID, or s.MentorID identical)
order by Mentees desc; -- sort by number of mentees

-- Item 22




