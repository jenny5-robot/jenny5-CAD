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
include <params_body.scad>
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
    echo(as5147_elbow_support_size = as5147_elbow_support_size);
    radius_support = 10;
    total_height = as5147_elbow_support_size[2] + 13 + 5 + 9;
    
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
        translate ([as5147_board_size[0] + radius_support + offset_x, 0, 0]) cylinder (h = total_height+ 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        translate ([as5147_board_size[0] + radius_support + offset_x, as5147_elbow_support_size[1], 0]) cylinder (h = total_height + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
    
        // remove material for wires way
        translate ([as5147_elbow_support_size[0] + 2, as5147_elbow_support_size[1] / 2, as5147_elbow_support_size[2]] + display_tolerance_x) rotate([0, -90, 0]) half_cylinder (_h = 20 + 2 * display_tolerance, _r = as5147_board_size[1] / 2, $fn = 30); 
    }    
}
//--------------------------------------------------------------
module belt_tensioner_spacer_with_sensor_support(distance_between_screws, width = 60)
{
    
    echo(distance_between_screws = distance_between_screws);
    length = distance_between_screws + 2 * m4_nut_radius + 2 * wall_thick_2;
    height = 4;
    screw_holder_size = 12;
    
    difference(){
        color(plastic_color)
        union(){
            translate ([- length / 2, -screw_holder_size / 2, 0]) cube([length, width + 2, height]);
        }
// first screw for connecting to the next part
        translate ([-distance_between_screws / 2, 0, 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = 2, $fn = 10);
//        translate ([-distance_between_screws / 2, 0, 0] - display_tolerance_z) cylinder(h = m4_nut_thick + display_tolerance, r = m4_nut_radius, $fn = 6);
// second screw hole
        translate ([distance_between_screws / 2, 0, 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = 2, $fn = 10);
//        translate ([distance_between_screws / 2, 0, 0] - display_tolerance_z) cylinder(h = m4_nut_thick + display_tolerance, r = m4_nut_radius, $fn = 6);
        
        // sensor screw holes
        for (i = [0: 3])
             translate ([0, width - screw_holder_size / 2 - as5147_space_between_holes_length / 2 - as5147_distance_hole_from_margin, 0]) rotate ([0, 0, 90]) translate ([-as5147_distance_hole_from_margin - as5147_space_between_holes_length / 2, -as5147_distance_hole_from_margin - as5147_space_between_holes_width / 2, 0] + as5147_holes_position[i] - display_tolerance_z) cylinder (h = height + 2 * display_tolerance, r = 1.2);
        
        // sensor connector holes
        translate ([-as5147_board_size[1] / 2, width - screw_holder_size / 2 - as5147_board_size[0] - 6, 0] - display_tolerance_z)  cube ([as5147_board_size[1], as5147_pin_area_length + 7, height] + 2 * display_tolerance_z);
        
        // slope
        translate ([-as5147_board_size[1] / 2, width - screw_holder_size / 2 - as5147_board_size[0] - 6 - 6, 0] - display_tolerance_z)  rotate ([-45, 0, 0]) cube ([as5147_board_size[1], height + 2, height + 2] + 2 * display_tolerance_z);

    // sensor voltage select pins hole
        translate ([-as5147_voltage_selector_pins_length / 2, width - screw_holder_size / 2 - as5147_voltage_selector_pins_position - 2.54 - 1 - 1, 0] - display_tolerance_z) cube ([as5147_voltage_selector_pins_length, 2.54 + 2, height] + 2 * display_tolerance_z);
        
    }
}
//---------------------------------------------------------------------------
module arm_up_down_sensor_support()
{
    belt_tensioner_spacer_with_sensor_support(distance_between_screws =  arm_up_down_motor_top_sheet_distance_between_belt_tensioners, width = distance_arm_up_down_motor_to_shaft - nema_17_motor_gearbox_radius - 2 - rbearing_6905_housing_size[0] / 2 + 6 + as5147_space_between_holes_length / 2 + 2);
}
//---------------------------------------------------------------------------
module body_sensor_support()
{
    belt_tensioner_spacer_with_sensor_support(distance_between_screws = 43, width = body_sheet_size[0] / 2 + as5147_space_between_holes_length / 2 + 2 + 1);
}
//---------------------------------------------------------------------------
module sensor_bearing_housing_bottom_upper_arm()
{
     h = 8;
    difference(){
    
        translate ([-rbearing_688_housing_size[0] / 2, -rbearing_688_housing_size[1] / 2, 0]) cube([rbearing_688_housing_size[0], rbearing_688_housing_size[1], h]);
        // shaft hole
        translate (-display_tolerance_z) cylinder (h = h + 2 * display_tolerance, r = rb_688_external_radius - 1);
        // bearing hole
        translate([0, 0, h - rb_688_thick]) cylinder (h = rb_688_thick + display_tolerance, r = rb_688_external_radius);
    } 
    
        // plate for fixing to the next part
    translate([0, -rbearing_688_housing_size[0] / 2, rbearing_6906_enclosed_housing_size[1] / 2]) 
    rotate([90, 0, 0])
    difference(){
                hull(){
                translate ([-rbearing_6906_enclosed_housing_size[0] / 2 + rbearing_6906_enclosed_housing_size[1] / 2, 0, 0])  cylinder (h = 3, r = rbearing_6906_enclosed_housing_size[1] / 2);
                translate ([rbearing_6906_enclosed_housing_size[0] / 2 - rbearing_6906_enclosed_housing_size[1] / 2, 0, 0]) cylinder (h = 3, r = rbearing_6906_enclosed_housing_size[1] / 2);
            }
            translate ([-rbearing_6906_enclosed_housing_size[0] / 2 + rbearing_6906_enclosed_housing_size[1] / 2, 0, 0])  cylinder (h = 3, r = 2);
                translate ([rbearing_6906_enclosed_housing_size[0] / 2 - rbearing_6906_enclosed_housing_size[1] / 2, 0, 0]) cylinder (h = 3, r = 2);
            
        }
}
//---------------------------------------------------------------------------
module sensor_bearing_housing_top_upper_arm()
{
     h = 20;
    difference(){
    echo(as5147_holes_position_relative);
        translate ([-rbearing_688_housing_size[0] / 2, -rbearing_688_housing_size[1] / 2, 0]) cube([rbearing_688_housing_size[0], rbearing_688_housing_size[1], h]);
        // shaft hole
        translate (-display_tolerance_z) cylinder (h = h + 2 * display_tolerance, r = rb_688_external_radius - 1);
        // bearing hole
        translate([0, 0, h - rb_688_thick]) cylinder (h = rb_688_thick + display_tolerance, r = rb_688_external_radius);
        
        // sensor holes
        for (i = [0: 3])
            translate (as5147_holes_position_relative[i] - display_tolerance_z) cylinder (h = 10, r = 1.2, $fn = 10);
        // voltage selector hole
        translate ([-(rbearing_688_housing_size[0] / 2 + 4.1), 0, 0] - display_tolerance_z) cylinder (h = h + 2 * display_tolerance, r = 7);
        
        translate ([(rbearing_688_housing_size[0] / 2 + 4.1), 0, 0] - display_tolerance_z) cylinder (h = h + 2 * display_tolerance, r = 7);
              
        
    }
    // plate for fixing to the next part
    translate([0, -rbearing_688_housing_size[0] / 2, rbearing_6906_enclosed_housing_size[1] / 2]) 
    rotate([90, 0, 0])
    difference(){
                hull(){
                translate ([-rbearing_6906_enclosed_housing_size[0] / 2 + rbearing_6906_enclosed_housing_size[1] / 2, 0, 0])  cylinder (h = 3, r = rbearing_6906_enclosed_housing_size[1] / 2);
                translate ([rbearing_6906_enclosed_housing_size[0] / 2 - rbearing_6906_enclosed_housing_size[1] / 2, 0, 0]) cylinder (h = 3, r = rbearing_6906_enclosed_housing_size[1] / 2);
            }
            // screw holes
            for (i = [0 : 1])
                translate (rbearing_6906_enclosed_housing_holes_position[i])
              cylinder (h = 3, r = m4_screw_radius, $fn = 10);
            
            
        }

}
//---------------------------------------------------------------------------
module sensor_bearing_housing_bottom_fore_arm()
{
     h = 8;
    difference(){
    
        translate ([-rbearing_688_housing_size[0] / 2, -rbearing_688_housing_size[1] / 2, 0]) cube([rbearing_688_housing_size[0], rbearing_688_housing_size[1], h]);
        // shaft hole
        translate (-display_tolerance_z) cylinder (h = h + 2 * display_tolerance, r = rb_688_external_radius - 1);
        // bearing hole
        translate([0, 0, h - rb_688_thick]) cylinder (h = rb_688_thick + display_tolerance, r = rb_688_external_radius);
    } 
    
        // plate for fixing to the next part
    translate([0, -rbearing_688_housing_size[0] / 2, rbearing_6906_enclosed_housing_size[1] / 2]) 
    rotate([90, 0, 0])
    difference(){
                hull(){
                    translate ([-rbearing_6906_enclosed_housing_size[0] / 2 + rbearing_6906_enclosed_housing_size[1] / 2, 0, 0])  cylinder (h = 3, r = rbearing_6906_enclosed_housing_size[1] / 2);
                    translate ([fore_arm_bearing_support_size[0]-rbearing_6906_enclosed_housing_size[0] / 2 -rbearing_6906_enclosed_housing_size[1] / 2 , 0, 0]) cylinder (h = 3, r = rbearing_6906_enclosed_housing_size[1] / 2);
                }
                //screw holes
                translate ([-rbearing_6906_enclosed_housing_size[0] / 2 + rbearing_6906_enclosed_housing_size[1] / 2, 0, 0])  cylinder (h = 3, r = 2);
                translate ([fore_arm_bearing_support_size[0]-rbearing_6906_enclosed_housing_size[0] / 2 - rbearing_6906_enclosed_housing_size[1] / 2, 0, 0]) cylinder (h = 3, r = 2);
            
        }

}
//---------------------------------------------------------------------------
module sensor_bearing_housing_top_fore_arm()
{
     h = 20;
    difference(){
    echo(as5147_holes_position_relative);
        translate ([-rbearing_688_housing_size[0] / 2, -rbearing_688_housing_size[1] / 2, 0]) cube([rbearing_688_housing_size[0], rbearing_688_housing_size[1], h]);
        // shaft hole
        translate (-display_tolerance_z) cylinder (h = h + 2 * display_tolerance, r = rb_688_external_radius - 1);
        // bearing hole
        translate([0, 0, h - rb_688_thick]) cylinder (h = rb_688_thick + display_tolerance, r = rb_688_external_radius);
        
        // sensor holes
        for (i = [0: 3])
            translate (as5147_holes_position_relative[i] - display_tolerance_z) cylinder (h = 10, r = 1.2, $fn = 10);
        // voltage selector hole
        translate ([-(rbearing_688_housing_size[0] / 2 + 5.01), 0, 0] - display_tolerance_z) cylinder (h = h + 2 * display_tolerance, r = 8);
        
        translate ([(rbearing_688_housing_size[0] / 2 + 5.01), 0, 0] - display_tolerance_z) cylinder (h = h + 2 * display_tolerance, r = 8);
              
        
    }
    // plate for fixing to the next part
    translate([0, -rbearing_688_housing_size[0] / 2, rbearing_6906_enclosed_housing_size[1] / 2]) 
    rotate([90, 0, 0])
    difference(){
                hull(){
                    translate ([-(-rbearing_6906_enclosed_housing_size[0] / 2 + rbearing_6906_enclosed_housing_size[1] / 2), 0, 0])  cylinder (h = 3, r = rbearing_6906_enclosed_housing_size[1] / 2);
                    translate ([-(fore_arm_bearing_support_size[0]-rbearing_6906_enclosed_housing_size[0] / 2 -rbearing_6906_enclosed_housing_size[1] / 2), 0, 0]) cylinder (h = 3, r = rbearing_6906_enclosed_housing_size[1] / 2);
                }
                // screw holes
                translate ([-(-rbearing_6906_enclosed_housing_size[0] / 2 + rbearing_6906_enclosed_housing_size[1] / 2), 0, 0])  cylinder (h = 3, r = 2);
                translate ([-(fore_arm_bearing_support_size[0]-rbearing_6906_enclosed_housing_size[0] / 2 - rbearing_6906_enclosed_housing_size[1] / 2), 0, 0]) cylinder (h = 3, r = 2);
            
        }

}
//---------------------------------------------------------------------------

//belt_tensioner_spacer_with_sensor_support(distance_between_screws = 28, width = 60);
//magnet_support_elbow();

//sensor_support_elbow();

//body_sensor_support();

//arm_up_down_sensor_support();

//sensor_bearing_housing_top_upper_arm();
//sensor_bearing_housing_bottom_upper_arm();

sensor_bearing_housing_top_fore_arm();
//sensor_bearing_housing_bottom_fore_arm();
