<cfimport taglib="/web-modules" prefix="zd">
<cfoutput>
  <cfset Application.SiteURL = 'http://venus.weblogic.gr/webvm_demo/adm/busbuilder/'/>
  <cfset PageAPI = createObject("component", "cfc.BusTypeTemplate").init(Application.DSN) />
  
  <cfparam name="Form.btn_submit" default=""/>
  <cfparam name="Form.VechicleTypeName" default=""/>
  <cfparam name="Form.SeatMIN" default=""/>
  <cfparam name="Form.SeatMAX" default=""/>
  <cfparam name="Form.SeatMaxRow" default=""/>
  <cfparam name="Form.BusRows" default=""/>
  <cfparam name="Form.Floors" default=""/>
  <cfparam name="Form.Facility_AC" default=""/>
  <cfparam name="Form.Facility_Toilet" default=""/>
  <cfparam name="Form.file_edit" default=""/>
  <cfparam name="Form.edit_id" default=""/>
  <cfparam name="Form.delete_id" default=""/>

  <cfset error = 0/>
  <cfif Form.btn_submit EQ 'add'>


    <cfset result = PageAPI.create(Form)>

    <cfif result.MSG EQ 'Success'>
      
      <cfset Request.successMsg = "Successfully added."/>

    <cfelse>
      
      <cfset Request.dangerMsg = "Something went wrong. Please try again."/>

    </cfif>

  <cfelseif Form.btn_submit EQ 'edit'>

    <cfset result = PageAPI.update(Form)>
  
    <cfif result.MSG EQ 'Success'>
      
      <cftry>
        <cffile action="delete" file="#filePath##listLast(Form.file_edit,'/')#"  />
      <cfcatch type="any">
      </cfcatch>
      </cftry>

      <cfset Request.successMsg = "Successfully updated."/>
    <cfelse>
      <cfset Request.dangerMsg = "Something went wrong. Please try again."/>
    </cfif>

  <cfelseif Form.btn_submit EQ 'Delete' AND isNumeric(Form.delete_id)>
    <cfset delete_result = PageAPI.list(Form.delete_id)/>
    
    <cfset result = PageAPI.delete(Form)>

    <cfif result.MSG EQ 'Success'>
      <cfset Request.successMsg = "Successfully deleted."/>
    <cfelse> 
      <cfset Request.dangerMsg = "Sorry! An Error occured while Deleting."/>
    </cfif>

  </cfif>

  <cfset Request.allData = PageAPI.list()/>

  <cfsavecontent variable="Request.headerHTML">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/dataTables.bootstrap.min.css">
  </cfsavecontent>
  
  <cfset Request.activeClass = 'BusTypeTemplate'/>
  <cfinclude template="includes/header.cfm"/>

  <!--- body start --->
  <div class="row">
    <h3 class="portlet-title"><u>Manage Bus Type Templates</u></h3>
    <cfinclude template="includes/alerts.cfm"/>
  </div>
  <div class="row">
    <ul class="nav nav-tabs">
      <li class="active"><a data-toggle="tab" href="##view">View</a></li>
      <li><a data-toggle="tab" href="##add">Add</a></li>
    </ul>

    <div class="tab-content">
      <div id="view" class="tab-pane fade in active">
        <br/>
          <div class="table-responsive table-scroll" style="white-space: nowrap;">
            <table class="table table-striped" id="table_id">
              <thead>
                <tr>
                  <th>##</th>
                  <th>Vehicle Type Name</th>
                  <th>MinS</th>
                  <th>MaxS</th>
                  <th>SMRN</th>
                  <th>BRN</th>
                  <th>Floors</th>
                  <th>AC</th>
                  <th>Toilet</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <cfloop query="Request.allData">
                  <tr>
                    <td>#currentrow#</td>

                    <td>
                      #HTMLEditFormat(Request.allData.VechicleTypeName)#
                    </td>
                    <td>
                      #HTMLEditFormat(Request.allData.SeatMIN)#
                    </td>
                    <td>
                      #HTMLEditFormat(Request.allData.SeatMAX)#
                    </td>
                    <td>
                      #HTMLEditFormat(Request.allData.SeatMaxRow)#
                    </td>
                    <td>
                      #HTMLEditFormat(Request.allData.BusRows)#
                    </td>
                    <td>
                      #HTMLEditFormat(Request.allData.Floors)#
                    </td>
                    <td>
                      #HTMLEditFormat(Request.allData.Facility_AC)#
                    </td>
                    <td>
                      #HTMLEditFormat(Request.allData.Facility_Toilet)#
                    </td>
                  
                    <td>
                      <cfset delete_id = Request.allData.VechicleTypeID />
                      <form method="POST" action="" enctype="multipart/form-data">
                        <button type="button" data-edit_id="#delete_id#" data-vehicle_type_name="#Request.allData.VechicleTypeName#" data-seat_min="#Request.allData.SeatMIN#" data-seat_max="#Request.allData.SeatMAX#" data-seat_max_row="#Request.allData.SeatMaxRow#" data-bus_rows="#Request.allData.BusRows#" data-floors="#Request.allData.Floors#" data-facility_ac="#Request.allData.Facility_AC#" data-facility_toilet="#Request.allData.Facility_Toilet#" class="btn btn-info updateDialog" data-toggle="modal" data-target="##updateModal"><i class="fa fa-edit"></i> <cfoutput>#ml.get_label('edit')#</cfoutput></button>
                        <input type="hidden" name="delete_id" value="#delete_id#">
                        <input class="btn btn-danger btn-md" onclick="return confirm('Are you sure?');" type="submit" name="btn_submit" value="Delete">
                      </form>
                    </td>

                  </tr>
                </cfloop>
              </tbody>
              <caption style="color: ##ccc;" align="bottom">MinS = Minimum Seats / MaxS = Maximum Seats / BRN = Bus Row Number / SMRN = Seat Max Row Number</caption>
            </table>
          </div>
      </div>
      <div id="add" class="tab-pane fade">
        <form method="POST" action="" enctype="multipart/form-data">
        <div class="row">
          <div class="col-md-12">
            <h4>Add a Bus Type Template</h4>

            <zd:table>
              <tr>
                <th>Vehicle Type Name</th><td><input class="form-control" type="text" name="VechicleTypeName"></td>
                <th>Floors</th><td><input class="form-control" type="number" name="Floors"></td>
              </tr>
              <tr>
                <th>Seat Min Number</th><td><input class="form-control" type="number" name="SeatMIN"></td>
                <th>Seat MAx Number</th><td><input class="form-control" type="number" name="SeatMAX"></td>
              </tr>
              <tr>
                <th>Seat Max Row Number</th><td><input class="form-control" type="number" name="SeatMaxRow"></td>
                <th>Bus Row Number</th><td><input class="form-control" type="number" name="BusRows"></td>
              </tr>
              <tr>
                <th>AC</th><td><input class="form-control" type="number" min="0" max="1" name="Facility_AC"></td>
                <th>Toilet</th><td><input class="form-control" type="number" min="0" max="1" name="Facility_Toilet"></td>
              </tr>
            </zd:table>

          <!--- <div class="form-group">
            <label>Vehicle Type Name:</label>
            <input type="text" class="form-control" name="VechicleTypeName">
          </div>

          <div class="form-group">
            <label>Seat Min Number:</label>
            <input type="number" class="form-control" name="SeatMIN">
          </div>

          <div class="form-group">
            <label>Seat Max Number:</label>
            <input type="number" class="form-control" name="SeatMAX">
          </div>

          <div class="form-group">
            <label>Seat Max Row Number:</label>
            <input type="number" class="form-control" name="SeatMaxRow">
          </div>

          <div class="form-group">
            <label>Bus Row Number:</label>
            <input type="number" class="form-control" name="BusRows">
          </div>

          <div class="form-group">
            <label>Floors:</label>
            <input type="number" class="form-control" name="Floors">
          </div>

          <div class="form-group">
            <label>AC:</label>
            <input type="number" min="0" max="1" class="form-control" name="Facility_AC">
          </div>

          <div class="form-group">
            <label>Toilet:</label>
            <input type="number" min="0" max="1" class="form-control" name="Facility_Toilet">
          </div> --->

          <button type="submit" name="btn_submit" value="add" class="btn btn-success pull-right"><i class="fa fa-save"></i> <cfoutput>#ml.get_label('save')#</cfoutput></button>
        </form>
      </div>
    </div>
  </div>

  <!-- Modal -->
  <div id="updateModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Update</h4>
        </div>
        <form method="POST" action="" enctype="multipart/form-data">
          <div class="modal-body">
            <zd:table>
              <tr>
                <th>Vehicle Type Name</th><td><input type="text" class="form-control" id="VechicleTypeName" name="VechicleTypeName"></td>
                <th>Floors</th><td><input type="number" class="form-control" id="Floors" name="Floors"></td>
              </tr>
              <tr>
                <th>Seat Min Number</th><td><input type="number" class="form-control" id="SeatMIN" name="SeatMIN"></td>
                <th>Seat Max Number</th><td><input type="number" class="form-control" id="SeatMAX" name="SeatMAX"></td>
              </tr>
              <tr>
                <th>Seat Max Row Number</th><td><input type="number" class="form-control" id="SeatMaxRow" name="SeatMaxRow"></td>
                <th>Bus Row Number</th><td><input type="number" class="form-control" id="BusRows" name="BusRows"></td>
              </tr>
              <tr>
                <th>AC</th><td><input type="number" min="0" max="1" class="form-control" id="Facility_AC" name="Facility_AC"></td>
                <th>Toilet</th><td><input type="number" min="0" max="1" class="form-control" id="Facility_Toilet" name="Facility_Toilet"></td>
              </tr>
            </zd:table>


            <!--- <div class="form-group">
              <label>Vehicle Type Name:</label>
              <input type="text" class="form-control" id="VechicleTypeName" name="VechicleTypeName">
            </div>

            <div class="form-group">
              <label>Seat Min Number:</label>
              <input type="number" class="form-control" id="SeatMIN" name="SeatMIN">
            </div>

            <div class="form-group">
              <label>Seat Max Number:</label>
              <input type="number" class="form-control" id="SeatMAX" name="SeatMAX">
            </div>

            <div class="form-group">
              <label>Seat Max Row Number:</label>
              <input type="number" class="form-control" id="SeatMaxRow" name="SeatMaxRow">
            </div>

            <div class="form-group">
              <label>Bus Row Number:</label>
              <input type="number" class="form-control" id="BusRows" name="BusRows">
            </div>

            <div class="form-group">
              <label>Floors:</label>
              <input type="number" class="form-control" id="Floors" name="Floors">
            </div>

            <div class="form-group">
              <label>AC:</label>
              <input type="number" min="0" max="1" class="form-control" id="Facility_AC" name="Facility_AC">
            </div>

            <div class="form-group">
              <label>Toilet:</label>
              <input type="number" min="0" max="1" class="form-control" id="Facility_Toilet" name="Facility_Toilet">
            </div> --->
            <input type="hidden" name="edit_id" id="edit_id" value="">
          </div>
          <div class="modal-footer">
            <button type="submit" name="btn_submit" value="edit" class="btn btn-success"><i class="fa fa-save"></i> <cfoutput>#ml.get_label('save_changes')#</cfoutput></button>
            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> <cfoutput>#ml.get_label('cancel')#</cfoutput></button>
          </div>
        </form>
      </div>

    </div>
  </div>

  <!--- body end --->

  <cfsavecontent variable="Request.footerHTML">

    <script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.13/js/dataTables.bootstrap.min.js"></script>

    <script>
      $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip(); 
      });
      
      $(document).ready( function () {
        $('##table_id').DataTable();
      });

      $(document).on("click", ".updateDialog", function () {

         var vehicle_type_name = $(this).data('vehicle_type_name');
         $(".modal-body ##VechicleTypeName").val( vehicle_type_name );

         var seat_min = $(this).data('seat_min');
         $(".modal-body ##SeatMIN").val( seat_min );

         var seat_max = $(this).data('seat_max');
         $(".modal-body ##SeatMAX").val( seat_max );

         var seat_max_row = $(this).data('seat_max_row');
         $(".modal-body ##SeatMaxRow").val( seat_max_row );

         var bus_rows = $(this).data('bus_rows');
         $(".modal-body ##BusRows").val( bus_rows );

         var floors = $(this).data('floors');
         $(".modal-body ##Floors").val( floors );

         var facility_ac = $(this).data('facility_ac');
         $(".modal-body ##Facility_AC").val( facility_ac );

         var facility_toilet = $(this).data('facility_toilet');
         $(".modal-body ##Facility_Toilet").val( facility_toilet );

         var edit_id = $(this).data('edit_id');
         $(".modal-body ##edit_id").val( edit_id );
       });

    </script>

  </cfsavecontent>
  
  <cfinclude template="includes/footer.cfm"/>

</cfoutput>