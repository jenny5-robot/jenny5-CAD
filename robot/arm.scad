include <params_arm.scad>

include <../basic_scad/params_stepper_motors.scad>

include <../basic_scad/params_basic_components.scad>
use <../basic_scad/basic_components.scad>
use <../basic_scad/stepper_motors.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_dc_motors.scad>
use <../basic_scad/dc_motors.scad>
use <../basic_scad/stepper_motors_housing.scad>
include <../basic_scad/params_motor_housing.scad>
use <../basic_scad/radial_bearing_housing.scad>
include <../basic_scad/config.scad>
include <../basic_scad/params_radial_bearings_housing.scad>
use <motor_plate.scad>
include <params_motor_plate.scad>
use <../basic_scad/functions_3d.scad>
use <../basic_scad/masa.scad>
use <../basic_scad/pulleys.scad>
use <../basic_scad/radial_bearings.scad>
use <../basic_scad/rings.scad>
use <../basic_scad/spacer.scad>
include <../basic_scad/params_sensor_array.scad>
use <../basic_scad/qtr_a1_support.scad>

use <gripper.scad>
use <gradient_support.scad>



//---------------------------------------------------------------------------
module bearing_support1()
{
    difference(){
      rbearing_608_vertical_housing_bounded_half();
      translate ([30, -2, 30]) rotate ([90, 0, 0]) cylinder_empty(5, 28, 25.2, 100);
    }
}
//---------------------------------------------------------------------------
module bearing_support1_with_qtr_a1_holes()
{
    difference(){
     bearing_support1();
        
        translate ([30, -2, 30])
        rotate([90, 0, 0]){
        // screw
            translate ([0, -QTR_1A_hole_position[0] - rb_608_external_radius, -6] - display_tolerance_z) cylinder (h = 10 + 2 * display_tolerance, r = 1, $fn = 20);
            // nuts
            translate ([0, -QTR_1A_hole_position[0] - rb_608_external_radius, -7]) cylinder (h = 3, r = m2_nut_radius + 0.3, $fn = 6);
         // QTR-1A connectors hole
            translate ([- QTR_1A_size[1] / 2 - 0.75, - rb_608_external_radius, -7] + [0, -QTR_1A_size[0], 0] - display_tolerance_z) cube([QTR_1A_size[1] + 1, 3.5, 10] + 2 * display_tolerance_z);
        }
    }
}
//---------------------------------------------------------------------------
module qtr_a1_support_with_screw_holes()
{

