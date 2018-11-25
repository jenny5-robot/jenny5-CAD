// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
use <../basic_scad/basic_components.scad>

include <../basic_scad/params_screws_nuts_washers.scad>

include <../basic_scad/config.scad>

include <../basic_scad/tolerance.scad>

include <params_arm.scad>
include <../basic_scad/as5147_params.scad>
include <arm_sensor_support_params.scad>

//--------------------------------------------------------------
module magnet_support_elbow()
{
    base_height = 4;
    total_height = 34;
    
    difference(){
        union(){
            hull(){
                cylinder (h = base_height, r = 6);
                translate ([0, elbow_pulley_holes_dist_x + 6 + elbow_pulley_holes_dist_x + 10, 0]) cylinder (h = base_height, r = 6);
            }
            hull(){
                cylinder (h = total_height, r = 6);
                translate ([0, 2 * elbow_pulley_holes_dist_x - 3, 0]) cylinder (h = total_height, r = 6);
            }
        }
        
        translate (-display_tolerance_z) cylinder(h = total_height + 2 * display_tolerance, r = 2, $fn = 20);
      //  translate ([0, elbow_pulley_holes_dist_x + 6 + elbow_pulley_holes_dist_x + 10, 0]) cylinder(h = base_height + 2 * display_tolerance, r = 2, $fn = 20);
        
        translate ([0, 2 * elbow_pulley_holes_dist_x, 0] - display_tolerance_z) cylinder(h = total_height + 2 * display_tolerance, r = 2, $fn = 20);
        
        // magnet hole
        translate ([0, elbow_pulley_holes_dist_x + 6 + elbow_pulley_holes_dist_x + 10, 0]) cylinder(h = 3, r = 4, $fn = 20);
    }
}
//--------------------------------------------------------------
module sensor_support_elbow()
{
    radius_support = 10;
    total_height = as5147_elbow_support_size[2] + 13 + 5 + 10;
    
    offset_x = 1;
    difference(){
        union(){
            cube(as5147_elbow_support_size);
            hull(){
                translate ([offset_x + as5147_board_size[0] + radius_support, radius_support - 5, 0]) cylinder(h = total_height, r = radius_support, $fn = 30);
                translate ([offset_x + as5147_board_size[0] + radius_support, as5147_elbow_support_size[1] - (radius_support - 5), 0]) cylinder(h = total_height, r = radius_support, $fn = 30);
            }
        }
        // screws holes for sensor
        for (i = [0 : 3])
            translate (as5147_holes_position[i] + [offset_x, (as5147_elbow_support_size[1] - as5147_board_size[1]) / 2, 0] - display_tolerance_z) cylinder(h = as5147_elbow_support_size[2] + 2 * display_tolerance, r = 1, $fn = 10);
        // cube 
       translate ([as5147_board_size[0] + offset_x, (as5147_elbow_support_size[1] - 20) / 2, as5147_elbow_support_size[2] + 13 + 5]) cube([20, 20, 30]);
        // screws for fixing the sensor on arm
        translate ([as5147_board_size[0] + radius_support, 0, 0]) cylinder (h = total_height+ 2 * display_tolerance, r = 2, $fn = 10);
        translate ([as5147_board_size[0] + radius_support, as5147_elbow_support_size[1], 0]) cylinder (h = total_height + 2 * display_tolerance, r = 2, $fn = 10);
    
        // remove material for wires way
        translate ([as5147_elbow_support_size[0] + 2, as5147_elbow_support_size[1] / 2, as5147_elbow_support_size[2]] + display_tolerance_x) rotate([0, -90, 0]) half_cylinder (_h = 20 + 2 * display_tolerance, _r = as5147_board_size[1] / 2, $fn = 30); 
    }    
}
//--------------------------------------------------------------

//magnet_support_elbow();

sensor_support_elbow();