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
use <../basic_scad/radial_bearings.scad>
use <../basic_scad/stepper_motors_housing.scad>
include <../basic_scad/params_motor_housing.scad>
use <../basic_scad/radial_bearing_housing.scad>
include <../basic_scad/config.scad>
include <../basic_scad/params_radial_bearings_housing.scad>

use <../basic_scad/functions_3d.scad>

include <../basic_scad/params_nuts_housing.scad>
use <../basic_scad/parametric_involute_gear_v5.0.scad>

include <params_leg.scad>

use <../basic_scad/linear_motors.scad>

include <../basic_scad/params_motor_housing.scad>

//-------------------------------------------------------
module sole_side()
{
//echo("distanta baza to gaura sustinere", grosime_placa_alu + dist_to_incheietura_talpa_motor);
    difference(){
        color (aluminium_color) cube(lateral_talpa_sizes);
     // hole first bone
        translate ([dist_to_first_bone, 0, dist_to_incheietura_talpa_motor] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
     // hole second bone
        translate ([dist_to_second_bone, 0, dist_to_incheietura_talpa_motor] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
        // hole spacer 1
        translate ([dist_to_first_spacer, 0, latime_teava / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
        // hole spacer 2
        translate ([dist_to_second_spacer, 0, latime_teava / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
     // hole second bone
        translate ([dist_to_push_motor_hole, 0, dist_to_incheietura_talpa_motor] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
        
        
    }
}

//-------------------------------------------------------
module knee_side()
{
//echo("distanta baza to gaura sustinere", grosime_placa_alu + dist_to_incheietura_talpa);
    difference(){
        // sheet
        color (aluminium_color) cube(knee_side_simple_sizes);
        // front hole bottom
        translate ([dist_to_first_bone, 0, 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = 4, $fn = 30);
        // front hole top
        translate ([dist_to_first_bone, 0, knee_side_simple_sizes[2] - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = 4, $fn = 30);
        // back hole bottom
        translate ([dist_to_second_bone, 0, 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = 4, $fn = 30);
        // back hole top
        translate ([dist_to_second_bone, 0, knee_side_simple_sizes[2] - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = 4, $fn = 30);
    }
}

//-------------------------------------------------------
module sole()
{
    translate ([0, - grosime_placa_alu -crotch_width / 2, 0]) sole_side();
    //translate ([-base_extension_tail - rb_608_external_radius, crotch_width / 2 + rb_608_thick, 40 - rb_608_external_radius - 6]) rotate ([90, 0, 0]) 608rs();

    translate ([0, crotch_width / 2, 0]) sole_side();
    
    difference(){
 union(){
        // first spacer
    color (aluminium_color) translate ([dist_to_first_spacer - latime_teava / 2, - crotch_width / 2, 0]) cube([latime_teava, crotch_width, latime_teava]);
    // second sapcer
    color (aluminium_color) translate ([dist_to_second_spacer - latime_teava / 2, - crotch_width / 2, 0]) cube([latime_teava, crotch_width, latime_teava]);
 }
        // holes for fixing the bone to the platform
    
    for (i=[0:3])
        translate (foot_spacer_holes[i] - display_tolerance_z) cylinder (h = latime_teava + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
}
}

//----------------------------------------------------------------------
module knee()
{
    // one side
    translate ([0, - grosime_placa_alu, 0]) knee_side();
// other side
    translate ([0, crotch_width, 0]) knee_side();
    // knee spacer
     color (aluminium_color) translate ([knee_side_simple_sizes[0] / 2, -0, knee_side_simple_sizes[2] / 2]) rotate ([-90, 0, 0]) cylinder (h = crotch_width, r = 15 * sqrt(2), $fn = 4);
}
//----------------------------------------------------------------------
module leg_bone()
{
    difference(){ 
         //U(inaltime_os_picior, latura_U_mic, latura_U_mic, grosime_perete_L);
        
        color (aluminium_color) teava_dreptunghiulara(latime_teava, lungime_teava, grosime_perete_teava, inaltime_os_picior);

// gaura mijloc rulment jos
        
        echo ("gaura mijloc rulment jos", [latime_teava / 2, 0, dist_to_incheietura] + rbearing_608_housing_holes_position[0], "raza = 6");
        
        translate ([latime_teava / 2, 0, dist_to_incheietura] - display_tolerance_y) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0]) cylinder (h = latura_U_mare + 2 * display_tolerance, r = 4, $fn = 30); 


        for (i=[1:4]){
        echo ("gauri suruburi rulment jos", [latime_teava / 2, dist_to_incheietura, 0] + rbearing_608_housing_holes_position[i], "raza = 1.6");
            
            translate ([latime_teava / 2, 0, dist_to_incheietura] - display_tolerance_y) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) cylinder (h = lungime_teava + 2 * display_tolerance, r = 1.6, $fn = 30); 
        }
        
// gaura rulment sus
        translate ([latime_teava / 2, 0, inaltime_os_picior - dist_to_incheietura] - display_tolerance_y) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0]) cylinder (h = latura_U_mare + 2 * display_tolerance, r = 4, $fn = 30); 


        for (i=[1:4]){
        echo ("suruburi rulment sus", [latime_teava / 2, dist_to_incheietura, 0] + rbearing_608_housing_holes_position[i], "raza = 1.6");
            
            translate ([latime_teava / 2, 0, inaltime_os_picior - dist_to_incheietura] - display_tolerance_y) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) cylinder (h = lungime_teava + 2 * display_tolerance, r = 1.6, $fn = 30); 
        }

    // gaura rulment impingere
        
        echo ("push bearing middle hole", [latime_teava / 2, distance_to_push_nut, 0] + rbearing_608_housing_holes_position[0], "raza = 6");
        
        translate ([latime_teava / 2, 0, distance_to_push_nut] - display_tolerance_y) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0]) cylinder (h = latura_U_mare + 2 * display_tolerance, r = 10, $fn = 30); 


        for (i=[1:4]){
        echo ("push bearing nuts", [latime_teava / 2, distance_to_push_nut, 0] + rbearing_608_housing_holes_position[i], "raza = 1.6");
            
            translate ([latime_teava / 2, 0, distance_to_push_nut] - display_tolerance_y) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) cylinder (h = lungime_teava + 2 * display_tolerance, r = 1.6, $fn = 30); 
        }

        }
}
//----------------------------------------------------------------------
module leg_bone_with_bearings()
{
    leg_bone();

// push bearing    
    translate ([latime_teava / 2, 0, distance_to_push_nut]) rotate ([-90, 0, 0]) mirror([0, 0, 1]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
    
    translate ([latime_teava / 2, latime_teava + rbearing_608_housing_size[2], distance_to_push_nut]) rotate ([-90, 0, 0]) mirror([0, 0, 1]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
    
//base bearing

    translate ([latime_teava / 2, 0, rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) mirror([0, 0, 1]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
// screws for base bearings
    for (i=[1:4]){            
      translate ([latime_teava / 2, - rbearing_608_housing_size[2] - m4_nut_thick - washer_4_9_thick, dist_to_incheietura]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) M4x12_hexa();
    }

    
    translate ([latime_teava / 2, latime_teava, rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();

    // shaft
translate ([latime_teava / 2, -25, 14]) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0])
       color(shaft_color) cylinder (h = 80, r = raza_ax, $fn = 30); 
    // ax sus
translate ([latime_teava / 2, -25, inaltime_os_picior - 14]) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0]) 
        color(shaft_color) cylinder (h = 80, r = raza_ax, $fn = 30); 
}
//----------------------------------------------------------------------
module piesa_prindere_motor_de_ax()
{
    difference(){
        union(){
            my_cube_rounded2(piesa_prindere_motor_pe_ax_sizes);
        }
        hull(){
            // gaura ax
        translate ([piesa_prindere_motor_pe_ax_sizes[0] / 2, 0, piesa_prindere_motor_pe_ax_sizes[2]] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = piesa_prindere_motor_pe_ax_sizes[1] + 2 * display_tolerance, r = 3.7, $fn = 30);
        translate ([piesa_prindere_motor_pe_ax_sizes[0] / 2, 0, piesa_prindere_motor_pe_ax_sizes[2] - raza_ax] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = piesa_prindere_motor_pe_ax_sizes[1] + 2 * display_tolerance, r = 3.7, $fn = 30);
        }
        // gauri nema 17
        translate ([piesa_prindere_motor_pe_ax_sizes[0] / 2, piesa_prindere_motor_pe_ax_sizes[0] / 2, 0] - display_tolerance_z){
            // gauri suruburi
            for (i=[1:4])
              translate (gauri_nema_17[i]) cylinder (h = piesa_prindere_motor_pe_ax_sizes[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);
        
        }
        // gauri degajare
        translate ([piesa_prindere_motor_pe_ax_sizes[0], piesa_prindere_motor_pe_ax_sizes[0] / 2, 0] - display_tolerance_z){
            cylinder (h = piesa_prindere_motor_pe_ax_sizes[2] + 2 * display_tolerance, r = 10, $fn = 30);
        }        
        
    }
}
//----------------------------------------------------------------------
module oscior()
{
    difference(){ 
         //U(inaltime_os_picior, latura_U_mic, latura_U_mic, grosime_perete_L);
        
        color (aluminium_color) teava_dreptunghiulara(latime_teava, lungime_teava, grosime_perete_teava, inaltime_os_picior);
       dist_to_surub_oscior = 170;
        
        
// midle hole bottom bearing
        
        echo ("gaura mijloc rulment jos", [latime_teava / 2, 0, dist_to_incheietura] + rbearing_608_housing_holes_position[0], "raza = 6");
        
        translate ([latime_teava / 2, 0, dist_to_incheietura] - display_tolerance_y) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0]) cylinder (h = latura_U_mare + 2 * display_tolerance, r = 4, $fn = 30); 

// holes for fixing the bottom bearing
        for (i=[1:4]){
        echo ("gauri suruburi rulment jos", [latime_teava / 2, dist_to_incheietura, 0] + rbearing_608_housing_holes_position[i], "raza = 1.6");
            
            translate ([latime_teava / 2, 0, dist_to_incheietura] - display_tolerance_y) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) cylinder (h = lungime_teava + 2 * display_tolerance, r = 1.6, $fn = 30); 
        }
        
// top bearing hole
        translate ([latime_teava / 2, 0, inaltime_os_picior - dist_to_incheietura] - display_tolerance_y) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0]) cylinder (h = latura_U_mare + 2 * display_tolerance, r = 4, $fn = 30); 

// holes for fixing the top bearing
        for (i=[1:4]){
        echo ("suruburi rulment sus", [latime_teava / 2, dist_to_incheietura, 0] + rbearing_608_housing_holes_position[i], "raza = 1.6");
            
            translate ([latime_teava / 2, 0, inaltime_os_picior - dist_to_incheietura] - display_tolerance_y) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) cylinder (h = lungime_teava + 2 * display_tolerance, r = 1.6, $fn = 30); 
        }
    }
}
//----------------------------------------------------------------------
module oscior_cu_rulmenti()
{
  oscior();

