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
use <../basic_scad/belt.scad>



//---------------------------------------------------------------------------
module bearing_support1()
{
    difference(){
      rbearing_608_vertical_housing_bounded_half();
      translate ([30, -2, 30]) rotate ([90, 0, 0]) cylinder_empty(5, 28, 25.2, 100);
    }
}
//---------------------------------------------------------------------------
module motor_pulley()
{
    pulley_with_shaft(61, 10, 0, 0, 8, 3, 0, 0);
}
//---------------------------------------------------------------------------
module upper_arm_pulley()
{
  difference(){
    pulley_with_shaft(64, 29, 0, 0, 4, m8_nut_radius, m8_nut_thick);
      // screw hole
      cylinder (h = 6, r = m8_nut_radius, $fn = 6);
      // motor housing fixer holes
      
      for (i=[0:3]){
          translate (nema_17_housing_small_base_holes_position[i] + [0, -0, 0] - display_tolerance_z) cylinder (h = 9 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
          translate (nema_17_housing_small_base_holes_position[i] + [0, -0, 4] - display_tolerance_z) cylinder (h = 9 + 2 * display_tolerance, r = m4_nut_radius, $fn = 6);
      }
  }
    
}
//---------------------------------------------------------------------------
module upper_arm_motor_housing()
{
    nema_motor_housing_with_base_holes(0, 0, nema_17_width, nema_17_height, 40, nema_17_gearbox_motor_hole_radius, gearbox_nema_17_holes_position, 3, 13, nema_17_housing_small_base_holes_position);    
}
//---------------------------------------------------------------------------
module upper_arm_pulley_with_components()
{
   upper_arm_pulley(); 
    // carcasa motor
    translate ([-motor_housing_width / 2, upper_arm_motor_housing_shift, 0]) rotate ([0, 90, -90]) 
    upper_arm_motor_housing();
}
//---------------------------------------------------------------------------
module shoulder_pulley()
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
  //  pulley(21, 130, 0, 0, 8, );
}
//---------------------------------------------------------------------------
module elbow_pulley()
{
    difference(){
            pulley(65, 66, 0, 0, 0, 0);
     
// bearing     
        translate ([0, 0, 0]) cylinder( h = rb_626_thick + 0.5, r = rb_626_external_radius, $fn = 50);
        // bearing border
        translate ([0, 0, 0]) cylinder( h = rb_626_thick + 90, r = rb_626_external_radius - 1, $fn = 50);
        // cut hole for belt
        translate ([dist_to_rotita_fore_arm + m8_nut_thick + rbearing_608_enclosed_housing_slim_size[1] - 0.7, -23, -1]) cube([13, 46, 20]);
        // holes for fixing the forearm
        // first bearing
        for (i= [0:1]){
            translate ([dist_to_rotita_fore_arm + 14.5, (rbearing_608_enclosed_housing_slim_holes_position[0][0] - rbearing_608_enclosed_housing_slim_holes_position[1][0]) / 2 - rbearing_608_enclosed_housing_slim_holes_position[0][0], 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(rbearing_608_enclosed_housing_slim_holes_position[i]) cylinder (h = 30, r = 2, $fn = 30);
        // holes for fixing the forearm
        // second bearing
            translate ([dist_to_rotita_fore_arm + 37, (rbearing_608_enclosed_housing_slim_holes_position[0][0] - rbearing_608_enclosed_housing_slim_holes_position[1][0]) / 2 - rbearing_608_enclosed_housing_slim_holes_position[0][0], 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(rbearing_608_enclosed_housing_slim_holes_position[i]) cylinder (h = 30, r = 2, $fn = 20);
        }
        // holes for fixing the motor housing
        for (i= [0:3]){
            translate (nema_11_housing_base_holes[i])  cylinder (h = 30, r = m3_screw_radius, $fn = 20);      
            translate (nema_11_housing_base_holes[i] + [0, 0, 5])  cylinder (h = 40, r = m3_nut_radius, $fn = 6);      
        }
    }
    
}
//---------------------------------------------------------------------------
module elbow_pulley_with_components()
{
    // big pulley 
  elbow_pulley();
    
    // motor housing
  translate ([20 + 3, -nema_11_width / 2 - 2, 0]) rotate ([0, 90, 0]) mirror ([0, 0, 1]) nema_11_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 0);
    
    // stepper motor
 // translate ([-10 - 2 - nema_11_27_1_gearbox_length, 0, -nema_11_width / 2 - 3 - 15]) rotate ([0, 90, 0]) 
   // nema_11_with_27_1_gearbox();
    
    // motor pulley
  translate ([0, 0, -nema_11_width / 2 - 3 - 15]) rotate ([0, 90, 0]) 
    motor_pulley();
    
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
module forearm_pulley()
{
    difference(){
        pulley_base_height = 2;
    pulley(16, 49, pulley_base_height, 15, 4, 0, 0);
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
    translate ([0, 0, m8_nut_thick + rb_608_thick + washer_8_thick]) forearm_pulley();
    // 608 bearing
    translate ([0, 0, m8_nut_thick + rb_608_thick + washer_8_thick + 9 + 2 + 2 * washer_8_thick]) 608rs();
   // first bearing housing 
    translate ([rbearing_608_enclosed_housing_slim_size[2] - rb_608_external_radius, rbearing_608_enclosed_housing_slim_size[0]/2, m8_nut_thick - radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime]) rotate ([90, 0, 0])rotate ([0, -90, 0]) radial_bearing_608_vertical_housing_slim();
// second bearing housing
    translate ([rbearing_608_enclosed_housing_slim_size[2] - rb_608_external_radius, rbearing_608_enclosed_housing_slim_size[0]/2, m8_nut_thick + rb_608_thick + washer_8_thick + 9 + 2 + 2 * washer_8_thick - radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime]) rotate ([90, 0, 0])rotate ([0, -90, 0]) radial_bearing_608_vertical_housing_slim();

translate ([-rb_608_external_radius - 9, 0, -11]) rotate ([0, 90,0]) rotate([0, 0, 180]) elbow_pulley_with_components();
    
    // gripper
    translate ([0, 0, fore_arm_length + bone_thick + inaltime_roata_reductor_cot + 3]) gripper();
    
}
//---------------------------------------------------------------------------
module fore_arm_with_elbow_pulley()
{
    translate ([9 + rb_608_external_radius, 0, dist_to_rotita_fore_arm]) fore_arm();
        // roata cot
    translate ([0, 0, 0]) rotate ([-180, 0, 0]) rotate ([0, 90, 0]) elbow_pulley_with_components();
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
   translate ([0, 9, 0]) rotate ([90, 0, 0]) M8_hexa_screw(150);
    
    // gear with components
    translate ([0, 9, 0]) rotate ([90, 0, 0]) upper_arm_pulley_with_components(); 
    
    // stepper motor 
    translate ([0, nema_17_width / 2 + 9 + 3 + 15, -nema_17_with_5_1_gearbox_height + upper_arm_motor_housing_shift - 3]) nema_17_with_5_1_gearbox();
    
    // motor pulley
    // translate ([0, nema_17_width / 2 + 9 + 3, 33]) mirror([0, 0, 1])motor_pulley();
    
    // forearm
    translate ([0, -160 - upper_arm_length + 3 / 2 * bone_thick -10, -bone_thick / 2 + 15])  rotate([0, 0, angle_elbow]) rotate([0, 90, 0]) fore_arm();
    
    echo(upper_arm_motor_housing_shift + nema_17_gearbox_shaft_length - 5);
    // belt
    translate ([0, 9 + 3 + 15 + nema_17_width / 2, upper_arm_motor_housing_shift + nema_17_gearbox_shaft_length - 10]) rotate([0, 0, -90]) belt_on_2_pulleys(10, 52, upper_arm_length + 192, 5);
    
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
    translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - nema_17_with_13_1_gearbox_height - perete_baza_motor_housing, -(nema_17_width / 2 + 3 + perete_baza_motor_housing +32)]) 
    rotate ([-90, 0, 0]) 
    nema_17_with_13_1_gearbox();
// motor gear for forearm  rotation
    translate ([shoulder_plate_size[0] / 2, (shoulder_plate_size[1] + 17), -(nema_17_width / 2 + 3 + perete_baza_motor_housing + 32)]) 
    rotate ([90, 0, 0]) 
    motor_pulley();
    
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
module traction_pulley()
{
    pulley_with_shaft(60, 33, 0, 0, 8, 4, m8_nut_radius, m8_nut_height);
}
//---------------------------------------------------------------------------
module body_articulation()
{
    // plate
    plate_body_articulation();
    // motor
    translate ([plate_body_size[0] / 2, -nema_17_with_13_1_gearbox_height + plate_body_size[1] - 3, -nema_17_width / 2 - 3 - 25]) rotate ([-90, 0, 0]) nema_17_with_13_1_gearbox();
// motor housing
    translate ([plate_body_size[0] / 2 - nema_17_width / 2 - 2 , plate_body_size[1], 0]) 
      rotate ([90, 0, 0]) 
        rotate ([0, 0, -90])
          nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(20, 5);

    // motor pulley
    
    translate ([plate_body_size[0] / 2, plate_body_size[1], -nema_17_width / 2 - 25 - 3]) rotate ([-90, 0, 0]) motor_pulley();
      
    //support upper arm
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small[0] / 2 + 5 + plate_body_size[0] / 2, 5, 3])  rbearing_608_vertical_housing_bounded_half_small();
    
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small_top[0] / 2 + 5 + plate_body_size[0] / 2, 5, rbearing_608_vertical_housing_size_bounded_half_small[2] + rbearing_608_vertical_housing_size_bounded_half_small_top[2] + 3])  
   mirror ([0, 0, 1]) 
    rbearing_608_vertical_housing_bounded_half_small_top();
    