    difference (){
        union(){
          qtr_a1_support(10);
          translate([35, -30, 0]) rotate ([0, 0, 90]) 
            color (plastic_color) cube_rounded_x_holed_z([60, 70, 10], 29);
        }
        translate ([30, 30, 5] + display_tolerance_y) rotate([90, 0, 0]) cylinder (h = 60 + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        translate ([-30, 30, 5] + display_tolerance_y) rotate([90, 0, 0]) cylinder (h = 60 + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
    }
}
//---------------------------------------------------------------------------

module roata_reductor_motor()
{
    my_pulley(18);
}
//---------------------------------------------------------------------------
module roata_upper_arm()
{
  difference(){
    my_pulley(56, 30, 0, 0, 8, 0);
      // gaura surub
      cylinder (h = 6, r = m8_nut_radius, $fn = 6);
      // fereastra curea
      translate ([-20, 18+8, 0] - display_tolerance_z) cube([40, 10, 9] + 2 * display_tolerance_z);
      // gauri motor
      
      for (i=[0:3]){
          translate (nema_17_housing_base_holes[i] + [0, -0, 0] - display_tolerance_z) cylinder (h = 9 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
          translate (nema_17_housing_base_holes[i] + [0, -0, 4] - display_tolerance_z) cylinder (h = 9 + 2 * display_tolerance, r = m4_nut_radius, $fn = 6);
      }
  }
    
}
//---------------------------------------------------------------------------
module roata_upper_arm_cu_piese()
{
   roata_upper_arm(); 
    // belt
   // translate ([-5, 18, 0] - display_tolerance_z) cube([10, 10, 100] + 2 * display_tolerance_z);
    // carcasa motor
    translate ([-motor_housing_width / 2, 15, 0]) rotate ([0, 90, -90]) 
    nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 0);
}
//---------------------------------------------------------------------------
module roata_umar()
{
    /*
    color(plastic_color)
    render(){
        difference(){
            union(){
                cylinder(h = inaltime_roata_reductor_ax, r = 10, $fn = 40);
                translate ([0, 0, 10]) cylinder(h = inaltime_roata_reductor_ax - 10, r = radius, $fn = 40);
            }
            // ax
            translate ([-bone_thick / 2, -bone_thick / 2, 0] -display_tolerance_z) cube ([bone_thick, bone_thick, inaltime_roata_reductor_ax + 2 * display_tolerance]);
            // screw hole
            translate ([0, 0, 4]) rotate([0, 90, 45]) translate ([0, 0, -10])cylinder (h = 20, r = m3_screw_radius, $fn = 20);
    // canal curea
            translate([0, 0, 13]){
                rotate_extrude(convexity = 1, $fn = 50)
                    translate([radius + 3, 0, 0])
                        circle(r = 4, $fn = 30);
            }
        }
    }
    */
    my_pulley(21, 130, 7, 25, 8, 0);
}
//---------------------------------------------------------------------------
module roata_cot()
{
    /*
    color(plastic_color)
    difference(){
            cylinder(h = inaltime_roata_reductor_cot, r = radius_roata_reductor, $fn = 40);
        // gaura ax
        translate (-display_tolerance_z) cylinder(h = inaltime_roata_reductor_cot + 2 * display_tolerance, r = bearing_4_external_radius - 2, $fn = 20);

// gaura rulment
        translate ([0, 0, 2] - display_tolerance_z) cylinder(h = bearing_4_height, r = bearing_4_external_radius, $fn = 20);
// canal curea        
                translate([0, 0, inaltime_roata_reductor_cot / 2]){
            rotate_extrude(convexity = 1, $fn = 50)
                translate([radius_roata_reductor + 3, 0, 0])
                    circle(r = 4, $fn = 30);
        }
    }
    */
    difference(){
        union(){
            my_pulley(21, 130, 0, 0, 0, 0);
        //    translate ([0, 0, 9]) ring_with_flanges(rb_624_external_radius + 2, rb_624_external_radius + 0.1, 10);
        }
        translate ([0, 0, 0]) cylinder( h = rb_624_thick + 0.5, r = rb_624_external_radius, $fn = 50);
        translate ([0, 0, 0]) cylinder( h = rb_624_thick + 90, r = rb_624_external_radius - 1, $fn = 50);
        // tai gaura pt. curea
        translate ([dist_to_rotita_fore_arm + m8_nut_thick + rbearing_608_enclosed_housing_slim_size[1] - 0.7, -23, -1]) cube([13, 46, 20]);
        
        for (i= [0:1]){
            translate ([dist_to_rotita_fore_arm +14.5, (rbearing_608_enclosed_housing_slim_holes_position[0][0] - rbearing_608_enclosed_housing_slim_holes_position[1][0]) / 2 - rbearing_608_enclosed_housing_slim_holes_position[0][0], 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(rbearing_608_enclosed_housing_slim_holes_position[i]) cylinder (h = 30, r = 2, $fn = 30);
            translate ([dist_to_rotita_fore_arm + 37, (rbearing_608_enclosed_housing_slim_holes_position[0][0] - rbearing_608_enclosed_housing_slim_holes_position[1][0]) / 2 - rbearing_608_enclosed_housing_slim_holes_position[0][0], 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(rbearing_608_enclosed_housing_slim_holes_position[i]) cylinder (h = 30, r = 2, $fn = 20);
        }
        for (i= [0:3]){
            translate (nema_11_housing_base_holes[i])  cylinder (h = 30, r = m3_screw_radius, $fn = 20);      
            translate (nema_11_housing_base_holes[i] + [0, 0, 5])  cylinder (h = 40, r = m3_nut_radius, $fn = 6);      
        }
        // translate([-20, 0, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 20);
        // translate([-40, 0, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 20);
    }
    
}
//---------------------------------------------------------------------------
module roata_cot_cu_piese()
{
    roata_cot();
    translate ([8 + m8_nut_thick + rbearing_608_enclosed_housing_size[1], -24, 0]) rotate ([0, 90, 0]) mirror ([0, 0, 1]) nema_14_motor_housing(10, 0, 0);
    
   // translate ([-12, 0, -nema_11_width / 2 - 3]) rotate ([0, 90, 0]) 
   // nema_11();
    
    /*
        distance_between_centers = 20 + nema_11_width / 2 + 3;
    translate ([0, -rbearing_608_enclosed_housing_size[0] / 2 - distance_between_centers / 2, -2 * rb_608_external_radius - 4]) radial_bearing_608_vertical_housing();

    translate ([13 + rbearing_608_enclosed_housing_size[1], -rbearing_608_enclosed_housing_size[0] / 2 - distance_between_centers / 2, -2 * rb_608_external_radius - 4]) radial_bearing_608_vertical_housing();
    */
}
//---------------------------------------------------------------------------
module forearm_bone()
{
    color (aluminium_color) cube([bone_thick, bone_thick, fore_arm_length]);
}
//---------------------------------------------------------------------------
module roata_forearm()
{
    difference(){
        pulley_base_height = 2;
    my_pulley(16, 49, pulley_base_height, 15, 8);
         // gaura fi 12
        //cylinder (h = 10, r = 6, $fn = 50);
        // surub M3
        
        translate ([0, 0, 5 + pulley_base_height]) rotate ([-90, 0, 0]) cylinder (h = 40, r = 1.5, $fn = 20);
        // gaura cap surub M3
        translate ([0, 15, 4.5 + pulley_base_height]) rotate ([-90, 0, 0]) cylinder (h = 40, r = m3_nut_radius, $fn = 20);
        
        // gaura piulitza M3
        hull(){
            translate ([0, 10, 0]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick, r = m3_nut_radius, $fn = 6);
            translate ([0, 10, 9 + pulley_base_height]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick, r = m3_nut_radius, $fn = 6);
        }

    }
}
//---------------------------------------------------------------------------
module fore_arm()
{
// ax
    translate ([-bone_thick / 2, -bone_thick / 2, m8_nut_thick + rb_608_thick + washer_8_thick + 9 + 2 + 2 * washer_8_thick + rb_608_thick + washer_8_thick]) forearm_bone();
    // surub M8
    translate ([0, 0, 0]) M8x50_hexa();
    // 608 bearing
    translate ([0, 0, m8_nut_thick]) 608rs();
    // roata dintata
    translate ([0, 0, m8_nut_thick + rb_608_thick + washer_8_thick]) roata_forearm();
    // 608 bearing
    translate ([0, 0, m8_nut_thick + rb_608_thick + washer_8_thick + 9 + 2 + 2 * washer_8_thick]) 608rs();
   // first bearing housing 
    translate ([rbearing_608_enclosed_housing_slim_size[2] - rb_608_external_radius, rbearing_608_enclosed_housing_slim_size[0]/2, m8_nut_thick - radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime]) rotate ([90, 0, 0])rotate ([0, -90, 0]) radial_bearing_608_vertical_housing_slim();

    translate ([rbearing_608_enclosed_housing_slim_size[2] - rb_608_external_radius, rbearing_608_enclosed_housing_slim_size[0]/2, m8_nut_thick + rb_608_thick + washer_8_thick + 9 + 2 + 2 * washer_8_thick - radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime]) rotate ([90, 0, 0])rotate ([0, -90, 0]) radial_bearing_608_vertical_housing_slim();

translate ([-rb_608_external_radius - 9, 0, -11]) rotate ([0, 90,0]) rotate([0, 0, 180]) roata_cot_cu_piese();
    
    // gripper
    translate ([0, 0, fore_arm_length + bone_thick + inaltime_roata_reductor_cot + 3]) gripper();
    
}
//---------------------------------------------------------------------------
module fore_arm_cu_roata_cot()
{
    translate ([9 + rb_608_external_radius, 0, dist_to_rotita_fore_arm]) fore_arm();
        // roata cot
    translate ([0, 0, 0]) rotate ([-180, 0, 0]) rotate ([0, 90, 0]) roata_cot_cu_piese();
}
//---------------------------------------------------------------------------
module upper_arm_bone()
{
    difference(){
        color (aluminium_color) cube([bone_thick, bone_thick, upper_arm_length]);
    }
}
//---------------------------------------------------------------------------
module upper_arm()
{
    // bone
   translate ([- bone_thick / 2, -150, -bone_thick / 2]) rotate ([90, 0, 0]) upper_arm_bone();
    
    // M8 screw
   translate ([0, 9, 0]) rotate ([90, 0, 0]) M8_hexa(150);
    
    // roata mare sus
    translate ([0, 9, 0]) rotate ([90, 0, 0]) roata_upper_arm_cu_piese(); 
    
    //motor rotatie cot
    translate ([0, nema_17_width / 2 + 9 + 3, -35]) nema_17();
    
    // roata reductie motor
    translate ([0, nema_17_width / 2 + 9 + 3, 33]) mirror([0, 0, 1])roata_reductor_motor();
    
    // forearm
    translate ([-bone_thick, -150 - upper_arm_length + 3 / 2 * bone_thick -10, -bone_thick / 2])  rotate([0, 0, angle_elbow]) rotate([0, 90, 0]) fore_arm();
}
//---------------------------------------------------------------------------
module shoulder_plate()
{
    difference(){
        echo("shoulder plate");
        echo(shoulder_plate_size=shoulder_plate_size);

        color (aluminium_color) cube(shoulder_plate_size);
        echo("motor housing holes:");
        for (i=[0:3]){
            echo([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - 22 - perete_motor_motor_housing, 0] - nema_17_housing_base_holes[i]);
        translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - 22 - perete_motor_motor_housing, 0] - nema_17_housing_base_holes[i] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        }
        echo("bearing housing holes:");
        for (i=[0:1]){
            echo(rbearing_608_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_608_enclosed_housing_holes_position[0][0] + rbearing_608_enclosed_housing_holes_position[1][0]) / 2, bone_thick, 0]);
            translate (rbearing_608_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_608_enclosed_housing_holes_position[0][0] + rbearing_608_enclosed_housing_holes_position[1][0]) / 2, bone_thick, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius);
        }
        for (i=[0:1])
            translate (rbearing_608_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_608_enclosed_housing_holes_position[0][0] + rbearing_608_enclosed_housing_holes_position[1][0]) / 2, bone_thick + 40, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius);
    }
}
//---------------------------------------------------------------------------
module shoulder()
{
    //plate
    shoulder_plate();
    
