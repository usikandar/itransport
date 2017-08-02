
var bustemplateseats = $('#bustemplateseats').val();
var bustemplatefloor = $('#bustemplatefloor').val();
var bustemplateBusRows = $('#bustemplateBusRows').val();
var bustemplateSeatMaxRow = $('#bustemplateSeatMaxRow').val();
var vehicleTypeId = $('#VechicleTypeID').val();
var vehicleId = $('#VechicleID').val();

var seatMaxBusRows = (bustemplateSeatMaxRow*bustemplateBusRows);

var rowStart=10;
var rowEnd= +bustemplateBusRows + +11;
var colStart=10;
var colEnd= +bustemplateSeatMaxRow + +9;

var remainingSeats = bustemplateseats-(bustemplateSeatMaxRow * bustemplateBusRows);
var diffRows = (rowEnd + 1 - rowStart)/2;

var seatIdLower;

var seatIdUpper;

var seatTypeId;

var xmlString="";
var xmlStringFinal="";
var busBuilderTable = function () {
	var vehicleIsConfigured = true;
	var categorizeSeats = false;

	var seatBoxLower = $('#seat-box-lower');
	var seatBoxUpper = $('#seat-box-upper');

	var seatDesignLower = $('#seat-design-lower');
	var seatDesignUpper = $('#seat-design-upper');

	if (vehicleIsConfigured) {
		var seatBoxLowerHTML = '<table>';
		var seatBoxUpperHTML = '<table>';
		var seatDesignLowerHTML = '<table>';
		var seatDesignUpperHTML = '<table>';

		var count = 1;
		var rowCount = 1;
		for (var rnum = rowStart; rnum <= rowEnd; rnum++) {
			seatBoxLowerHTML = seatBoxLowerHTML + '<tr>';
			for (var cnum = colStart; cnum <= colEnd; cnum++) {
				//bus built coreC
				if(rowCount == 13 || rowCount == 14){
					
					seatBoxLowerHTML = seatBoxLowerHTML + "<td><input disabled id='boxLower" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input></td>";
					seatBoxUpperHTML = seatBoxUpperHTML + "<td><input disabled id='boxUpper" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input></td>";

					seatDesignLowerHTML = seatDesignLowerHTML + "<td rel='" + rnum + cnum + "' id='designLower" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'></td>";
					seatDesignUpperHTML = seatDesignUpperHTML + "<td rel='" + rnum + cnum + "' id='designUpper" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'></td>";

				}else{
					
					seatBoxLowerHTML = seatBoxLowerHTML + "<td><input disabled value='"+count+"' id='boxLower" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input></td>";
					seatBoxUpperHTML = seatBoxUpperHTML + "<td><input disabled value='"+count+"' id='boxUpper" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input></td>";
          
          classToappend = '';
          onclickFunction = 'seatDesignHandler(this)';
          style = '';
          arrayLength = previousSeats.length-1;
          seatID = count;
          for(var i=1;i<=arrayLength;i++){
            if(previousSeats[i][2] == count){
              classToappend = 'previousseat';
              onclickFunction = '';
              style = 'background-image: url('+previousSeats[i][1]+');';
              seatID = '';
            }
          }

					seatDesignLowerHTML = seatDesignLowerHTML + "<td style='"+style+"' rel='" + rnum + cnum + "' id='designLower" + rnum + cnum + "' class='vehicle-seat "+classToappend+"' onclick='"+onclickFunction+"'>"+seatID+"</td>";//seatDesignHandler(this)
					seatDesignUpperHTML = seatDesignUpperHTML + "<td rel='" + rnum + cnum + "' id='designUpper" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'>"+count+"</td>";
					
					count++;
				}
				
			}
			seatBoxLowerHTML = seatBoxLowerHTML + '</tr>';
			seatBoxUpperHTML = seatBoxUpperHTML + '</tr>';
			
			seatDesignLowerHTML = seatDesignLowerHTML + '</tr>';
			seatDesignUpperHTML = seatDesignUpperHTML + '</tr>';
			
			rowCount++;
		}
		seatBoxLowerHTML = seatBoxLowerHTML + '</table>';
		seatBoxUpperHTML = seatBoxUpperHTML + '</table>';

		seatDesignLowerHTML = seatDesignLowerHTML + '</table>';
		seatDesignUpperHTML = seatDesignUpperHTML + '</table>';


		$( seatBoxLower ).append( seatBoxLowerHTML );
		$( seatDesignLower ).append( seatDesignLowerHTML );
		
		if(bustemplatefloor == 2){
			$( seatBoxUpper ).append( seatBoxUpperHTML );
			$( seatDesignUpper ).append( seatDesignUpperHTML );
		}
		
		//	$("#designLower1114").attr('class', 'vehicle-sleeper');
	}
}

