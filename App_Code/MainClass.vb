Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Web.Security


Public Class MainClass

    Public Shared Function getdateofweek(ByVal termstart As Date, ByVal weeknum As Integer, ByVal dayName As String) As Date
        Dim reqDate As Date
        Dim weekDate As Date = termstart.AddDays(7 * weeknum)
        While weekDate.DayOfWeek <> DayOfWeek.Monday
            weekDate = weekDate.AddDays(-1)
        End While

        If weekDate.DayOfWeek.ToString = dayName.ToString Then
            reqDate = weekDate.Date
        Else
            Do While weekDate.DayOfWeek.ToString <> dayName.ToString
                weekDate = weekDate.AddDays(1)
                If weekDate.DayOfWeek.ToString = dayName.ToString Then
                    reqDate = weekDate.Date
                    Exit Do
                End If
            Loop

        End If
        Return reqDate
    End Function

    Public Shared Function getWeekNumber(ByVal termStart As Date, ByVal currentDate As Date) As Integer
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
    Public Shared Function getCurrentTermDates(ByVal reqDate As Date) As Date

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
End Class
