<%@ Page Language="VB" Inherits="Table" MasterPageFile="~/Master.master" Title="Group Schedule" CodeFile="Table.aspx.vb" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>



<asp:Content ID="contentHome" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="body">
        <div class="container-fluid">
            <h4>Select a time slot to create a meeting</h4>
            <div class="table-responsive span5 offset1">

                <div>
                  
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [eventTable]"></asp:SqlDataSource>

                    <asp:HiddenField ID="HiddenField1" runat="server" />
                    <script type="text/javascript">
                        function SetValue() {


                            document.getElementById('<%=HiddenField1.ClientID%>').value = "test";
                            alert("test");
                            $('#CreateMeetingModalBox').modal('toggle');
                        }
                    </script>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always">
                        <ContentTemplate>

                            <DayPilot:DayPilotCalendar ID="DayPilotCalendar2" EventCorners="Rounded" EventArrangement="Full" HeightSpec="Fixed" HeaderDateFormat="m" CellDuration="60"
                                ColumnWidthSpec="Fixed" ClientObjectName="dpm" CellBorderColor="Green" CellHeight="50" EventHeaderHeight="50" Days="5" runat="server" EventClickHandling="CallBack" DurationBarVisible="false" CrosshairOpacity="20" HeaderHeightAutoFit="True" HeaderHeight="50" ColumnWidth="50" HideFreeCells="False" Crosshair="Header" EventSelectColor="#FFCC66" LoadingLabelText="Now Please Select The Place To Meet">
                            </DayPilot:DayPilotCalendar>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="DayPilotCalendar2" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <button runat="server" onclick="SetValue();"></button>

                </div>
            </div>


            <div class="span3">
                <form class="form-horizontal">
                    <div>
                        <label class="control-label checkbox">
                            <input type="checkbox" name="auto-location" id="closest-loc" />
                            Sort By Closest Location
                        </label>
                    </div>
                    <br />
                    <label class="control-label" id="campus">Campuses : </label>
                    <select class="campus-list" name="campus"></select>
                    <label class="control-label" id="building">Buildings : </label>
                    <select class="build-box" name="building" size="19"></select>

                </form>
            </div>
            <div class="span3">
                <form class="form-horizontal">
                    <br />
                    <br />
                    <br />

                    <label id="room">Rooms : </label>
                    <select class="room-box" name="room" size="10"></select>
                    <label id="equipment">Equipment : </label>
                    <select class="equip-box" name="equipment" size="10"></select>
                </form>
            </div>
            <div class="span6">
                <center><button id="btnCreatePlace" type="button"  class="btn btn-success" style="width:30%" runat="server" data-toggle="modal" data-target="#AddMeetingPlaceModal">
                Create Meeting</button></center>
            </div>

            <div id="AddMeetingPlaceModal" class="modal hide fade" tabindex="-1">
                <div class="modal-header">
                    <h4>Meeting Confirmation</h4>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                        <ContentTemplate>

                            <h5>You Meeting Details:</h5>
                            <br />
                            <asp:Label ID="lblDay" runat="server" Text=""></asp:Label>
                            <asp:Label ID="lblStart" runat="server" Text=""></asp:Label>
                            <asp:Label ID="lblEnd" runat="server" Text=""></asp:Label>
                            <asp:Label ID="lblDate" runat="server" Text=""></asp:Label>
                            <asp:Label ID="lblPlace" runat="server" Text=""></asp:Label>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="cmdCreateMeeting" runat="server" CssClass="btn btn-success" Text="Create Meeing & Send Emails" />
                    <button id="Button3" data-dismiss="modal" class="btn ">Cancel</button>
                </div>
            </div>
    </div>
    </div>
    <footer>
        <script src="js/csv.js"></script>
    </footer>
    <asp:HiddenField runat="server" ID="building_hf" Value="1416,29,46" />
</asp:Content>
