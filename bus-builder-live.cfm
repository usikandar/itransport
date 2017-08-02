<cfimport taglib="/i-modules" prefix="zd"><zd:security app="adm">
<cftry>
<cfoutput>

<cfparam name="Form.sub_btn" default=""/>
<cfparam name="Form.bustemplate" default=""/>
<cfparam name="Form.formAction" default=""/>
<cfparam name="Form.vehicleid" default=""/>
<cfparam name="Form.versionid" default=""/>
<cfparam name="Form.VechicleTypeID" default=""/>
<cfparam name="Form.VehicleVirtualVersionID" default=""/>
<cfparam name="Form.dimensionType" default="seatTypeDimension"/>
<cfparam name="xmlData" default=""/>

<cfset CommonFunctionsAPI = createObject("component", "admin.cfc.CommonFunctions").init(Application.DSN) />
<cfset VehicleFunctionsAPI = createObject("component", "admin.cfc.BusTypeTemplate").init(Application.DSN) />
<cfset VehicleClassFunctionsAPI = createObject("component", "admin.cfc.VehicleBusStructureClass").init(Application.DSN) />
<cfset VehicleFacilityFunctionsAPI = createObject("component", "admin.cfc.VehicleBusStructureFacility").init(Application.DSN) />
<cfset VehicleCategoryFunctionsAPI = createObject("component", "admin.cfc.VehicleBusStructureFacilityCategory").init(Application.DSN) />

<cfset Request.BusTypeTemplates = CommonFunctionsAPI.list('Vehicle__BUS__TypeTemplate__CRUD')/>

<cfset Request.SeatTypes = CommonFunctionsAPI.list('Vehicle__BUS_DIM_SeatType__CRUD')/>
<!--- <cfset Request.Vehicles = CommonFunctionsAPI.list('vehicle_master_handle')/> --->
<cfset Request.VehicleVersions = CommonFunctionsAPI.list('vehicle_cch_versions_handle', 'K')/>
<!--- <cfset Request.Vehicles = CommonFunctionsAPI.list('Vehicle__BUS__Structure__SeatType__CRUD', 'E')/> --->
<cfset Request.Vehicles = CommonFunctionsAPI.list('Vehicle__BUS__Structure__SeatType__CRUD', 'K')/>

<cfset Request.SeatClasses = CommonFunctionsAPI.list('Vehicle__BUS_DIM_SeatClass__CRUD')/>
<cfset Request.SeatFacilities = CommonFunctionsAPI.list('Vehicle__BUS_DIM_SeatFacility__CRUD')/>
<cfset Request.SeatCategoryFacilities = CommonFunctionsAPI.list('Vehicle__BUS_DIM_SeatCategoryFacility__CRUD')/>

<cfset Request.VehicleSeatClass = CommonFunctionsAPI.list('Vehicle__BUS__Structure__Facility__CRUD')/>