   translate ([-rbearing_608_vertical_housing_size_bounded_half_small[0] / 2 + 5 + plate_body_size[0] / 2, plate_body_size[1] - 5, 3])  rbearing_608_vertical_housing_bounded_half_small();
    
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small_top[0] / 2 + 5 + plate_body_size[0] / 2, plate_body_size[1] - 5, rbearing_608_vertical_housing_size_bounded_half_small[2] + rbearing_608_vertical_housing_size_bounded_half_small_top[2] + 3])  
   mirror ([0, 0, 1]) 
    rbearing_608_vertical_housing_bounded_half_small_top();
    
// screw for upper arm
    translate ([40, 73, 33 + 5]) 
    rotate ([90, 0, 0]) 
    rotate ([0, 0, angle_shoulder]) 
    translate ([- bone_thick / 2, - bone_thick / 2, 0])
    color (aluminium_color) 
    M8_hexa_screw(100);
    ;  

            // shaft
    translate ([35, -10, 30 + 3]) 
    rotate ([90, 0, 0]) 
    rotate ([0, 0, angle_shoulder]) 
    translate ([- bone_thick / 2, - bone_thick / 2, 0])
    color (aluminium_color) 
    cube([bone_thick, bone_thick, 80])
    ;  
       // pulley 
    translate ([35, 73, 30 + 3]) 
      rotate ([90, 0, 0]) 
        rotate ([0, 0, angle_shoulder]) 
          traction_pulley();

// upper arm
    translate ([35 + 10, -90, 30 + plate_body_size[2]]) 
      rotate ([0, angle_shoulder, 0]) 
        translate([bone_thick / 2, 0, + bone_thick / 2]) 
          rotate ([0, 0, 90]) 
    shoulder()
 ;
    
}
//---------------------------------------------------------------------------
body_articulation();

//nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(20, 5);

//bearing_support1();

//nema_11_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 0);

//shoulder_pulley();

//plate_body_articulation();


//shoulder();
//upper_arm();

//forearm_pulley();

//fore_arm();

//fore_arm_with_elbow_pulley();

//elbow_pulley();

//elbow_pulley_with_components();

//upper_arm_pulley();
//upper_arm_motor_housing();
//upper_arm_pulley_with_components();

//plate_body_articulation();

//shoulder_plate();

