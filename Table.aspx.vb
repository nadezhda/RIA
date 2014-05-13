Imports System
Imports System.Web
Imports System.Web.UI
Imports MainClass
Imports System.Net.Mail
Imports System.Net
Imports System.Drawing
Imports System.Data.SqlClient
Imports System.Data


Partial Public Class [Table]
    Inherits System.Web.UI.Page
    Dim objDataTable As New System.Data.DataTable
    Dim freeTimeDataTable As New System.Data.DataTable

    Dim sDate As Date
    Shared StudentGroupArray As New ArrayList
    Shared resultbuilding As New ArrayList
    Dim buildingStr As String = ""


    Dim SelectedStart, SelectedEnd, SelectedDate, SelectedDay As String
    Shared SelectedStartDate, SelectedEndDate As Date
    Dim selectedTime As Boolean


    Protected Sub getGroupsSubscribedTo()
        Dim conn As SqlConnection
        Dim cmd As SqlCommand

        Try
            'Define new connection and open it
            conn = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
            conn.Open()

            cmd = New SqlCommand("SELECT StudentId FROM GroupMembers WHERE GroupId = " + Session("groupId").ToString + "", conn)
            Dim groupReader As SqlDataReader = cmd.ExecuteReader()


            Do While groupReader.Read
                StudentGroupArray.Add(groupReader.GetValue(0))
            Loop
            conn.Close()

            conn.Close()

        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try



    End Sub


    Protected Sub sendEmail()
        Dim client As SmtpClient = New SmtpClient("smtp.gmail.com")

        client.Port = 587
        client.DeliveryMethod = SmtpDeliveryMethod.Network
        client.UseDefaultCredentials = False
        Dim credentials As New System.Net.NetworkCredential("meetingmanagersoton@gmail.com", "richApp123")
        client.EnableSsl = True
        client.Credentials = credentials

        Try

            Dim mail = New MailMessage("meetingmanagersoton@gmail.com", "n.alnaamani@gmail.com")
            mail.Bcc.Add("n.alnaamani@gmail.com")

            mail.Subject = "Group Meeting Notification"
            mail.IsBodyHtml = True
            mail.Body = "Hello, <br/>Your Group meeting will be on " + SelectedDay.ToString + " , " + SelectedDate.ToString + ", From " + SelectedStart.ToString + " To " + SelectedEnd.ToString + ".<br/>To view the meeting <a href='www.google.com'>Click Here</a>.<br/>To suggest another time please <a href='www.google.com'>Click Here</a>.<br/><br/><br/>Regards,<br/>Social Network Group<br/>Meeting Manager"
            'MsgBox(mail.Body.ToString)

            client.Send(mail)
        Catch ex As Exception
        
        End Try


    End Sub
  
    Protected Sub csvTimeTable()

        objDataTable.Columns.Add("eventId", GetType(Integer))
        objDataTable.Columns.Add("eventName", String.Empty.GetType())
        objDataTable.Columns.Add("startEvent", GetType(Date))
        objDataTable.Columns.Add("endEvent", GetType(Date))
        objDataTable.Columns.Add("weekNumber", GetType(Integer))
        objDataTable.Columns.Add("dayName", String.Empty.GetType())
        objDataTable.Columns.Add("studentId", String.Empty.GetType())
        objDataTable.Columns.Add("building", String.Empty.GetType())

        objDataTable.Columns(0).AutoIncrement = True

        Dim weekNumber As Integer = MainClass.getWeekNumber(MainClass.getCurrentTermDates(DateTime.Today), DateTime.Today)
        Dim sreader As New System.IO.StreamReader(HttpContext.Current.Server.MapPath("Data/timetable8.csv"))

        'read first line to skip the header



        Do While sreader.Peek() >= 0  ' Is -1 when no data exists on the next line of the CSV file

            Dim temp As String = sreader.ReadLine

            If temp <> "" Then

                Dim tempstr() As String
                tempstr = temp.Split(",", options:=StringSplitOptions.None)
                Dim buildingNumber() As String = tempstr(3).Split(" ")
                If tempstr(4).Contains("-") Then
                    Dim tempweeknumber() As String = tempstr(4).Split("-")

                    Dim weekstart As Integer
                    Dim weekend As Integer
                    weekstart = CInt(tempweeknumber(0))
                    weekend = CInt(tempweeknumber(1))

                    Dim a As Integer = 0
                    Do While weekstart <= weekend
                        Dim objDataRow As System.Data.DataRow = objDataTable.NewRow

                        objDataRow("eventName") = "timetable"
                        objDataRow("dayName") = tempstr(0)
                        objDataRow("studentId") = tempstr(5)
                        objDataRow("weekNumber") = weekstart
                        Dim weekdate As Date = MainClass.getdateofweek(MainClass.getCurrentTermDates(Today.Date), weekstart, tempstr(0))
                        objDataRow("startEvent") = DateTime.ParseExact(weekdate.Month.ToString + "/" + weekdate.Day.ToString + "/" + weekdate.Year.ToString + " " + tempstr(1), "M/d/yyyy HH:mm", Globalization.DateTimeFormatInfo.InvariantInfo)
                        objDataRow("endEvent") = DateTime.ParseExact(weekdate.Month.ToString + "/" + weekdate.Day.ToString + "/" + weekdate.Year.ToString + " " + tempstr(2), "M/d/yyyy HH:mm", Globalization.DateTimeFormatInfo.InvariantInfo)
                        objDataRow("building") = buildingNumber(0)
                        objDataTable.Rows.Add(objDataRow)

                        weekstart += 1
                    Loop
                Else
                    Dim objDataRow As System.Data.DataRow = objDataTable.NewRow

                    objDataRow("eventName") = "timetable"
                    objDataRow("dayName") = tempstr(0)
                    objDataRow("studentId") = tempstr(5)
                    objDataRow("weekNumber") = CInt(tempstr(4))
                    Dim weekdate As Date = MainClass.getdateofweek(MainClass.getCurrentTermDates(Today.Date), CInt(tempstr(4)), tempstr(0))
                    objDataRow("startEvent") = DateTime.ParseExact((weekdate.Month.ToString + "/" + weekdate.Day.ToString + "/" + weekdate.Year.ToString + " " + tempstr(1).ToString), "M/d/yyyy HH:mm", Globalization.DateTimeFormatInfo.InvariantInfo)
                    objDataRow("endEvent") = DateTime.ParseExact(weekdate.Month.ToString + "/" + weekdate.Day.ToString + "/" + weekdate.Year.ToString + " " + tempstr(2), "M/d/yyyy HH:mm", Globalization.DateTimeFormatInfo.InvariantInfo)
                    objDataRow("building") = buildingNumber(0)
                    objDataTable.Rows.Add(objDataRow)


                End If



            End If
        Loop
        getScheduledEvents()

        freetimes()
     

    End Sub

    Protected Sub getScheduledEvents()
        Dim conn As SqlConnection
        Dim cmd As SqlCommand

        Try
            'Define new connection and open it
            conn = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
            conn.Open()
            'define the sqlcommand ro select the password of the username and the connection
            cmd = New SqlCommand("SELECT eventName, startEvent, endEvent, weekNumber, dayName, GroupId FROM eventTable WHERE (GroupId =" + CInt(Session("groupId")).ToString + ") AND (weekNumber= " + CInt(Session("weekNumber")).ToString + ")", conn)
            'Return the first row, since username is primary key
            Dim groupReader As SqlDataReader = cmd.ExecuteReader()


            Do While groupReader.Read

                Dim i As Integer = 0

                Do While i < StudentGroupArray.Count
                    Dim objEventDataRow As System.Data.DataRow = objDataTable.NewRow

                    objEventDataRow("eventName") = "Scheduled"
                    objEventDataRow("dayName") = groupReader(4)
                    objEventDataRow("studentId") = StudentGroupArray.Item(i)
                    objEventDataRow("weekNumber") = Session("weekNumber")
                    objEventDataRow("startEvent") = groupReader(1)
                    objEventDataRow("endEvent") = groupReader(2)
                    objDataTable.Rows.Add(objEventDataRow)
                    i = i + 1
                Loop
            Loop
            conn.Close()
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try



    End Sub



    Protected Sub freetimes()
        Dim daysWeek As String() = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"}
        Dim daysCounter = 5
        Dim academicHours = 9

        freeTimeDataTable.Columns.Add("eventId", GetType(Integer))
        freeTimeDataTable.Columns.Add("eventDay", String.Empty.GetType())
        freeTimeDataTable.Columns.Add("eventDate", GetType(Date))
        freeTimeDataTable.Columns.Add("eventStart", GetType(Date))
        freeTimeDataTable.Columns.Add("eventEnd", GetType(Date))
        freeTimeDataTable.Columns.Add("eventStatus", String.Empty.GetType()).DefaultValue = "Free"
        freeTimeDataTable.Columns(0).AutoIncrement = True

        Dim dayCounter As Integer = 0
        Dim hourCounter As Integer = 0

        '   sDate = DateTime.Today
        sDate = DateTime.Parse("09:00")
        Dim eDate As Date = Today.Date


        Do While sDate.DayOfWeek <> DayOfWeek.Monday
            sDate = sDate.AddDays(-1)   ' to start from the first day of the week
        Loop
        eDate = sDate.AddDays(5) 'this will be friday


        Dim tempStartDate = sDate
        Dim StudentsStr As String = ""
        Dim selectStr As String

        Dim i As Integer = 0
        Do While i < StudentGroupArray.Count
            If i = (StudentGroupArray.Count - 1) Then
                StudentsStr = StudentsStr + "studentId='" + StudentGroupArray(i) + "') "
                i = i + 1
            Else
                StudentsStr = StudentsStr + " studentId='" + StudentGroupArray(i) + "' or "
                i = i + 1
            End If

        Loop

        Do While tempStartDate < eDate      'loop for five days

            '''''''''''''''''''''''''''''********************************STOP*************************************'''''''''''''''''''''''
            Do While hourCounter < 9

                selectStr = "startEvent <= #" + tempStartDate + "# and endEvent > #" + tempStartDate + "# and ( " + StudentsStr + " "
                Dim result() As DataRow = objDataTable.Select(selectStr) 'Dont Forget to add and studentId

                Dim freeTimeDataRow As System.Data.DataRow = freeTimeDataTable.NewRow

                freeTimeDataRow("eventDay") = daysWeek(dayCounter)
                freeTimeDataRow("eventDate") = tempStartDate
                freeTimeDataRow("eventStart") = tempStartDate
                freeTimeDataRow("eventEnd") = tempStartDate.AddHours(1)

                If result.Length > 0 Then
                    If result(0).Item("eventName").ToString = "Scheduled" Then

                        freeTimeDataRow("eventStatus") = "Scheduled"
                    Else
                        freeTimeDataRow("eventStatus") = "Busy"
                    End If
                Else
                    If freeTimeDataRow("eventStatus") <> "Busy" And freeTimeDataRow("eventStatus") <> "Scheduled" Then
                        freeTimeDataRow("eventStatus") = "Free"
                    End If

                End If

                    freeTimeDataTable.Rows.Add(freeTimeDataRow)

                    tempStartDate = tempStartDate.AddHours(1)
                    hourCounter = hourCounter + 1
            Loop
            tempStartDate = tempStartDate.AddHours(15)
            hourCounter = 0
            daysCounter = dayCounter + 1
            ' tempStartDate = tempStartDate.AddDays(1)
        Loop


        DayPilotCalendar2.DataSource = freeTimeDataTable
        DayPilotCalendar2.DataStartField = "eventStart"
        DayPilotCalendar2.DataEndField = "eventEnd"
        DayPilotCalendar2.StartDate = sDate
        DayPilotCalendar2.DataTextField = "eventStatus"
        DayPilotCalendar2.DataIdField = "eventId"
        DayPilotCalendar2.HideFreeCells = True
        DayPilotCalendar2.DataBind()

       


    End Sub







    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        'check if user logged in or not. Role must be either Admin or Member 
        If Session("Role") Is Nothing Then
            Response.Redirect("Login.aspx")
        Else

            StudentGroupArray.Clear()
            getGroupsSubscribedTo()
            DayPilotCalendar2.BusinessBeginsHour = "9"
            DayPilotCalendar2.BusinessEndsHour = "18"

            csvTimeTable()


        End If
    End Sub

    Protected Sub DayPilotCalendar2_BeforeEventRender1(sender As Object, e As DayPilot.Web.Ui.Events.Calendar.BeforeEventRenderEventArgs) Handles DayPilotCalendar2.BeforeEventRender

        Dim colorDetermin As String = CStr(e.DataItem("eventStatus"))
        DayPilotCalendar2.EventCorners = DayPilot.Web.Ui.Enums.CornerShape.Rounded
        DayPilotCalendar2.HeightSpec = DayPilot.Web.Ui.Enums.HeightSpecEnum.Full
        DayPilotCalendar2.ColumnMarginRight = 7
        DayPilotCalendar2.ColumnWidth = 55
        If colorDetermin = "Free" Then
            e.BackgroundColor = "#5DD687"
            e.BorderColor = "#5DD687"
            ' e.Html = "<div style='height:43px'></div>"

        ElseIf colorDetermin = "Busy" Then
            e.BackgroundColor = "#E2E2DD"
            e.BorderColor = "#E2E2DD"
            '  e.Html = "<div style='height:43px'></div>"
        Else
            e.BackgroundColor = "#FFCC66"
            e.BorderColor = "#FFCC66"

        End If


    End Sub




   

    Protected Sub SaveMeeting(ByVal SD As Date, ByVal ED As Date)
        Dim conn As SqlConnection
        Dim cmdStrSaveMeeting As String
        Dim cmd As SqlCommand

        Try
            'Define new connection and open it
            conn = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
            conn.Open()
            cmdStrSaveMeeting = "Insert into eventTable(eventName, startEvent, endEvent, weekNumber, dayName, GroupId) values ('Scheduled', '" + SD + "', '" + ED + "', " + CInt(Session("weekNumber")).ToString + ", '" + SelectedDay.ToString + "', " + CInt(Session("groupId")).ToString + ")"
            MsgBox(cmdStrSaveMeeting)
            cmd = New SqlCommand(cmdStrSaveMeeting, conn)
            cmd.ExecuteNonQuery()



            conn.Close()
        Catch ex As Exception
            'Temp msgfor development stage
            MsgBox(ex.ToString)
        End Try
    End Sub

    Protected Sub FindLastLectures()
        Dim resultStudents() As DataRow
        Dim t As Integer = 0

    
        Dim temphour As Date = SelectedStartDate

         Dim j As Integer = 0
        Do While StudentGroupArray.Count > j
            resultStudents = objDataTable.Select("endEvent= #" + SelectedStartDate + "# and studentId='" + StudentGroupArray(j) + "'")
            'Do While resultStudents.Length = 0
            '    resultStudents = objDataTable.Select("startEvent= #" + temphour.AddHours(-1).ToString + "# and ( " + StudentsStr)
            'Loop

            If resultStudents.Length > 0 Then
                If resultStudents(0)("building").ToString <> "" Then
                    If CInt(resultStudents(0)("building").ToString) > 0 Then
                        resultbuilding.Add(resultStudents(0)("building").ToString)

                    End If
                End If
            End If
            j = j + 1
        Loop
        Dim m As Integer = 0
        Do While m < resultbuilding.Count

            If m = (resultbuilding.Count) - 1 Then
                buildingStr = buildingStr + resultbuilding(m).ToString
            Else
                buildingStr = buildingStr + resultbuilding(m).ToString + ","
            End If
            m = m + 1
        Loop
        '       End If
        building_hf.Value = buildingStr

    End Sub

    

    Protected Sub DayPilotCalendar2_EventClick(sender As Object, e As DayPilot.Web.Ui.Events.EventClickEventArgs) Handles DayPilotCalendar2.EventClick
     
        SelectedEnd = e.End.ToShortTimeString
        SelectedDate = e.Start.ToShortDateString
        SelectedStartDate = e.Start
        SelectedEndDate = e.End
        SelectedDay = e.Start.DayOfWeek.ToString
        lblDate.Text = lblDate.Text + "Date: " + SelectedDate.ToString
        lblDay.Text = "Day: " + e.Start.ToShortTimeString.ToString
        lblStart.Text = "From: " + e.End.ToShortTimeString.ToString
        lblEnd.Text = "To: " + SelectedEnd.ToString
        lblEnd.Text = "Location: " + SelectedEnd.ToString
        resultbuilding.Clear()

        FindLastLectures()
     
        '  


        'sendEmail()
        ' MsgBox("email was sent")

    End Sub







    Protected Sub cmdCreateMeeting_Click(sender As Object, e As EventArgs) Handles cmdCreateMeeting.Click
        SaveMeeting(SelectedStartDate, SelectedEndDate)
        sendEmail()
    End Sub


End Class