    // motor
    translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - nema_17_with_gearbox_height - perete_baza_motor_housing, -(nema_17_width / 2 + 3 + perete_baza_motor_housing +32)]) 
    rotate ([-90, 0, 0]) 
    nema_17_with_gearbox();
// motor gear for forearm  rotation
    translate ([shoulder_plate_size[0] / 2, (shoulder_plate_size[1] + 17), -(nema_17_width / 2 + 3 + perete_baza_motor_housing + 32)]) 
    rotate ([90, 0, 0]) 
    roata_reductor_motor();
    
    // motor housing
    translate ([shoulder_plate_size[0] / 2 + motor_housing_width / 2, latime_tabla_umar , 0]) 
    mirror([0, 0, 1])
    rotate ([0, -90, 90]) 
    nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 20);
    
    // bone support 1
    translate ([-rbearing_608_enclosed_housing_size[0] / 2 + shoulder_plate_size[0] / 2, 0, grosime_tabla_alu + 25]) 
    mirror([0, 0, 1])
    radial_bearing_608_vertical_housing();
    
    // bone support 2
    translate ([-rbearing_608_enclosed_housing_size[0] / 2 + shoulder_plate_size[0] / 2, shoulder_plate_size[1] - rbearing_608_enclosed_housing_size[1], grosime_tabla_alu + 25]) 
