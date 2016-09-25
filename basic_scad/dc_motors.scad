// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_dc_motors.scad>

//--------------------------------------------------------------
module dc_motor(motor_length, motor_radius, motor_distance_between_screws, motor_shaft_radius, motor_shaft_length, motor_shaft_cilinder_radius)
{
    color("silver")
	union(){
        // motor
         cylinder(h = motor_length, r = motor_radius, $fn = 50);
        // shaft base
        translate ([0, 0, motor_length]) cylinder (h = 1, r = motor_shaft_cilinder_radius, $fn = 30);
        // shaft
        translate ([0, 0, motor_length]) cylinder (h = motor_shaft_length, r = motor_shaft_radius, $fn = 20);
	}
}
//--------------------------------------------------------------
module motor_zga17()
{
    cylinder(h = motor_zga17_length, r = motor_zga17_radius, $fn = 50);
    translate ([0, 0, motor_zga17_length]) cylinder(h = 10, r = 1.5, $fn = 50);
}
//--------------------------------------------------------------
module motor_gr_ep_45()
{
    dc_motor(motor_gr_ep_45_length, motor_gr_ep_45_radius, motor_gr_ep_45_distance_between_screws, motor_gr_ep_45_shaft_radius, motor_gr_ep_45_shaft_length, motor_gr_ep_45_shaft_cilinder_radius);
}
//--------------------------------------------------------------

motor_gr_ep_45();
//motor_zga17();