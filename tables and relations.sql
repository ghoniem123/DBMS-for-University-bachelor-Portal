create database Milestone3

CREATE TABLE Users (
Userid INT IDENTITY PRIMARY KEY,
Username VARCHAR(20) NOT NULL,
Pass VARCHAR(10) NOT NULL,
Email VARCHAR(50) NOT NULL,
UserRole varchar(20),
PhoneNumber VARCHAR(20)
);

CREATE TABLE Lecturer(
LecturerID INT PRIMARY KEY FOREIGN KEY REFERENCES Users ON DELETE CASCADE,
Schedule VARCHAR(1000)
);

create table LecturerFields(
LecturerID int FOREIGN KEY REFERENCES Lecturer ON DELETE CASCADE ,
field varchar(500)
primary key (LecturerID, field)
);

create table Company(
CompanyID int primary key foreign key references Users ON DELETE CASCADE ,
CompanyName varchar(50) not null,
RepresentativeName varchar(50) not null ,
RepresentativeEmail varchar(50) not null,
CompanyLocation varchar(50)
);

create table Employee(
StaffID int identity,
CompanyID int foreign key references Company ON DELETE CASCADE ,
Username varchar(50) not null,
Pass varchar(20)  not null,
Email varchar(50) not null,
Field varchar(50) ,
Phone varchar(50)
primary key (StaffID, CompanyID)
);

create table ExternalExaminer (
EEID int primary key foreign key references Users ON DELETE CASCADE,
Schedule VARCHAR(1000)
);

create table TeachingAssistant(
TAID int primary key foreign key references Users ON DELETE CASCADE,
Schedule VARCHAR(1000)
);

create table Coordinator(
coodrinatorID int primary key foreign key references Users ON DELETE CASCADE,
);

create table BachelorProject(
Code varchar(50) primary key not null, 
Projectname varchar(50) not null,
SubmittedMaterial varchar(1000),
ProjectDescription varchar(1000)
);

create table BachelorSubmittedMaterials (
Code varchar(50) primary key foreign key references BachelorProject ON DELETE CASCADE not null,
Material varchar(1000)

);

create table Academic (
AcademicCode varchar(50) primary key foreign key references BachelorProject ON DELETE CASCADE not null,
LID int foreign key references Lecturer,
TAID int foreign key references TeachingAssistant,
EEID int foreign key references ExternalExaminer
);

create table Industrial (
 IndustrialCode varchar(50) primary key foreign key references BachelorProject ON DELETE CASCADE not null,
 CID int foreign key references Company,
 LID int foreign key references Lecturer,
 EID int,
 foreign key (EID, CID ) references Employee(StaffID, CompanyID)

 );

 create table Faculty(
 FacultyCode varchar(50) primary key not null,
 FacultyName varchar(50),
 Dean int foreign key references Lecturer
 );

 create table Major(
 MajorCode varchar(10) primary key not null,
 FacultyCode varchar(50) foreign key references Faculty ON DELETE SET NULL ,
 MajorName varchar(50)
 );

 create table Meeting(
 MeetingID int identity primary key not null,
 LID int foreign key references Lecturer,
 STime time,
 ETime time,
 Duration as DATEDIFF(minute, STime,ETime ),
 MeetingDate datetime,
 MeetingPoint varchar(5)
 );


 create table MeetingToDoList(
 MeetingID int primary key foreign key references Meeting ON DELETE CASCADE not null,
 ToDoList varchar(1000)
 );

 create table MeetingAttendant (
  MeetingID int foreign key references Meeting ,
  AttendantID int foreign key references Users ,
  primary key (MeetingID, AttendantID)
  );

  
