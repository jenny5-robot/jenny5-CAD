// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_dc_motor.scad>

//--------------------------------------------------------------
module dc_motor()
{
	union(){
	translate ([-motor_length / 2, -motor_width / 2, 0]) cube([motor_length, motor_width, motor_height]);
	translate ([0, 0, motor_height]) cylinder (h = motor_shaft_length, r = 1.5, $fn = 10);
	}
}
//--------------------------------------------------------------
module motor_zga17()
{
    cylinder(h = motor_zga17_length, r = motor_zga17_radius, $fn = 50);
    translate ([0, 0, motor_zga17_length]) cylinder(h = 10, r = 1.5, $fn = 50);
}
//--------------------------------------------------------------

motor_zga17();