

Imports System
Imports System.Web
Imports System.Web.UI


Partial Public Class [Table]
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        'check if user logged in or not. Role must be either Admin or Member 
        If Session("Role") Is Nothing Then
            Response.Redirect("Login.aspx")
        Else


        End If
    End Sub
End Class

