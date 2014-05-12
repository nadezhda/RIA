<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TestPlace.aspx.vb" Inherits="TestPlace" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
		<meta charset="utf-8">
		<title> CSV test </title>
		<script src="js/jquery-1.8.0.min.js"></script>
		<script src="js/jquery.csv-0.71.js"></script>
		<script src="js/kdTree.js"></script>
		<script src="js/meetingPlace.js"></script>
		<link rel="stylesheet" type="text/css" href="css/place-style.css"></head>
<body>
    <form id="form1" runat="server">
    <div>
    		<div class="place-finder">
			<div class="left-pf-container">
				<form class="form-horizontal">
					<label class="control-label checkbox">
	                    <input type="checkbox" name="auto-location" id="closest-loc"/>
	                    Sort By Closest Location
	                </label><br />
                    <label class="control-label"id="campus">Campuses : </label><br />
                        <select class="campus-list" name="campus"></select>
                    <label class="control-label" id="building">Buildings : </label><br />
                    <select class="build-box" name="building" size="19"></select>

				</form>
			</div>
			<div class="right-pf-container">
				<form class="form-horizontal">
                    <label class="control-label" id="room">Rooms : </label><br />
                    <select class="room-box" name="room" size="10"></select>
                    <label class="control-label" id="equipment">Equipment : </label><br />
                    <select class="equip-box" name="equipment" size="10"></select>
                </form>
			</div>
		</div>

    </div>
    </form>
</body>
</html>
