// if(bustemplatefloor == 2){
// 	bustemplateseats = bustemplateseats/2;
// 	console.log(rowsperseats,'rowsperseats');
// }

// var rowsperseats = Math.ceil(bustemplateseats/bustemplateSeatMaxRow);
// var numberRows = Math.ceil(rowsperseats+9);
// //console.log(bustemplateseats,'bustemplateseats');


// var totalSeats = bustemplateseats;
// var calculateRows = Math.ceil(totalSeats/bustemplateSeatMaxRow);
// var numberRows = Math.ceil(calculateRows+9);
// console.log(calculateRows,'calculateRows');
// console.log(numberRows,'numberRows');

var bustemplateseats = $('#bustemplateseats').val();
var bustemplatefloor = $('#bustemplatefloor').val();
var bustemplateBusRows = $('#bustemplateBusRows').val();
var bustemplateSeatMaxRow = $('#bustemplateSeatMaxRow').val();

var seatMaxBusRows = (bustemplateSeatMaxRow*bustemplateBusRows);

console.log(bustemplateseats,'bustemplateseats');
console.log(bustemplatefloor,'bustemplatefloor');
console.log(bustemplateBusRows,'bustemplateBusRows');
console.log(bustemplateSeatMaxRow,'bustemplateSeatMaxRow');

console.log(seatMaxBusRows,'seatMaxBusRows');

