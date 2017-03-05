// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

use <../basic_scad/basic_components.scad>
include <params_gripper.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
include <../basic_scad/params_stepper_motors.scad>
include <../basic_scad/params_basic_components.scad>
use <../basic_scad/stepper_motors.scad>
include <../basic_scad/params_radial_bearings.scad>
use <../basic_scad/stepper_motors_housing.scad>
include <../basic_scad/params_motor_housing.scad>
include <../basic_scad/params_webcam.scad>
use <../basic_scad/webcam_support.scad>
include <../basic_scad/config.scad>

//-----------------------------------------------------------------------------------
module gripper_lateral_support()
{
	difference(){
		color(plastic_color)
        union(){
			cube(gripper_lateral_sheet_size);
            difference(){
                translate ([0, -10, 0]) cube([10, gripper_lateral_sheet_size[1] + 20, gripper_lateral_sheet_size[2]]);
                // holes for screws
                translate([5, -5, 0]-display_tolerance_z) cylinder (h = gripper_lateral_sheet_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20); 
                translate([5, gripper_lateral_sheet_size[1] + 5, 0]-display_tolerance_z) cylinder (h = gripper_lateral_sheet_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20); 
            }
		}
        // pusher translation hole
        hull(){
        translate([10, gripper_lateral_sheet_size[1] / 2, 0] - display_tolerance_z) cylinder (h = gripper_lateral_sheet_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        translate([42, gripper_lateral_sheet_size[1] / 2, 0] - display_tolerance_z) cylinder (h = gripper_lateral_sheet_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        }
        
        // base holes
        translate([gripper_lateral_sheet_size[0] - gripper_motor_support_size[2] / 2, 9, 0] - display_tolerance_z) cylinder (h = gripper_lateral_sheet_size[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        translate([gripper_lateral_sheet_size[0] - gripper_motor_support_size[2] / 2, gripper_lateral_sheet_size[1] - 9, 0] - display_tolerance_z) cylinder (h = gripper_lateral_sheet_size[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        
        // holes for bone fixing
        translate([gripper_lateral_sheet_size[0] - 25, gripper_lateral_sheet_size[1] / 2 - 15, 0] - display_tolerance_z) cylinder (h = gripper_lateral_sheet_size[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        translate([gripper_lateral_sheet_size[0] - 25, gripper_lateral_sheet_size[1] / 2 + 15, 0] - display_tolerance_z) cylinder (h = gripper_lateral_sheet_size[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        
	}
}
//-----------------------------------------------------------------------------------
module gripper_lateral_support_with_ir_support()
{
    gripper_lateral_support();
    
    support_thick = 3;
    translate ([-3, -37 / 2 + gripper_lateral_sheet_size[1] / 2 - 3.75, 0]) 
    difference(){ 
        color(plastic_color) 
        hull(){
          cube([3, 37 + 2 * 3.75, 13 + 3]);
            //rotate ([0, 90, 0]) cylinder(h = support_thick, r = 4);
            //translate([0, 37, 0]) rotate ([0, 90, 0]) cylinder(h = support_thick, r = 4);
        }
        // screw holes
        translate([0, 3.75, 3 + 6.5] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = support_thick + 2 * display_tolerance, r = 1.5, $fn = 20); 
        translate([0, 37 + 3.75, 3 + 6.5] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = support_thick + 2 * display_tolerance, r = 1.5, $fn = 20); 
    }
}
//-----------------------------------------------------------------------------------
module finger ()
{
    // base finger; or the first segment
	difference(){
        color(plastic_color)
		hull(){
			cylinder(r = finger_width / 2, h = finger_thick );
			translate([finger_first_segment_length, 0, 0 ]) cylinder(r = finger_width / 2, h = finger_thick);
		}
        // slide hole
		translate(-display_tolerance_z) 
            hull(){
                cylinder (h = finger_thick + 2 * display_tolerance, r = m4_screw_radius); 
                translate ([20, 0, 0]) cylinder (h = finger_thick + 2 * display_tolerance, r = m4_screw_radius); 
            }
        
// m4 screw hole for finger rotation
		translate([finger_first_segment_length, 0, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = finger_thick + 2 * display_tolerance, $fn = 30);
	}
    // finger, second segment
    difference(){
        translate([finger_first_segment_length, 0, 0]) 
                rotate ([0, 0, -90]) 
                    translate ([-55, -5, 0]) 
                        difference(){
                            color(plastic_color)
                            arc_thick(radius_exterior = 60, radius_interior = 50, thick = finger_thick, angle = 90);
                            // spacer hole
                            translate([5, 54.5, 0] - display_tolerance_z) cylinder (r = m3_screw_radius, h = finger_thick + 2 * display_tolerance, $fn = 100);
                        }
        // screw hole
    	translate([finger_first_segment_length, 0, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = finger_thick + 2 * display_tolerance, $fn = 30);
    }
}
//-----------------------------------------------------------------------------------
module finger_with_button_support ()
{
    // base finger; or the first segment
	difference(){
        color(plastic_color)
		hull(){
			cylinder(r = finger_width / 2, h = finger_thick );
			translate([finger_first_segment_length, 0, 0 ]) cylinder(r = finger_width / 2, h = finger_thick);
		}
        // slide hole
		translate(-display_tolerance_z) 
            hull(){
                cylinder (h = finger_thick + 2 * display_tolerance, r = m4_screw_radius); 
                translate ([20, 0, 0]) cylinder (h = finger_thick + 2 * display_tolerance, r = m4_screw_radius); 
            }
        
// m4 screw hole for finger rotation
		translate([finger_first_segment_length, 0, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = finger_thick + 2 * display_tolerance, $fn = 30);
	}
    // finger, second segment
    difference(){
	translate([finger_first_segment_length, 0, 0]) rotate([0, 0, finger_with_button_angle]) 
        difference(){
            color(plastic_color)
            union(){
                
                hull(){
                    cylinder(r = finger_width / 2, h = finger_thick );
                    translate([finger_second_second_length - 20, -finger_width / 2, 0 ]) cube([1, finger_width, finger_thick]);
                }
                translate([finger_second_second_length - 20, -finger_width / 2, 0 ]) 
                difference(){
                    cube([20, finger_width, 14]);
                    translate([10, 0, 7] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = finger_width + 2 * display_tolerance, r = 3.4, $fn = 30);
                    translate([10, 0, 7] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = 7 + display_tolerance, r = 5.5, $fn = 30);
                }
            }
//            translate([finger_second_second_length / 2, 38, 0]) cylinder (r = 32, h = finger_thick, $fn = 100);
        }
    	translate([finger_first_segment_length, 0, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = finger_thick + 2 * display_tolerance, $fn = 30);
    }
}
//-----------------------------------------------------------------------------------
module fore_finger()
{
  difference(){
      color(plastic_color)
    hull(){
      cylinder(r = finger_width / 2, h = finger_thick );
      translate([finger_second_second_length, 0, 0 ]) cylinder(r = finger_width / 2, h = finger_thick);
    }
        
    translate(- display_tolerance_z) cylinder (r = m4_screw_radius, h = finger_thick + 2 * display_tolerance, $fn = 30);
  }
}
//-----------------------------------------------------------------------------------
module fore_fingers()
{
    fore_finger();
    translate ([0, 0, 2 * spacer_between_fingers + 2 * finger_thick]) 
        fore_finger();
    translate ([finger_second_second_length - 15, -4, finger_thick]) 
        color(plastic_color) cube([15, 4, 2 * spacer_between_fingers + finger_thick]);
}
//-----------------------------------------------------------------------------------
module U_pusher()
{
    // base
    difference(){
        color(plastic_color)
        cube(U_pusher_base_size);
        // screw hole for push screw
        translate([U_pusher_base_size[0] / 2, U_pusher_base_size[1] / 2, 0] - display_tolerance_z)
        cylinder (h = U_pusher_base_size[2] + 2 * display_tolerance, r = 2.5, $fn = 20);
        // screw hole for stopper
        translate ([U_pusher_base_size[0] / 2, 0, U_pusher_base_size[2] / 2] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h =  U_pusher_base_size[1] / 2, r = m4_screw_radius, $fn = 20);
        // nut
        hull(){
            translate ([U_pusher_base_size[0] / 2, 3, U_pusher_base_size[2] / 2]) rotate([-90, 30, 0]) cylinder (h =  m4_nut_thick, r = m4_nut_radius, $fn = 6);
            translate ([U_pusher_base_size[0] / 2, 3, U_pusher_base_size[2]]) rotate([-90, 30, 0]) cylinder (h =  m4_nut_thick, r = m4_nut_radius, $fn = 6);
        }
    }
    
    // pusher fingers
    difference(){
        color(plastic_color)
        union(){
            translate ([0, U_pusher_base_size[1] / 2, U_pusher_height]) rotate ([0, 90, 0]) cylinder ( h = U_finger_thick, r = U_pusher_base_size[1] / 2, $fn = 30);
            cube([U_finger_thick, U_pusher_base_size[1], U_pusher_height]);
            // other side
            translate ([U_pusher_base_size[0] - U_finger_thick, U_pusher_base_size[1] / 2, U_pusher_height]) rotate ([0, 90, 0]) cylinder ( h = U_finger_thick, r = U_pusher_base_size[1] / 2, $fn = 30);
            translate ([U_pusher_base_size[0] - U_finger_thick, 0, 0]) cube([U_finger_thick, U_pusher_base_size[1], U_pusher_height]);
        }
        // shaft hole
        translate([0, U_pusher_base_size[1] / 2, U_pusher_height] - display_tolerance_x) rotate ([0, 90, 0]) cylinder ( h = U_pusher_base_size[0] + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);

    }
}
//-----------------------------------------------------------------------------------
module gripper_base()
{
    difference(){
        color(plastic_color) cube(gripper_motor_support_size);
        
        translate ([gripper_motor_support_size[0] / 2, gripper_motor_support_size[1] / 2, 0] - display_tolerance_z) {
        // middle screw hole
            cylinder(h = gripper_motor_support_size[2] + 2 * display_tolerance, r = 4, $fn = 40);
            // 
            cylinder(h = rb_625_thick + display_tolerance, r = rb_625_external_radius, $fn = 40);
        }
        // holes for fixing the motor support to lateral support
        translate ([0, 9, gripper_motor_support_size[2] / 2] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = gripper_motor_support_size[1] + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        translate ([0, gripper_motor_support_size[1] - 9, gripper_motor_support_size[2] / 2] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = gripper_motor_support_size[1] + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
    }
}
//-----------------------------------------------------------------------------------
module gripper_motor_housing()
{
    //nema_motor_housing_with_base_holes_for_nuts(0, 0, 0, nema_17_width, nema_17_height, 43, nema_17_gearbox_motor_hole_radius, gearbox_nema_17_holes_position, nema_17_housing_base_holes, 22, 4);
    
    difference(){
        union(){
        nema_motor_housing_with_base_holes(0, 0, nema_14_39BYGL215A_width, nema_14_39BYGL215A_height, nema_14_39BYGL215A_height, nema_14_39BYGL215A_top_radius, nema_14_39BYGL215A_screw_hole_position, 3, dist_to_first_hole_z = 12, nema_housing_base_holes = nema_17_housing_large_base_holes, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0);
    
        translate([0, nema_14_39BYGL215A_width / 2 + 2, nema_14_39BYGL215A_height / 2]) 
            rotate ([0, -90, 0]) 
                color(plastic_color)  cylinder (h = 9.5, r = nema_14_39BYGL215A_height / 2);
        }
        // bone hole
        translate([-9.6, nema_14_39BYGL215A_width / 2 + 2 - 5, 0]) 
            cube([9.6, 10, nema_14_39BYGL215A_height]);   
   
        // screw holes     
        translate ([3, nema_14_39BYGL215A_width / 2 + 2 - 10, nema_14_39BYGL215A_height / 2]) rotate ([0, -90, 0]) cylinder (h = 15, r = m4_screw_radius, $fn = 20);
        translate ([4, nema_14_39BYGL215A_width / 2 + 2 - 10, nema_14_39BYGL215A_height / 2]) rotate ([0, -90, 0]) cylinder (h = 4, r = m4_nut_radius, $fn = 6);


        // screw holes     
        translate ([3, nema_14_39BYGL215A_width / 2 + 2 + 10, nema_14_39BYGL215A_height / 2]) rotate ([0, -90, 0]) cylinder (h = 15, r = m4_screw_radius, $fn = 20);
        translate ([4, nema_14_39BYGL215A_width / 2 + 2 + 10, nema_14_39BYGL215A_height / 2]) rotate ([0, -90, 0]) cylinder (h = 4, r = m4_nut_radius, $fn = 6);
    }

}
//-----------------------------------------------------------------------------------
module gripper_motor_housing_cover()
{
    difference(){
        color(plastic_color) cylinder (h = 3, r = nema_14_39BYGL215A_height / 2);
        
        // screw holes     
        translate ([-10, 0, 0] - display_tolerance_z) 
                cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        
        // screw holes     
        translate ([10, 0, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
    }
}
//-----------------------------------------------------------------------------------
module gripper(pusher_position = 25)
{ 
    pusher_offset = 31;
// bottom plate
    gripper_lateral_support();
    // top plate
    translate([0, 0, gripper_motor_support_size[0] + gripper_lateral_sheet_size[2]]) gripper_lateral_support_with_ir_support();
    
    gripper_angle = atan((gripper_lateral_sheet_size[1] / 2 + 5) / (pusher_position - 5));
    
    // pusher
    translate ([U_pusher_height +  pusher_position, -U_pusher_base_size[1] / 2 + gripper_lateral_sheet_size[1] / 2, gripper_lateral_sheet_size[2] + spacer_between_fingers]) rotate ([0, -90, 0]) U_pusher();
    
    // pusher screw
    translate ([pusher_position, gripper_lateral_sheet_size[1] / 2, -m4_nut_thick]) M4_hexa (50);
    translate ([pusher_position, gripper_lateral_sheet_size[1] / 2, 45]) M4_autolock_nut();
    
    // lateral screw
    translate ([5, -5, -m4_nut_thick]) M4_hexa (50);
    // lateral screw
    translate ([5, gripper_lateral_sheet_size[1] + 5, -m4_nut_thick]) M4_hexa (50);
    
    // lateral nut
    translate ([5, -5, 45]) M4_autolock_nut();
    // lateral nut
    translate ([5, gripper_lateral_sheet_size[1] + 5, 45]) M4_autolock_nut();
    
    // motor support
    translate([gripper_lateral_sheet_size[0], 0, 4]) rotate([0, -90, 0]) gripper_base();
    
     // motor
    translate([gripper_lateral_sheet_size[0] + nema_14_39BYGL215A_height + 200, gripper_lateral_sheet_size[1] / 2, gripper_lateral_sheet_size[2] + gripper_motor_support_size[0] / 2]) rotate ([0, -90, 0]) nema_14_39BYGL215A();
    
    // motor housing
    translate([gripper_lateral_sheet_size[0] + 200 - 3, nema_14_39BYGL215A_width + 1.5, 0]) rotate ([0, -90, 180]) 
    gripper_motor_housing();
    
    // motor housing cover
    translate([gripper_lateral_sheet_size[0] + 200 - 3 + nema_14_39BYGL215A_height / 2, nema_14_39BYGL215A_width / 2 - 0.5, -13]) rotate([0, 0, 90]) 
    gripper_motor_housing_cover();
    
    // shaft - motor pusher
    translate([49, gripper_lateral_sheet_size[1] / 2, gripper_lateral_sheet_size[2] + gripper_motor_support_size[0] / 2]) rotate ([0, 90, 0]) color ("gray") cylinder (h = 200, r = 3);
    
    // fingers
    translate ([5, gripper_lateral_sheet_size[1] + 5, 0])
    rotate ([0, 0, 180 - gripper_angle]) 
    translate ([-finger_first_segment_length, 0, gripper_lateral_sheet_size[2] + spacer_between_fingers + U_finger_thick + spacer_between_fingers]) 
    finger();
    
    // finger with button support
    translate ([5, - 5, 0])
    rotate ([0, 0, gripper_angle]) 
    mirror([1, 0, 0])
    translate ([-finger_first_segment_length, 0, gripper_lateral_sheet_size[2] + spacer_between_fingers + U_finger_thick + spacer_between_fingers + finger_thick + spacer_between_fingers]) 
    finger_with_button_support ();

// touch fingers
    translate ([5, - 5, 0])
    rotate ([0, 0, gripper_angle - finger_angle]) 
    mirror([1, 0, 0])
    translate ([0, 0, gripper_lateral_sheet_size[2] + spacer_between_fingers + U_finger_thick + spacer_between_fingers ]) 
    fore_fingers();
    
    // second finger
        translate ([5, gripper_lateral_sheet_size[1] + 5, 0])
    rotate ([0, 0, 180 - gripper_angle]) 
    translate ([-finger_first_segment_length, 0, gripper_lateral_sheet_size[2] + spacer_between_fingers + U_finger_thick + spacer_between_fingers + finger_thick + spacer_between_fingers  + finger_thick + spacer_between_fingers]) finger();

}
//-----------------------------------------------------------------------------------
module gripper_c920_support()
{
    difference(){
        union(){
            c920_support();
            translate([c920_dist_between_holder_holes / 2 + c920_depth / 2 - gripper_motor_support_size[1] / 2, 0, 0]) 
            difference(){
                cube([gripper_motor_support_size[1], 12.5, 13]);
            // bone hole
                translate ([gripper_motor_support_size[1] / 2 - 5, 3, 0] - display_tolerance_z) cube([10, 10, 13] + 2 * display_tolerance_yz);
            }
        }
        // gripper screw holes
        translate([c920_dist_between_holder_holes / 2 + c920_depth / 2 - 15, 0, 6.5] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = 13 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        translate([c920_dist_between_holder_holes / 2 + c920_depth / 2 + 15, 0, 6.5] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = 13 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
                
        // sunken screw holes
        translate([c920_dist_between_holder_holes / 2 + c920_depth / 2 - 15, 0, 6.5] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = 2, r2 = m3_screw_radius, r1 = m3_nut_radius, $fn = 20);
        translate([c920_dist_between_holder_holes / 2 + c920_depth / 2 + 15, 0, 6.5] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = 2, r2 = m3_screw_radius, r1 = m3_nut_radius, $fn = 20);
    }
}
//-----------------------------------------------------------------------------------

gripper(pusher_position = 42); // 10...42


//gripper_motor_housing();

//gripper_motor_housing_cover();

//fore_fingers();  // 1x

//gripper_lateral_support(); // 1x

//gripper_lateral_support_with_ir_support(); // 1x

//U_pusher(); // 1x

//finger(); // 2x
//finger_with_button_support(); // 1x


//gripper_motor_support();//1x

//gripper_c920_support();