<!DOCTYPE html>
<html>
<head>
	<title>iTransport Vehicle implementation</title>
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="assets/css/global.css">
</head>
<body>

	<section class="vehicle-set-up">

		<div class="row">		
			<div class="col-sm-12 col-md-6">

				<form class="form-enter-seats">
					<input type="text" class="" placeholder="Enter Seats">
				</form>
			
				<div class="big-bus">
					<div class="big-bus-left-part">
						<div class="vehicle-steering-wheel"></div>
					</div>
					<div class="big-bus-right-part">
						<div class="big-bus-right-top-part">
							<div id="vehicle-seat-1" class="vehicle-seat" data-seat-available="true">1</div>
							<div id="vehicle-seat-2" class="vehicle-seat" data-seat-available="true">2</div>
							<div id="vehicle-seat-3" class="vehicle-seat" data-seat-available="true">3</div>
							<div id="vehicle-seat-4" class="vehicle-seat" data-seat-available="true">4</div>
							<div id="vehicle-seat-5" class="vehicle-seat" data-seat-available="true">5</div>
							<div id="vehicle-seat-6" class="vehicle-seat" data-seat-available="true">6</div>
							<div id="vehicle-seat-7" class="vehicle-seat" data-seat-available="true">7</div>
							<div id="vehicle-seat-8" class="vehicle-seat" data-seat-available="true">8</div>
							<div id="vehicle-seat-9" class="vehicle-seat" data-seat-available="true">9</div>
							<div id="vehicle-seat-10" class="vehicle-seat" data-seat-available="true">10</div>
							<div id="vehicle-seat-11" class="vehicle-seat" data-seat-available="true">11</div>
							<div id="vehicle-seat-12" class="vehicle-seat" data-seat-available="true">12</div>
							<div id="vehicle-seat-13" class="vehicle-seat" data-seat-available="true">13</div>
							<div id="vehicle-seat-14" class="vehicle-seat" data-seat-available="true">14</div>
							<div id="vehicle-seat-15" class="vehicle-seat" data-seat-available="true">15</div>
							<div id="vehicle-seat-16" class="vehicle-seat" data-seat-available="true">16</div>
							<div id="vehicle-seat-17" class="vehicle-seat" data-seat-available="true">17</div>
							<div id="vehicle-seat-18" class="vehicle-seat" data-seat-available="true">18</div>
							<div id="vehicle-seat-19" class="vehicle-seat" data-seat-available="true">19</div>
							<div id="vehicle-seat-20" class="vehicle-seat" data-seat-available="true">20</div>
							<div id="vehicle-seat-21" class="vehicle-seat" data-seat-available="true">21</div>
							<div id="vehicle-seat-22" class="vehicle-seat" data-seat-available="true">22</div>
							<div id="vehicle-seat-23" class="vehicle-seat" data-seat-available="true">23</div>
							<div id="vehicle-seat-24" class="vehicle-seat" data-seat-available="true">24</div>
						</div>
						<div class="amenities">
							<div class="amenities-washroom"></div>
							<div class="amenities-tv"></div>
							<div class="amenities-coffee"></div>
						</div>
						<div class="big-bus-right-bottom-part">
							<div id="vehicle-seat-1" class="vehicle-seat" data-seat-available="true">1</div>
							<div id="vehicle-seat-2" class="vehicle-seat" data-seat-available="true">2</div>
							<div id="vehicle-seat-3" class="vehicle-seat" data-seat-available="true">3</div>
							<div id="vehicle-seat-4" class="vehicle-seat" data-seat-available="true">4</div>
							<div id="vehicle-seat-5" class="vehicle-seat" data-seat-available="true">5</div>
							<div id="vehicle-seat-6" class="vehicle-seat" data-seat-available="true">6</div>
							<div id="vehicle-seat-7" class="vehicle-seat" data-seat-available="true">7</div>
							<div id="vehicle-seat-8" class="vehicle-seat" data-seat-available="true">8</div>
							<div id="vehicle-seat-9" class="vehicle-seat" data-seat-available="true">9</div>
							<div id="vehicle-seat-10" class="vehicle-seat" data-seat-available="true">10</div>
							<div id="vehicle-seat-11" class="vehicle-seat" data-seat-available="true">11</div>
							<div id="vehicle-seat-12" class="vehicle-seat" data-seat-available="true">12</div>
							<div id="vehicle-seat-13" class="vehicle-seat" data-seat-available="true">13</div>
							<div id="vehicle-seat-14" class="vehicle-seat" data-seat-available="true">14</div>
							<div id="vehicle-seat-15" class="vehicle-seat" data-seat-available="true">15</div>
							<div id="vehicle-seat-16" class="vehicle-seat" data-seat-available="true">16</div>
							<div id="vehicle-seat-17" class="vehicle-seat" data-seat-available="true">17</div>
							<div id="vehicle-seat-18" class="vehicle-seat" data-seat-available="true">18</div>
							<div id="vehicle-seat-19" class="vehicle-seat" data-seat-available="true">19</div>
							<div id="vehicle-seat-20" class="vehicle-seat" data-seat-available="true">20</div>
							<div id="vehicle-seat-21" class="vehicle-seat" data-seat-available="true">21</div>
							<div id="vehicle-seat-22" class="vehicle-seat" data-seat-available="true">22</div>
							<div id="vehicle-seat-23" class="vehicle-seat" data-seat-available="true">23</div>
							<div id="vehicle-seat-24" class="vehicle-seat" data-seat-available="true">24</div>
						</div>
					</div>

					<!-- <div class="row">
						<div class="col-sm-12 col-md-12 vehicle-booking-status">
							<div class="vehicle-booking-status-header">Current Status:</div>
							<div class="vehicle-booking-status-attention">Booking Closed</div> OR <button class="btn btn-success">Open Booking</button>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-12 col-md-12 vehicle-default-closing">
							<button class="btn btn-primary">Open Booking</button>
							<span class="vehicle-default-closing-emphasis">Default Closing Time : 2hrs before Departure : 07:00 AM</span>
						</div>
					</div>-->
				</div>

				<div class="row">
					<div class="col-sm-12 col-md-12 passenger-list">
						<div class="passenger-list-header">
							<div class="col-md-3 passenger-list-seat-label">Seat Number</div>
							<div class="col-md-4 passenger-list-name-label">Name</div>
							<div class="col-md-3 passenger-list-gender-label">Gender</div>
							<div class="col-md-2 passenger-list-age-label">Age</div>
						</div>
						<div class="passenger-list-input-container">
							<div class="col-md-3 passenger-list-input-seat-number">1</div>
							<div class="col-md-4"><input type="text" class="passenger-list-input-name" placeholder="Enter Name"></div>
							<div class="col-md-3 passenger-list-input-gender">
								<input type="radio" name="" id="male" class="passenger-list-input-radio-button">
								<label for="Male">M</label>
								<input type="radio" name="" id="female">
								<label for="female">F</label></span>
							</div>
							<div class="col-md-2"><input type="text"></div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-sm-12 col-md-12">
						<div class="vehicle-set-up-info">
							<div class="available"></div><div class="vehicle-set-up-info-label">Available</div>
							<div class="booked"></div><div class="vehicle-set-up-info-label">Booked</div>
							<div class="ladies"></div><div class="vehicle-set-up-info-label">Lady Reserved / Booked</div>
							<div class="phone-reserved"></div><div class="vehicle-set-up-info-label">Phone Reserved</div>
							<div class="quota"></div><div class="vehicle-set-up-info-label">Quota</div>
						</div>
					</div>
				</div>
					
				<button class="btn btn-danger cancel-bus">Cancel Bus</button>
			</div>
				
			
			<div class="col-sm-12 col-md-6">
			
				<!--<div class="col-sm-12 col-md-6 vehicle-set-up-right">
				<div class="panel panel-default">
				  <div class="panel-heading">Complete the form to procceed with the payment</div>
				  <div class="panel-body">
				    <form>
					  <div class="form-group">
					    <label for="exampleInput1">Ticket Cost</label>
					    <input type="text" class="form-control" id="exampleInput1" placeholder="Email">
					  </div>
					  <div class="form-group">
					    <label for="exampleInput2">Discount</label>
					    <input type="text" class="form-control" id="exampleInput2" placeholder="">
					  </div>
					  <div class="form-group">
					    <label for="exampleInputFile">Total Fare</label>  
					    <p class="help-block">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
					    tempor incididunt ut labore et dolore magna aliqua.</p>
					  </div>
					  <div class="form-group">
					    <label for="exampleInput4">Pick Up</label>
					    <input type="password" class="form-control" id="exampleInput4" placeholder="Pick up point">
					  </div>
					  <div class="form-group">
					    <label for="email">Email</label>
					    <input type="email" class="form-control" id="email" placeholder="your email">
					  </div>
					  <button type="submit" class="btn btn-primary">Proceed to payment</button>
					</form>

				  </div>
				</div>
				</div> -->
			</div>

		</div>
	</section>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="assets/scripts/global.js"></script>

</body>
</html>