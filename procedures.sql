CREATE PROCEDURE UserRegister @usertype varchar(20), @Username varchar(20), @Email varchar(50), @firstname varchar(20),
    @lastname varchar(20), @DateOfBirth datetime, @GPA decimal(3,2), @Semester int, @StudentAddress varchar(100), @FacultyCode varchar(10), @MajorCode varchar(10), @company_name varchar(20),
    @RepresentativeName varchar(20), @RepresentativeEmail varchar(50), @Phone varchar(20),@CompanyLocation varchar(20), 
    @ID int output, @password varchar(10) output
    AS

    set @password = FLOOR(RAND() * (100000 - 1 + 1)) + 1;

    if (exists(
      Select *
      From users
      where @Email = Email 
      ))
      begin
      set @password='email';
      print 'The user already exists'
      end

	  else if (not exists(
	  select*
	  from Major
	  where @MajorCode=MajorCode
	  ))
	  begin
       set @password='major';
	  end

      else 
      begin
      Insert into Users values(@Username, @password, @Email, @usertype, @Phone);

     select @ID = Userid
     from Users
     where @Email=Email;
     
     if (@usertype = 'Student')
     begin
       insert into Student values (@ID,@firstname,  @lastname,@MajorCode,@DateOfBirth,  @StudentAddress, @Semester, @GPA, null, null);
       end;
    else if (@usertype='Company')
      insert into Company values (@ID, @company_name, @RepresentativeName, @RepresentativeEmail, @CompanyLocation)
      else if (@usertype='Lecturer')
      insert into Lecturer values (@ID, null)
      else if (@usertype='Teaching Assistant')
      insert into TeachingAssistant values (@ID, null)
      else if (@usertype='External examiner')
      insert into ExternalExaminer values (@ID, null)
      else if (@usertype='Coordinator')
      insert into Coordinator values (@ID)
      else 
      print ' you cant register on the system '
      end

go; 

 create procedure UserLogin @email varchar(50), @password varchar(10), @success bit output, @ID int output
 as 
 if (exists(
 Select *
 from Users
 where Users.Email=@email and Users.Pass=@password
 ))

 set @success='1';
 else 
 set @success='0';

 if (@success='1')
 Select @ID = Users.Userid
 from Users
 where Users.Email=@email and Users.Pass=@password
 else 
 set @ID=-1;
 go;

 create procedure ViewProfile @ID int
 as 
 select*
 from Users
 where Users.Userid=@ID
 go;


 create procedure MakePreferencesLocalProject @sid int , @bachelorCode varchar(10), @preferenceNumber int
 as
declare @MCode varchar(10)=null;

select @MCode=MajorCode
from Student
where StudentID=@sid

if (exists (
   select*
   from MajorHasBachelorProject
   where MajorCode=@MCode and PCode=@bachelorCode
))
begin

if (not exists(
select*
from StudentPreferences
where StudentID=@sid and PreferenceNumber=@preferenceNumber
))
begin
insert into StudentPreferences values (@sid, @bachelorCode, @preferenceNumber)
end
end
else 

print 'you can only make preferences to projects those belong to your major'

go;

