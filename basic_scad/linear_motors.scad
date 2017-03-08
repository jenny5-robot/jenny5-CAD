// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_stepper_motors.scad>

use <stepper_motors.scad>
use <pulleys.scad>


//------------------------------------------------------

module linear_stepper_motor()
{
    cylinder (h = 250, r = 4, $fn = 20);
    translate([40, 0, nema_17_with_gearbox_height + nema_17_gearbox_shaft_length]) mirror([0, 0, 1]) nema_17_with_gearbox();
    // sheet
    translate ([-20, -20, nema_17_gearbox_shaft_length - 3]) cube([80, 40, 3]);
    
    // pulleys
    my_pulley(24, 30, 0, 0, 0);
    
    translate([40, 0, 0]) my_pulley(24, 30, 0, 0, 0);
}
//------------------------------------------------------
module linear_dc_motor(stroke, current_pos)
{
    motor_base_length = 105 + stroke - 20;
    // tube
    color("grey") 
      translate([0, 0, 10]) cylinder (h = motor_base_length, r = 17);
    // base support
    translate ([0, 0, -10]) 
      difference() {
          color("grey") cylinder (h = 20, r = 10);
          // hole
          translate ([0, -10, 10]) rotate([-90, 0, 0]) cylinder(h = 20, r = 4);
      }
    // pusher
    color("grey") translate([0, 0, motor_base_length + 10]) 
      difference(){
        cylinder (h = current_pos + 20, r = 10);
          // hole
        translate ([0, -10, current_pos + 10]) rotate([-90, 0, 0]) cylinder(h = 20, r = 4);
      }
    
    // motor
    color("grey") 
      translate ([-34, 0, 10]) cylinder(h = 100, r = 20);
}
//------------------------------------------------------

//linear_stepper_motor();

linear_dc_motor(100, 0);