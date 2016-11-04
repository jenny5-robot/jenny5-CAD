// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_dc_motors.scad>
include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/dc_motors.scad>
use <../basic_scad/buttons.scad>
include <../basic_scad/params_buttons.scad>
include <../basic_scad/params_radial_bearings.scad>



include <params_gripper.scad>
include <params_general.scad>

cut_height = 6;

//---------------------------------------------------------
module motor_coupler()
{   
    difference(){
        cylinder(h = gripper_motor_coupler_height, r = gripper_motor_coupler_radius, $fn = 50);
        // M3 axis
        translate (-display_tolerance_z) cylinder(h = gripper_motor_coupler_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 50);
        // M4 axis
        translate ([0, 0, gripper_motor_coupler_height / 2]) cylinder(h = gripper_motor_coupler_height + 2 * display_tolerance, r = m5_screw_radius, $fn = 50);
        // M3 fixer
        // bottom
        translate ([0, 0, 4]) rotate ([0, 90, 0]) cylinder (h =  gripper_motor_coupler_radius, r = m3_screw_radius, $fn = 20);
        // bottom nut hole
        hull(){
          translate ([m4_screw_radius - 0.1, 0, 4]) rotate ([0, 90, 0]) cylinder (h =  m3_nut_thick, r = m3_nut_radius, $fn = 6);
          translate ([m4_screw_radius - 0.1, 0, 0]) rotate ([0, 90, 0]) cylinder (h =  m3_nut_thick, r = m3_nut_radius, $fn = 6);
        }
        // top screw hole
        translate ([0, 0, gripper_motor_coupler_height - 4]) rotate ([0, 90, 0]) cylinder (h = gripper_motor_coupler_radius, r = m3_screw_radius, $fn = 20);
        // top nut hole
        hull(){
          translate ([m5_screw_radius - 0.1, 0, gripper_motor_coupler_height - 4]) rotate ([0, 90, 0]) cylinder (h =  m3_nut_thick, r = m3_nut_radius, $fn = 6);
          translate ([m5_screw_radius - 0.1, 0, gripper_motor_coupler_height]) rotate ([0, 90, 0]) cylinder (h =  m3_nut_thick, r = m3_nut_radius, $fn = 6);
        }
    }
}
//---------------------------------------------------------
module connector_father(length, thick = 6)
{
    cut_tolerance = 1;
  difference(){
      union(){
        cube ([length, finger_height, thick]);
        // rounded margins
        translate ([0, 0, thick / 2]) rotate ([-90, 0, 0]) cylinder(h = finger_height, r = thick / 2, $fn = 30);
        translate ([length, 0, thick / 2]) rotate ([-90, 0, 0]) cylinder(h = finger_height, r = thick / 2, $fn = 30);
      }
      // screw holes
      // left
        translate ([0, 0, thick / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = finger_height + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);
      // right
        translate ([length, 0, thick / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = finger_height + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);
      // cut margins
      // left
      translate([- thick / 2, 0, 0] - display_tolerance_z - display_tolerance_y) cube([thick / 2 + cut_height, finger_height / 4 + cut_tolerance, thick] + display_tolerance_y + 2 * display_tolerance_z);
      translate([- thick / 2, 3 * finger_height / 4 - cut_tolerance, 0] - display_tolerance_z) cube([thick / 2 + cut_height, finger_height / 4 + cut_tolerance, thick] + display_tolerance_y + 2 * display_tolerance_z);
      
      // right
      translate([length - cut_height, 0, 0] - display_tolerance_z - display_tolerance_y) cube([thick / 2 + cut_height, finger_height / 4 + cut_tolerance, thick] + display_tolerance_y + 2 * display_tolerance_z);
      translate([length - cut_height, 3 * finger_height / 4 - cut_tolerance, 0] - display_tolerance_z) cube([thick / 2 + cut_height, finger_height / 4 + cut_tolerance, thick] + display_tolerance_y + 2 * display_tolerance_z);
    }
}
//---------------------------------------------------------
module connector_mother(length, left_side = true, right_side = true)
{
    difference(){
      union(){
        cube ([length, finger_height, finger_thick]);
        // rounded margins
        translate ([0, 0, finger_thick / 2]) rotate ([-90, 0, 0]) cylinder(h = finger_height, r = finger_thick / 2, $fn = 30);
        translate ([length, 0, finger_thick / 2]) rotate ([-90, 0, 0]) cylinder(h = finger_height, r = finger_thick / 2, $fn = 30);
      }
      if (left_side){
      // screw holes
      // left
        translate ([0, 0, finger_thick / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = finger_height + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);
      // cut left margin
      translate([- finger_thick / 2, finger_height / 4, 0] - display_tolerance_z) cube([finger_thick / 2 + cut_height, finger_height / 2, finger_thick] + 2 * display_tolerance_z);
      }
      if (right_side){
      // screw holes
      // right
        translate ([length, 0, finger_thick / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = finger_height + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);
      
      // cut margins
      // right
      translate([length - cut_height, finger_height / 4, 0] - display_tolerance_z) cube([finger_thick / 2 + cut_height, finger_height / 2, finger_thick] + + 2 * display_tolerance_z);
    }
    }
}
//---------------------------------------------------------
module gripper_base()
{
  union(){
    difference(){
      cube([gripper_base_length, finger_height, finger_thick]);
          // motor hole
     // translate ([gripper_base_length / 2, finger_height / 2, 0] - display_tolerance_z) cylinder (h = finger_thick - 2 + display_tolerance, r = motor_zga17_radius, $fn = 50);
          // motor shaft
      //translate ([gripper_base_length / 2, finger_height / 2, 0] - display_tolerance_z) cylinder (h = finger_thick + 2 * display_tolerance, r = 3.5, $fn = 50);
// screws
      translate ([gripper_base_length / 2 - motor_zga17_distance_between_screws / 2, finger_height / 2, 0] - display_tolerance_z) cylinder (h = finger_thick + 2 * display_tolerance, r = 1, $fn = 50);
      translate ([gripper_base_length / 2 + motor_zga17_distance_between_screws / 2, finger_height / 2, 0] - display_tolerance_z) cylinder (h = finger_thick + 2 * display_tolerance, r = 1, $fn = 50);
      }
      // walls
      translate ([finger_thick, 0, finger_thick - 0.01]) rotate ([0, -90, 0]) connector_mother(gripper_base_height, false, true);
      translate ([gripper_base_length, 0, finger_thick - 0.01]) rotate ([0, -90, 0]) connector_mother(gripper_base_height, false, true);
  }
}
//---------------------------------------------------------
module finger_base()
{
  difference(){
    connector_father(finger_base_length);
    translate ([finger_base_length / 2, finger_height / 2, 0] - display_tolerance_z) cylinder (h = finger_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
    translate ([finger_base_length / 2 - finger_thick / 2 - 0.25, 0, finger_thick - 1]) cube([finger_thick + 0.5, finger_height, 2]);  
  }
}
//---------------------------------------------------------
module finger_fixed()
{
  difference(){
    cube([finger_thick, finger_height, finger_length]);
    translate ([finger_thick / 2, finger_height / 2, 0]) cylinder (h = 20, r = 2, $fn = 20);   
  }
}
//---------------------------------------------------------
module finger_mobile_fixed_part()
{
  difference(){
      union(){
        cube([finger_thick, finger_height, finger_length]);
          translate ([3, 0, 20]) connector_father(8);
      }
      // hole for screw
     translate ([finger_thick / 2, finger_height / 2, 0]) cylinder (h = 20, r = 1.5, $fn = 20);
      // hole for nut
     hull(){
      translate ([0, finger_height / 2, 10]) cylinder (h = m3_nut_thick, r = m3_nut_radius, $fn = 6);
         translate ([finger_thick, finger_height / 2, 10]) cylinder (h = m3_nut_thick, r = m3_nut_radius, $fn = 6);
     }
      // hole for button
     translate ([0, finger_height / 2, finger_length - 8]) rotate ([0, 90, 0]) cylinder (h = finger_thick + 2 * display_tolerance, r = button_radius, $fn = 50);  
      // hole for button
     translate ([0, finger_height / 2, finger_length - 8]) rotate ([0, 90, 0]) cylinder (h = 4, r = button_large_radius, $fn = 50);  
     // cut margin for elastic string
     translate ([0, 0, 12]) rotate ([0, 90, 0]) cylinder (h = finger_thick, r = 5, $fn = 50);
     translate ([0, finger_height, 12]) rotate ([0, 90, 0]) cylinder (h = finger_thick, r = 5, $fn = 50);
  }
}
//---------------------------------------------------------
module finger_mobile_mobile_part(angle = 5)
{
  difference(){
    cube([finger_thick, finger_height, finger_length]);
      // hole for connector to fixed part
    translate ([0, finger_height / 4, 15]) cube([finger_thick, finger_height / 2, 10]);
      // hole for screw
      translate ([finger_thick / 2, 0, 20]) rotate ([-90, 0, 0]) cylinder (h = finger_height, r = 1.5, $fn = 20);
      // hole for push button
      translate ([0, finger_height / 2, finger_length - 10] -display_tolerance_x) rotate ([0, 90 - angle, 0]) cylinder (r = 6, h = 4 + display_tolerance);

     // cut margin for elastic string
     translate ([0, 0, 9]) rotate ([0, 90, 0]) cylinder (h = finger_thick, r = 5, $fn = 50);
     translate ([0, finger_height, 9]) rotate ([0, 90, 0]) cylinder (h = finger_thick, r = 5, $fn = 50);
  }
}
//---------------------------------------------------------
module finger_mobile(angle = 5)
{
    finger_mobile_fixed_part();
    translate ([finger_thick + 2, 0, 0]) 
    translate ([finger_thick / 2, 0, 23])
    rotate ([0, angle, 0]) translate ([-finger_thick / 2, 0, -20]) finger_mobile_mobile_part(angle);
    // button
    translate ([-button_length + 4 + 12, finger_height / 2, finger_length - 8]) rotate ([0, 90, 0]) button();
}
//---------------------------------------------------------
module finger_with_base()
{
  finger_base();
  translate ([finger_base_length / 2 - finger_thick / 2, 0, finger_thick]) finger_fixed();
}
//---------------------------------------------------------
module base_with_nut()
{
    moving_base_thick = 8;
    difference(){
      connector_father(moving_base_length, moving_base_thick);
        // screw hole
      translate ([moving_base_length / 2, finger_height / 2, 0] - display_tolerance_z) cylinder (h = moving_base_thick + 2 * display_tolerance, r = 2.5, $fn = 20);
        // nut hole
      hull(){
        translate ([moving_base_length / 2, finger_height / 2, moving_base_thick / 2 - m4_nut_thick / 2]) rotate ([0, 0, 30]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
        translate ([moving_base_length / 2, 0, moving_base_thick / 2 - m4_nut_thick / 2]) rotate ([0, 0, 30]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
      }
    }
}
//---------------------------------------------------------
module gripper()
{
    // motor
 //   translate ([gripper_base_length / 2, finger_height / 2, -motor_zga17_length + 4]) motor_zga17();
    
   // translate ([gripper_base_length / 2, finger_height / 2, finger_thick + 2]) motor_coupler();
    gripper_base();
    // finger left
    translate ([finger_thick / 2, 0, finger_thick / 2 + gripper_base_height]) finger_with_base();
    // conector left
    translate ([finger_base_length, 0, finger_thick + gripper_base_height]) rotate ([0, 90, 0]) connector_mother(finger_connector_length);
    // finger right
    translate ([gripper_base_length - finger_thick / 2 - finger_base_length, 0, finger_thick / 2 + gripper_base_height]) finger_with_base();
    // conector left
    translate ([gripper_base_length - finger_base_length - finger_thick, 0, finger_thick + gripper_base_height]) rotate ([0, 90, 0]) connector_mother(finger_connector_length);
    
    // base
    translate ([gripper_base_length / 2 - moving_base_length / 2, 0, gripper_base_height - finger_connector_length + finger_thick / 2 - 1])
    base_with_nut();
}
//---------------------------------------------------------
module gripper_motor_holder()
{
    grosime_perete = 3;
    
    lungime = grosime_perete + m4_nut_thick  + 1 + bone_thick + 1 + m4_nut_thick + grosime_perete + 2 * rb_624_external_radius;
    grosime = 15;
    latime = 23;
   
    difference(){
        union(){
            cube([lungime, latime, grosime]);
        }
        // bone hole
        translate([grosime_perete + m4_nut_thick, latime / 2 - bone_thick/2 - 0.2, 0] - display_tolerance_z) cube([bone_thick + 0.3, bone_thick + 2 * 0.2, grosime] + 2 * display_tolerance_z);
        // bearing hole
        translate([grosime_perete + m4_nut_thick  + 2 + bone_thick + 1 + rb_624_external_radius, latime / 2, 0] - display_tolerance_z) cylinder (h = rb_624_thick + display_tolerance, r = rb_624_external_radius, $fn = 50);        
        // gripper shaft hole
        translate([grosime_perete + m4_nut_thick  + 2 + bone_thick + 1 + rb_624_external_radius, latime / 2, 0] - display_tolerance_z) cylinder (h = grosime + 2 * display_tolerance, r = m6_screw_radius, $fn = 50);        
        // M4 bone screw hole
        translate([grosime_perete + m4_nut_thick + bone_thick / 2, 0, grosime / 2]) rotate([-90, 0, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 30);
        translate([grosime_perete + m4_nut_thick + bone_thick / 2, 2.5, grosime / 2]) rotate([-90, 0, 0]) rotate ([0, 0, 30]) cylinder (h = m4_nut_thick + 1, r = m4_nut_radius, $fn = 6);
        // M4 motor fixer screw hole
        translate([lungime - (m4_nut_thick + grosime_perete), latime / 2, grosime / 2] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 30);
        translate([lungime - (m4_nut_thick + grosime_perete), latime / 2, grosime / 2]) rotate([0, 90, 0]) cylinder (h = m4_nut_thick + 0.5, r = m4_nut_radius, $fn = 6);
    }
}
//---------------------------------------------------------------------------
module gripper_motor_holder_with_C920_holder()
{
    grosime_perete = 3;
    motor_diameter = 17.3;
    lungime_prindere_os = grosime_perete + m4_nut_thick  + 1 + bone_thick + motor_diameter + m4_nut_thick + grosime_perete;
     
    grosime = 20;
    latime = motor_diameter + 2 * grosime_perete;
    
    dist_between_holes = 64.25;

    lungime_holder = 75;
    
    lungime_ir = 45;
    grosime_ir = 13;
    
    grosime_gripper_holder = 15;
    
    dist_between_ir_holes = 37;

    union(){
      rotate ([0, 0, -90]) gripper_motor_holder();
        // ir suppport
        translate([-(lungime_ir - latime) / 2, -0.1, 0]) 
        difference(){
            
        cube([lungime_ir, grosime_ir, grosime_gripper_holder]);
// holes for fixing the camera
            translate ([lungime_ir / 2 - dist_between_ir_holes / 2, grosime_ir / 2, 0] - display_tolerance_z) cylinder (h = grosime_gripper_holder + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
            translate ([lungime_ir / 2 + dist_between_ir_holes / 2, grosime_ir / 2, 0] - display_tolerance_z) cylinder (h = grosime_gripper_holder + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        }
       
      translate([-(lungime_holder - latime) / 2, grosime_ir -0.1, 0]) 
        difference(){
            
        cube([lungime_holder, 3, grosime]);
// holes for fixing the camera
            translate ([lungime_holder / 2 - dist_between_holes / 2, 0, 7] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
            translate ([lungime_holder / 2 + dist_between_holes / 2, 0, 7] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        }
    }
}
//---------------------------------------------------------------------------




//connector_father(finger_connector_length);
//connector_mother(finger_connector_length); // 2x

//gripper();
//finger_mobile();

//base_with_nut(); // 1x
//finger_fixed(); // 1x
//finger_mobile_fixed_part(); // 1x
//finger_mobile_mobile_part(); // 1x
//finger_base(); // 2x
//gripper_base(); // 1x
//motor_coupler(); // 1x

gripper_motor_holder_with_C920_holder();

//gripper_motor_holder();