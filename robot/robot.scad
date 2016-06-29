// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_stepper_motors.scad>

include <../basic_scad/params_basic_components.scad>
use <../basic_scad/basic_components.scad>
use <../basic_scad/stepper_motors.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_dc_motor.scad>
use <../basic_scad/dc_motors.scad>
use <../basic_scad/stepper_motors_housing.scad>
include <../basic_scad/params_motor_housing.scad>
use <../basic_scad/radial_bearing_housing.scad>
include <../basic_scad/config.scad>
include <../basic_scad/params_radial_bearings_housing.scad>
use <../basic_scad/placa_motor.scad>
include <../basic_scad/params_placa_motor.scad>
use <../basic_scad/functions_3d.scad>
use <../basic_scad/masa.scad>
use <../basic_scad/pulleys.scad>
use <../basic_scad/radial_bearings.scad>
use <../basic_scad/rings.scad>
use <../basic_scad/spacer.scad>

include <params_robot.scad>
use <leg.scad>
include <params_table_robot.scad>
include <params_base_platform.scad>
include <params_leg.scad>
use <table_robot.scad>

use <head.scad>
use <base_platform.scad>

include <params_arm.scad>
use <arm.scad>

unghi_trunchi = 90;// -90...90
angle_knee = -60;

   motor_housing_tolerance = 10;
   motor_housing_tolerance_large = 20;



   motor_housing_width_with_tolerance = motor_housing_width + 2 * motor_housing_tolerance;
   
   coloana_vertebrala_size = [30, 30, chest_height - 2 * grosime_perete_L];
   
   
   inaltime_platforma_mobila = 30;
   
   bone_trunchi_size = [10, 10, chest_height - 2 * grosime_perete_L - 2 * washer_8_thick -  2 * rb_608_thick];
   
   echo(bone_trunchi_size=bone_trunchi_size);


//---------------------------------------------------------------------------
module bone_trunchi()
{
    echo("gauri bone trunchi");
    difference(){
        cube_empty(bone_trunchi_size[0] - 4, bone_trunchi_size[1], bone_trunchi_size[2]);
        for (i=[0:1]){
            echo(chest_height / 2 + rotate_y (90, pozitie_gauri_trunchi[i])[2]);
            translate ([-bone_thick / 2, 0, (chest_height -latura_L + rbearing_6002_housing_size[2] + grosime_perete_L) / 2 + pozitie_gauri_trunchi[i][0]] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = bone_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        }
    }
}
//---------------------------------------------------------------------------

module roata_reductor_motor()
{
    my_pulley(18);
}
//---------------------------------------------------------------------------
module brat()
{
// vertical axis
    translate ([0, 0, grosime_perete_L + washer_8_thick + rb_608_thick]) rotate ([0, 0, unghi_trunchi])  
    //cube([bone_thick, bone_thick, chest_height -latura_L + rbearing_6002_housing_size[2] + grosime_perete_L]);
    color (aluminium_color) bone_trunchi();
        
    // roata reductie mare
    translate ([0, 0, 0]) rotate([0, 0, unghi_trunchi]) mirror ([0, 0, 1]) roata_umar();
    