var rowStart=10;
var rowEnd= +bustemplateBusRows + +9;
var colStart=10;
var colEnd= +bustemplateSeatMaxRow + +9;

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

		for (var rnum = rowStart; rnum <= rowEnd; rnum++) {
			seatBoxLowerHTML = seatBoxLowerHTML + '<tr>';
			for (var cnum = colStart; cnum <= colEnd; cnum++) {
				//bus built coreC
				seatBoxLowerHTML = seatBoxLowerHTML + "<td><input id='boxLower" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input></td>";
				seatBoxUpperHTML = seatBoxUpperHTML + "<td><input id='boxUpper" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input></td>";

				seatDesignLowerHTML = seatDesignLowerHTML + "<td id='designLower" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'></td>";
				seatDesignUpperHTML = seatDesignUpperHTML + "<td id='designUpper" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'></td>";

				//$( seatBoxLower ).append( "<input id='boxLower" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input>" );
				//$( seatBoxUpper ).append( "<input id='boxUpper" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input>" );
				
				//$( seatDesignLower ).append( "<div id='designLower" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'></div>" );
				//$( seatDesignUpper ).append( "<div id='designUpper" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'></div>" );
				
			}
			seatBoxLowerHTML = seatBoxLowerHTML + '</tr>';
			seatBoxUpperHTML = seatBoxUpperHTML + '</tr>';
			
			seatDesignLowerHTML = seatDesignLowerHTML + '</tr>';
			seatDesignUpperHTML = seatDesignUpperHTML + '</tr>';
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
	if(seatNum =="@TV" || seatNum=="@WR" || seatNum=="@PT" || parseInt(seatNum)>0)
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
	
	
	if(isFound>2)
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
		$("#"+s2).attr('class', 'vehicle-sleepervBottom');
		//$("#"+s2).attr('class', 'vehicle-sleeperv');
		//$("#"+s2).hide();
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
//console.log(lowerSeats.length,'lowerSeatsLength');
  i=0;
	var lowerSleeperSeats = $('#seat-design-lower')
                    .find('.vehicle-sleeper.selected')
                    .map(function() {
						i++;
						if(i==1)
							if(lowerSeats.length >=1){
	            	return "," + $(this).html();
							}
	            else{
	            	return $(this).html();
	            }
						else
						    return "," + $(this).html();
                    })
                    .get();

  i=0;
	var lowerSleeperVSeats = $('#seat-design-lower')
                    .find('.vehicle-sleeperv.selected')
                    .map(function() {
						i++;
						if(i==1)
							if(lowerSleeperSeats.length >=1){
	            	return "," + $(this).html();
							}
	            else{
	            	return $(this).html();
	            }
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

  i=0;
	var upperSleeperSeats = $('#seat-design-upper')
                    .find('.vehicle-sleeper.selected')
                    .map(function() {
						i++;
						if(i==1)
							if(upperSeats.length >=1){
	            	return "," + $(this).html();
							}
	            else{
	            	return $(this).html();
	            }
						else
						    return "," + $(this).html();
                    })
                    .get();

  i=0;
	var upperSleeperVSeats = $('#seat-design-upper')
                    .find('.vehicle-sleeperv.selected')
                    .map(function() {
						i++;
						if(i==1)
							if(upperSleeperSeats.length >=1){
	            	return "," + $(this).html();
							}
	            else{
	            	return $(this).html();
	            }
						else
						    return "," + $(this).html();
                    })
                    .get();



//$('#lowerseats').html(lowerSeats+' '+lowerSleeperSeats+' '+lowerSleeperVSeats);
$('#lowerseats').html(lowerSeats);
$('#lowerSleeperSeats').html(lowerSleeperSeats);
$('#lowerSleeperVSeats').html(lowerSleeperVSeats);

$('#upperseats').html(upperSeats);
$('#upperSleeperSeats').html(upperSleeperSeats);
$('#upperSleeperVSeats').html(upperSleeperVSeats);

}


var seatCategoryHandler = function (el) {
	var sStr=$('#seatcategory').val();
	if(sStr=="")
	{
		alert("Select Seat Type");
		return false;
	}
	if($('#lowerseats').html()!="")
		//sStr=sStr + " [ " + $('#lowerseats').html() + " ] ";
		sStr=sStr + " [ " + $('#lowerseats').html() + $('#lowerSleeperSeats').html() + $('#lowerSleeperVSeats').html() + " ] ";
	
	if($('#upperseats').html()!="")
		//sStr=sStr + " [ " + $('#upperseats').html() + " ] ";
		sStr=sStr + " [ " + $('#upperseats').html() + $('#upperSleeperSeats').html() + $('#upperSleeperVSeats').html() + " ] ";
	
	$('#selectedseats').html(sStr);
	
	//clear all
	// $('#lowerseats').html("");
	// $('#upperseats').html("");
	$('#lowerseats').html("");
	$('#lowerSleeperSeats').html("");
	$('#lowerSleeperVSeats').html("");

	$('#upperseats').html("");
	$('#upperSleeperSeats').html("");
	$('#upperSleeperVSeats').html("");

	$('#seatcategory').val("");
	
lowerSeats = $('#seat-design-lower')
			.find('.vehicle-seat.selected')
			.map(function() {
				$(this).toggleClass('selected');
			})
			.get();
lowerSleeperSeats = $('#seat-design-lower')
			.find('.vehicle-sleeper.selected')
			.map(function() {
				$(this).toggleClass('selected');
			})
			.get();
lowerSleeperVSeats = $('#seat-design-lower')
			.find('.vehicle-sleeperv.selected')
			.map(function() {
				$(this).toggleClass('selected');
			})
			.get();

upperSeats = $('#seat-design-upper')
			.find('.vehicle-seat.selected')
			.map(function() {
				$(this).toggleClass('selected');
			})
			.get();		
upperSleeperSeats = $('#seat-design-upper')
			.find('.vehicle-sleeper.selected')
			.map(function() {
				$(this).toggleClass('selected');
			})
			.get();
upperSleeperVSeats = $('#seat-design-upper')
			.find('.vehicle-sleeperv.selected')
			.map(function() {
				$(this).toggleClass('selected');
			})
			.get();			
	
}


$(document).ready(function() {
	$('[data-toggle="tooltip-bus-name"], [data-toggle="tooltip-configure-info"]').tooltip();

	busBuilderTable();
});