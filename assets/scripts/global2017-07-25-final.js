
var bustemplateseats = $('#bustemplateseats').val();
var bustemplatefloor = $('#bustemplatefloor').val();
var bustemplateBusRows = $('#bustemplateBusRows').val();
var bustemplateSeatMaxRow = $('#bustemplateSeatMaxRow').val();
var vehicleTypeId = $('#VechicleTypeID').val();
var vehicleVirtualVersionID = $('#VehicleVirtualVersionID').val();
// var vehicleId = $('#VechicleID').val();
var versionId = $('#VersionID').val();
var dimensionType = $('#dimensionType').val();
var dimension = "";
// var sStr = "";

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
          
          seatBoxLowerHTML = seatBoxLowerHTML + "<td><input id='boxLower" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input></td>";
          seatBoxUpperHTML = seatBoxUpperHTML + "<td><input id='boxUpper" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input></td>";

          seatDesignLowerHTML = seatDesignLowerHTML + "<td rel='" + rnum + cnum + "' id='designLower" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'></td>";
          seatDesignUpperHTML = seatDesignUpperHTML + "<td rel='" + rnum + cnum + "' id='designUpper" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'></td>";

        }else{
          
          seatBoxLowerHTML = seatBoxLowerHTML + "<td><input value='"+count+"' id='boxLower" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input></td>";
          seatBoxUpperHTML = seatBoxUpperHTML + "<td><input value='"+count+"' id='boxUpper" + rnum + cnum + "' type='text' class='seat_box' onchange='seatBoxHandler(this)'></input></td>";
          
          classToappend = '';
          onclickFunction = 'seatDesignHandler(this)';
          style = '';
          selected = '';
          arrayLength = previousSeats.length-1;
          seatID = count;
          for(var i=1;i<=arrayLength;i++){
            if(previousSeats[i][2] == count){
              //classToappend = 'previousseat';
              //onclickFunction = '';
              style = 'background-image: url('+previousSeats[i][1]+');';
              selected = "selected";
              dimension = previousSeats[i][0];
              //seatID = '';
            }
          }

          if(selected == 'selected'){
            // seatDesignHandler(seatDesignLowerHTML);
            seatDesignLowerHTML = seatDesignLowerHTML + "<td style='"+style+"' rel='" + rnum + cnum + "' dimension='"+dimension+"' seatId='"+seatID+"' id='designLower" + rnum + cnum + "' class='vehicle-seat-selected "+classToappend+"' onclick='getSelectedSeat(this)'></td>";//seatDesignHandler(this)
            seatDesignUpperHTML = seatDesignUpperHTML + "<td rel='" + rnum + cnum + "' id='designUpper" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'>"+count+"</td>";

            seatCategoryAssign(dimension, seatID);
          }else{
            seatDesignLowerHTML = seatDesignLowerHTML + "<td style='"+style+"' rel='" + rnum + cnum + "' seatId='"+seatID+"' dimension='"+dimension+"' id='designLower" + rnum + cnum + "' class='vehicle-seat "+classToappend+"' onclick='"+onclickFunction+"'>"+seatID+"</td>";//seatDesignHandler(this)
            seatDesignUpperHTML = seatDesignUpperHTML + "<td rel='" + rnum + cnum + "' id='designUpper" + rnum + cnum + "' class='vehicle-seat' onclick='seatDesignHandler(this)'>"+count+"</td>";

          }

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
    
    //  $("#designLower1114").attr('class', 'vehicle-sleeper');
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
  if(parseInt(seatNum)>0){
    //alert(1);
    isValid =true;
  }else{
    //alert(2);
    isValid =true;
  }


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

var getSelectedSeat = function (el) {
  let $el = $(el); 

  var selectedSeat = el.getAttribute("seatId"); 

  console.log(el, "el");
  console.log(selectedSeat, "selectedSeat");

  if (selectedSeat > 0) {
    $el.toggleClass('selected');  
  }

  xmlSeatsString = "<seats>"+xmlString+"</seats>";

  var parser, xmlDoc;

  var txt = "";
  var xmlNewString = '';

  parser = new DOMParser();
  xmlDoc = parser.parseFromString(xmlSeatsString,"text/xml");


  dimensionType = $('input[name=dimensionsradio]:checked').val();

  if(dimensionType == 'classDimension'){
    var busCategory = "BusSeatClass";
  }else if(dimensionType == 'facilitiesCategoryDimension'){
    var busCategory = "FacilityCategory";
  }else if(dimensionType == 'facilitiesDimension'){
    var busCategory = "Facility";
  }else{
    var busCategory = "BusSeatType";
  }

  x = xmlDoc.getElementsByTagName(busCategory);

  for (i = 0; i < x.length; i++) { 

      y = x[i].getAttribute('SeatID');

      if(selectedSeat == y){

        removeAtttr = xmlDoc.getElementsByTagName(busCategory)[i];

        xmlDoc.documentElement.removeChild(removeAtttr);
      }
  }

  for (i = 0; i < x.length; i++) { 

      xmlNewString += x[i].outerHTML;

  }

  xmlString = xmlNewString;

  i=0;
  var lowerSeatsSelected = $('#seat-design-lower')
    .find('.vehicle-seat-selected.selected')
    .map(function() {

        if(dimensionType == 'classDimension'){
          
          $(this).removeClass('CLASS-A-1');
          $(this).removeClass('CLASS-B-2');
          $(this).removeClass('CLASS-C-3');
          $(this).removeClass('CLASS-D-4');
          $(this).removeClass('CLASS-E-5');

        }else if(dimensionType == 'facilitiesCategoryDimension'){
          
          $(this).removeClass('Food-and-Beverages-1');
          $(this).removeClass('Entertainment-21');
          $(this).removeClass('Bar-22');

        }else if(dimensionType == 'facilitiesDimension'){

          $(this).removeClass('Cold-Drink-1');
          $(this).removeClass('Coffee-2');
          $(this).removeClass('Tea-20');
          $(this).removeClass('Other-21');
          $(this).removeClass('tv-23');
          $(this).removeClass('Vodka-24');
        }else{
          $(this).removeClass('Front-Seats-1');
          $(this).removeClass('Middle-Seats-2');
          $(this).removeClass('Back-Seats-3');
          $(this).removeClass('Premium-Seats-4');
          $(this).removeClass('Luxury-Seats-5');
          $(this).removeClass('VIP-Seats-6');
          $(this).removeClass('Driver-7');
          $(this).removeClass('Co-driver-8');
          $(this).removeClass('Toilet-9');
          $(this).removeClass('Sleeper-10');
          $(this).removeClass('TV-111');
        }
        $(this).removeAttr('style');
      i++;
      if(i==1)
        return $(this).attr("seatId");
      else
        return "," + $(this).attr("seatId");
    })
  .get();

  i=0;
  var upperSeatsSelected = $('#seat-design-upper')
    .find('.vehicle-seat-selected.selected')
    .map(function() {

        if(dimensionType == 'classDimension'){
          
          $(this).removeClass('CLASS-A-1');
          $(this).removeClass('CLASS-B-2');
          $(this).removeClass('CLASS-C-3');
          $(this).removeClass('CLASS-D-4');
          $(this).removeClass('CLASS-E-5');

        }else if(dimensionType == 'facilitiesCategoryDimension'){
          
          $(this).removeClass('Food-and-Beverages-1');
          $(this).removeClass('Entertainment-21');
          $(this).removeClass('Bar-22');

        }else if(dimensionType == 'facilitiesDimension'){

          $(this).removeClass('Cold-Drink-1');
          $(this).removeClass('Coffee-2');
          $(this).removeClass('Tea-20');
          $(this).removeClass('Other-21');
          $(this).removeClass('tv-23');
          $(this).removeClass('Vodka-24');
        }else{
          $(this).removeClass('Front-Seats-1');
          $(this).removeClass('Middle-Seats-2');
          $(this).removeClass('Back-Seats-3');
          $(this).removeClass('Premium-Seats-4');
          $(this).removeClass('Luxury-Seats-5');
          $(this).removeClass('VIP-Seats-6');
          $(this).removeClass('Driver-7');
          $(this).removeClass('Co-driver-8');
          $(this).removeClass('Toilet-9');
          $(this).removeClass('Sleeper-10');
          $(this).removeClass('TV-111');
        }
        $(this).removeAttr('style');

      i++;
      if(i==1)
        return $(this).attr("seatId");
      else
        return "," + $(this).attr("seatId");
    })
  .get();


  $('#lowerseatsSelected').html(lowerSeatsSelected);

  $('#upperseatsSelected').html(upperSeatsSelected);

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


var generatXml  = function (el,dimensionType) {
  //Generate XML String to save in Stored Procedure
  if(dimensionType == 'classDimension'){
    xmlStringFinal = '<BusSeatClasses>'+xmlString+'</BusSeatClasses>';
  }else if(dimensionType == 'facilitiesCategoryDimension'){
    xmlStringFinal = '<FacilityCategories>'+xmlString+'</FacilityCategories>';
  }else if(dimensionType == 'facilitiesDimension'){
    xmlStringFinal = '<Facilities>'+xmlString+'</Facilities>';
  }else if(dimensionType == 'seatTypeDimension'){
    xmlStringFinal = '<BusSeatTypes>'+xmlString+'</BusSeatTypes>';
  }

  $.ajax({
    type: "POST",
    url: "Ajax.cfm",
    data: {ajaxAction: 'saveBusStructure', dimensiontype: dimensionType, xmlData: xmlStringFinal, VehicleVirtualVersionID: vehicleVirtualVersionID, VechicleTypeID: vehicleTypeId, VersionID: versionId},
    returnformat:'json',
      success: function (data) {
        alert(data);
        console.log(data);
        // location.reload();
          $( "#saveBus" ).hide(); 
          $( "#updateSaveBus" ).removeClass('hidden'); 
      }
  });
}

var generatUpdateXml  = function (el,dimensionType) {

  //Generate XML String to save in Stored Procedure
  if(dimensionType == 'classDimension'){
    xmlStringFinal = '<BusSeatClasses>'+xmlString+'</BusSeatClasses>';
  }else if(dimensionType == 'facilitiesCategoryDimension'){
    xmlStringFinal = '<FacilityCategories>'+xmlString+'</FacilityCategories>';
  }else if(dimensionType == 'facilitiesDimension'){
    xmlStringFinal = '<Facilities>'+xmlString+'</Facilities>';
  }else if(dimensionType == 'seatTypeDimension'){
    xmlStringFinal = '<BusSeatTypes>'+xmlString+'</BusSeatTypes>';
  }
  // console.log(xmlStringFinal, "xmlStringFinal");
  $.ajax({
    type: "POST",
    url: "Ajax.cfm",
    data: {ajaxAction: 'updateBusStructure', dimensiontype: dimensionType, xmlData: xmlStringFinal, VehicleVirtualVersionID: vehicleVirtualVersionID, VechicleTypeID: vehicleTypeId, VersionID: versionId},
    returnformat:'json',
      success: function (data) {
        if(data!==''){
          alert(data);
          console.log(data);
        }
      }
  });
}

var deleteXml  = function (el,dimensionType) {


  var answer = confirm ("Are you sure that you want to delete bus?");

  if(answer){

    //Generate XML String to save in Stored Procedure
    if(dimensionType == 'classDimension'){
      xmlStringFinal = '<BusSeatClasses>'+xmlString+'</BusSeatClasses>';
    }else if(dimensionType == 'facilitiesCategoryDimension'){
      xmlStringFinal = '<FacilityCategories>'+xmlString+'</FacilityCategories>';
    }else if(dimensionType == 'facilitiesDimension'){
      xmlStringFinal = '<Facilities>'+xmlString+'</Facilities>';
    }else if(dimensionType == 'seatTypeDimension'){
      xmlStringFinal = '<BusSeatTypes>'+xmlString+'</BusSeatTypes>';
    }
    // console.log(xmlStringFinal, "xmlStringFinal");
    // console.log(versionId, "versionId");
    // console.log(vehicleVirtualVersionID, "vehicleVirtualVersionID");
    // console.log(vehicleTypeId, "vehicleTypeId");
    $.ajax({
      type: "POST",
      url: "Ajax.cfm",
      data: {ajaxAction: 'deleteBusStructure', dimensiontype: dimensionType, xmlData: xmlStringFinal, VehicleVirtualVersionID: vehicleVirtualVersionID, VechicleTypeID: vehicleTypeId, VersionID: versionId},
      returnformat:'json',
        success: function (data) {
          if(data!==''){
            alert(data);
            console.log(data);
            // location.reload();
          }
        }
    });

  }

}

function seatCategoryAssign(dimension, seatNumber){

  dimensionType = $('input[name=dimensionsradio]:checked').val();

  if(dimensionType == 'classDimension'){
    setID = 'classradioselect';
  }else if(dimensionType == 'facilitiesCategoryDimension'){
    setID = 'facilitycategoryradioselect';
  }else if(dimensionType == 'facilitiesDimension'){
    setID = 'facilitiesradioselect';
  }else{
    setID = 'seattyperadioselect';
  }

  var selectCounter = 0;

  if(dimensionType == 'facilitiesCategoryDimension'){
    if(dimension == 1){
      dimension = 1;
    }else if(dimension == 21){
      dimension = 2;
    }else if(dimension == 22){
      dimension = 3;
    }
  }

  if(dimensionType == 'facilitiesDimension'){
    if(dimension == 20){
      dimension = 3;
    }else if(dimension == 21){
      dimension = 4;
    }else if(dimension == 23){
      dimension = 5;
    }else if(dimension == 24){
      dimension = 6;
    }else if(dimension == 1){
      dimension = 1;
    }else if(dimension == 2){
      dimension = 2;
    }
  }

  $("#"+setID+" option").each(function()
  {
      if(selectCounter == dimension){
        sStr = $(this).val();
      }
      selectCounter++;
  });

  //removing ClassName Space for future use
  className=sStr.replace(" ", "-");
  className=className.replace(" ", "-");
  className=className.replace(" ", "-");
  className=className.replace(" ", "-");
  oldsStr = sStr;

  //Getting SeatTypeId to Put in xmlString
  classNameId=sStr.split("-");
  for(var index=0; index < classNameId.length; index++){
    seatTypeId=classNameId[index];
  }

  if(sStr=="")
  {
    // alert("Select value from list");
    return false;
  }else{
    $( "#saveBus" ).removeAttr("disabled"); 
    $( "#updateBus" ).removeAttr("disabled"); 
  }
  //Remove the last digit from the String of Class
    sStr = sStr.split("-");
    sStr = sStr[0];

    sStr=sStr + " [ " + seatNumber + " ] ";

    if(dimensionType == 'classDimension'){
      xmlString= xmlString+'<BusSeatClass SeatID="'+seatNumber+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</BusSeatClass>';
    }else if(dimensionType == 'facilitiesCategoryDimension'){
      xmlString= xmlString+'<FacilityCategory SeatID="'+seatNumber+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</FacilityCategory>';
    }else if(dimensionType == 'facilitiesDimension'){
      xmlString= xmlString+'<Facility SeatID="'+seatNumber+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</Facility>';
    }else if(dimensionType == 'seatTypeDimension'){
      xmlString= xmlString+'<BusSeatType SeatID="'+seatNumber+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</BusSeatType>';
    }

  $('#selectedseats').append(sStr);
  
  //clear all
  $('#lowerseats').html("");
  $('#upperseats').html("");
  //$('#seattyperadioselect').val("");
  
lowerSeats = $('#seat-design-lower')
      .find('.vehicle-seat.selected')
      .map(function() {
        $(this).toggleClass('selected');
        $(this).toggleClass(className);
        $(this).removeAttr("onclick");
        // $(this).removeAttr("style");
        $(this).html("");
        relValue = $(this).attr('rel');
        $('#boxLower'+relValue).attr("disabled",'disabled');
      })
      .get();

upperSeats = $('#seat-design-upper')
      .find('.vehicle-seat.selected')
      .map(function() {
        $(this).toggleClass('selected');
        $(this).toggleClass(className);
        $(this).removeAttr("onclick");
        // $(this).removeAttr("style");
        $(this).html("");
        relValue = $(this).attr('rel');
        $('#boxUpper'+relValue).attr("disabled",'disabled');
      })
      .get();  

}

var seatCategoryHandler = function (el) {
  
  dimensionType = $('input[name=dimensionsradio]:checked').val();
  if(dimensionType == 'classDimension'){
    setID = 'classradioselect';
  }else if(dimensionType == 'facilitiesCategoryDimension'){
    setID = 'facilitycategoryradioselect';
  }else if(dimensionType == 'facilitiesDimension'){
    setID = 'facilitiesradioselect';
  }else{
    setID = 'seattyperadioselect';
  }

  var sStr = $('#'+setID).val();
  //removing ClassName Space for future use
  className=sStr.replace(" ", "-");
  className=className.replace(" ", "-");
  className=className.replace(" ", "-");
  className=className.replace(" ", "-");
  oldsStr = sStr;

  //Getting SeatTypeId to Put in xmlString
  classNameId=sStr.split("-");
  for(var index=0; index < classNameId.length; index++){
    seatTypeId=classNameId[index];
  }

  if(sStr=="")
  {
    alert("Select value from list");
    return false;
  }else{
    $( "#saveBus" ).removeAttr("disabled"); 
    $( "#updateBus" ).removeAttr("disabled"); 
  }
  //Remove the last digit from the String of Class
    sStr = sStr.split("-");
    sStr = sStr[0];
  
  if($('#lowerseats').html()!=""){
    sStr=sStr + " [ " + $('#lowerseats').html() + " ] ";
    
    //Getting lowerSeats to Put in xmlString
    seatIdLower = $('#lowerseats').html();
    seatIdLower = seatIdLower.split(",");
    //.match(/[a-zA-Z]+|[0-9]+/g)

    //Making xmlString
    for(var index=0; index < seatIdLower.length; index++){

      // console.log(seatIdLower[index].match(/[a-zA-Z]+|[0-9]+/g),'alphaNumericsLower');

      getSeat = seatIdLower[index].match(/[a-zA-Z]+|[0-9]+/g);
        
      if(getSeat.length > 1){
        seatID = getSeat[1];
        seatNumber = getSeat[0]+seatID;
      }else if(getSeat.length == 1){
        seatID = getSeat[0];
        seatNumber = seatID;
      }

      if(dimensionType == 'classDimension'){
        xmlString= xmlString+'<BusSeatClass SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</BusSeatClass>';
      }else if(dimensionType == 'facilitiesCategoryDimension'){
        xmlString= xmlString+'<FacilityCategory SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</FacilityCategory>';
      }else if(dimensionType == 'facilitiesDimension'){
        xmlString= xmlString+'<Facility SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</Facility>';
      }else if(dimensionType == 'seatTypeDimension'){
        xmlString= xmlString+'<BusSeatType SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</BusSeatType>';
      }

    }

  }  

  if($('#lowerseatsSelected').html()!=""){
    sStr=sStr + " [ " + $('#lowerseatsSelected').html() + " ] ";
    
    //Getting lowerSeats to Put in xmlString
    seatIdLower = $('#lowerseatsSelected').html();
    seatIdLower = seatIdLower.split(",");
    //console.log(seatIdLower,'seatIdLower');
    //.match(/[a-zA-Z]+|[0-9]+/g)

    //Making xmlString
    for(var index=0; index < seatIdLower.length; index++){

      // console.log(seatIdLower[index].match(/[a-zA-Z]+|[0-9]+/g),'alphaNumericsLower');

      getSeat = seatIdLower[index].match(/[a-zA-Z]+|[0-9]+/g);
        
      if(getSeat.length > 1){
        seatID = getSeat[1];
        seatNumber = getSeat[0]+seatID;
      }else if(getSeat.length == 1){
        seatID = getSeat[0];
        seatNumber = seatID;
      }

      if(dimensionType == 'classDimension'){
        xmlString= xmlString+'<BusSeatClass SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</BusSeatClass>';
      }else if(dimensionType == 'facilitiesCategoryDimension'){
        xmlString= xmlString+'<FacilityCategory SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</FacilityCategory>';
      }else if(dimensionType == 'facilitiesDimension'){
        xmlString= xmlString+'<Facility SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</Facility>';
      }else if(dimensionType == 'seatTypeDimension'){
        xmlString= xmlString+'<BusSeatType SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</BusSeatType>';
      }

    }

  }


  if($('#upperseats').html()!=="" && $('#upperseats').html()!=null){
    try{
        sStr=sStr + " [ " + $('#upperseats').html() + " ] ";
      // console.log(sStr,"upperseats Condition true");    
      //Getting lowerSeats to Put in xmlString
      seatIdUpper = $('#upperseats').html();
      seatIdUpper = seatIdUpper.split(",");

      //Making xmlString
      for(var index=0; index < seatIdUpper.length; index++){

        getSeat = seatIdUpper[index].match(/[a-zA-Z]+|[0-9]+/g);
        
        if(getSeat.length > 1){
          seatID = getSeat[1];
          seatNumber = getSeat[0]+seatID;
        }else if(getSeat.length == 1){
          seatID = getSeat[0];
          seatNumber = seatID;
        }


        if(dimensionType == 'classDimension'){
          xmlString= xmlString+'<BusSeatClass SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</BusSeatClass>';
        }else if(dimensionType == 'facilitiesCategoryDimension'){
          xmlString= xmlString+'<FacilityCategory SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</FacilityCategory>';
        }else if(dimensionType == 'facilitiesDimension'){
          xmlString= xmlString+'<Facility SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</Facility>';
        }else if(dimensionType == 'seatTypeDimension'){
          xmlString= xmlString+'<BusSeatType SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</BusSeatType>';
        }
        //xmlString= xmlString+'<BusSeatType SeatID="'+seatIdUpper[index]+'">'+seatTypeId+'</BusSeatType>';
      }
    }
    catch(e){
        //alert('An error has occurred: '+e.message)
    }
    //console.log(xmlString,"xmlString");
  }

  if($('#upperseatsSelected').html()!=="" && $('#upperseatsSelected').html()!=null){
    try{
        sStr=sStr + " [ " + $('#upperseatsSelected').html() + " ] ";
      // console.log(sStr,"upperseats Condition true");    
      //Getting lowerSeats to Put in xmlString
      seatIdUpper = $('#upperseatsSelected').html();
      seatIdUpper = seatIdUpper.split(",");

      //Making xmlString
      for(var index=0; index < seatIdUpper.length; index++){

        getSeat = seatIdUpper[index].match(/[a-zA-Z]+|[0-9]+/g);
        
        if(getSeat.length > 1){
          seatID = getSeat[1];
          seatNumber = getSeat[0]+seatID;
        }else if(getSeat.length == 1){
          seatID = getSeat[0];
          seatNumber = seatID;
        }


        if(dimensionType == 'classDimension'){
          xmlString= xmlString+'<BusSeatClass SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</BusSeatClass>';
        }else if(dimensionType == 'facilitiesCategoryDimension'){
          xmlString= xmlString+'<FacilityCategory SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</FacilityCategory>';
        }else if(dimensionType == 'facilitiesDimension'){
          xmlString= xmlString+'<Facility SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</Facility>';
        }else if(dimensionType == 'seatTypeDimension'){
          xmlString= xmlString+'<BusSeatType SeatID="'+seatID+'" SeatNumber="'+seatNumber+'">'+seatTypeId+'</BusSeatType>';
        }
        //xmlString= xmlString+'<BusSeatType SeatID="'+seatIdUpper[index]+'">'+seatTypeId+'</BusSeatType>';
      }
    }
    catch(e){
        //alert('An error has occurred: '+e.message)
    }

  }

  //$('#selectedseats').html(sStr);
  $('#selectedseats').append(sStr);
  
  //clear all
  $('#lowerseats').html("");
  $('#upperseats').html("");
  $('#lowerseatsSelected').html("");
  $('#upperseatsSelected').html("");
  //$('#seattyperadioselect').val("");
  
lowerSeats = $('#seat-design-lower')
      .find('.vehicle-seat.selected')
      .map(function() {
        //console.log($(this).attr('rel'),'rel');
        $(this).toggleClass('selected');
        $(this).removeClass('vehicle-seat');
        $(this).addClass('vehicle-seat-selected');
        $(this).toggleClass(className);
        $(this).removeAttr("style");
        $(this).removeAttr("onclick");
        $(this).html("");
        relValue = $(this).attr('rel');
        $('#designLower'+relValue).attr("onclick",'getSelectedSeat(this)');
        // $('#boxLower'+relValue).attr("disabled",'disabled');
      })
      .get(); 

lowerSeatsSelected = $('#seat-design-lower')
      .find('.vehicle-seat-selected.selected')
      .map(function() {
        //console.log($(this).attr('rel'),'rel');
        $(this).toggleClass('selected');

        if(dimensionType == 'classDimension'){
          
          $(this).removeClass('CLASS-A-1');
          $(this).removeClass('CLASS-B-2');
          $(this).removeClass('CLASS-C-3');
          $(this).removeClass('CLASS-D-4');
          $(this).removeClass('CLASS-E-5');

        }else if(dimensionType == 'facilitiesCategoryDimension'){
          
          $(this).removeClass('Food-and-Beverages-1');
          $(this).removeClass('Entertainment-21');
          $(this).removeClass('Bar-22');

        }else if(dimensionType == 'facilitiesDimension'){

          $(this).removeClass('Cold-Drink-1');
          $(this).removeClass('Coffee-2');
          $(this).removeClass('Tea-20');
          $(this).removeClass('Other-21');
          $(this).removeClass('tv-23');
          $(this).removeClass('Vodka-24');
        }else{
          $(this).removeClass('Front-Seats-1');
          $(this).removeClass('Middle-Seats-2');
          $(this).removeClass('Back-Seats-3');
          $(this).removeClass('Premium-Seats-4');
          $(this).removeClass('Luxury-Seats-5');
          $(this).removeClass('VIP-Seats-6');
          $(this).removeClass('Driver-7');
          $(this).removeClass('Co-driver-8');
          $(this).removeClass('Toilet-9');
          $(this).removeClass('Sleeper-10');
          $(this).removeClass('TV-111');
        }
        $(this).toggleClass(className);
        $(this).removeAttr("onclick");
        $(this).removeAttr("style");
        $(this).html("");
        relValue = $(this).attr('rel');
        $('#designLower'+relValue).attr("onclick",'getSelectedSeat(this)');
        // $('#boxLower'+relValue).attr("disabled",'disabled');
      })
      .get();

upperSeats = $('#seat-design-upper')
      .find('.vehicle-seat.selected')
      .map(function() {
        //console.log(this);
        $(this).toggleClass('selected');
        $(this).removeClass('vehicle-seat');
        $(this).addClass('vehicle-seat-selected');
        $(this).toggleClass(className);
        $(this).removeAttr("onclick");
        $(this).removeAttr("style");
        $(this).html("");
        relValue = $(this).attr('rel');
        $('#designUpper'+relValue).attr("onclick",'getSelectedSeat(this)');
        // $('#boxUpper'+relValue).attr("disabled",'disabled');
      })
      .get(); 

upperSeatsSelected = $('#seat-design-upper')
      .find('.vehicle-seat-selected.selected')
      .map(function() {
        //console.log(this);
        $(this).toggleClass('selected');

        if(dimensionType == 'classDimension'){
          
          $(this).removeClass('CLASS-A-1');
          $(this).removeClass('CLASS-B-2');
          $(this).removeClass('CLASS-C-3');
          $(this).removeClass('CLASS-D-4');
          $(this).removeClass('CLASS-E-5');

        }else if(dimensionType == 'facilitiesCategoryDimension'){
          
          $(this).removeClass('Food-and-Beverages-1');
          $(this).removeClass('Entertainment-21');
          $(this).removeClass('Bar-22');

        }else if(dimensionType == 'facilitiesDimension'){

          $(this).removeClass('Cold-Drink-1');
          $(this).removeClass('Coffee-2');
          $(this).removeClass('Tea-20');
          $(this).removeClass('Other-21');
          $(this).removeClass('tv-23');
          $(this).removeClass('Vodka-24');
        }else{
          $(this).removeClass('Front-Seats-1');
          $(this).removeClass('Middle-Seats-2');
          $(this).removeClass('Back-Seats-3');
          $(this).removeClass('Premium-Seats-4');
          $(this).removeClass('Luxury-Seats-5');
          $(this).removeClass('VIP-Seats-6');
          $(this).removeClass('Driver-7');
          $(this).removeClass('Co-driver-8');
          $(this).removeClass('Toilet-9');
          $(this).removeClass('Sleeper-10');
          $(this).removeClass('TV-111');
        }
        $(this).toggleClass(className);
        $(this).removeAttr("onclick");
        $(this).removeAttr("style");
        $(this).html("");
        relValue = $(this).attr('rel');
        $('#designUpper'+relValue).attr("onclick",'getSelectedSeat(this)');
        // $('#boxUpper'+relValue).attr("disabled",'disabled');
      })
      .get();  

  
}

$(document).ready(function() {
  $('[data-toggle="tooltip-bus-name"], [data-toggle="tooltip-configure-info"]').tooltip();

  busBuilderTable();
});