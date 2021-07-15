CREATE DATABASE Uni_HomeWork_

USE Uni_HomeWork_

CREATE TABLE TblDepartment(
DepartmentID int PRIMARY KEY NOT NULL IDENTITY(1,1),
DepartmentName nvarchar(50) NOT NULL
)

CREATE TABLE TblDuty(
DutyID int PRIMARY KEY NOT NULL IDENTITY(1,1),
Duty nvarchar(50) NOT NULL
)

CREATE TABLE TblCityAdress(
CityID int PRIMARY KEY NOT NULL IDENTITY(1,1),
City nvarchar(50) NOT NULL
)

CREATE TABLE TblWorker(
WorkerID int PRIMARY KEY NOT NULL IDENTITY(1,1),
Name nvarchar(50) NOT NULL,
Surname nvarchar(50) NOT NULL,
Salary smallmoney NOT NULL,
OwnerID int FOREIGN KEY REFERENCES TblWorker(WorkerID),
DepartmentID int NOT NULL FOREIGN KEY REFERENCES TblDepartment(DepartmentID),
CityAdressID int NOT NULL FOREIGN KEY REFERENCES TblCityAdress(CityID),
DutyID int NOT NULL FOREIGN KEY REFERENCES TblDuty(DutyID),
)

ALTER TABLE TblDepartment ADD IsDepartmentDelete bit NOT NULL

ALTER TABLE TblDuty ADD IsDutyDelete bit NOT NULL

ALTER TABLE TblCityAdress ADD IsCityDelete bit NOT NULL

ALTER TABLE TblWorker ADD IsWorkerDelete bit NOT NULL

CREATE TABLE TblChair(
ChairID int PRIMARY KEY NOT NULL IDENTITY(1,1),
Chair nvarchar(50) NOT NULL,
IsChairDelete bit NOT NULL
)

CREATE TABLE TblTeacher(
TeacherID int PRIMARY KEY NOT NULL IDENTITY(1,1),
Name nvarchar(50) NOT NULL,
Surname nvarchar(50) NOT NULL,
Salary smallmoney NOT NULL,
PhoneNumber char(13) NOT NULL,
IsTeacherDelete bit NOT NULL,
CityAdressID int NOT NULL FOREIGN KEY REFERENCES TblCityAdress(CityID),
DutyID int NOT NULL FOREIGN KEY REFERENCES TblDuty(DutyID)
)

CREATE TABLE TblChairTeacher(
ChairTeacherID int NOT NULL IDENTITY(1,1),
TeacherID int  NOT NULL,
ChairID int NOT NULL,
PRIMARY KEY(ChairTeacherID,TeacherID,ChairID),
FOREIGN KEY (TeacherID) REFERENCES TblTeacher(TeacherID),
FOREIGN KEY (ChairID) REFERENCES TblChair(ChairID)
)

ALTER TABLE TblChairTeacher ADD IsChairTeacherDelete bit NOT NULL

ALTER TABLE TblDepartment
ADD CONSTRAINT df_IsDepartmentDelete
DEFAULT 'False' FOR IsDepartmentDelete

ALTER TABLE TblDuty
ADD CONSTRAINT df_IsDutyDelete
DEFAULT 'False' FOR IsDutyDelete

ALTER TABLE TblCityAdress
ADD CONSTRAINT df_IsCityDelete
DEFAULT 'False' FOR IsCityDelete

ALTER TABLE TblWorker
ADD CONSTRAINT df_IsWorkerDelete
DEFAULT 'False' FOR IsWorkerDelete

ALTER TABLE TblChair
ADD CONSTRAINT df_IsChairDelete
DEFAULT 'False' FOR IsChairDelete

ALTER TABLE TblTeacher
ADD CONSTRAINT df_IsTeacherDelete
DEFAULT 'False' FOR IsTeacherDelete

ALTER TABLE TblChairTeacher
ADD CONSTRAINT df_IsChairTeacherDelete
DEFAULT 'False' FOR IsChairTeacherDelete

--sadasdsdssda
CREATE TABLE TblScience(
ScienceİD int PRIMARY KEY NOT NULL IDENTITY(1,1),
Science nvarchar(50) NOT NULL,
ScienceCredit nvarchar(50) NOT NULL,
IsScienceDelete bit NOT NULL DEFAULT 'False'
)

CREATE TABLE TblTeacherScience(
TeacherScienceID int NOT NULL IDENTITY(1,1),
TeacherID int  NOT NULL,
ScienceİD int NOT NULL,
IsTeacherScienceDelete bit NOT NULL DEFAULT 'False'
PRIMARY KEY(TeacherScienceID,TeacherID,ScienceİD),
FOREIGN KEY (TeacherID) REFERENCES TblTeacher(TeacherID),
FOREIGN KEY (ScienceİD) REFERENCES TblScience(ScienceİD)
)

