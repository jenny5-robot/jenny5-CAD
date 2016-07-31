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
linear_stepper_motor();