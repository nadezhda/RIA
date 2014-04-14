Imports System.Collections.Generic
Imports System.Data.SqlClient

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


        End If
    End Sub
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
End Class
