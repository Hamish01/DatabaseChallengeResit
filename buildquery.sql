--use database s103599187
/* Hamish Sansom 103599187
Subject(SubjCode, Description)
PrimaryKey(SubjCode)
Teacher(StaffID, Surname, GivenName)
PrimaryKey(StaffID)
Student(StudentID, Surname, GivenName, Gender)
PrimaryKey(StudentID)
SubjectOffering(SubjCode, StaffID, Year, Semester, Fee)
PrimaryKey( Year, Semester)
ForiegnKey(SubjCode, StaffID)
Enrolment(SubjCode, StaffID, Year, Semester, StudentID, DateEnrolled, Grade)
ForiegnKey(SubjCode, StaffID, Year, Semester, StudentID)
*/
USE DATABASE s103599187
IF OBJECT_ID('Subject') IS NOT NULL
    DROP TABLE Subject;
IF OBJECT_ID('Student') IS NOT NULL
    DROP TABLE Subject;
IF OBJECT_ID('Teacher') IS NOT NULL
    DROP TABLE Subject;
IF OBJECT_ID('SubjectOffering') IS NOT NULL
    DROP TABLE Subject;
IF OBJECT_ID('Enrolment') IS NOT NULL
    DROP TABLE Subject;

GO

CREATE TABLE Subject(
    SubjCode NVARCHAR(100) PRIMARY KEY,
    SubjDescription NVARCHAR(500)
);
CREATE TABLE Student(
    StudentID NVARCHAR(10) PRIMARY KEY,
    Surname NVARCHAR(100) NOT NULL, 
    GivenName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(1),
    CHECK (Gender IN ('M', 'F', 'I'))
);
CREATE TABLE Teacher(
    StaffID int PRIMARY KEY CHECK(LEN(StaffID)=8),
    Surname NVARCHAR(100) NOT NULL, 
    GivenName NVARCHAR(100) Not NULL
);
CREATE TABLE SubjectOffering(
    SubjCode NVARCHAR(100) FOREIGN KEY REFERENCES Subject,
    Year INT CHECK(len(Year)=4),
    Semester INT CHECK(Semester in (1,2)),
    Fee MONEY NOT NULL CHECK(Fee>0),
    StaffID INT FOREIGN KEY REFERENCES Teacher,
    CONSTRAINT PK_SubjectOffering PRIMARY KEY (Year, Semester)
);
CREATE TABLE Enrolment(
    StudentID NVARCHAR(100) FOREIGN KEY REFERENCES Student,
    SubjCode NVARCHAR(100) FOREIGN KEY REFERENCES SubjectOffering,
    Year INT FOREIGN KEY REFERENCES SubjectOffering CHECK(len(Year)=4),
    Semester INT FOREIGN KEY REFERENCES SubjectOffering CHECK(Semester in (1,2)),
    Grade NVARCHAR(2) CHECK(Grade in ('N', 'P', 'C', 'D', 'HD')),
    DateEnrolled DATE
);