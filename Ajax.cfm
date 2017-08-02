<cfparam name="Form.ajaxAction" default=""/>
<cfparam name="Form.acfilter" default="1"/>
<cfparam name="Form.toiletfilter" default="1"/>
<cfparam name="Form.dimensionType" default=""/>
<cfparam name="Form.xmlData" default=""/>

<cfset msg = 0/>
<cfoutput>
  
  <cftry>
    <!--- <cfdump var="#Form#" label="Form" abort="true"/> --->
    <cfif Form.ajaxAction EQ 'saveBusStructure'>

      <cfif Form.xmlData NEQ '' AND isXML(Form.xmlData)>

        <cfset Form.Action = 'I'/>
        
        <cfif Form.dimensionType EQ 'classDimension'>

          <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureClass").init(Application.DSN) />

        <cfelseif Form.dimensionType EQ 'facilitiesCategoryDimension'>

          <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureFacilityCategory").init(Application.DSN) />

        <cfelseif Form.dimensionType EQ 'facilitiesDimension'>

          <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureFacility").init(Application.DSN) />

        <cfelseif Form.dimensionType EQ 'seatTypeDimension'>

          <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureSeatType").init(Application.DSN) />
        
        </cfif>

        <cfset result = PageAPI.create(Form)>

        <cfif result.MSG EQ 'Success'>
        <!--- <cfif result['Return Value'][1] EQ 1> --->

          <!--- <cfset xmlData = Form.xmlData /> --->
          <cfset msg = 'Seats are successfully saved in database for the current selected vehicle.'/>

        <cfelse>
          <cfif result.FLAG EQ 5>
            <cfif result.MSG CONTAINS 'duplicate key'>

              <cfset msgArray = listToArray(result.MSG,'.')/>
              
              <cfloop from="1" to="#arrayLen(msgArray)#" index="i">
                <cfif msgArray[i] CONTAINS 'The duplicate key value is'>
                  <cfset setString = replaceNoCase(msgArray[i], "The duplicate key value is", "") />
                  <cfset setString = replaceNoCase(setString, "(", "") />
                  <cfset setString = replaceNoCase(setString, ")", "") />
                  <cfset setString = listLast(setString, ',')/>
                  <cfset msg = 'The seat number '&setString&' is already exists in the database for the current selected vehicle.'/>
                </cfif>
              </cfloop>
          
            </cfif>
            <!--- <cfset msg = ''/> --->
          </cfif>
        </cfif>

      <cfelse>
        
        <cfset msg = 'Please select seats.'/>

      </cfif>


    <cfelseif Form.ajaxAction EQ 'deleteBusStructure'>

      <cfif Form.xmlData NEQ '' AND isXML(Form.xmlData)>
        
        <cfset Form.Action = 'D'/>
        <!--- <cfif Form.dimensionType EQ 'classDimension'>
        <cfelseif Form.dimensionType EQ 'facilitiesCategoryDimension'>
        <cfelseif Form.dimensionType EQ 'facilitiesDimension'>
        <cfelseif Form.dimensionType EQ 'seatTypeDimension'>
        </cfif> --->
        
        <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureClass").init(Application.DSN) />
        <cfset result = PageAPI.deleteBus(FORM.VersionID, FORM.VechicleTypeID, FORM.VehicleVirtualVersionID)>
        <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureFacilityCategory").init(Application.DSN) />
        <cfset result = PageAPI.deleteBus(FORM.VersionID, FORM.VechicleTypeID, FORM.VehicleVirtualVersionID)>
        <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureFacility").init(Application.DSN) />
        <cfset result = PageAPI.deleteBus(FORM.VersionID, FORM.VechicleTypeID, FORM.VehicleVirtualVersionID)>
        <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureSeatType").init(Application.DSN) />
        <cfset result = PageAPI.deleteBus(FORM.VersionID, FORM.VechicleTypeID, FORM.VehicleVirtualVersionID)>

        
        <cfif result.MSG EQ 'Success'>
        <!--- <cfif result['Return Value'][1] EQ 1> --->
          <cfset msg = 'Bus structure is successfully deleted.'/>
        <cfelse>
          <cfset msg = 'Something went wrong. Please try again.'/>
        </cfif>

      </cfif>

    <cfelseif Form.ajaxAction EQ 'updateBusStructure'>

      <cfif Form.xmlData NEQ '' AND isXML(Form.xmlData)>
        
        <cfset Form.Action = 'U'/>
        <cfif Form.dimensionType EQ 'classDimension'>

          <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureClass").init(Application.DSN) />

        <cfelseif Form.dimensionType EQ 'facilitiesCategoryDimension'>

          <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureFacilityCategory").init(Application.DSN) />

        <cfelseif Form.dimensionType EQ 'facilitiesDimension'>

          <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureFacility").init(Application.DSN) />

        <cfelseif Form.dimensionType EQ 'seatTypeDimension'>

          <cfset PageAPI = createObject("component", "admin.cfc.VehicleBusStructureSeatType").init(Application.DSN) />
        
        </cfif>

        <cfset result = PageAPI.create(Form)>
        
        <cfif result.MSG EQ 'Success'>
          <cfset msg = 'Seats are successfully updated in database for the current selected vehicle.'/>
        <cfelse>
          <cfset msg = 'Something went wrong. Please try again.'/>
        </cfif>
      <cfelse>
        <cfset msg = 'Please select seats.'/>
      </cfif>

    <cfelseif Form.ajaxAction EQ 'AcToiletFilters'>

      <cfset PageAPI = createObject("component", "admin.cfc.BusTypeTemplate").init(Application.DSN) />
      
      <cfif Form.acfilter>
        <cfset Form.acfilter = 1/>
      <cfelse>
        <cfset Form.acfilter = 0/>
      </cfif>

      <cfif Form.toiletfilter>
        <cfset Form.toiletfilter = 1/>
      <cfelse>
        <cfset Form.toiletfilter = 0/>
      </cfif>

      <!--- <cfif></cfif> --->


      <cfset result = PageAPI.list(Form.acfilter, Form.toiletfilter)/>
      <!--- <cfdump var="#result#"/> --->
      <cfsavecontent variable="html">
        <cfset count = 1/>
        <cfloop query="result">
          <p>
          <input type="radio" name="bustemplate" required="required" value="#SeatMAX#,#SeatMaxRow#,#BusRows#,#Floors#,#VECHICLETYPEID#">Dimension #count#<br/>
          <b>Vehicle Type Name: </b>#VECHICLETYPENAME#<br/>
          <b>Seat Max Number: </b>#SeatMAX#<br/>
          <b>Seat Max Row Number: </b>#SeatMaxRow#<br/>
          <b>Bus Row Number: </b>#BusRows#<br/>
          <b>Floors: </b>#Floors#<br/>
          <b>AC: </b>#FACILITY_AC#<br/>
          <b>Toilet: </b>#FACILITY_TOILET#
          </p>
          <cfset count++/>
        </cfloop>
        <!--- <cfloop query="result">
          <optgroup label="Dimension #count#">
            <option value="#SeatMAX#,#SeatMaxRow#,#BusRows#,#Floors#,#VechicleTypeID#">
              VehicleTypeName-#VECHICLETYPENAME#<br/> SeatMax-#SeatMAX#<br/> SeatMaxRow-#SeatMaxRow#<br/> BusRows-#BusRows#<br/> Floors-#Floors#<br/> AC-#FACILITY_AC#<br/> Toilet-#FACILITY_TOILET#
            </option>
          </optgroup>
          <cfset count++/>
        </cfloop> --->
      </cfsavecontent>
      
      <cfset msg = html/>

    </cfif>


  <cfcatch type="any">
    <cfdump var="#cfcatch#"/>
    <cfset msg = 0/>
  </cfcatch>

  </cftry>
  #msg#
</cfoutput>