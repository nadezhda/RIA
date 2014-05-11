Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Data

Partial Class GroupsHome
    Inherits System.Web.UI.Page

    Dim countMembers As Integer = 2
    Dim controlIdList As New List(Of String)()

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        'check if user logged in or not. Role must be either Admin or Member 
        If Session("Role") Is Nothing Then
            Response.Redirect("Login.aspx")
        Else
            '  getGroupsSubscribedTo()
        End If
    End Sub

    'Protected Sub getGroupsSubscribedTo()
    '    Dim findPassword As String = Nothing
    '    Dim conn As SqlConnection
    '    Dim cmd As SqlCommand
    '    Dim GroupArray As New ArrayList

    '    Try
    '        'Define new connection and open it
    '        conn = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
    '        conn.Open()

    '        'define the sqlcommand ro select the password of the username and the connection
    '        cmd = New SqlCommand("SELECT GroupId FROM GroupMembers WHERE StudentId = '" + Session("UserId").ToString + "'", conn)

    '        'Return the first row, since username is primary key
    '        Dim groupReader As SqlDataReader = cmd.ExecuteReader()


    '        Do While groupReader.Read
    '            GroupArray.Add(groupReader.GetValue(0))
    '        Loop
    '        conn.Close()
    '        Session("UserGroups") = GroupArray
    '        Dim i As Integer = 0
    '        Do While i < GroupArray.Count
    '            i = i + 1
    '        Loop

    '        conn.Close()

    '    Catch ex As Exception
    '        MsgBox(ex.ToString)
    '    End Try



    'End Sub

    Protected Overrides Sub LoadViewState(savedState As Object)

        MyBase.LoadViewState(savedState)
        controlIdList = DirectCast(ViewState("controlIdList"), List(Of String))

        For Each Id As String In controlIdList
            countMembers = countMembers + 1
            Dim txtMembers As New TextBox
            Dim lineBreak As New LiteralControl("</br>")
            txtMembers.ID = Id
            MembersPlaceHolder.Controls.Add(txtMembers)
            MembersPlaceHolder.Controls.Add(lineBreak)
        Next

    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles cmdAddMember.Click

        Dim txtMembers As New TextBox
        Dim lineBreak As New LiteralControl("</br>")
        txtMembers.ID = "members" + countMembers.ToString
        countMembers = countMembers + 1

        Me.MembersPlaceHolder.Controls.Add(txtMembers)
        MembersPlaceHolder.Controls.Add(lineBreak)
        controlIdList.Add(txtMembers.ID)

        ViewState("controlIdList") = controlIdList

    End Sub


    Protected Sub cmdCreateGroup_Click(sender As Object, e As EventArgs) Handles cmdCreateGroup.Click
        Dim findPassword As String = Nothing
        Dim conn As SqlConnection
        Dim cmdStr As String
        Dim cmd As SqlCommand

        Try
            'Define new connection and open it
            conn = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
            conn.Open()

            cmdStr = "Insert into GroupDetails (GroupName) values ('" + txtGroupName.Text + "')"
            cmd = New SqlCommand(cmdStr, conn)

            cmd.ExecuteNonQuery()
            cmd.CommandText = " Select SCOPE_IDENTITY()"
            Dim tempid As Integer = cmd.ExecuteScalar()

            cmd.CommandText = "Insert into GroupMembers values ('" + Session("UserId").ToString + "', " + tempid.ToString + ", 'A', 'C')"
            cmd.ExecuteNonQuery()

            Dim countM As Integer = 1

            Do While countM < countMembers
                Dim tb As New TextBox
                '  tb.ID = "memebers" + countM.ToString
                Dim ntb As String = "memebers" + countM.ToString
                tb = MembersPlaceHolder.FindControl("members" + countM.ToString)
                '             MsgBox(tb.Text)
                cmd.CommandText = "Insert into GroupMembers values ('" + tb.Text + "', " + tempid.ToString + ", 'M', 'P')"
                cmd.ExecuteNonQuery()
                countM = countM + 1
            Loop
            GridView1.DataBind()


            conn.Close()
        Catch ex As Exception
            'Temp msgfor development stage
            MsgBox(ex.ToString)
        End Try


    End Sub



    Protected Sub imgButtonAddMeeting_Click(sender As Object, e As ImageClickEventArgs)
     
    End Sub

    Private Function getWeekNumber(ByVal termStart As Date, ByVal currentDate As Date) As Integer
        Dim starterm = termStart
        Dim temptime As Date = starterm
        Dim weekNumber As Integer = 0

        While temptime.DayOfWeek <> DayOfWeek.Monday
            temptime = temptime.AddDays(-1)
        End While

        While currentDate.DayOfWeek <> DayOfWeek.Monday
            currentDate = currentDate.AddDays(-1)
        End While

        'maybe i will add && tempdate <> endterm
        Do While temptime < currentDate
            temptime = temptime.AddDays(7)
            weekNumber = weekNumber + 1
        Loop

        Return weekNumber

    End Function

    'This function loops through termdates.csv and determin which semester is it depending on the date entered
    Private Function getCurrentTermDates(ByVal reqDate As Date) As Date

        Dim PrevYearTerm(), CurrentYearTerm() As String
        Dim sr As New System.IO.StreamReader(HttpContext.Current.Server.MapPath("Data/termdates.csv"))

        'read first line to skip the header
        sr.ReadLine()

        Do While sr.Peek() >= 0  ' Is -1 when no data exists on the next line of the CSV file

            Dim temp As String = sr.ReadLine
            Dim tempYear As Integer = reqDate.Year
            PrevYearTerm = temp.Split(",")

            If (reqDate.Year - CInt(PrevYearTerm(1).Substring(0, 4)) = 1) Then
                temp = sr.ReadLine()
                CurrentYearTerm = temp.Split(",")
                Exit Do

            End If
        Loop

        Dim NextStartTermDate, PrevStartTermDate As Date
        PrevStartTermDate = DateTime.ParseExact(PrevYearTerm(1), "yyyy-MM-dd", System.Globalization.CultureInfo.CurrentCulture)
        NextStartTermDate = DateTime.ParseExact(CurrentYearTerm(1), "yyyy-MM-dd", System.Globalization.CultureInfo.CurrentCulture)

        If reqDate <= NextStartTermDate.AddDays(-1) Then
            Return PrevStartTermDate
        Else
            Return NextStartTermDate
        End If

    End Function

    Protected Sub ViewDetails(sender As Object, e As EventArgs)
        'Dim lnkView As LinkButton = TryCast(sender, LinkButton)
        'Dim row As GridViewRow = TryCast(lnkView.NamingContainer, GridViewRow)
        'Dim id As String = lnkView.CommandArgument
        'Dim name As String = row.Cells(0).Text
        'Dim country As String = TryCast(row.FindControl("txtCountry"), TextBox).Text
        'ClientScript.RegisterStartupScript(Me.[GetType](), "alert", (Convert.ToString((Convert.ToString((Convert.ToString("alert('Id: ") & id) + " Name: ") & name) + " Country: ") & country) + "')", True)
    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        Session("groupId") = e.CommandName
        Dim weeknumber As Integer = getWeekNumber(getCurrentTermDates(Today.Date), Today.Date)
        Session("weekNumber") = weeknumber
        Response.Redirect("table.aspx")

    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView1.RowDataBound
        'If e.Row.RowType = DataControlRowType.DataRow Then
        '       Dim lnkView As New LinkButton()
        '    lnkView.ID = "lnkView"
        '    lnkView.Text = "View"

        '    AddHandler lnkView.Click, AddressOf imgButtonAddMeeting_Click
        '    lnkView.CommandArgument = TryCast(e.Row.DataItem, DataRowView).Row("GroupName").ToString()
        '    e.Row.Cells(0).Controls.Add(lnkView)
        'End If
    End Sub
End Class
