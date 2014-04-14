<%@ Page Title="Groups" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="GroupsHome.aspx.vb" Inherits="GroupsHome" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>

    <div class="container-fluid body">
        <div class="span7">
           <div class="row-fluid">

                <button id="cmdCreateNewGroup" runat="server" data-toggle="modal" data-target="#createGroupModal" class="btn btn-info pull-left" style="margin-bottom: 20px;">
                    Add New Group <i class="fa fa-plus-circle fa-lg"></i>
                </button>

            </div> 
    <!--         <div class="row-fluid">
                <div class="well span12">
                    <div class="row-fluid">
                        <div class="span9">
                            <h4><i class="fa fa-users fa-lg"></i>Social Networks </h4>
                        </div>
                        <div class="span3" style="margin-top: -18px;">
                            <a id="btnSettings" class="btn pull-right btn-primary" data-toggle="modal" rel="tooltip" data-target="#groupSettingModal" data-original-title="Group Settings"><i class="fa fa-cogs fa-lg"></i></a>
                            <a id="btnAddMeeting" href="Table.aspx" class="btn pull-right btn-warning" data-toggle="tooltip" data-original-title="Add Meeting"><i class="fa fa-calendar fa-lg"></i></a>
                        </div>
                    </div>
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
            </div>-->
            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always"><ContentTemplate>
        <asp:GridView ID="GridView1" ShowHeader="false" BorderStyle="None"  runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="100%" BorderWidth="0px" AlternatingRowStyle-BorderStyle="None" EditRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderStyle="None" GridLines="None">
            <Columns>
                <asp:TemplateField HeaderText="GroupName" SortExpression="GroupName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("GroupName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                                    <div class="row-fluid">
                <div class="well span12">
                    <div class="row-fluid">
                        <div class="span9">
                            <h4><asp:Label ID="Label1" runat="server" Text='<%# Bind("GroupName") %>'></asp:Label>
</h4>
                        </div>
                        <div class="span3" style="margin-top: -18px">
                            <a id="btnSettings" class="btn pull-right btn-primary" data-toggle="modal" rel="tooltip" data-target="#groupSettingModal" data-original-title="Group Settings"><i class="fa fa-cogs fa-lg"></i></a>
                            <a id="btnAddMeeting" href="Table.aspx" class="btn pull-right btn-warning" data-toggle="tooltip" data-original-title="Add Meeting"><i class="fa fa-calendar fa-lg"></i></a>
                        </div>
                    </div>
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

                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BorderStyle="None" BorderWidth="0px" />
            <RowStyle BorderStyle="None" />
        </asp:GridView>    </ContentTemplate> 
                <Triggers><asp:PostBackTrigger ControlID="cmdCreateGroup"  /></Triggers>

            </asp:UpdatePanel>    </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [GroupName] FROM [GroupDetails]"></asp:SqlDataSource>
        <div class="span5"></div>
        <div class="span3">
            <h3>Groups Feed</h3>
        </div>
    </div>

    <div id="createGroupModal" class="modal hide fade" tabindex="-1">
        <%--<asp:Panel ID="groupPanel" runat="server">--%>

        <div class="modal-header">
            <h3>Add Group</h3>
        </div>
        <div class="modal-body modal-body-big">
            <form class="form-horizontal">
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>

                <div class="control-group">
                    <asp:Label ID="Label1" runat="server" CssClass="control-label" Text="Group Name : "></asp:Label>
                    <div class="controls">
                        <asp:TextBox ID="txtGroupName" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <asp:Label ID="Label2" runat="server" Text="Members : "></asp:Label>
                    <asp:PlaceHolder ID="MembersPlaceHolder" runat="server">
                        <div id="members">
                            <asp:TextBox ID="members1" runat="server"></asp:TextBox>
                            <asp:Button ID="cmdAddMember" runat="server" Text="Add Member" />
                        </div>
                    </asp:PlaceHolder>
                </div>
                                                    </ContentTemplate></asp:UpdatePanel>
            </form>
        </div>

        <div class="modal-footer" style="padding-top:30px;">
            
            <label class="checkbox pull-left" style="margin-top:-20px;" >
                <input type="checkbox" />  I Agree on <a href="#">terms and conditions.</a>
            </label>
                
            <asp:Button ID="cmdCreateGroup" CssClass="btn btn-success" runat="server" Text="Create Group" />
            <button id="cancel" data-dismiss="modal" class="btn ">Close</button>

        </div>
        <%--</asp:Panel>--%>
    </div>

    <div id="groupSettingModal" class="modal hide fade" tabindex="-1">

        <div class="modal-header">
            <h3>Group Settings</h3>
        </div>
        <div class="modal-body">
            <form class="form-horizontal">
                <div class="control-group">
                    <asp:Label ID="Label3" runat="server" CssClass="control-label" Text="Edit Group Name : "></asp:Label>
                    <div class="controls">
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <asp:Label ID="Label4" runat="server" CssClass="control-label" Text="Add new admin : "></asp:Label>
                    <div id="Div2" class="controls">
                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                     

                    </div>
            </form>
        </div>

        <div class="modal-footer">

            <asp:Button ID="Button2" CssClass="btn btn-success" runat="server" Text="Save Settings" />
            <button id="Button3" data-dismiss="modal" class="btn ">Close</button>

        </div>
        <%--</asp:Panel>--%>
    </div>
    <script type="text/javascript">
        $(function () {
            $('#btnAddMeeting').tooltip();
            $("[rel='tooltip']").tooltip();
        });
    </script>
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