create procedure ViewMyThesis @sid int, @title varchar(50)
as
declare @type varchar(50) = 'no thesis';
declare @grade float=-500;
if (exists (
    select*
    from GradeAcademicThesis
    where StudentID=@sid and Title=@title
    ))
    set @type='academic'

    if (exists (
    select*
    from GradeIndustrialThesis
    where StudentID=@sid and Title=@title
    ))
    set @type='industrial';

    if (@type='no thesis')
      print'This thesis is not found';

    else if (@type='academic')
     
     select @grade=(EEGrade+LecturerGrade)/2
     from GradeAcademicThesis
     where StudentID=@sid and Title=@title and EEGrade is not null and LecturerGrade is not null

     else if (@type='industrial')
     select @grade=(CompanyGrade+ EmployeeGrade)/2
     from GradeIndustrialThesis
     where StudentID=@sid and Title=@title and CompanyGrade is not null and EmployeeGrade is not null
 
     if (@grade <> -500)
     update Thesis
     set TotalGrade=@grade
     where StudentID=@sid and Title=@title

     select*
     from Thesis
     where StudentID=@sid and Title=@title

     go;

    

     
     create procedure SubmitMyThesis @sid int, @title varchar(50), @PDFDocument varchar(1000)
     as 
     update Thesis
     set PDFDoc=@PDFDocument
     where StudentID=@sid and Title=@title
     go;
     
     CREATE procedure ViewMyProgressReport @sid int, @date datetime
     as 

	  if (@date = '9999/12/31')
	 begin
	 set @date=null;
	 end

	 exec ComulativeGradeProgressReport @sid, @date

     if (@date is null)
      select *
      from ProgressReport
      where StudentID=@sid
      order by ReportDate desc

     if (@date is not null)
      select *
      from ProgressReport
      where StudentID=@sid and ReportDate=@date

      go;


      create procedure ViewMyDefense @sid int
      as
      declare @type varchar(50) = 'no defense';
     declare @grade float=-500;
    if (exists (
     select*
     from GradeAcademicDefense
     where StudentID=@sid 
     ))
     set @type='academic'

     if (exists (
     select*
     from GradeIndustrialDefense
     where StudentID=@sid 
     ))
     set @type='industrial';

     if (@type='no defense')
      print'This defense is not found';

     else if (@type='academic')
     
     select @grade=(EEGrade+LecturerGrade)/2
     from GradeAcademicDefense
     where StudentID=@sid and EEGrade is not null and LecturerGrade is not null

      else if (@type='industrial')
      select @grade=(CompanyGrade+ EmployeeGrade)/2
      from GradeIndustrialDefense
      where StudentID=@sid and CompanyGrade is not null and EmployeeGrade is not null
 
      if (@grade <> -500)
      update Defense
      set TotalGrade=@grade
      where StudentID=@sid

      select*
      from Defense
      where StudentID=@sid 
      go;

    
      create procedure UpdateMyDefense @sid int, @defenseContent varchar(1000)
      as

      update Defense
      set Content=@defenseContent
      where StudentID=@sid

      go;

          CREATE procedure ViewMyBachelorProjectGrade @sid int, @BachelorGrade decimal(4,2) output
      as
      declare @thesisgrade float=-500;
      declare @defensegrade float=-500;
      declare @PR float=-500;
      declare @totalgrade float;

	  declare @com float;
	  exec ComulativeGradeProgressReportForBachelor  @sid, @com output;

      select @thesisgrade=0.3*TotalGrade
      from Thesis
      where StudentID=@sid and TotalGrade is not null

      select @defensegrade=0.3*TotalGrade
      from Defense
      where StudentID=@sid and TotalGrade is not null

	  if (@com is not null)
	  begin
      set @PR=0.4*@com
	  end
     
      if (@thesisgrade <> -500 and @defensegrade <> -500 and @PR <> -500)
       set @totalgrade=@thesisgrade+@defensegrade+@PR
      else 
       set @totalgrade=null

      update Student
      set TotalBachelorGrade=@totalgrade
      where StudentID=@sid

      set @BachelorGrade=@totalgrade

      go;

   CREATE procedure ComulativeGradeProgressReport @sid int, @date datetime
      as 
      declare @com float;
	  declare @maxdate datetime;

	  update ProgressReport
	  set ComulativeProgressReportGrade=null
	  where StudentID=@sid

	  if (@date is not null)
	  begin
	    select @com=AVG(Grade)
      from ProgressReport
      where StudentID=@sid and ReportDate<=@date 

      update ProgressReport
      set ComulativeProgressReportGrade=@com
      where StudentID=@sid and ReportDate=@date
	  end

	  if (@date is null)
	  begin

	  select @com=AVG(Grade)
      from ProgressReport
      where StudentID=@sid 

	  select @maxdate=MAX(ReportDate)
	  from ProgressReport
	  where StudentID=@sid

	  update ProgressReport
      set ComulativeProgressReportGrade=@com
      where StudentID=@sid and ReportDate=@maxdate
	  end

      go;

      create procedure AddEmployee @companyID int, @email varchar(50), @name varchar(20), @phone varchar(20),@field varchar(25),
      @staffID int output, @CompanyID_OUT int output, @password varchar(10) output
      as
      set @password = FLOOR(RAND() * (100000 - 1 + 1)) + 1;
      set @CompanyID_OUT=@companyID;
      insert into Employee values (@companyID, @name, @password,@email,@field, @phone);

      select @staffID=staffID
      from Employee
      where CompanyID=@companyID and Username= @name and Pass= @password and Email= @email and Field= @field and Phone= @phone
      go;

      create procedure CompanyCreateLocalProject @companyID int, @projCode varchar(10), @title varchar(50), @description varchar(200),
      @Majorcode varchar(10)
      as
      insert into BachelorProject values (@projCode, @title, null, @description);
      insert into Industrial values (@projCode, @companyID, null , null);
      insert into MajorHasBachelorProject values (@Majorcode, @projCode);
      go;

      create procedure AssignEmployee @bachelor_code varchar(10), @staffID int , @companyID int, @StaffID_OUT int output , 
          @Code varchar(10) output, @name varchar(50) output, @submitted_material varchar(1000) output, @description varchar(1000) output
      as 
      update Industrial
      set EID=@staffID
      where IndustrialCode=@bachelor_code

      set @StaffID_OUT=@staffID

      select @Code=Code, @name=Projectname, @submitted_material=SubmittedMaterial, @description=ProjectDescription
      from BachelorProject
      where Code=@bachelor_code

      go;

      create procedure CompanyGradeThesis @companyID int, @sid int, @thesisTitle varchar(50), @companyGrade decimal(4,2)
      as
      update GradeIndustrialThesis
      set CompanyGrade=@companyGrade,
         CID=@companyID
      where  StudentID=@sid and Title=@thesisTitle
      go;
     
      create procedure CompanyGradedefense @companyID int, @sid int, @defenseLocation varchar(5), @companyGrade decimal(4,2)
      as
      update GradeIndustrialDefense
      set CompanyGrade=@companyGrade,
          CID=@companyID
      where StudentID=@sid and DefenseLocation=@defenseLocation
      go;

      create procedure CompanyGradePR @companyID int, @sid int, @date datetime ,  @companyGrade decimal(4,2)
      as
      declare @success bit='0';

      if (exists(
      select*
      from GradeIndustrialPR
      where StudentID=@sid and PRDate=@date
      ))
      set @success='1';

      if (@success='1')
      update GradeIndustrialPR
      set CompanyGrade=@companyGrade
      where StudentID=@sid and PRDate=@date
      else 
      print 'There is no such a progress report'
      go;

      create procedure TACreatePR @TAid int, @sid int, @date datetime ,@content varchar(1000)
      as
      insert into ProgressReport values (@sid, @date, @content, null, @TAid, null)
      insert into GradeAcademicPR values (null, @sid, @date, null)
      go;

      create procedure TAAddToDo @meetingID int, @ToDoList varchar(200)
      as
       if (exists(
      select*
      from Meeting
      where MeetingID=@meetingID
      ))
      begin
      if (exists(
      select*
      from MeetingToDoList
      where MeetingID=@meetingID
      ))
      update MeetingToDoList
      set ToDoList=@ToDoList
      where MeetingID=@meetingID
      else
      insert into MeetingToDoList values (@meetingID, @ToDoList)

      end
      else
      print ' this meeting doesnt exist'
      go;

      create procedure EEGradeThesis @EEid int , @sid int, @thesistitle varchar(50), @EEgrade decimal (4,2)
      as
      declare @success bit='0'

      if (exists (
      select*
      from GradeAcademicThesis
      where StudentID=@sid and Title=@thesistitle
      ))
      set @success='1'

      if (@success='1')
      update GradeAcademicThesis
      set EEGrade=@EEgrade, 
          EEID=@EEid
      where StudentID=@sid and Title=@thesistitle
      else 
      print ' External examiner is not allowed to grade this thesis'

      go;

      create procedure EEGradedefense @EEid int , @sid int, @defenseLocation varchar(5), @EEgrade decimal (4,2)
      as
      declare @success bit='0'

      if (exists (
      select*
      from GradeAcademicDefense
      where StudentID=@sid and DefenseLocation=@defenseLocation
      ))
      set @success='1'

      if (@success='1')
      update GradeAcademicDefense
      set EEGrade=@EEgrade, 
          EEID=@EEid
      where StudentID=@sid and DefenseLocation=@defenseLocation
       else 
      print ' External examiner is not allowed to grade this defense'
      go;

      create procedure EmployeeGradeThesis @employeeID int , @sid int, @thesisTitle varchar(50), @EmployeeGrade decimal(4,2)
      as
       declare @success bit='0'

      if (exists (
      select*
      from GradeIndustrialThesis
      where StudentID=@sid and Title=@thesistitle
      ))
      set @success='1'

      if (@success='1')
      update GradeIndustrialThesis
      set EmployeeGrade=@EmployeeGrade, 
          EID=@employeeID
      where StudentID=@sid and Title=@thesistitle
       else 
      print ' Employee is not allowed to grade this thesis'
      go;

      create procedure EmployeeGradedefense @employeeID int , @sid int, @defenseLocation varchar(5), @EmployeeGrade decimal(4,2)
      as
        declare @success bit='0'

      if (exists (
      select*
      from GradeIndustrialDefense
      where StudentID=@sid and DefenseLocation=@defenseLocation
      ))
      set @success='1'

      if (@success='1')
      update GradeIndustrialDefense
      set EmployeeGrade=@EmployeeGrade, 
          EID=@employeeID
      where StudentID=@sid and DefenseLocation=@defenseLocation
         else 
      print ' Employee is not allowed to grade this defense'
      go;

      create procedure EmployeeCreatePR @employeeID int, @sid int, @date datetime, @content varchar(1000)
      as
      declare @code int;
      insert into ProgressReport values (@sid, @date, @content, null, @employeeID, null)

      select @code=CompanyID
      from Employee
      where StaffID=@employeeID

      insert into GradeIndustrialPR values (@code, @sid, @date, null, null)
      go;
      
      create procedure ViewUsers @userType varchar(20), @UserID int
      as
      if (@userType='Lecturer')
      select*
      from Users
      inner join Lecturer
      on Userid=LecturerID
      where Userid=@UserID
      else if (@userType='Company')
      select*
      from Users
      inner join Company
      on Userid=CompanyID
      where Userid=@UserID
      else if (@userType='Employee')
      select*
      from Users
      inner join Employee
      on Userid=CompanyID
      where Userid=@UserID
        else if (@userType='External examiner')
      select*
      from Users
      inner join ExternalExaminer
      on Userid=EEID
      where Userid=@UserID
        else if (@userType='Teaching assistant')
      select*
      from Users
      inner join TeachingAssistant
      on Userid=TAID
      where Userid=@UserID
        else if (@userType='Coordinator')
      select*
      from Users
      inner join Coordinator
      on Userid=coodrinatorID
      where Userid=@UserID
        else if (@userType='Student')
      select*
      from Users
      inner join Student
      on Userid=StudentID
      where Userid=@UserID

      go;

      create procedure AssignTAs @coordinatorID int, @TAid int, @projCode varchar(10)
      as
      declare @success bit='0'

      if (exists(
      select*
      from Academic
      where AcademicCode=@projCode
      ))
      set @success='1'

      if (@success='1')
      update Academic
      set TAID=@TAid
      where AcademicCode=@projCode
      else 
      print 'TAs can be assigned to academic projects'

      go;

      create procedure ViewRecommendation @LecturerID int
      as
      select EEID, PCode 
      from LecturerRecommendEE
      where LID=@LecturerID
      go;

      create procedure AssignEE @coordinatorID int, @EE_ID int, @projCode varchar(10)
      as

      if (exists(
      select*
      from Academic
      where AcademicCode=@projCode
      ))
      update Academic
      set EEID=@EE_ID
      where AcademicCode=@projCode
       else 
      print 'External examiner can be only assigned to academic projects'
      go;
     
      create procedure LecturerCreateLocalProject @LecturerID int, @ProjCode varchar(10), @title varchar(50), @description varchar(200), @majorCode varchar(10)
      as
      insert into BachelorProject values (@ProjCode, @title, null, @description)
      insert into Academic values(@ProjCode, @LecturerID, null, null)
      insert into MajorHasBachelorProject values (@majorCode, @ProjCode)
      go;


      create procedure CreateMeeting @lecturerID int, @startTime time, @EndTime time, @date datetime, @meetingPoint varchar(5)
      as
      insert into Meeting values (@lecturerID, @startTime, @EndTime, @date, @meetingPoint)
      go;

      create procedure LecturerAddToDo @meetingID int, @ToDoList varchar(200)
      as
  if (exists(
      select*
      from Meeting
      where MeetingID=@meetingID
      ))
      begin
      if (exists(
      select*
      from MeetingToDoList
      where MeetingID=@meetingID
      ))
      update MeetingToDoList
      set ToDoList=@ToDoList
      where MeetingID=@meetingID
      else
      insert into MeetingToDoList values (@meetingID, @ToDoList)

      end
      else
      print ' this meeting doesnt exist'
      go;

      create procedure ViewMeetingLecturer @lecturerID int, @meetingID int
      as
      if (@meetingID is null)
      select *
      from Meeting
      where LID=@lecturerID
      order by MeetingDate

      else 

      select *
      from Meeting
      where MeetingID=@meetingID

      go;

      create procedure ViewEE
      as
      select*
      from ExternalExaminer
      left join LecturerRecommendEE
      on ExternalExaminer.EEID=LecturerRecommendEE.EEID
      where PCode is null
      go;

      create procedure RecommendEE @LecturerID int, @projCode varchar(10), @EEID int
      as
      if (exists(
      select*
      from Academic
      where AcademicCode=@projCode
      ))
      insert into LecturerRecommendEE values (@LecturerID, @EEID, @projCode)
      else
      print ' this project is not an academic one'
      go;

      create procedure SuperviseIndustrial @LecturerID int, @ProjCode varchar(10)
      as
      if (exists(
      select*
      from Industrial
      where IndustrialCode=@projCode
      ))
      update Industrial
      set LID=@LecturerID
      where IndustrialCode=@ProjCode
      else 
      print ' this project is not an industrial one'
      go;

      create procedure LecGradeThesis @lecturerID int , @sid int , @thesisTitle varchar(10), @lecturerGrade decimal(4,2)
      as
      update GradeAcademicThesis
      set LecturerGrade=@lecturerGrade,
          LID=@lecturerID
      where StudentID=@sid and Title=@thesisTitle
      go;

      create procedure LecGradedefense @lecturerID int , @sid int , @defenseLocation varchar(5), @lecturerGrade decimal(4,2)
      as
      update GradeAcademicDefense
      set LecturerGrade=@lecturerGrade,
          LID=@lecturerID
      where StudentID=@sid and DefenseLocation=@defenseLocation
      go; 

      create procedure LecCreatePR @lecturerID int, @sid int, @date datetime, @content varchar(100)
      as 
      insert into ProgressReport values (@sid, @date, @content, null, @lecturerID, null)
      insert into GradeAcademicPR values (null, @sid,@date, null)
      go;

      create procedure LecGradePR @lecturerID int, @sid int, @date datetime, @lecturerGrade decimal (4,2)
      as
      declare @code varchar(10);

      select @code=AssignedProjectcode
      from Student
      where StudentID=@sid

      if (exists(
          select*
          from academic
          where AcademicCode=@code
          ))
      begin
       update GradeAcademicPR
       set LecturerGrade=@lecturerGrade,
           LID=@lecturerID
       where StudentID=@sid and PRDate=@date

       update ProgressReport
       set Grade=@lecturerGrade,
           UpdatingUserID=@lecturerID
       where StudentID=@sid and ReportDate=@date
       end
       else 
       print 'not allowed to grade this progress report'
       go;

        create procedure StudentAddToDo @meetingID int , @ToDoList varchar(200)
      as
      if (exists (
	  select*
	  from Meeting
	  where @meetingID=MeetingID
	  ))
	  begin
  
      if (exists(
	  select*
	  from MeetingToDoList
	  where MeetingID=@meetingID
	  ))
	  begin

	  update MeetingToDoList
	  set ToDoList=@ToDoList
	  where MeetingID=@meetingID

	  end
	  else 
	  begin
	  insert into MeetingToDoList values (@meetingID, @ToDoList)
	  end
	  end
	  

      go;

      create procedure BookMeeting @sid int, @meetingID int
      as 
      declare @lecturerCode int;
      declare @ProjCode varchar(20);

      select @ProjCode=AssignedProjectcode
      from Student
      where StudentID=@sid

      if (exists (
      select*
      from Academic
      where AcademicCode=@ProjCode
      ))
      begin
      select @lecturerCode=LID
      from Academic
      where AcademicCode=@ProjCode
      end
      else 
      begin
      if (exists (
      select*
      from Industrial
      where IndustrialCode=@ProjCode
      ))
      select @lecturerCode=LID
      from Industrial
      where IndustrialCode=@ProjCode
      end

      if (exists (
      select *
      from Meeting
      where MeetingID=@meetingID and LID=@lecturerCode
      ))
      begin
      insert into MeetingAttendant values (@meetingID, @sid)
      end
      else 
      begin
      print 'you can only attend meeting created by your lecturer'
      end
   
      go;   

     create procedure ViewNotBookedMeetings @sid int
      as
      declare @ID int;
	  declare @projcode varchar(20);

	  select @projcode=AssignedProjectcode
	  from Student
	  where StudentID=@sid

      if (exists(
	  select*
	  from Academic
	  where AcademicCode=@projcode
	  ))
	  begin
	  select @ID=LID
	  from Academic
	  where AcademicCode=@projcode
	  end

	   if (exists(
	  select*
	  from Industrial
	  where IndustrialCode=@projcode
	  ))
	  begin
	  select @ID=LID
	  from Industrial
	  where IndustrialCode=@projcode
	  end

	  select *
	  from Meeting
	  where LID=@ID and MeetingID not in (
	  select MeetingID
	  from MeetingAttendant
	  where AttendantID=@sid
	  )

      go;

       CREATE procedure ViewMeeting @meetingID int, @sid int
      as
	  if (@meetingID = -500)
	  begin
	  set @meetingID = null;
	   end

      if (@meetingID is null)
	  begin
	  
	  select *
	  from Meeting
	  left outer join MeetingToDoList on      
        Meeting.MeetingID=MeetingToDoList.MeetingID
	  where Meeting.MeetingID in(
	  select MeetingID
	  from MeetingAttendant
	  where AttendantID=@sid 
	  )
	  

	  end

	  else 
	  begin
	  if (exists (
	  select*
	  from MeetingAttendant
	  where MeetingID=@meetingID and AttendantID=@sid
	  ))
	  begin
	  select *
	  from Meeting
	  left outer join MeetingToDoList on Meeting.MeetingID=MeetingToDoList.MeetingID
	  where Meeting.MeetingID=@meetingID
	  end

	  end

      go;

         CREATE procedure ViewBachelorProjects @projectType varchar(20), @userID int
      as
	  
	  declare @code varchar(20);

	  if (@projectType='')
	  begin
	   set @projectType=null;
	   end

	   
	   if (@userID=-1)
	   begin
	   set @userID=null;
	   end

      declare @type varchar(5);

      if (@projectType is not null and @userID is not null)

      begin

      if (exists(
       select*
       from Student
       where StudentID=@userID
       ))
      select *
      from Student
      inner join BachelorProject
      on Student.AssignedProjectcode=BachelorProject.Code 
      where StudentID=@userID
      else if (exists (
      select*
      from Lecturer
      where LecturerID=@userID
      ))
      set @type='L'
      else if (exists (
      select*
      from TeachingAssistant
      where TAID=@userID
      ))
      set @type='T'
      else if (exists (
      select*
      from ExternalExaminer
      where EEID=@userID
      ))
      set @type='EE'
      else if (exists (
      select*
      from Company
      where CompanyID=@userID
      ))
      set @type='C'
      else if (exists (
      select*
      from Employee
      where StaffID=@userID
      ))
      set @type='E'

      if (CHARINDEX('Academic',@projectType) > 0  and @type = 'L')
      select BachelorProject.Code, BachelorProject.Projectname, BachelorProject.SubmittedMaterial ,BachelorProject.ProjectDescription 
      from Academic
	  inner join BachelorProject
	  on Academic.AcademicCode=BachelorProject.Code
	  where LID=@userID

      else if (CHARINDEX('Academic',@projectType) > 0  and @type = 'T')
     select BachelorProject.Code, BachelorProject.Projectname, BachelorProject.SubmittedMaterial ,BachelorProject.ProjectDescription 
      from Academic
	  inner join BachelorProject
	  on Academic.AcademicCode=BachelorProject.Code
	  where TAID=@userID

      else if (CHARINDEX('Academic',@projectType) > 0  and @type = 'EE')
       select BachelorProject.Code, BachelorProject.Projectname, BachelorProject.SubmittedMaterial ,BachelorProject.ProjectDescription 
      from Academic
	  inner join BachelorProject
	  on Academic.AcademicCode=BachelorProject.Code
      where EEID=@userID

      else if (CHARINDEX('Industrial',@projectType) > 0 and @type='L')
       select BachelorProject.Code, BachelorProject.Projectname, BachelorProject.SubmittedMaterial ,BachelorProject.ProjectDescription 
      from Industrial
	  inner join BachelorProject
	  on Industrial.IndustrialCode=BachelorProject.Code
      where LID=@userID

        else if (CHARINDEX('Industrial',@projectType) > 0 and @type='C')
     select BachelorProject.Code, BachelorProject.Projectname, BachelorProject.SubmittedMaterial ,BachelorProject.ProjectDescription 
      from Industrial
	  inner join BachelorProject
	  on Industrial.IndustrialCode=BachelorProject.Code
      where CID=@userID

        else if (CHARINDEX('Industrial',@projectType) > 0 and @type='E')
     select BachelorProject.Code, BachelorProject.Projectname, BachelorProject.SubmittedMaterial ,BachelorProject.ProjectDescription 
      from Industrial
	  inner join BachelorProject
	  on Industrial.IndustrialCode=BachelorProject.Code
      where EID=@userID

      end

      else if (@projectType is null and @userID is not null)
      begin
      select BachelorProject.Code, BachelorProject.Projectname, BachelorProject.SubmittedMaterial ,BachelorProject.ProjectDescription 
      from Industrial
	  inner join BachelorProject
	  on Industrial.IndustrialCode=BachelorProject.Code
      where  CID=@userID or EID=@userID or  Industrial.LID=@userID
	  union
	   select BachelorProject.Code, BachelorProject.Projectname, BachelorProject.SubmittedMaterial ,BachelorProject.ProjectDescription 
      from Academic
	  inner join BachelorProject
	  on AcademicCode=BachelorProject.Code
      where TAID=@userID or EEID=@userID or  Academic.LID=@userID 
      end

	  else if (@userID is null and @projectType is not null)
	  begin
	  if (CHARINDEX('Industrial',@projectType) >0)
	  begin
      select BachelorProject.Code, BachelorProject.Projectname, BachelorProject.SubmittedMaterial ,BachelorProject.ProjectDescription 
      from Industrial
	  inner join BachelorProject
	  on Industrial.IndustrialCode=BachelorProject.Code
      end
      else if (CHARINDEX('Academic',@projectType) > 0 )
	  begin
       select BachelorProject.Code, BachelorProject.Projectname, BachelorProject.SubmittedMaterial ,BachelorProject.ProjectDescription 
      from Academic
	  inner join BachelorProject
	  on AcademicCode=BachelorProject.Code
      end

	  end

      else if (@userID is null and @projectType is null)
	  begin
      select*
      from BachelorProject
	  end

      go;

      create procedure SpecifyThesisDeadline @deadline datetime
      as


      go;

      create procedure AssignAllStudentToLocalProject 
      as

      go;

      create procedure ScheduleDefense @sid int, @date datetime , @time time, @location varchar(5)
      as
      declare @Code varchar(20)
      insert into Defense values (@sid, @location, null, @time, @date, null)
      select @Code=AssignedProjectcode
      from Student
      where StudentID=@sid

      if (exists (
      select*
      from Academic
      where AcademicCode=@Code
      ))
      begin
      insert into GradeAcademicDefense values(null,null,@sid, @location, null,null)
      end
      else 
      if (exists (
      select*
      from Industrial
      where IndustrialCode=@Code
      ))
      insert into GradeIndustrialDefense values (null,null,@sid, @location, null,null)
    
      go;

create procedure ComulativeGradeProgressReportForBachelor @sid int, @comGrade float output
      as 

	  if (exists (
	  select *
	  from ProgressReport
	  where Grade is null
	  ))
	  begin
	   set  @comGrade=null;
	  end
	  else 
	  begin
      select @comGrade=AVG(Grade)
      from ProgressReport
      where StudentID=@sid
	  end

      go;