    // continuare
    translate ([0, 0, chest_height / 2 + plate_body_size[0] / 2 + 1.5]) rotate ([0, 0, unghi_trunchi]) translate ([-bone_thick / 2 - 3, -5, 0]) rotate ([0, 90, 0]) body_articulation();
}
//---------------------------------------------------------------------------

module coloana_vertebrala()
{
    //U(chest_height, latura_L, latura_L, grosime_tabla);
    color (aluminium_color) cube_empty(coloana_vertebrala_size[0] - 3, coloana_vertebrala_size[0], coloana_vertebrala_size[2]);
}
//---------------------------------------------------------------------------
module os_clavicula()
{
    difference(){
        color (aluminium_color) L(chest_length, latura_L / 2, latura_L, grosime_perete_L); 
        echo("gauri_os_clavicula left = ");
        for (i = [0:4]){
            echo([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i]);
            translate ([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = grosime_perete_L + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        }
// gaura mare mijloc
            translate ([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0] - display_tolerance_z) cylinder(h = grosime_perete_L + 2 * display_tolerance, r = 11, $fn = 30);

        echo("gauri_os_clavicula right = ");
        for (i = [0:4]){
            echo([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i]);
        translate ([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = grosime_perete_L + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        }
// gaura mare mijloc
        translate ([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0] - display_tolerance_z) cylinder(h = grosime_perete_L + 2 * display_tolerance, r = 11, $fn = 30);
    }
    
    // carcasa sus - left
    translate ([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, grosime_tabla_alu + rbearing_608_housing_size[2]]) mirror ([0,0,1])rbearing_608_housing_with_bearing();
    
        // carcasa sus - right
    translate ([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, grosime_tabla_alu + rbearing_608_housing_size[2]]) mirror ([0,0,1])rbearing_608_housing_with_bearing();
}
//---------------------------------------------------------------------------
module os_diafragma()
{
    difference(){
        color (aluminium_color) L(chest_length, latura_L / 2, latura_L, grosime_perete_L);
        // gaura ax stanga
        echo("gauri_os_diafragma left = ");
        for (i = [0:4]){
            echo([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i]);
            translate ([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = grosime_perete_L + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        }
        // gaura ax dreapta
        echo("gauri_os_diafragma right = ");
        for (i = [0:4]){
            echo([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i]);
            translate ([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = grosime_perete_L + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        }
// gauri placa motor

echo("gauri_os_diafragma placa motor left = ");
        for (i = [0:4])
            echo([grosime_tabla_alu + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, 0] + rotate_z(90, pozitie_gauri_placa_motor[i]));
        
      translate ([grosime_tabla_alu + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, 0]) rotate ([0, 0, 90]) motor_plate_holes(placa_motor_trunchi_size[0], placa_motor_trunchi_size[1], placa_motor_trunchi_size[2], 2, 2, 0, 0);
     
     echo("gauri_os_diafragma placa motor right = ");
        for (i = [0:4])
            echo([grosime_tabla_alu + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), 0] + rotate_z(90, pozitie_gauri_placa_motor[i]));
        
      translate ([grosime_tabla_alu + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), 0]) rotate ([0, 0, 90]) motor_plate_holes(placa_motor_trunchi_size[0], placa_motor_trunchi_size[1], placa_motor_trunchi_size[2], 2, 2, 0, 0);
        

    }
}
//---------------------------------------------------------------------------
module os_diafragma_cu_piese()
{
    os_diafragma();
                // carcasa rulment
    translate ([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, rbearing_608_housing_size[2] + grosime_tabla_alu]) mirror ([0, 0, 1]) rbearing_608_housing_with_bearing();
    // motor
    translate ([grosime_tabla_alu + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, nema_17_height + grosime_perete_L + placa_motor_trunchi_size[2]]) mirror ([0, 0, 1]) nema_17();
    // intindere curea
    translate ([grosime_tabla_alu + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, grosime_perete_L]) rotate ([0, 0, 90]) motor_plate_belt_tensioner(motor_housing_tolerance);
  
    // roata reductie motor
    translate ([grosime_tabla_alu + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, -2]) mirror ([0, 0, 1]) roata_reductor_motor();
    
    // cealalta parte
    translate ([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, rbearing_608_housing_size[2] + grosime_tabla_alu]) mirror ([0, 0, 1]) rbearing_608_housing_with_bearing();
    // motor
    translate ([grosime_tabla_alu + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), nema_17_height + grosime_perete_L + placa_motor_trunchi_size[2]]) mirror ([0, 0, 1]) nema_17();
    // intindere curea
    translate ([grosime_tabla_alu + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), grosime_perete_L]) rotate ([0, 0, 90]) motor_plate_belt_tensioner(motor_housing_tolerance);
  
    // roata reductie motor
    translate ([grosime_tabla_alu + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), -2]) mirror ([0, 0, 1]) roata_reductor_motor();
    
}
//---------------------------------------------------------------------------
module trunchi()
{
    // left side
    // bottom L
    translate ([-chest_length / 2, 0, 0]) 
    rotate ([0, 0, -90]) 
    //mirror([0, 0, 1])
        os_diafragma_cu_piese();
    // top L
    translate ([-chest_length / 2, 0, chest_height]) rotate ([0, 0, -90]) 
    mirror([0, 0, 1])
    os_clavicula();

// coloana
    translate ([0, -coloana_vertebrala_size[1]/2 - grosime_perete_L, grosime_perete_L]) coloana_vertebrala();
    
// brat stang
    translate ([-(chest_length / 2 -dist_edge_to_shaft), -(grosime_tabla_alu + rbearing_608_housing_size[0] / 2), 0]) mirror([1, 0, 0]) brat();
    // brat drept
    translate ([chest_length / 2 - dist_edge_to_shaft, -(grosime_tabla_alu + rbearing_608_housing_size[0] / 2), 0]) brat();
}    
//---------------------------------------------------------------------------
module body_with_head()
{
    trunchi();
    // head
    translate ([0, -latura_L / 2 - 1, chest_height + 37]) mirror ([0, 1, 0]) head();
    // spacers for linking head with body
    translate ([29, -latura_L, chest_height + 30]) rotate ([0, 90, 0]) spacer_with_1_hole(30, 37, 11);
    translate ([-40, -latura_L, chest_height + 30]) rotate ([0, 90, 0]) spacer_with_1_hole(30, 37, 11);
}
//---------------------------------------------------------------------------
module long_leg_with_rotation_module()
{
    inaltime_long_leg = 2 * ((inaltime_os_picior - 2 * dist_to_incheietura) * cos(angle_knee) + 2 * dist_to_incheietura_talpa - dist_to_incheietura + dist_to_incheietura);

echo(inaltime_long_leg=inaltime_long_leg);
       // picioare
    translate ([latura_U_mare / 2, 0, inaltime_platforma_mobila]) rotate ([0, 0, 90]) long_leg(angle_knee);
    // motor rotatie trunchi

}
//---------------------------------------------------------------------------
module head_body_foot()
{
    inaltime_long_leg = 2 * ((inaltime_os_picior - 2 * dist_to_incheietura) * cos(angle_knee) + (dist_to_incheietura_talpa + dist_to_incheietura_talpa_os));
    // trunchi
    translate ([0, lungime_talpa - 40, inaltime_long_leg + 30])  body_with_head();
// legs
    long_leg_with_rotation_module();
 }
//---------------------------------------------------------------------------
module platform_foot()
{
    long_leg_with_rotation_module();
    // mobile platform
    translate ([-base_platform_size[1] / 2 - 20, 250, 0]) rotate([0, 0, -90]) platform();
}
//---------------------------------------------------------------------------
module robot()
{
    inaltime_long_leg = 2 * ((inaltime_os_picior - 2 * dist_to_incheietura) * cos(angle_knee) + (dist_to_incheietura_talpa + dist_to_incheietura_talpa_os));
    
    translate ([0, lungime_talpa - 40, inaltime_long_leg + 10]) body_with_head();
    platform_foot();
}
//---------------------------------------------------------------------------
module robot_with_kitchen_table()
{
    robot();
    translate ([0, 1000, 0]) masa_rotunda(750, 400);
}
//---------------------------------------------------------------------------
module belt_tensioner_bearing_holder(lungime, latime, grosime_perete)
{
    difference(){
        cube([lungime, latime, grosime_perete]);
        translate ([6, latime / 2, 0] - display_tolerance_z) cylinder(h = grosime_perete + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        translate ([lungime - 6, latime / 2, 0] - display_tolerance_z) cylinder(h = grosime_perete + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
    }
}
//---------------------------------------------------------------------------
module belt_tensioner_base()
{
    grosime_perete = 3;

    h = 13 - grosime_perete;
    lungime = h + grosime_perete + bone_thick + 3 + m4_nut_thick;
    grosime = 12;
    latime = bone_thick + 2 * grosime_perete;
    lungime_bearing_holder = 2 * washer_4_12_radius + latime + 2 * rb_624_external_radius;
    difference(){
        union(){
            cube([lungime, latime, grosime]);
            translate ([lungime -0.1, -lungime_bearing_holder / 2 + latime / 2, 0]) rotate ([90, 0, 90]) belt_tensioner_bearing_holder(lungime_bearing_holder, grosime, grosime_perete);
        }
        // gaura os
        translate([grosime_perete + m4_nut_thick, grosime_perete - 0.2, 0] - display_tolerance_z) cube([bone_thick + 3, bone_thick + 2 * 0.2, grosime] + 2 * display_tolerance_z);
        // gaura m4 screw
        translate([0, latime / 2, grosime / 2] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 30);
        translate([grosime_perete, latime / 2, grosime / 2]) rotate([0, 90, 0]) cylinder (h = 10, r = m4_nut_radius, $fn = 6);
    }
    
   // translate ([0, 30, 0]) belt_tensioner_bearing_holder(lungime_bearing_holder, grosime, grosime_perete);
}
//---------------------------------------------------------------------------
module gear_motor1()
{
    difference(){
      my_pulley(54, 32, 0, 18, 8, 0, angle = 20);// motor #1
        cylinder( h = 5, r = m8_nut_radius, $fn = 6);
    }
}
//---------------------------------------------------------------------------
//robot_with_kitchen_table();
robot();

//brat();

//body_with_head();

//gear_motor1();

//belt_tensioner_base();

//roata_reductor_motor();

//trunchi();

//housing_rbearing_6002();

//placa_motor_trunchi(4);

//tabla_articulatie_trunchi();

//bone_trunchi();

//os_clavicula();

//os_diafragma();
//os_diafragma_cu_piese();


//coloana_vertebrala();

