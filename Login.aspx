<<<<<<< HEAD
﻿<%@ Page Language="VB" MasterPageFile="~/Master.master"  AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">

    <br />
    <br />
    <br />
    <form id="form1" >
    <div>
        <div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
        </div>
    <div>
        <asp:Label ID="Label1" runat="server" Text="Username: "></asp:Label><asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidatorUserName" runat="server" ErrorMessage="Please enter your username" ControlToValidate="txtUsername">*</asp:RequiredFieldValidator>
        </div>
        <div>
            <asp:Label ID="Label2" runat="server" Text="Password: "></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server" ErrorMessage="Please enter your password" ControlToValidate="txtPassword">*</asp:RequiredFieldValidator>
            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="The password is invalid">*</asp:CustomValidator>
        </div>
        <div>
            <asp:Button ID="cmdLogin" runat="server" Text="Login" style="height: 26px" />
        </div>
    </div>
      
    </form>

</asp:Content>
=======
﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="~/Login.aspx.vb" Inherits="Login" MasterPageFile="~/Master.master" Title="Login"%>

<asp:Content id="contentLogin" ContentPlaceHolderID="Main" runat="server">

</asp:Content>
>>>>>>> FETCH_HEAD
