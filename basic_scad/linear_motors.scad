// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_stepper_motors.scad>

use <stepper_motors.scad>
use <pulleys.scad>
include <tolerance.scad>


//------------------------------------------------------

module linear_stepper_motor()
{
    cylinder (h = 250, r = 4, $fn = 20);
    translate([40, 0, nema_17_with_gearbox_height + nema_17_gearbox_shaft_length]) mirror([0, 0, 1]) nema_17_with_gearbox();
    // sheet
    translate ([-20, -20, nema_17_gearbox_shaft_length - 3]) cube([80, 40, 3]);
    
    // pulleys
    my_pulley("T5mm_pulley", 30, 0, 0, 0);
    
    translate([40, 0, 0]) my_pulley(24, 30, 0, 0, 0);
}
//------------------------------------------------------
module linear_dc_motor(stroke, current_pos)
{
    color("grey") 
    render()
    {
        motor_base_length = 105 + stroke - 20;
        // tube
          translate([0, 0, 10]) cylinder (h = motor_base_length, r = 17);
        // base support
        translate ([0, 0, -10]) 
          difference() {
              cylinder (h = 20, r = 10);
              // hole
              translate ([0, -10, 10]) rotate([-90, 0, 0]) cylinder(h = 20, r = 4);
          }
        // pusher
        translate([0, 0, motor_base_length + 10]) 
          difference(){
            cylinder (h = current_pos + 20, r = 10);
              // hole
            translate ([0, -10, current_pos + 10]) rotate([-90, 0, 0]) cylinder(h = 20, r = 4);
          }
        
        // motor
          translate ([-20 - 17, 0, 10]) cylinder(h = 100, r = 20);
    }
}
//------------------------------------------------------
module linear_dc_motor_simple(stroke)
{
    color("grey") 
    render(){
        // screw
        translate([0, 0, 10 + 26]) cylinder (h = stroke, r = 6);
        // base support
        translate ([0, 0, -10]) 
          difference() {
              cylinder (h = 20, r = 10);
              // hole
              translate ([0, -10, 10]) rotate([-90, 0, 0]) cylinder(h = 20, r = 4);
          }
        
        // motor
          translate ([-20 - 17, 0, 10]) cylinder(h = 74, r = 20);
          hull(){
              translate([0, 0, 10]) cylinder(h = 26, r = 20);
              translate([-20 - 17, 0, 10]) cylinder(h = 26, r = 20);
          }
    }
}
//------------------------------------------------------

//linear_stepper_motor();

//linear_dc_motor(100, 0);

linear_dc_motor_simple(150);