  translate ([latime_teava / 2, 0, rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) mirror([0, 0, 1]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
// screws for bottom bearing    
            for (i=[1:4]){            
            translate ([latime_teava / 2, - rbearing_608_housing_size[2] - m4_nut_thick - washer_4_9_thick, dist_to_incheietura]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) M4x12_hexa();
        }

// the other side    
    translate ([latime_teava / 2, latime_teava, rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
            for (i=[1:4]){            
            translate ([latime_teava / 2, - rbearing_608_housing_size[2] - m4_nut_thick - washer_4_9_thick, dist_to_incheietura]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) M4x12_hexa();
        }
        
        
         translate ([latime_teava / 2, 0, inaltime_os_picior - rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) mirror([0, 0, 1]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
// screws for bottom bearing    
            for (i=[1:4]){            
            translate ([latime_teava / 2, - rbearing_608_housing_size[2] - m4_nut_thick - washer_4_9_thick, inaltime_os_picior - dist_to_incheietura]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) M4x12_hexa();
        }

    
    translate ([latime_teava / 2, latime_teava, inaltime_os_picior - rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
/*
    translate ([grosime_L_mic + rbearing_608_housing_size[2], dist_to_incheietura, dist_to_incheietura + grosime_L_mic]) rotate ([0, -90, 0]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();

    translate ([grosime_L_mic + rbearing_608_housing_size[2], inaltime_os_picior - dist_to_incheietura, dist_to_incheietura + grosime_L_mic]) rotate ([0, -90, 0]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
    
            for (i=[1:4]){
                //screws
          translate ([-m4_nut_thick, dist_to_incheietura, dist_to_incheietura + grosime_L_mic]) rotate ([0, 90, 0]) translate (rbearing_608_housing_holes_position[i]) M4x16_hexa(); 
          translate ([-m4_nut_thick, inaltime_os_picior - dist_to_incheietura, dist_to_incheietura + grosime_L_mic]) rotate ([0, 90, 0]) translate (rbearing_608_housing_holes_position[i]) M4x16_hexa(); 
// washers
          translate ([2 + rbearing_608_housing_size[2], dist_to_incheietura, dist_to_incheietura + grosime_L_mic]) rotate ([0, 90, 0]) translate (rbearing_608_housing_holes_position[i]) washer_4_9();      
          translate ([2 + rbearing_608_housing_size[2], inaltime_os_picior - dist_to_incheietura, dist_to_incheietura + grosime_L_mic]) rotate ([0, 90, 0]) translate (rbearing_608_housing_holes_position[i]) washer_4_9();      
                // nuts
          translate ([2 + rbearing_608_housing_size[2] + washer_4_thick, dist_to_incheietura, dist_to_incheietura + grosime_L_mic]) rotate ([0, 90, 0]) translate (rbearing_608_housing_holes_position[i]) M4_autolock_nut(); 
          translate ([2 + rbearing_608_housing_size[2] + washer_4_thick, inaltime_os_picior - dist_to_incheietura, dist_to_incheietura + grosime_L_mic]) rotate ([0, 90, 0]) translate (rbearing_608_housing_holes_position[i]) M4_autolock_nut(); 
    
        }
  */  
}
//----------------------------------------------------------------------
module sheet_push_motor()
{
    difference(){
        translate ([-nema_17_width / 2, -nema_17_width / 2, 0]) cube([nema_17_width, nema_17_width, 3]);
        for (i = [0:3]){
            translate (nema_17_housing_base_holes[i] - display_tolerance_z) cylinder ( h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
          }

    }
}
//----------------------------------------------------------------------
module leg_push_motor()
{
    // motor
    translate ([0, 0, 3 + rb_608_external_radius]) nema_17_with_13_1_gearbox_and_screw(200);
    // sheet
    translate ([0, 0, rb_608_external_radius]) sheet_push_motor();
    // radial bearing housing
    translate ([-rbearing_608_enclosed_housing_size[0] / 2, 0, - rb_608_external_radius - 3]) radial_bearing_608_vertical_housing();
    // radial bearing housing
    translate ([-rbearing_608_enclosed_housing_size[0] / 2, -rbearing_608_enclosed_housing_size[1], - rb_608_external_radius - 3]) radial_bearing_608_vertical_housing();
}
//----------------------------------------------------------------------
module half_leg(unghi)
{
    // bottom sheet
    sole();
    // bone 1
    translate ([dist_to_second_bone, crotch_width / 2 - latime_teava - rbearing_608_housing_size[2] - 5, dist_to_incheietura_talpa_os])
    rotate ([0, unghi, 0])
    translate ([-latime_teava / 2, 0, -dist_to_incheietura])
    oscior_cu_rulmenti();
    
    // bone 2
    translate ([dist_to_second_bone, - crotch_width / 2 + rbearing_608_housing_size[2] + 5, dist_to_incheietura_talpa_os])
    rotate ([0, unghi, 0])
    translate ([-latime_teava / 2, 0, -dist_to_incheietura])
    oscior_cu_rulmenti();
    

       // oscior 1
    translate ([dist_to_first_bone, crotch_width / 2 - latime_teava - rbearing_608_housing_size[2] - 5, dist_to_incheietura_talpa_os])
    rotate ([0, unghi, 0])
    translate ([-latime_teava / 2, 0, -dist_to_incheietura]) 
    leg_bone_with_bearings();
    
       // oscior 1
    translate ([dist_to_first_bone, - crotch_width / 2 + rbearing_608_housing_size[2] + 5, dist_to_incheietura_talpa_os])
    rotate ([0, unghi, 0])
    translate ([-latime_teava / 2, 0, -dist_to_incheietura]) 
    leg_bone_with_bearings();

    /*
    // bottom shaft
    translate([dist_to_incheietura, -20, dist_to_incheietura_talpa]) rotate ([-90, 0, 0]) cylinder (h = 90, r = raza_ax, $fn = 30);
    
    // ax jos prindere os
    translate([lungime_talpa - dist_to_incheietura, -20, dist_to_incheietura_talpa]) rotate ([-90, 0, 0]) cylinder (h = 90, r = raza_ax, $fn = 30);
*/

    // linear motor
    
    
    h = sin(90 - unghi) * (distance_to_push_nut - dist_to_incheietura);
    echo(h = h);
    d1 = cos(90 - unghi) * (distance_to_push_nut - dist_to_incheietura);
    echo(d1 = d1);
    d2 = dist_to_push_motor_hole - dist_to_first_bone - d1;
    echo(d2=d2);
    beta = atan(h / d2);
    
    //beta = atan(cos(-unghi) * dist_to_surub / ((lungime_talpa - 2 * dist_to_incheietura_talpa_motor) - sin (-unghi) * dist_to_surub) );
    echo(beta=beta);
    echo(dist_to_incheietura_talpa_motor = dist_to_incheietura_talpa_motor);
    if (d2 >= 0){
  translate([dist_to_push_motor_hole, 0, dist_to_incheietura_talpa_motor])
    rotate ([0, -(90 - beta), 0])
    leg_push_motor();
    }
    else
  translate([dist_to_push_motor_hole, 0, dist_to_incheietura_talpa_motor])
    rotate ([0, 90 + beta, 0])
    leg_push_motor();
        
    // piesa prindere motor
 //   translate([dist_to_motor, -piesa_prindere_motor_pe_ax_sizes[1] / 2 + latime_talpa / 2, dist_to_incheietura_talpa_motor + grosime_placa_alu])
   // rotate ([0, 90 -beta])
   // translate ([-piesa_prindere_motor_pe_ax_sizes[0] / 2, 0, -piesa_prindere_motor_pe_ax_sizes[2] + raza_ax]) piesa_prindere_motor_de_ax();
    

    
    // ax oscior sus
    /*
    translate([dist_to_oscior, -20, -dist_to_incheietura_talpa]) 
        translate ([(inaltime_os_picior - 2 * dist_to_incheietura) * sin(unghi), 
        0, 
        (inaltime_os_picior - 2 * dist_to_incheietura) * cos(unghi) + 2 * dist_to_incheietura_talpa - dist_to_incheietura + dist_to_incheietura])
        rotate ([-90, 0, 0]) cylinder (h = 90, r = raza_ax, $fn = 30);
        
            // ax oscior jos
    translate([dist_to_oscior, -20, dist_to_incheietura_talpa]) 
        rotate ([-90, 0, 0]) cylinder (h = 90, r = raza_ax, $fn = 30);
      */  
}
//----------------------------------------------------------------------
module long_leg(unghi)
{
    half_leg(unghi);
    //translate ([(inaltime_os_picior - 2 * dist_to_incheietura) * sin(unghi), 0, (inaltime_os_picior - 2 * dist_to_incheietura) * cos(unghi) + 2 * dist_to_incheietura_talpa - dist_to_incheietura + dist_to_incheietura]) 
    translate ([0, 0, 2 * ((inaltime_os_picior - 2 * dist_to_incheietura) * cos(unghi) + (dist_to_incheietura_talpa + dist_to_incheietura_talpa_os)) - 20]) 
    mirror ([0, 0, 1]) half_leg(unghi);
    
        // placa sus
    
    translate ([(inaltime_os_picior - 2 * dist_to_incheietura) * sin(unghi), 
    - crotch_width / 2, 
    (inaltime_os_picior - 2 * dist_to_incheietura) * cos(unghi) 
    + dist_to_incheietura_talpa - 8])
    knee();
    
}
//----------------------------------------------------------------------


//genunchi();

//roata_genunchi();
//roata_genunchi(360/33/2);

//    echo (placa_talpa_sizes = placa_talpa_sizes);

//sole();

//talpa_picior_jos_with_bearings();
//os_picior();
//os_picior_cu_bearings();
//half_leg(angle_knee);

//motor_cu_balama();

//oscior_cu_rulmenti();

long_leg(angle_knee);

//piesa_prindere_motor_de_ax();

//piesa_impingere();

//miez_piesa_impingere();