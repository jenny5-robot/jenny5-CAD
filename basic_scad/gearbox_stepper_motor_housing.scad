// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

use <basic_components.scad>

include <params_screws_nuts_washers.scad>
include <params_stepper_motors.scad>
include <tolerance.scad>

module stepper_motor_holder()
{
    length = 40;
    width = 40;
    thick = 6;
    difference(){
      cube([length, width, thick]);
      translate ([length / 2, width / 2, 0]) cylinder (h = thick, r = 11, $fn = 100);
        translate ([length / 2, width / 2, 3]) cylinder (h = thick, r = nema_17_motor_gearbox_radius, $fn = 100);
        for (i=[-1, 1])
            for (j=[-1, 1]){
            translate ([length / 2, width / 2, 0] + [i * nema_17_gearbox_dist_between_screw_holes / 2, j * nema_17_gearbox_dist_between_screw_holes / 2, 0]) cylinder (h = thick, r = m3_screw_radius, $fn = 20);
            // here I have to make the sunken holes
            translate ([length / 2, width / 2, 0] + [i * nema_17_gearbox_dist_between_screw_holes / 2, j * nema_17_gearbox_dist_between_screw_holes / 2, 0]) cylinder (h = 1.5, r2 = m3_screw_radius, r1 = m3_nut_radius, $fn = 20);
            }
        for (k = [0: 4]){
            echo([length / 2, width / 2, 0] + gauri_nema_17[k]);
            translate ([length / 2, width / 2, 0] + gauri_nema_17[k]) cylinder (h = thick, r = m3_screw_radius, $fn = 20);
        }
    }
}

stepper_motor_holder();