create table Student(
StudentID int primary key foreign key references Users ON DELETE CASCADE ,
firstname varchar(50) not null,
lastname varchar(50) not null,
MajorCode varchar(10) foreign key references Major ON DELETE SET NULL,
DateOfBirth datetime not null,
StudentAddress varchar(100),
age AS (YEAR(CURRENT_TIMESTAMP) - YEAR(DateOfBirth)),
Semester int,
GPA decimal(3,2) ,
TotalBachelorGrade float,
AssignedProjectcode varchar(50) foreign key references BachelorProject ON DELETE CASCADE
);

  create table Thesis (
  StudentID int foreign key references Student ON DELETE CASCADE not null ,
  Title varchar(50) default 'Title',
  Deadline datetime,
  PDFDoc varchar(1000),
  TotalGrade float

  primary key (StudentID, Title)
  );
  
  create table Defense (
  StudentID int foreign key references Student ON DELETE CASCADE not null,
  DefenseLocation varchar(50) not null,
  Content varchar(1000),
  defenseTime time,
  defenseDate datetime,
  TotalGrade float

  primary key (StudentID, DefenseLocation)
  );

  create table ProgressReport (
    StudentID int foreign key references Student ON DELETE CASCADE not null,
    ReportDate datetime not null,
    Content varchar(50),
    Grade float,
    UpdatingUserID int foreign key references Users not null,
    ComulativeProgressReportGrade float
    primary key (StudentID, ReportDate)
);

   create table GradeIndustrialPR (
    CID int foreign key references Company not null,
    StudentID int ,
    PRDate datetime,
    CompanyGrade float,
    LecturerGrade float,
    foreign key (StudentID, PRDate) references ProgressReport(StudentID, ReportDate),
    primary key(StudentID, PRDate)
    );

    create table GradeAcademicPR(
    LID int foreign key references Lecturer,
    StudentID int ,
    PRDate datetime,
    LecturerGrade float,
    foreign key (StudentID, PRDate) references ProgressReport(StudentID, ReportDate),
    primary key(StudentID, PRDate)
    );

    create table GradeAcademicThesis(
    LID int foreign key references Lecturer  not null,
    EEID int foreign key references EXternalExaminer not null,
    StudentID int ,
    Title varchar(50) ,
    EEGrade float,
    LecturerGrade float,
    foreign key (StudentID, Title) references Thesis(StudentID, Title) ,
    primary key (StudentID, Title)
    );


    create table GradeIndustrialThesis(
    CID int foreign key references Company not null,
    EID int not null,
    StudentID int,
    Title varchar(50) ,
    CompanyGrade float,
    EmployeeGrade float,
    foreign key (EID, CID) references Employee(StaffID, CompanyID),
    foreign key (StudentID , Title ) references thesis (StudentID, Title),
    primary key (StudentID, Title)
    );

    create table GradeAcademicDefense(
    LID int foreign key references Lecturer,
    EEID int foreign key references EXternalExaminer,
    StudentID int ,
    DefenseLocation varchar(50),
    EEGrade float,
    LecturerGrade float,
    foreign key (StudentID, DefenseLocation) references Defense(StudentID, DefenseLocation),
    primary key (StudentID, DefenseLocation)
    );

    create table GradeIndustrialDefense (
    CID int foreign key references Company,
    EID int ,
    StudentID int ,
    DefenseLocation varchar(50) ,
    CompanyGrade float,
    EmployeeGrade float,
    foreign key (CID, EID ) references Employee(StaffID, CompanyID),
    foreign key (StudentID, DefenseLocation) references Defense(StudentID, DefenseLocation),
    primary key (StudentID, DefenseLocation)
    );

    create table LecturerRecommendEE(
    LID int foreign key references Lecturer ON DELETE CASCADE not null,
    EEID int foreign key references EXternalExaminer not null,
    PCode varchar(50) foreign key references Academic not null,
    primary key (EEID, PCode)
    );

    create table StudentPreferences(
    StudentID int foreign key references Student ON DELETE CASCADE not null,
    PCode varchar(50) foreign key references BachelorProject not null,
    PreferenceNumber int
    primary key (StudentID, PCode)
    );

    create table MajorHasBachelorProject(
    MajorCode varchar(10) foreign key references Major ON DELETE CASCADE not null,
    PCode varchar(50) foreign key references BachelorProject ON DELETE CASCADE not null,
    primary key (MajorCode,PCode)
    );
     

  