mirror([0, 0, 1])    
    radial_bearing_608_vertical_housing();
        
    // continuation with upper arm
    translate ([shoulder_plate_size[0]/ 2, shoulder_plate_size[1] + 7, rb_608_external_radius + grosime_tabla_alu]) rotate ([0, angle_fore_arm, 0]) upper_arm();    

}
//---------------------------------------------------------------------------
module plate_body_articulation()
{
    difference(){
        echo("Body plate size: ", plate_body_size);
        color (aluminium_color) cube(plate_body_size);
        // screws holes for body bone connection
        // rest of arms screws
        
        // motor housing screws
        for (i = [0:3]){
            translate ([plate_body_size[0] / 2, plate_body_size[1] - 18 - 3, 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(nema_17_housing_base_holes[i])  cylinder ( h = wall_thick_3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        }
        // 
    }
}
//---------------------------------------------------------------------------
module body_articulation()
{
    // plate
    plate_body_articulation();
    // motor
    translate ([plate_body_size[0] / 2, -nema_17_with_gearbox_height + plate_body_size[1] - 3, -nema_17_width / 2 - 3 - 25]) rotate ([-90, 0, 0]) nema_17_with_gearbox();
// motor housing
    translate ([plate_body_size[0] / 2 - nema_17_width / 2 - 2 , plate_body_size[1], 0]) 
      rotate ([90, 0, 0]) 
        rotate ([0, 0, -90])
          nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(20, 5);

    // motor gear
    
    translate ([plate_body_size[0] / 2, plate_body_size[1], -nema_17_width / 2 - 25 - 3]) rotate ([-90, 0, 0]) roata_reductor_motor();
      
    //support upper arm
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small[0] / 2 + 5 + plate_body_size[0] / 2, 5, 3])  rbearing_608_vertical_housing_bounded_half_small();
    
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small_top[0] / 2 + 5 + plate_body_size[0] / 2, 5, rbearing_608_vertical_housing_size_bounded_half_small[2] + rbearing_608_vertical_housing_size_bounded_half_small_top[2] + 3])  
   mirror ([0, 0, 1]) 
    rbearing_608_vertical_housing_bounded_half_small_top();
    
    translate ([35, plate_body_size[1] - 10 - 5, 30 + 3]) mirror ([0, 1, 0]) rotate([90, 0, 0]) qtr_a1_support_with_screw_holes();

            // axis
    translate ([35, -10, 30 + 3]) 
    rotate ([90, 0, 0]) 
    rotate ([0, 0, angle_shoulder]) 
    translate ([- bone_thick / 2, - bone_thick / 2, 0])
    color (aluminium_color) 
    cube([bone_thick, bone_thick, 80])
    ;  
        
    translate ([35, 73, 30 + 3]) 
      rotate ([90, 0, 0]) 
        rotate ([0, 0, angle_shoulder]) 
          gradient_support_with_screw(100);

// continuare  - upper arm
    translate ([35 + 10, -90, 30 + plate_body_size[2]]) 
      rotate ([0, angle_shoulder, 0]) 
        translate([bone_thick / 2, 0, + bone_thick / 2]) 
          rotate ([0, 0, 90]) 
    shoulder()
 ;
    
}
//---------------------------------------------------------------------------
//nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(20, 5);

//bearing_support1();

//bearing_support1_with_qtr_a1_holes();

//qtr_a1_support_with_screw_holes();


//roata_umar();


//translate ([-bone_thick / 2 - placa_trunchi_size[2], -placa_trunchi_size[1] / 2, 0]) rotate ([0, 90, 0]) 
body_articulation();

//plate_body_articulation();


//shoulder();
//upper_arm();

//roata_forearm();

//fore_arm();

//fore_arm_cu_roata_cot();

//roata_cot();

//roata_cot_cu_piese();

//roata_upper_arm();
//roata_upper_arm_cu_piese();

//plate_body_articulation();

//shoulder_plate();