var seatBoxHandler = function (el) {
	var sourceId=event.target.id;
	var targetId=sourceId.replace("box", "design");
	var divName=sourceId.substring(0, 8);
	var rowNum=sourceId.substring(8, 10);
	var colNum=sourceId.substring(10, 12);
	var seatNum=event.target.value;
	var topId="";
	var bottomId="";
	var leftId="";
	var rightId="";
	
	if(rowNum>rowStart) //up
	{
		x=parseInt(rowNum)-1;
		topId=divName+x+colNum;
	}	
	if(rowNum<rowEnd) //down
	{
		x=parseInt(rowNum)+1;
		bottomId=divName+x+colNum;
	}
	
	if(colNum>colStart) //left
	{
		x=parseInt(colNum)-1;
		leftId=divName+rowNum+x;
	}
	
	if(colNum<colEnd) //right
	{
		x=parseInt(colNum)+1;
		rightId=divName+rowNum+x;
	}	

	//reset sleeper seat
	resetSeat(targetId,topId,bottomId,leftId,rightId);
	
	//check valid key
	if(parseInt(seatNum)>0)
		isValid =true;
	else
		isValid =false;


	//check duplicate
	var isFound=0;
	for (var rnum = rowStart; rnum <= rowEnd; rnum++) {
		for (var cnum = colStart; cnum <= colEnd; cnum++) {
			if($("#"+divName+rnum+cnum).val()==seatNum)
				isFound++;
		}
	}
	
	
	if(isFound>=2)
		isValid =false;
	else if(isFound==2 && isValid==true)
		isValid=checkSleeper(seatNum,sourceId,topId,bottomId,leftId,rightId);
	
	
	if(isValid==true)
	{
		if (seatNum=="@WR"){
			$("#"+targetId).attr('class', 'vehicle-washroom');
		}
		else if (seatNum=="@TV"){
			$("#"+targetId).attr('class', 'vehicle-tv');
		}
		else if (seatNum=="@PT"){
			$("#"+targetId).attr('class', 'vehicle-coffee');
		}
		else if (seatNum.includes("@SL")){
			var res = seatNum.replace("@SL", "");
			if(isNaN(res) || res === ''){
				alert('Please enter correct number. @SL[number] -> @SL1, @SL2');
				$("#"+targetId).html('');
				event.target.value="";
			}else{
				$("#"+targetId).html(res);
				$("#"+targetId).attr('class', 'vehicle-sleep');
			}

		}
		else{
			$("#"+targetId).html(seatNum);
		}
	}
	else
	{ 
		$("#"+targetId).html('');
		event.target.value="";
	}
}

function checkSleeper(seatNum,sourceId,topId,bottomId,leftId,rightId)
{
	var s1="";
	var s2="";
	var v="";

	if($("#"+topId).val()==seatNum)
	{
		s1=topId;
		s2=sourceId;
		v="1";
	}
	
	if($("#"+bottomId).val()==seatNum)
	{
		s2=bottomId;
		s1=sourceId;
		v="1";
	}
	
	if($("#"+leftId).val()==seatNum)
	{
		s1=leftId;
		s2=sourceId;
	}
	
	if($("#"+rightId).val()==seatNum)
	{
		s2=rightId;
		s1=sourceId;
	}
	
	s1=s1.replace("box", "design");
	s2=s2.replace("box", "design");
	
	if(s1=="" || s2=="")
		return false;
	else if(v=="")
	{
		//change seat to sleeper
		$("#"+s1).attr('class', 'vehicle-sleeper');
		$("#"+s2).attr('class', 'vehicle-sleeper');
		$("#"+s2).hide();
	}
	else if(v=="1")
	{
		$("#"+s1).attr('class', 'vehicle-sleeperv');
		$("#"+s2).attr('class', 'vehicle-sleeperv');
		$("#"+s2).hide();
	}
	return true;			
}

function resetSeat(targetId,topId,bottomId,leftId,rightId)
{
		topId=topId.replace("box", "design");
		bottomId=bottomId.replace("box", "design");
		leftId=leftId.replace("box", "design");
		rightId=rightId.replace("box", "design");
		
		if($("#"+targetId).html()==$("#"+topId).html() && $("#"+targetId).html()!="")
		{
			$("#"+topId).show()
			$("#"+topId).attr('class', 'vehicle-seat');
		}
		if($("#"+targetId).html()==$("#"+bottomId).html() && $("#"+targetId).html()!="")
		{
			$("#"+bottomId).show()
			$("#"+bottomId).attr('class', 'vehicle-seat');
		}
		if($("#"+targetId).html()==$("#"+leftId).html() && $("#"+targetId).html()!="")
		{
			$("#"+leftId).show()
			$("#"+leftId).attr('class', 'vehicle-seat');
		}
		if($("#"+targetId).html()==$("#"+rightId).html() && $("#"+targetId).html()!="")
		{
			$("#"+rightId).show()
			$("#"+rightId).attr('class', 'vehicle-seat');
		}
		$("#"+targetId).show()
		$("#"+targetId).attr('class', 'vehicle-seat');

}

