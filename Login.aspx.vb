Imports System.Data.SqlClient


Partial Class Login
    Inherits System.Web.UI.Page

    Private Function UserValidation(ByVal username As String, ByVal password As String) As Boolean
        Dim findPassword As String = Nothing
        Dim conn As SqlConnection
        Dim cmd As SqlCommand

        Try
            'Define new connection and open it
            conn = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
            conn.Open()

            'define the sqlcommand ro select the password of the username and the connection
            cmd = New SqlCommand("SELECT StudentPassword FROM StudentRegisteration WHERE StudentId = '" + username + "'", conn)

            'Return the first row, since username is primary key
            findPassword = cmd.ExecuteScalar()
            conn.Close()

        Catch ex As Exception
            MsgBox(ex.ToString)
            System.Diagnostics.Trace.WriteLine("[ValidateUser] Exception " & ex.Message)
        End Try


        If (findPassword Is Nothing) Then
            'If the username is incorrect, the function will return false
            Return False
        End If

        'Compare the password retrieved with the password entered by user, if match return true otherwise return false
        Return String.Compare(findPassword, password, False) = 0

    End Function


    Protected Sub cmdLogin_Click(sender As Object, e As EventArgs) Handles cmdLogin.Click
        'Get users input username
        Dim UserName As String = txtUsername.Text.ToString
        'Get users input password
        Dim Password As String = txtPassword.Text.ToString
        'call the function to check the user credentials
        Dim checkUser As Boolean = UserValidation(UserName, Password)

        'If users credentials wrong
        If checkUser = False Then
            CustomValidator1.IsValid = False

        Else
            'Authenticated
            'Set Role as Admin and UserID as Username
            Session("Role") = "Admin"
            Session("UserId") = UserName

            'Go to the application default page
            Response.Redirect("GroupsHome.aspx")
        End If

    End Sub
End Class