CREATE TABLE TblFaculty(
FacultyID int  PRIMARY KEY NOT NULL IDENTITY(1,1),
Faculty nvarchar(50) NOT NULL,
IsFacultyDelete bit NOT NULL DEFAULT 'False'

)

CREATE TABLE TblLanguage(
LanguageID int  PRIMARY KEY NOT NULL IDENTITY(1,1),
Language nvarchar(50) NOT NULL,
IsLanguageDelete bit NOT NULL DEFAULT 'False'
)

CREATE TABLE TblSpecialty(
SpecialtyID int PRIMARY KEY NOT NULL IDENTITY(1,1),
Specialty nvarchar(50) NOT NULL,
IsSpecialtyDelete bit NOT NULL DEFAULT 'False',
FacultyID int NOT NULL FOREIGN KEY REFERENCES TblFaculty(FacultyID),
LanguageID int NOT NULL FOREIGN KEY REFERENCES TblLanguage(LanguageID)
)

CREATE TABLE TblGroup(
GroupID int  PRIMARY KEY NOT NULL IDENTITY(1,1),
_Group nvarchar(50) NOT NULL,
IsGroupDelete bit NOT NULL DEFAULT 'False'
)

CREATE TABLE TblStudent(
StudentID int PRIMARY KEY NOT NULL IDENTITY(1,1),
Name nvarchar(50) NOT NULL,
Surname nvarchar(50) NOT NULL,
Scholarship smallmoney NOT NULL DEFAULT 0,
PhoneNumber char(13) NOT NULL DEFAULT 'Yoxdu',
TuitionFees smallmoney NOT NULL,
IsStudentDelete bit NOT NULL DEFAULT 'False',
CityAdressID int NOT NULL FOREIGN KEY REFERENCES TblCityAdress(CityID),
PaymentScheduleID int NOT NULL,
SpecialtyID int NOT NULL FOREIGN KEY REFERENCES TblSpecialty(SpecialtyID),
GroupID int NOT NULL FOREIGN KEY REFERENCES TblGroup(GroupID),
)

CREATE TABLE TblPaymentSchedule(
PaymentScheduleID int PRIMARY KEY NOT NULL IDENTITY(1,1),
AmountPaid smallmoney NOT NULL DEFAULT 0,
RemainingDebt smallmoney NOT NULL,
IsPaymentScheduleDelete bit NOT NULL DEFAULT 'False',
StudentID int NOT NULL UNIQUE FOREIGN KEY REFERENCES TblStudent(StudentID),
)

CREATE TABLE TblStudentScore(
StudentScoreID int NOT NULL IDENTITY(1,1),
StudentID int  NOT NULL,
ScienceİD int NOT NULL,
IsTeacherScienceDelete bit NOT NULL DEFAULT 'False'
PRIMARY KEY(StudentScoreID,StudentID,ScienceİD),
FOREIGN KEY (StudentID) REFERENCES TblStudent(StudentID),
FOREIGN KEY (ScienceİD) REFERENCES TblScience(ScienceİD)
)

CREATE TABLE TblRoom(
RoomID int  PRIMARY KEY NOT NULL IDENTITY(1,1),
Room nvarchar(50) NOT NULL UNIQUE,
IsRoomDelete bit NOT NULL DEFAULT 'False'
)

CREATE TABLE TblLesson(
LessonID int  PRIMARY KEY NOT NULL IDENTITY(1,1),
ScienceID int NOT NULL,
TeacherID int NOT NULL,
IsLessonDelete bit NOT NULL DEFAULT 'False'
)

CREATE TABLE TblLessonSchedule(
LessonScheduleID int NOT NULL IDENTITY(1,1),
LessonDateTime datetime NOT NULL, 
LessonID int NOT NULL,
GroupID int NOT NULL,
RoomID int NOT NULL,
IsLessonScheduleDelete bit NOT NULL DEFAULT 'False'
PRIMARY KEY(LessonScheduleID,LessonDateTime,RoomID),
FOREIGN KEY (RoomID) REFERENCES TblRoom(RoomID),
FOREIGN KEY (LessonID) REFERENCES TblLesson(LessonID),
FOREIGN KEY (GroupID) REFERENCES TblGroup(GroupID)
)

CREATE TABLE TblGroupTecher(
GroupTecherID int NOT NULL IDENTITY(1,1),
TeacherID int NOT NULL,
GroupID int NOT NULL,
IsGroupTecherDelete bit NOT NULL DEFAULT 'False'
PRIMARY KEY(GroupTecherID,TeacherID,GroupID),
FOREIGN KEY (TeacherID) REFERENCES TblTeacher(TeacherID),
FOREIGN KEY (GroupID) REFERENCES TblGroup(GroupID)
)