var seatDesignHandler = function (el) {

	let $el = $(el); 

	if (($el).text().length > 0) {
		$el.toggleClass('selected');	
	}

	i=0;
	var lowerSeats = $('#seat-design-lower')
                    .find('.vehicle-seat.selected')
                    .map(function() {
						i++;
						if(i==1)
	                        return $(this).html();
						else
						    return "," + $(this).html();
                    })
                    .get();

	i=0;
	var upperSeats = $('#seat-design-upper')
          .find('.vehicle-seat.selected')
          .map(function() {
	i++;
	if(i==1)
                return $(this).html();
	else
	    return "," + $(this).html();
          })
          .get();


$('#lowerseats').html(lowerSeats);

$('#upperseats').html(upperSeats);

}


var generatXml  = function (el) {
	//Generate XML String to save in Stored Procedure
	xmlStringFinal = '<BusSeatTypes>'+xmlString+'</BusSeatTypes>';
	console.log(xmlStringFinal,"final xmlString");
	$.ajax({
    type: "POST",
    url: "Ajax.cfm",
    data: {ajaxAction: 'saveBusStructure', xmlData: xmlStringFinal, VechicleTypeID: vehicleTypeId, vehicleID: vehicleId},
    returnformat:'json',
    	success: function (data) {  
    		//console.log("start Data",data,"this is dat value");
    		alert(data);
    		// if(data==1){
    		// 	alert('Data successfully Added in DataBase');
    		// }else{
    		// 	alert('Sorry DataBase cannot Add these values');
    		// }
    	}
	});
	//$.get('BUS__Structure__SeatType.cfc?method=create&value=xmlStringFinal');
}

var seatCategoryHandler = function (el) {
	var sStr = $('#seattyperadioselect').val();
	//removing ClassName Space for future use
	className=sStr.replace(" ", "-");
	oldsStr = sStr;
	console.log(className,"ClassName Value");
	//Getting SeatTypeId to Put in xmlString
	classNameId=sStr.split("-");
	for(var index=0; index < classNameId.length; index++){
		seatTypeId=classNameId[index];
	}
	console.log(seatTypeId, "seatTypeId");

	if(sStr=="")
	{
		alert("Select Seat Type");
		return false;
	}
	//Remove the last digit from the String of Class
		sStr = sStr.split("-");
		sStr = sStr[0];
	
	if($('#lowerseats').html()!=""){
		sStr=sStr + " [ " + $('#lowerseats').html() + " ] ";
		
		//Getting lowerSeats to Put in xmlString
		seatIdLower = $('#lowerseats').html();
		seatIdLower = seatIdLower.split(",");

		//Making xmlString
		for(var index=0; index < seatIdLower.length; index++){
			xmlString= xmlString+'<BusSeatType SeatID="'+seatIdLower[index]+'">'+seatTypeId+'</BusSeatType>';
		}
		console.log(xmlString,"xmlString");
	}


	if($('#upperseats').html()!=="" && $('#upperseats').html()!=null){
		try{
	   		sStr=sStr + " [ " + $('#upperseats').html() + " ] ";
			console.log(sStr,"upperseats Condition true");		
			//Getting lowerSeats to Put in xmlString
			seatIdUpper = $('#upperseats').html();
			seatIdUpper = seatIdUpper.split(",");

			//Making xmlString
			for(var index=0; index < seatIdUpper.length; index++){
				xmlString= xmlString+'<BusSeatType SeatID="'+seatIdUpper[index]+'">'+seatTypeId+'</BusSeatType>';
			}
		}
		catch(e){
    		//alert('An error has occurred: '+e.message)
		}
		console.log(xmlString,"xmlString");
	}

	console.log(sStr,"sStrSeatCategory");
	//$('#selectedseats').html(sStr);
	$('#selectedseats').append(sStr);
	
	//clear all
	$('#lowerseats').html("");
	$('#upperseats').html("");
	$('#seattyperadioselect').val("");
	
lowerSeats = $('#seat-design-lower')
			.find('.vehicle-seat.selected')
			.map(function() {
				console.log($(this).attr('rel'),'rel');
				$(this).toggleClass('selected');
				$(this).toggleClass(className);
				$(this).removeAttr("onclick");
				$(this).html("");
				relValue = $(this).attr('rel');
				$('#boxLower'+relValue).attr("disabled",'disabled');
			})
			.get();

upperSeats = $('#seat-design-upper')
			.find('.vehicle-seat.selected')
			.map(function() {
				console.log(this);
				$(this).toggleClass('selected');
				$(this).toggleClass(className);
				$(this).removeAttr("onclick");
				$(this).html("");
				relValue = $(this).attr('rel');
				$('#boxUpper'+relValue).attr("disabled",'disabled');
			})
			.get();		
	
}

$(document).ready(function() {
	$('[data-toggle="tooltip-bus-name"], [data-toggle="tooltip-configure-info"]').tooltip();

	busBuilderTable();
});