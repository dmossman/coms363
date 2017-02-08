Drop Enrollment;
Drop Offering;
Drop Course;
Drop Student;
Drop Instructor;
Drop Person;

create table Person (
Name char (20),
ID char (9) not null,
Address char (30),
DOB date,
Primary key (ID))

create table Instructor (
InstructorID char (9) not null references Person(ID),
Rank char (12),
Salary int,
Primary key (InstructorID))

create table Student (
StudentID char (9) not null references Person(ID),
Classification char (10),
GPA double,
MentorID char (9) references Instructor(InstructorID),
CreditHours int,
Primary key (StudentID))

create table Course (
CourseCode char (6) not null,
CourseName char (50),
PreReq char (6))

create table Offering (
CourseCode char(6) not null,
SectionNo int not null,
InstructorID char(9) not null references Instructor(InstructorID))

create table Enrollment (
CourseCode char(6) not null,
SectionNo int not null,
StudentID char(9) not null references Student,
Grade char(4) not null,
primary key (CourseCode, StudentID), 
foreign key (CourseCode, SectionNo) references Offering(CourseCode, SectionNo))