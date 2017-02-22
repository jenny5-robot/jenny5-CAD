// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_gripper.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
include <../basic_scad/params_stepper_motors.scad>
include <../basic_scad/params_basic_components.scad>
use <../basic_scad/stepper_motors.scad>
use <../basic_scad/webcam_support.scad>
include <../basic_scad/params_webcam.scad>

//-----------------------------------------------------------------------------------
module gripper_lateral_support()
{
	difference(){
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
        translate([40, gripper_lateral_sheet_size[1] / 2, 0] - display_tolerance_z) cylinder (h = gripper_lateral_sheet_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
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
	translate([finger_first_segment_length, 0, 0]) rotate([0, 0, finger_angle]) 
        difference(){
            hull(){
                cylinder(r = finger_width / 2, h = finger_thick );
                translate([finger_second_second_length, 0, 0 ]) cylinder(r = finger_width / 2, h = finger_thick);
            }
//            translate([finger_second_second_length / 2, 38, 0]) cylinder (r = 32, h = finger_thick, $fn = 100);
        }
    	translate([finger_first_segment_length, 0, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = finger_thick + 2 * display_tolerance, $fn = 30);
    }
}
//-----------------------------------------------------------------------------------
module finger_with_button_support ()
{
    // base finger; or the first segment
	difference(){
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
	translate([finger_first_segment_length, 0, 0]) rotate([0, 0, finger_angle - 15]) 
        difference(){
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
    translate ([0, 0, 2 * spacer_between_fingers + 2 * finger_thick]) fore_finger();
    translate ([finger_second_second_length - 15, -4, finger_thick]) cube([15, 4, 2 * spacer_between_fingers + finger_thick]);
}
//-----------------------------------------------------------------------------------
module U_pusher()
{
    // base
    difference(){
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
module gripper_motor_support()
{
    difference(){
        cube(gripper_motor_support_size);
        
        translate ([gripper_motor_support_size[0] / 2, gripper_motor_support_size[1] / 2, 0] - display_tolerance_z) {
        // middle motor hole
            cylinder(h = 2.4 + display_tolerance, r = nema_14_39BYGL215A_top_radius + 0.1, $fn = 40);
            cylinder(h = gripper_motor_support_size[2] + 2 * display_tolerance, r = 5, $fn = 40);
        // screw holes for fixing the motor
            for (i = [1 : 4])
                translate (nema_14_39BYGL215A_screw_hole_position[i]){
                    cylinder (h = gripper_motor_support_size[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
                    translate([0, 0, gripper_motor_support_size[2]])
                    cylinder (h = 2, r2 = m3_nut_radius, r1 = m3_screw_radius, $fn = 20);
                }
        }
        // holes for fixing the motor support to lateral support
        translate ([0, 9, gripper_motor_support_size[2] / 2 + 0.5] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = gripper_motor_support_size[1] + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        translate ([0, gripper_motor_support_size[1] - 9, gripper_motor_support_size[2] / 2 + 0.5] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = gripper_motor_support_size[1] + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
    }
}
//-----------------------------------------------------------------------------------
module gripper(gripper_angle = 5)
{
    
    pusher_offset = 31;
// bottom
    gripper_lateral_support();
    // top
    translate([0, 0, gripper_motor_support_size[0] + gripper_lateral_sheet_size[2]]) gripper_lateral_support_with_ir_support();
    
    
    // pusher
    translate ([U_pusher_height + pusher_offset + sin(gripper_angle) * finger_first_segment_length, -U_pusher_base_size[1] / 2 + gripper_lateral_sheet_size[1] / 2, gripper_lateral_sheet_size[2] + spacer_between_fingers]) rotate ([0, -90, 0]) U_pusher();
    
    // pusher screw
    translate ([pusher_offset + sin(gripper_angle) * finger_first_segment_length, gripper_lateral_sheet_size[1] / 2, -5]) cylinder (h = 55, r = m4_screw_radius, $fn = 20);
    
    // lateral screw
    translate ([5, -5, -m4_nut_thick]) M4_hexa (50);
    // lateral screw
    translate ([5, gripper_lateral_sheet_size[1] + 5, -m4_nut_thick]) M4_hexa (50);
    
    // lateral nut
    translate ([5, -5, 45]) M4_autolock_nut();
    // lateral nut
    translate ([5, gripper_lateral_sheet_size[1] + 5, 45]) M4_autolock_nut();
    
    
    // motor support
    translate([gripper_lateral_sheet_size[0], 0, 4]) rotate([0, -90, 0]) gripper_motor_support();
    
    // motor
    translate([gripper_lateral_sheet_size[0] + nema_14_39BYGL215A_height, gripper_lateral_sheet_size[1] / 2, gripper_lateral_sheet_size[2] + gripper_motor_support_size[0] / 2]) rotate ([0, -90, 0]) nema_14_39BYGL215A();
    
    // fingers
    translate ([5, gripper_lateral_sheet_size[1] + 5, 0])
    rotate ([0, 0, gripper_angle + 180 - finger_angle]) 
    translate ([-finger_first_segment_length, 0, gripper_lateral_sheet_size[2] + spacer_between_fingers + U_finger_thick + spacer_between_fingers]) 
    finger();
    
    // finger with button support
    translate ([5, - 5, 0])
    rotate ([0, 0, -gripper_angle + finger_angle]) 
    mirror([1, 0, 0])
    translate ([-finger_first_segment_length, 0, gripper_lateral_sheet_size[2] + spacer_between_fingers + U_finger_thick + spacer_between_fingers + finger_thick + spacer_between_fingers]) 
    finger_with_button_support ();

// touch fingers
    translate ([5, - 5, 0])
    rotate ([0, 0, -gripper_angle - 10]) 
    mirror([1, 0, 0])
    translate ([0, 0, gripper_lateral_sheet_size[2] + spacer_between_fingers + U_finger_thick + spacer_between_fingers ]) 
    fore_fingers();
    
    // second finger
        translate ([5, gripper_lateral_sheet_size[1] + 5, 0])
    rotate ([0, 0, gripper_angle + 180 - finger_angle]) 
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

gripper(-10);


//fore_fingers();  // 1x

//gripper_lateral_support(); // 1x

//gripper_lateral_support_with_ir_support(); // 1x

//U_pusher(); // 1x

//finger(); // 2x
//finger_with_button_support(); // 1x


//gripper_motor_support();//1x

//gripper_c920_support();