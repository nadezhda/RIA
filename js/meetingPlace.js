$(document).ready(function(){
//---------------------------------------------
	// Global Variables
	var radians = Math.PI/180;
	
	// Datasets
	var bldDataFile = "js/datasets/places-csv.csv"; // Buildings
	var roomDataFile = "js/datasets/rooms.csv"; // Rooms and room facilities

	// grab the buldings CSV file
	$.get(bldDataFile, function (csvString) {
		//transform the CSV string into array of bulding objects
		var bldData = $.csv.toObjects(csvString);
		// console.log(bldData);

		//****************** DropDown List with Buildings ****************

		// retrieve unique Campus Names from csv
		var unique = {};
		var distinct = [];
		for( var i in bldData ){
			if( typeof(unique[bldData[i].site_name]) == "undefined"){
				// Grab all names with substring "Campus"
				if(bldData[i].site_name.indexOf("Campus") != -1){
					distinct.push(bldData[i].site_name);
				}
		 	}
			unique[bldData[i].site_name] = 0;
		}
		
		// add campus values to dropdownlist
		var campusDlist = $(".campus-list");
		$.each(distinct, function(val, text) {
		    campusDlist.append(
		        $('<option></option>').val(val).html(text)
		    );
		});

		// Dummy data
		//----------------------------------------------
		// last buildings of each memebers of the group
		var Buildings = ["1416","29","46"];
		var campusName = "Highfield Campus";
		// var campusName = "Oceanography Centre Campus";
		//----------------------------------------------

		// calculate nearest neibor buildings
		var nearestBuildings = findNearestBuildings(bldData,Buildings, campusName);
		
		var campusList = $("select[name='campus']");
		var selectedCampus = $("option:selected", campusList).text();
		
		var buildingMultBox = $("select[name='building']");

		var roomMultBox = $("select[name='room']");
		var equipmentMultBox = $("select[name='equipment']");

		// dislay closest buildings accordint to midpoint
		var displayNearestBld = function(){
			campusList.prop('disabled', true);
			// clean building list
			buildingMultBox.empty();
			roomMultBox.empty();
			equipmentMultBox.empty();
			// display all nearest buildings in the multibox
		    for (index = 0; index < nearestBuildings.length; index++) {
				var bldNameString = TrimLength(nearestBuildings[index][0].number + "/"+ nearestBuildings[index][0].name,40);
		    	if(buildingMultBox.text() == ''){
		        	buildingMultBox.append("<option selected='selected'>"+ bldNameString + "</option>");

		    	}
		    	else{
		        	buildingMultBox.append("<option>"+ bldNameString + "</option>");
		        }
		    }
		}
		// display all the buildings for certain campus
		var displayAllCampusBld = function(){
			buildingMultBox.empty();
		    for(var i in bldData){

				if(bldData[i].site_name == $("option:selected", campusList).text()){
					// display all buildings in the box
					var bldNameString = TrimLength(bldData[i].number + "/" +bldData[i].name,40);
					if (buildingMultBox.text() == ''){ // if multibox is empty => select the first element
				        buildingMultBox.append("<option selected='selected'>" + bldNameString + "</option>");
					}
					else{
			        	buildingMultBox.append("<option>" + bldNameString + "</option>");
			        }
				}
			}
		}

		var displayBuildings = function(){
			if ($('input').is(':checked')) {
				// disable the campus list
				campusList.prop('disabled', true);
				displayNearestBld();
			}
			else{
				campusList.prop('disabled', false);
				displayAllCampusBld();
			}
		}

		// When page load/refresh
		displayBuildings();

		// If checkbox changed
		$("input").change(function(){
			displayBuildings();
		});

		// If campus changed
		campusList.change(function() {
			displayAllCampusBld();
		});

		//-------------------------------------------
		// Rooms
		//-------------------------------------------

		$.get(roomDataFile, function(csvString){
			//transform the CSV string into array of bulding objects
			var roomData = $.csv.toObjects(csvString);

			var displayAllAvailableRooms = function(){
				var selectedCampus = $("option:selected", campusList).text();
				var selectedBuilding = $("option:selected", buildingMultBox).text();
				var buildingNumber = selectedBuilding.substr(0, selectedBuilding.indexOf('/')); 

				roomMultBox.empty();
				equipmentMultBox.empty();
				
				var prevRoomNumber = "";
			    for(var i in roomData){

					if(roomData[i].site_name == selectedCampus){
						if(roomData[i].bldNumber == buildingNumber){
							// if current room number == previous room number
							if(roomData[i].roomNumber == prevRoomNumber){
								continue;
							}
							else{
								if(roomMultBox.text() == ""){ // if multibox is empty => select the first element
						        	roomMultBox.append("<option selected='selected'>" + roomData[i].roomNumber + "</option>");
								}
								else{
					        		roomMultBox.append("<option>" + roomData[i].roomNumber + "</option>");
					        	}
					        	prevRoomNumber = roomData[i].roomNumber;
					        }
						}
					}
				}

				// if rooms not been found
				if(roomMultBox.text() == ""){
					roomMultBox.append("<option class='notification'> No rooms available </option>");
					equipmentMultBox.append("<option class='notification'> No equipment available </option>");
				}
			}

			displayAllEquipment = function(){
				var selectedCampus = $("option:selected", campusList).text();
				var selectedBuilding = $("option:selected", buildingMultBox).text();
				var buildingNumber = selectedBuilding.substr(0, selectedBuilding.indexOf('/')); 
				var selectedRoom = $("option:selected", roomMultBox).text();

				equipmentMultBox.empty();

				if(roomMultBox.text() == " No rooms available "){
					equipmentMultBox.append("<option class='notification'> No equipment available </option>");
				}
				else{
				    for(var i in roomData){
				    	if(roomData[i].site_name == selectedCampus){
				    		if(roomData[i].bldNumber == buildingNumber){
						    	if(roomData[i].roomNumber == selectedRoom){
					        		equipmentMultBox.append("<option>" + TrimLength(roomData[i].features,35) + "</option>");
					        	}
				        	}
				    	}
				    }
				}
			}

			// display rooms & equipment
			displayAllAvailableRooms();
			displayAllEquipment();

			// If campus changed
			campusList.change(function() {
				displayAllAvailableRooms();
				displayAllEquipment();
			});


			// if building selected => display rooms
			buildingMultBox.change(function(){
				displayAllAvailableRooms();
				displayAllEquipment();
			});
			
			// if room selected => display equipment
			roomMultBox.change(function(){
				displayAllEquipment();

			});

			// If checkbox changed
			$("input").change(function(){
				displayAllAvailableRooms();
				displayAllEquipment();
			});

		});
	});


	function findNearestBuildings(bldDataset,buildingArray, campusName){
		/* 
		* Calculate midpoint among buildings from timetable and 
		* find closest building to that midpoint
		*/
		//******************** Calculate midpoint *************************
		var xCoordAggregation = 0,
			yCoordAggregation = 0,
			zCoordAggregation = 0;
		var campusBuildings = [];

		for (var i=0; i < buildingArray.length; i++){

			for (var j=0; j < bldDataset.length; j++){
				// if buildings within one campus
				if (bldDataset[j].site_name == campusName){
					if(i == buildingArray.length - 1){
						// Buildings of particular campus
						campusBuildings.push(bldDataset[j]);
					}
					
					if (buildingArray[i] == bldDataset[j].number){
						// console.log(bldDataset[j].number);
						var lat = parseFloat(bldDataset[j].lat);
						var lon = parseFloat(bldDataset[j].lon);
						// console.log("lat = " + lat + "; long = " + lon);

						// Get XYZ coordinates of the building
						var bldXYZCoords = covertToCartesianCoodrs(lat,lon);
						// console.log(bldXYZCoords.xCoord + ";" + bldXYZCoords.yCoord + ";" + bldXYZCoords.zCoord);
					}
				}
		}
			xCoordAggregation += bldXYZCoords.xCoord;
			yCoordAggregation += bldXYZCoords.yCoord;
			zCoordAggregation += bldXYZCoords.zCoord;

		}
		//console.log(bldDataset.length);
		//console.log(campusBuildings.length);

		// Calculate midpoint between the buildings
		var midPointX = xCoordAggregation/buildingArray.length;
		var midPointY = yCoordAggregation/buildingArray.length;
		var midPointZ = zCoordAggregation/buildingArray.length;

		// Convert midpoint coordinates to latitude and longitude
		var midPointLon = Math.atan2(midPointY,midPointX), // radians
			midPointHyp = Math.sqrt(midPointX*midPointX + midPointY*midPointY),
			midPointLat = Math.atan2(midPointZ,midPointHyp); // radians

		// console.log("Midpoint lat = " + midPointLat + ", Midpoint lon = " + midPointLon);
		// console.log("Midpoint lat = " + midPointLat/radians + ", Midpoint lon = " + midPointLon/radians);

		//******************** Find nearest buildings *************************

		var tree = new kdTree(campusBuildings, distance, ["lat", "lon"]);

		var nearest = tree.nearest({ lat: midPointLat, lon: midPointLon }, 10);

		var cleanNearestBld = [];

		for (var i in nearest){
			// if building doesn't have coordinates, 
			// delete it from nearest places array
			if (nearest[i][0].lat === "" || nearest[i][0].lon === ""){
				delete nearest[i];
			}
			else{
				cleanNearestBld.push(nearest[i]);
			}
		}
		// console.log(nearest);
		return cleanNearestBld;

	}


	// Convert latitude and longitude to cartesian coordinates
	function covertToCartesianCoodrs(lat,lon){

		// Convert decimal degrees to radians
		lat = lat*radians;
		lon = lon*radians;

		// convert to cartesian coordinates
		var cartCoodrs = {
			xCoord: Math.cos(lat)*Math.cos(lon),
			yCoord: Math.cos(lat)*Math.sin(lon),
			zCoord: Math.sin(lat)
		};

		return cartCoodrs;
	}

	// Calculate the Euclidean distance
	function distance(a, b) {

        var lat1 = parseFloat(a.lat),
	        lon1 = parseFloat(a.lon),
	        lat2 = parseFloat(b.lat),
	        lon2 = parseFloat(b.lon);
		
		// console.log(a.lat);

        var dLat = (lat2-lat1)*radians;
        var dLon = (lon2-lon1)*radians;
        var lat1 = lat1*radians;
        var lat2 = lat2*radians;

        var x = Math.sin(dLat/2);
        var y = Math.sin(dLon/2);

        var a = x*x + y*y * Math.cos(lat1) * Math.cos(lat2);
        return Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    }


	function TrimLength(text, maxLength){
    var ellipsis = "...";
	    text = $.trim(text);

	    if (text.length > maxLength)
	    {
	        text = text.substring(0, maxLength - ellipsis.length)
	        return text.substring(0, text.lastIndexOf(" ")) + ellipsis;
	    }
	    else
	        return text;
	}

//----------------------------------------------	
});