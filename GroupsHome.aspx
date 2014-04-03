<%@ Page Title="" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="GroupsHome.aspx.vb" Inherits="GroupsHome" %>


<<<<<<< HEAD
<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="container-fluid body"> 
        <div class="col-md-6">
            <div class="row col-md-offset-1">

                <h3>Group Name : </h3>
                <asp:Button ID="cmdCreateNewGroup" runat="server" Text="Add New Group" class="btn btn-lg pull-right btn-dark" />
=======
    <div class="container-fluid body">
        <div class="span6">
            <div class="row-fluid">

                <button id="cmdCreateGroup" runat="server" class="btn btn-info pull-left ">
                    Add New Group  <i class="fa fa-plus-circle fa-lg"></i>
                </button>
>>>>>>> FETCH_HEAD

            </div>
            <div class="row-fluid">
                <div class="well span12">
                    <h4><i class="fa fa-users fa-lg"></i>Social Networks </h4>
                    <div class="row-fluid">
                        <div class="">
                            <div class="btn meeting-confirm btn-success btn-large span11">
                                <label class="pull-left">Wednesday 11:00 AM </label>
                                <label class="pull-right">Confirmed<i class="fa fa-check-circle fa-lg"></i></label>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid">
                        <div class="">
                            <div class="btn meeting-conflict btn-danger btn-large span11">
                                <label class="pull-left">Friday 15:00 PM </label>
                                <label class="pull-right">Conflict <i class="fa fa-exclamation-circle fa-lg"></i></label>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
    </div>
    <div class="span3 pull-right">
        ghjgh
            
    </div>




    </div>










    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
    
    <div>
      
    <asp:Panel ID="groupPanel" runat="server">
        <h3>Add Group</h3>
        <div>
            <p>
            <asp:Label ID="Label1" Width="130px" runat="server" Text="Group Name"></asp:Label>
            <asp:TextBox ID="txtGroupName" runat="server" Width="200px"></asp:TextBox></p>
        </div>
         <div>
        </div>
        <h4>Members</h4>
                    <asp:PlaceHolder ID="MembersPlaceHolder" runat="server">
        <div id="members">
            <asp:TextBox ID="members1" runat="server"></asp:TextBox>
            <asp:Button  ID="cmdAddMember" runat="server" Text="Add Member" />
            
        </div></asp:PlaceHolder>
            <div>
                <asp:Button ID="cmdCreateGroup" runat="server" Text="Create Group" /></div>       
</asp:Panel>
            <%--  <div id="p_member" >
            <p>            <asp:Label ID="Label2" Width="130px" runat="server" Text="Group Members"></asp:Label>

                <label for="p_member">
                    <input type="text" id="p_member" size="20" style="width:200px" name="p_member" value="" placeholder="Input Value" /></label>
            <a href="#" id="addMember">
            <img src="images/iconAdd.png" height="20px" width="20px" ID="ImageAdd" /></a></p>
        </div>
        <div>
            <asp:Button ID="btnCreateGroup" runat="server" Text="Create Group" />
            <br />
            <input name="HiddenMemberCounter" runat="server"  type="hidden" />
        </div>

    </div>


    <script>$(function () {
    var membersDiv = $('#p_member');
    var count = $('#p_member p').size() + 1;

    $('#addMember').live('click', function () {
        $('<p><label for="p_member"><input type="text" style="margin-left:135px; width:200px" id="p_member" size="20" name="p_member_' + count + '" value="" placeholder="Input Value" /></label> <a href="#" id="remMember"><img src="images/iconRemove.png" height="20px" width="20px" ID="ImgRemove" /></a></p>').appendTo(membersDiv);
        count++;
        return false;
    });

    $('#remMember').live('click', function () {
        if (count > 2) {
            $(this).parents('p').remove();
            count--;
        }
        return false;
    });
});
</script>--%>


</asp:Content>