<cfif Form.sub_btn EQ 'builtbus'>

  <cfset xmlData = "" />

  <cfif Form.formAction EQ 'bus_list'>

    <cfset VersionID = Form.versionid />

    <cfset vehicleArray = listToArray(Form.versionid) />

    <cfset VersionID = vehicleArray[1] />
    <cfset VechicleTypeID = vehicleArray[2] />
    <cfset VehicleVirtualVersionID = vehicleArray[3] />

    <cfset busTypeTemplate = VehicleFunctionsAPI.list(vehicleTypeId="#VechicleTypeID#") />

    <cfset seatMax = busTypeTemplate.seatMax />
    <cfset seatMaxRow = busTypeTemplate.seatMaxRow />
    <cfset busRows = busTypeTemplate.busRows />
    <cfset floors = busTypeTemplate.floors />
    <cfset VechicleTypeID = busTypeTemplate.VechicleTypeID />
    <cfset VechicleID = Form.vehicleid />

    <cfif Form.dimensionType EQ 'classDimension'>
    
      <cfset VehicleBusStructureSeatsGetXML = createObject("component", "admin.cfc.VehicleBusStructureClass").init(Application.DSN) />
    
    <cfelseif Form.dimensionType EQ 'facilitiesDimension'>

      <cfset VehicleBusStructureSeatsGetXML = createObject("component", "admin.cfc.VehicleBusStructureFacility").init(Application.DSN) />
    
    <cfelseif Form.dimensionType EQ 'facilitiesCategoryDimension'>

      <cfset VehicleBusStructureSeatsGetXML = createObject("component", "admin.cfc.VehicleBusStructureFacilityCategory").init(Application.DSN) />
    
    <cfelse>
      
      <cfset VehicleBusStructureSeatsGetXML = createObject("component", "admin.cfc.VehicleBusStructureSeatType").init(Application.DSN) />
    
    </cfif>

    <cfset BusStructureSeatsXML = VehicleBusStructureSeatsGetXML.getPreviousSeats(VersionID, VechicleTypeID, VehicleVirtualVersionID)/>

    <cfloop query="#BusStructureSeatsXML#">

      <cfset xmlData = xmlData & BusStructureSeatsXML['XML_F52E2B61-18A1-11D1-B105-00805F49916B'][currentRow] />
    </cfloop>

  <cfelseif Form.formAction EQ 'bus_template'>

    <cfset bustemplateArray = listToArray(Form.bustemplate)/>
    <cfset seatMax = bustemplateArray[1]/>
    <cfset seatMaxRow = bustemplateArray[2]/>
    <cfset busRows = bustemplateArray[3]/>
    <cfset floors = bustemplateArray[4]/>
    <cfset VechicleTypeID = bustemplateArray[5]/>
    <cfset VechicleID = Form.vehicleid/>

    <cfset VersionID = Form.versionid />

    <!--- <cfset vehicleArray = listToArray(Form.versionid) />

    <cfset VersionID = vehicleArray[1] />
    <cfset VehicleVirtualVersionID = vehicleArray[2] /> --->

    <cfif Form.dimensionType EQ 'classDimension'>
    
      <cfset VehicleBusStructureSeatsGetXML = createObject("component", "admin.cfc.VehicleBusStructureClass").init(Application.DSN) />
    
    <cfelseif Form.dimensionType EQ 'facilitiesDimension'>

      <cfset VehicleBusStructureSeatsGetXML = createObject("component", "admin.cfc.VehicleBusStructureFacility").init(Application.DSN) />
    
    <cfelseif Form.dimensionType EQ 'facilitiesCategoryDimension'>

      <cfset VehicleBusStructureSeatsGetXML = createObject("component", "admin.cfc.VehicleBusStructureFacilityCategory").init(Application.DSN) />
    
    <cfelse>
      
      <cfset VehicleBusStructureSeatsGetXML = createObject("component", "admin.cfc.VehicleBusStructureSeatType").init(Application.DSN) />
    
    </cfif>

    <cfset BusStructureSeatsXML = VehicleBusStructureSeatsGetXML.getPreviousSeats(VersionID, VechicleTypeID, VehicleVirtualVersionID)/>

  </cfif>

  <cfif xmlData NEQ ''>

    <cfset parsedXML = XMLParse(xmlData)/>
    <script type="text/javascript">
      var previousSeats = [];
      
      <cfif Form.dimensionType EQ 'seatTypeDimension'>
        
        <cfloop from="1" to="#arrayLen(parsedXML.BusSeatTypes.BusSeatType)#" index="node">

          <cfset seatTypeID = parsedXML.BusSeatTypes.BusSeatType[node].XmlText/>
          <cfset imagesPath = parsedXML.BusSeatTypes.BusSeatType[node].XmlAttributes.ImagePath/>
          <cfset seatID = parsedXML.BusSeatTypes.BusSeatType[node].XmlAttributes.SeatID/>
          <cfset seatNumber = parsedXML.BusSeatTypes.BusSeatType[node].XmlAttributes.SeatNumber/>

          previousSeats[#node#] = [#seatTypeID#,"#imagesPath#",#seatID#,"#seatNumber#"];
        
        </cfloop>

      <cfelseif Form.dimensionType EQ 'classDimension'>
        
        <cfloop from="1" to="#arrayLen(parsedXML.BusSeatClasses.BusSeatClass)#" index="node">

          <cfset seatTypeID = parsedXML.BusSeatClasses.BusSeatClass[node].XmlText/>
          <cfset imagesPath = parsedXML.BusSeatClasses.BusSeatClass[node].XmlAttributes.ImagePath/>
          <cfset seatID = parsedXML.BusSeatClasses.BusSeatClass[node].XmlAttributes.SeatID/>
          <cfset seatNumber = parsedXML.BusSeatClasses.BusSeatClass[node].XmlAttributes.SeatNumber/>

          previousSeats[#node#] = [#seatTypeID#,"#imagesPath#",#seatID#,"#seatNumber#"];
        </cfloop>

      <cfelseif Form.dimensionType EQ 'facilitiesCategoryDimension'>
        
        <cfloop from="1" to="#arrayLen(parsedXML.FacilityCategories.FacilityCategory)#" index="node">

          <cfset seatTypeID = parsedXML.FacilityCategories.FacilityCategory[node].XmlText/>
          <cfset imagesPath = parsedXML.FacilityCategories.FacilityCategory[node].XmlAttributes.ImagePath/>
          <cfset seatID = parsedXML.FacilityCategories.FacilityCategory[node].XmlAttributes.SeatID/>
          <cfset seatNumber = parsedXML.FacilityCategories.FacilityCategory[node].XmlAttributes.SeatNumber/>

          previousSeats[#node#] = [#seatTypeID#,"#imagesPath#",#seatID#,"#seatNumber#"];
        </cfloop>

       <cfelseif Form.dimensionType EQ 'facilitiesDimension'>
        
        <cfloop from="1" to="#arrayLen(parsedXML.Facilities.Facility)#" index="node">

          <cfset seatTypeID = parsedXML.Facilities.Facility[node].XmlText/>
          <cfset imagesPath = parsedXML.Facilities.Facility[node].XmlAttributes.ImagePath/>
          <cfset seatID = parsedXML.Facilities.Facility[node].XmlAttributes.SeatID/>
          <cfset seatNumber = parsedXML.Facilities.Facility[node].XmlAttributes.SeatNumber/>

          previousSeats[#node#] = [#seatTypeID#,"#imagesPath#",#seatID#,"#seatNumber#"];
        </cfloop>

      </cfif>

    </script>
  <cfelse>
    <script type="text/javascript">
      var previousSeats = [];
    </script>
  </cfif>

</cfif>


<cfscript>
nav_title="Settings,Bus Builder";
nav_url="../main.cfm";
</cfscript>
<cfinclude template="header.cfm">
<!DOCTYPE html>
<html>
<head>
	<title>Bus Builder</title>
	<!--- <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> --->
	<!--- <link rel="stylesheet" type="text/css" href="assets/node_modules/bootstrap/dist/css/bootstrap.min.css"> --->
	<link rel="stylesheet" type="text/css" href="assets/css/global.css">
  <style type="text/css">
    .big-bus table {
      color:##333;
    }
    .categorize-seats {
      color :##333;
    }
    .table-scroll tr:nth-child(3) {
        background-color: rgba(255, 255, 255, 0);
    }
    .table-scroll tr:nth-child(4){
      background-color: rgba(255, 255, 255, 0);
    }
    <cfif Form.sub_btn EQ 'builtbus'>
    <cfif seatMaxRow EQ 20>
      .big-bus .vehicle-seat {
        width: 18px;
      }
      .big-bus .vehicle-seat-selected {
        width: 18px;
      }
      .big-bus .vehicle-sleeper {
        width: 44px;
      }
      .big-bus .vehicle-sleeperv {
        width: 18px;
      }
      .big-bus .vehicle-sleepervBottom {
        width: 18px;
      }
    </cfif>
    </cfif>
    <cfset newNum= 0 />
    <cfloop query="Request.SeatTypes">
      <cfset className = replace(Request.SeatTypes.Name, " ", "-","ALL")/>
      .big-bus .#className#-#Request.SeatTypes.SeatTypeID# {
       color: white;
       font-weight: bold;
       background-image: url(#Request.SeatTypes.ImagePath#);
      }
    </cfloop>
  	<cfloop query="Request.SeatClasses">
      <cfset className = replace(Request.SeatClasses.Name, " ", "-","ALL")/>
      .big-bus .#className#-#Request.SeatClasses.SeatClassID# {
       color: white;
       font-weight: bold;
       background-image: url(#Request.SeatClasses.ImagePath#);
      }
    </cfloop>
    <cfloop query="Request.SeatFacilities">
      <cfset className = replace(Request.SeatFacilities.Name, " ", "-","ALL")/>
      .big-bus .#className#-#Request.SeatFacilities.SeatFacilityID# {
       color: white;
       font-weight: bold;
       background-image: url(#Request.SeatFacilities.ImagePath#);
      }
    </cfloop>
    <cfloop query="Request.SeatCategoryFacilities">
      <cfset className = replace(Request.SeatCategoryFacilities.Name, " ", "-","ALL")/>
      .big-bus .#className#-#Request.SeatCategoryFacilities.SeatCategoryFacilityID# {
       color: white;
       font-weight: bold;
       background-image: url(#Request.SeatCategoryFacilities.ImagePath#);
      }
    </cfloop>
    .big-bus .previousseat {
     color: white;
     font-weight: bold;
    }
    .div-hide{
      display: none;
    }
  </style>

<!---   <cfset qvar = Request.Vehicles>
  <cfsetting enablecfoutputonly="no">
  <!--- <zd:xmlpaging query="#Request.Vehicles#"> --->
  <!--- <cfoutput> --->
    <xml totalrows="#qvar.recordcount#" page="1" rpp="10">
      <rows>
        <cfloop query="qvar" startrow="1" endrow="10"> 
          <row>
            <zd:xc value='<span><input type="radio" name="versionid" required="required" value="#VEHICLE_VERSION_ID#, #VECHICLETYPEID#, #VEHICLE_VIRTUAL_VERSION_ID#"/>Bus #qvar.currentRow#</span>'>
            <zd:xc value="#VEHICLE_VERSION_ID#">
            <zd:xc value="#VEHICLETYPENAME#">
            <zd:xc value="#VEHICLE_VIRTUAL_VERSION_ID#">
            <zd:xc value="#VECHICLETYPEID#">
          </row>
        </cfloop>
      </rows>
    </xml>
  <!--- </cfoutput> --->
  <cfsetting enablecfoutputonly="yes">

  <cfscript>
    alert();
  </cfscript>
 --->
  <div class="row">
    <div class="col-md-4 col-md-offset-8">
      <div class="pull-right">
        <button type="button" class="btn btn-info" onclick="showSearch()"><i class="fa fa-search"></i> <cfoutput>#ml.get_label('List')#</cfoutput></button>
        <button type="button" class="btn btn-success" onclick="showAdd()"><i class="fa fa-plus"></i> <cfoutput>#ml.get_label('add_new')#</cfoutput></button>
      </div>
    </div>

    <div class="clear"></div>
    <div <cfif Form.sub_btn NEQ ''> class="searchTbl div-hide" <cfelse> class="searchTbl"</cfif> style="position: absolute;">
      <div class="col-md-12">
        <h3 class="portlet-title"><u>Edit Existing Bus Templates</u></h3>
        <form method="post" action="">
          <!--- <cfset countBus = 1/> --->
          <div class="table-scroll" style="max-height: 400px;">
            <zd:table title="Customized Templates" style="font-size: 13px;"
              headers="&nbsp;,Bus Type Template,Manufacturer,Model,Body Type,Seats,A/C,Toilet,WiFi">
              <cfif Request.Vehicles.recordcount>
                <cfloop query="#Request.Vehicles#">
                <tr>
                  <td><p class="radioP"><input type="radio" name="versionid" id="#Request.Vehicles.currentRow#" required="required" value="#VEHICLE_VERSION_ID#, #VECHICLETYPEID#, #VEHICLE_VIRTUAL_VERSION_ID#"/><label for="#Request.Vehicles.currentRow#"><span class="radioButtonGraph"></span></label></p>
                  </td>
                  <td>#VEHICLETYPENAME#</td>
                  <zd:proc name="vehicle_cch_versions_handle" result="ver">
                    <zd:param name="action" value="L">
                    <zd:param name="version_id" value="#VEHICLE_VERSION_ID#">
                  </zd:proc>
                  <td>#ver.man_name#</td>
                  <td>#ver.model_name#</td>
                  <td>#ver.BODY_TYPE_NAME#</td>
                  <td>#ver.seats_nb#</td>
                  <td><cfif ver.AIRCONDITIONING EQ 1><i class="fa fa-check text-success"></i><cfelse><i class="fa fa-times text-danger"></i></cfif></td>
                  <td><cfif ver.RESTROOM_ONBOARD EQ 1><i class="fa fa-check text-success"></i><cfelse><i class="fa fa-times text-danger"></i></cfif></td>
                  <td><cfif ver.WIFI EQ 1><i class="fa fa-check text-success"></i><cfelse><i class="fa fa-times text-danger"></i></cfif></td>
                  <!--- <cfset countBus++/> --->
                </tr>
                </cfloop>
              <cfelse>
                <td colspan="9"><span class="text-center">You can add Customized Templates by clicking "Add New" and selecting a Sample Template and a Vehicle Version</span></td>
              </cfif>
            </zd:table>
          </div>
          <div class="row">
            <div class="col-md-8">
              <div class="bus-display-name">Bus Type will be Displayed as : <span>Inti Class A/C VIP (2+3)</span></div>
            </div>

            <div class="col-md-4">
              <div class="pull-right">
                <input type="hidden" name="formAction" value="bus_list" />
                <button type="submit" class="btn btn-warning" name="sub_btn" value="builtbus"><i class="fa fa-edit"></i> <cfoutput>#ml.get_label('edit')#</cfoutput></button>
                <!--- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> --->
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

    <div class="addTbl" style="position: absolute;display: none;">
      <h3 class="portlet-title"><u>Add New Bus Template</u></h3>
      <form method="post" action="">
        <div class="row">
          <div class="col-md-5">
            <!--- <label for="busTemplate">Bus Template <span class="helper-info" data-toggle="tooltip-bus-name" data-placement="bottom" title="Select the dimensions for bus">?</span></label> --->
            <div class="table-scroll" style="max-height: 400px;">
              <zd:table title="Sample Templates" style="font-size: 13px;"
                headers="&nbsp;,Template Name,Max Seats,Max Seats / Row,Bus Rows,Floors">
                <cfloop query="Request.BusTypeTemplates">
                <tr>
                  <td>
                    <p class="radioP"><input type="radio" name="bustemplate" id="#Request.BusTypeTemplates.currentRow#_1" required="required" value="#SeatMAX#,#SeatMaxRow#,#BusRows#,#Floors#,#VECHICLETYPEID#"><label for="#Request.BusTypeTemplates.currentRow#_1"><span class="radioButtonGraph"></span></label></p>
                  </td>
                  <td>#VECHICLETYPENAME#</td>
                  <td>#SeatMAX#</td>
                  <td>#SeatMaxRow#</td>
                  <td>#BusRows#</td>
                  <td>#Floors#</td>
                  <!--- <td>#FACILITY_AC#</td>
                  <td>#FACILITY_TOILET#</td> --->
                </tr>
                </cfloop>
              </zd:table>
            </div>
          </div>
        
          <div class="col-md-7">
            <!--- <label for="vehicleid">Bus Name <span class="helper-info" data-toggle="tooltip-bus-name" data-placement="bottom" title="A name to identify this bus type">?</span></label> --->
            <zd:proc name="vehicle_cch_versions_handle" result="ver">
              <zd:param name="action" value="L">
              <!--- <zd:param name="version_id" value="#VEHICLE_VERSION_ID#"> --->
            </zd:proc>
            <div class="table-scroll" style="max-height: 400px;">
              <zd:table title="Vehicle Versions" style="font-size: 13px;"
                headers="&nbsp;,Manufacturer,Model,Body Type,Seats,A/C,Toilet,WiFi">
                <cfloop query="ver">
                <tr>
                  <td>
                    <p class="radioP"><input type="radio" name="versionid" id="#ver.currentRow#_2" required="required" value="#ver.version_id#"><label for="#ver.currentRow#_2"><span class="radioButtonGraph"></span></label></p>
                  </td>
                  
                  <td>#ver.man_name#</td>
                  <td>#ver.model_name#</td>
                  <td>#ver.BODY_TYPE_NAME#</td>
                  <td>#ver.seats_nb#</td>
                  <td><cfif ver.AIRCONDITIONING EQ 1><i class="fa fa-check text-success"></i><cfelse><i class="fa fa-times text-danger"></i></cfif></td>
                  <td><cfif ver.RESTROOM_ONBOARD EQ 1><i class="fa fa-check text-success"></i><cfelse><i class="fa fa-times text-danger"></i></cfif></td>
                  <td><cfif ver.WIFI EQ 1><i class="fa fa-check text-success"></i><cfelse><i class="fa fa-times text-danger"></i></cfif></td>
                </tr>
                </cfloop>
              </zd:table>
            </div>
          </div>
        </div><!--- row --->

        <div class="row">
          <div class="col-md-8">
            <div class="bus-display-name">Bus Type will be Displayed as : <span>Inti Class A/C VIP (2+3)</span></div>
          </div>

          <div class="col-md-4">
            <div class="pull-right">
              <input type="hidden" name="formAction" value="bus_template" />
              <button type="submit" class="btn btn-success" name="sub_btn" value="builtbus"><i class="fa fa-plus"></i> #ml.get_label('add')#</button>
              <!--- <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button> --->
            </div>
          </div>
        </div><!--- row --->
      </form>
    </div>
  </div><!--- row --->
  
  <cfif Form.sub_btn EQ 'builtbus'>

    <section class="bus-builder">
      
      <div class="row">
        <div class="col-md-5">
          <h4 class="portlet-title"><u>Seats Blueprint</u></h4>
          <em>You can add/remove entire seat by adding/removing the table data</em>

          <div class="bus-builder-seat-box-container" id="seat-box-lower"></div>

          <cfif floors EQ 2>
            <div class="clear"><br></div>
            <div class="bus-builder-seat-box-container" id="seat-box-upper"></div>
          </cfif>

          <div class="clear"><br></div>
          <div style="border:2px solid;">Current Template Dimensions:<br/>#Form.bustemplate# <!--- background:##999999 --->
            <div id="newdesign"></div>
          </div>
        </div>

        <div class="col-md-7 big-bus-container">
          <h4 class="portlet-title"><u>Seat Customization</u></h4>
          <div class="big-bus">
            <div class="big-bus-left-part">
              <div class="vehicle-steering-wheel"></div>
            </div>
            <div class="big-bus-right-part" id="seat-design-lower">
              
            </div>
          </div>

          <cfif floors EQ 2>
            <div class="big-bus upper">
              <span class="bus-label-upper"></span>
              <div class="big-bus-left-part" ></div>
              <div class="big-bus-right-part" id="seat-design-upper">
                
              </div>
            </div>
          </cfif>
  
          <div class="clear"><br></div>
          <div class="categorize-seats">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
              <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingOne">
                  <h4 class="panel-title">
                    <a role="button" data-toggle="collapse" data-parent="##accordion" href="##collapseOne" aria-expanded="true" aria-controls="collapseOne">Categorize Seats(optional)</a>
                  </h4>
                </div>
              </div>

              <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                <div class="panel-body">
                  <div class="row">
                    <div class="col-md-5">
                      <div class="col-sm-12 col-md-12">
                        
                        <label for="seattyperadio">
                          <p class="radioP"><input type="radio" name="dimensionsradio" <cfif Form.dimensionType EQ 'seatTypeDimension'> checked="checked"</cfif> id="seattyperadio" value="seatTypeDimension" onchange="seattyperadio();"/><label class="label label-secondary btn-sm" for="seattyperadio"><span class="radioButtonGraph"></span>Seat type</label></p>
                          <!--- <input type="radio" name="dimensionsradio" <cfif Form.dimensionType EQ 'seatTypeDimension'> checked="checked"</cfif> id="seattyperadio" value="seatTypeDimension" onchange="seattyperadio();">Seat type --->
                        </label>
                        <select class="form-control <cfif Form.dimensionType NEQ 'seatTypeDimension'>div-hide</cfif>" id="seattyperadioselect">
                          <option value="">--select--</option>
                          <cfloop query="Request.SeatTypes">
                            <option value="#Request.SeatTypes.Name#-#Request.SeatTypes.SeatTypeID#">#Request.SeatTypes.Name#</option>
                          </cfloop>
                        </select>
                          
                      </div>

                        <div class="col-sm-12 col-md-12">
                          <label for="classradio">
                            <p class="radioP"><input type="radio" name="dimensionsradio" id="classradio" <cfif Form.dimensionType EQ 'classDimension'> checked="checked"</cfif> value="classDimension" onchange="classradio();"/><label class="label label-secondary btn-sm" for="classradio"><span class="radioButtonGraph"></span>Class</label></p>
                          </label>
                          <select class="form-control <cfif Form.dimensionType NEQ 'classDimension'>div-hide</cfif>" id="classradioselect">
                            <option value="">--select--</option>
                            <cfloop query="Request.SeatClasses">
                              <option value="#Request.SeatClasses.Name#-#Request.SeatClasses.SeatClassID#">#Request.SeatClasses.Name#</option>
                            </cfloop>
                          </select>

                        </div>

                        <br/>
                        <div class="col-sm-12 col-md-12">
                          <label for="facilitycategoryradio">
                            <p class="radioP"><input type="radio" name="dimensionsradio" id="facilitycategoryradio" <cfif Form.dimensionType EQ 'facilitiesCategoryDimension'> checked="checked"</cfif> value="facilitiesCategoryDimension" onchange="facilitycategoryradio();"/><label class="label label-secondary btn-sm" for="facilitycategoryradio"><span class="radioButtonGraph"></span>Facility Category</label></p>
                          </label>
                          <select class="form-control <cfif Form.dimensionType NEQ 'facilitiesCategoryDimension'>div-hide</cfif>" id="facilitycategoryradioselect">
                            <option value="">--select--</option>
                            <cfloop query="Request.SeatCategoryFacilities">
                              <option value="#Request.SeatCategoryFacilities.Name#-#Request.SeatCategoryFacilities.SeatCategoryFacilityID#">#Request.SeatCategoryFacilities.Name#</option>
                            </cfloop>
                          </select>
                          <!--- <div class="div-hide" id="facilitycategoryradioselect">
                            <cfloop query="Request.SeatCategoryFacilities">
                              <input type="checkbox" id="" value="#Request.SeatCategoryFacilities.SeatCategoryFacilityID#">#Request.SeatCategoryFacilities.Name#<br/>
                            </cfloop>
                          </div> --->
                        </div>
                        <br/>
                        <div class="col-sm-12 col-md-12">  
                          <label for="facilitiesradio">
                            <p class="radioP"><input type="radio" name="dimensionsradio" id="facilitiesradio" <cfif Form.dimensionType EQ 'facilitiesDimension'> checked="checked"</cfif> value="facilitiesDimension" onchange="facilitiesradio();"/><label class="label label-secondary btn-sm" for="facilitiesradio"><span class="radioButtonGraph"></span>Facilities</label></p>
                            
                          </label>
                          <select class="form-control <cfif Form.dimensionType NEQ 'facilitiesDimension'>div-hide</cfif>" id="facilitiesradioselect">
                            <option value="">--select--</option>
                            <cfloop query="Request.SeatFacilities">
                              <option value="#Request.SeatFacilities.Name#-#Request.SeatFacilities.SeatFacilityID#">#Request.SeatFacilities.Name#</option>
                            </cfloop>
                          </select>
                          <!--- <div class="div-hide" id="facilitiesradioselect">
                            <cfloop query="Request.SeatFacilities">
                              <input type="checkbox" id="" value="#Request.SeatFacilities.SeatFacilityID#">#Request.SeatFacilities.Name#<br/>
                            </cfloop>
                          </div> --->
                        </div>
                      
                    </div>
                  
                    <div class="col-md-3">
                      <div class="categorize-seat-information-body">
                        <div class="categorize-seats-appended">
                          Lower Seats
                          <div class="seat-list" value="seats">
                            <span id="lowerseats"></span>
                            <span id="lowerseatsSelected"></span>
                            <span id="lowerSleepSeats"></span>
                          </div>
                        </div>
                      </div>
                    </div>
                    
                    <cfif floors EQ 2>
                      <div class="col-md-3">
                        <div class="categorize-seat-information-body">
                          <div class="categorize-seats-appended">
                            Upper Seats
                            <div class="seat-list" value="seats">
                              <span id="upperseats"></span>
                              <span id="upperseatsSelected"></span>
                              <span id="upperSleepSeats"></span>
                            </div>
                          </div>
                        </div>
                      </div>
                    </cfif>
                    
                    <div class="col-md-1">
                      <div class="categorize-seat-information-body">
                        <div class="categorize-seats-appended">
                          <button type="button" class="btn btn-primary btn-md" onclick='seatCategoryHandler(this)'>+</button>
                        </div>
                      </div>
                    </div>                                
                  </div>
                  
                  <div class="row">
                    <div class="col-md-8" id="selectedseats"></div>
                    
                  </div>
              </div>

            </div>
          </div>
        </div>
      </div>

      <div class="bus-build-actions pull-right">
        <cfif xmlData EQ ''>

            <button type="submit" class="btn btn-success" id="saveBus" onclick="generatXml(this,'#Form.dimensionType#')" disabled="disabled"><i class="fa fa-save"></i> <cfoutput>#ml.get_label('save')#</cfoutput></button>

            <button type="submit" class="btn btn-success" id="updateSaveBus" onclick="generatUpdateXml(this,'#Form.dimensionType#')" style="display: none;"><i class="fa fa-save"></i> <cfoutput>#ml.get_label('save_changes')#</cfoutput></button>
          <button type="submit" class="btn btn-danger" id="deleteBus" onclick="deleteXml(this,'#Form.dimensionType#')" style="display: none;"> <i class="fa fa-trash"></i> <cfoutput>#ml.get_label('delete')#</cfoutput></button>
          <!--- <button type="submit" class="btn btn-success hidden" id="updateSaveBus" onclick="generatUpdateXml(this,'#Form.dimensionType#')">Update Bus</button> --->
        <cfelse>
          <button type="submit" class="btn btn-success" id="updateBus" onclick="generatUpdateXml(this,'#Form.dimensionType#')" disabled="disabled"><i class="fa fa-save"></i> <cfoutput>#ml.get_label('save_changes')#</cfoutput></button>
          <button type="submit" class="btn btn-danger" onclick="deleteXml(this,'#Form.dimensionType#')"> <i class="fa fa-trash"></i> <cfoutput>#ml.get_label('delete')#</cfoutput></button>
        </cfif>
      </div>

      <input type="hidden" name="bustemplateseats" id="bustemplateseats" value="#seatMax#">
      <input type="hidden" name="bustemplatefloor" id="bustemplatefloor" value="#floors#">
      <input type="hidden" name="bustemplateBusRows" id="bustemplateBusRows" value="#busRows#">
      <input type="hidden" name="bustemplateSeatMaxRow" id="bustemplateSeatMaxRow" value="#seatMaxRow#">
      <input type="hidden" name="VechicleID" id="VechicleID" value="#VechicleID#">
      <input type="hidden" name="VersionID" id="VersionID" value="#VersionID#">
      <input type="hidden" name="VechicleTypeID" id="VechicleTypeID" value="#VechicleTypeID#">
      <input type="hidden" name="VehicleVirtualVersionID" id="VehicleVirtualVersionID" value="#VehicleVirtualVersionID#">
  
    </section>

    <form id="rebuildbus" name="rebuildbus" method="post" action="">


      <cfif Form.formAction EQ 'bus_template'>

        <input type="hidden" name="formAction" value="bus_template" />

      <cfelseif Form.formAction EQ 'bus_list'>

        <input type="hidden" name="formAction" value="bus_list" />

      </cfif>

      <input type="hidden" name="sub_btn" value="builtbus">
      <input type="hidden" name="bustemplate" value="#Form.bustemplate#">
      <input type="hidden" name="vehicleid" value="#Form.vehicleid#">
      <input type="hidden" name="versionid" value="#Form.versionid#">
      <input type="hidden" name="VechicleTypeID" value="#Form.VechicleTypeID#">
      <input type="hidden" name="VehicleVirtualVersionID" value="#Form.VehicleVirtualVersionID#">
      <input type="hidden" name="dimensionType" id="dimensionType" value="#Form.dimensionType#">
    </form>
  
  </cfif>


  <cfinclude template="footer.cfm">

  <script src="assets/node_modules/jquery/dist/jquery.min.js"></script>
  <script src="assets/node_modules/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
  <cfif Form.sub_btn EQ 'builtbus'>
    <script type="text/javascript" src="assets/scripts/global.js"></script>
  </cfif>
  <script type="text/javascript">

    function filters(){
      ac_check = document.getElementById('acfilter').checked;
      toilet_check = document.getElementById('toiletfilter').checked;
      
      $.ajax({
        type: "POST",
        url: "Ajax.cfm",
        data: {ajaxAction: 'AcToiletFilters', acfilter: ac_check, toiletfilter: toilet_check},
        returnformat:'json',
          success: function (data) {
            $('.busTemplateHTML').html(data);
          }
      });

    }

    function seattyperadio(){
      check = document.getElementById('seattyperadio').checked;
      if(check){

        $('##dimensionType').val('seatTypeDimension');

        $('##seattyperadioselect').show();
        $('##classradioselect').hide();
        $('##facilitiesradioselect').hide();
        $('##facilitycategoryradioselect').hide();

        $('##rebuildbus').submit();

      }else{
        $('##seattyperadioselect').hide();
      }
    }

    function classradio(){
      check = document.getElementById('classradio').checked;
      if(check){

        $('##dimensionType').val('classDimension');

        $('##classradioselect').show();
        $('##seattyperadioselect').hide();
        $('##facilitiesradioselect').hide();
        $('##facilitycategoryradioselect').hide();

        $('##rebuildbus').submit();
      
      }else{
        $('##classradioselect').hide();
      }
    }
    
    function facilitiesradio(){
      check = document.getElementById('facilitiesradio').checked;
      if(check){

        $('##dimensionType').val('facilitiesDimension');

        $('##facilitiesradioselect').show();
        $('##seattyperadioselect').hide();
        $('##facilitycategoryradioselect').hide();
        $('##classradioselect').hide();

        $('##rebuildbus').submit();

      }else{
        $('##facilitiesradioselect').hide();
      }  
    }

    function facilitycategoryradio(){
      check = document.getElementById('facilitycategoryradio').checked;
      if(check){

        $('##dimensionType').val('facilitiesCategoryDimension');
        
        $('##facilitycategoryradioselect').show();
        $('##seattyperadioselect').hide();
        $('##facilitiesradioselect').hide();
        $('##classradioselect').hide();
        
        $('##rebuildbus').submit();

      }else{
        $('##facilitycategoryradioselect').hide();
      }
      
    }
    
    function showAdd(){
      $('.addTbl').fadeIn();
      $('.searchTbl').hide();
      $('.bus-builder').hide();
    }

    function showSearch(){
      $('.searchTbl').fadeIn();
      $('.addTbl').hide();
      $('.bus-builder').hide();
    }
  </script>
<!--- </body> --->
<!--- </html> --->
</cfoutput>
<cfcatch type="any"><cfdump var="#cfcatch#"/></cfcatch>
</cftry>