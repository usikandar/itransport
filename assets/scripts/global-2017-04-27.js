var bustemplateseats = $('#bustemplateseats').val();
var bustemplatefloor = $('#bustemplatefloor').val();
var bustemplateBusRows = $('#bustemplateBusRows').val();
var bustemplateSeatMaxRow = $('#bustemplateSeatMaxRow').val();

var seatMaxBusRows = (bustemplateSeatMaxRow*bustemplateBusRows);

var rowStart=10;
var rowEnd= +bustemplateBusRows + +9;
var colStart=10;
var colEnd= +bustemplateSeatMaxRow + +9;

var remainingSeats = bustemplateseats-(bustemplateSeatMaxRow * bustemplateBusRows);
var diffRows = (rowEnd + 1 - rowStart)/2;

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

				seatDesignLowerHTML = seatDesignLowerHTML + "<td rel='" + rnum + cnum + "' id='designLower" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'></td>";
				seatDesignUpperHTML = seatDesignUpperHTML + "<td rel='" + rnum + cnum + "' id='designUpper" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'></td>";

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


var seatCategoryHandler = function (el) {
	var sStr=$('#seatcategory').val();
	className=sStr.replace(" ", "-");
	
	if(sStr=="")
	{
		alert("Select Seat Type");
		return false;
	}
	if($('#lowerseats').html()!="")
		sStr=sStr + " [ " + $('#lowerseats').html() + " ] ";
	
	if($('#upperseats').html()!="")
		sStr=sStr + " [ " + $('#upperseats').html() + " ] ";
	
	// $('#selectedseats').html(sStr);
	$('#selectedseats').append(sStr);
	
	//clear all
	$('#lowerseats').html("");
	$('#upperseats').html("");
	$('#seatcategory').val("");
	
lowerSeats = $('#seat-design-lower')
			.find('.vehicle-seat.selected')
			.map(function() {
				console.log($(this).attr('rel'),'rel');
				// 

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