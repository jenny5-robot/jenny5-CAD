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
include <../basic_scad/params_dc_motor.scad>
use <../basic_scad/stepper_motors_housing.scad>
include <../basic_scad/params_motor_housing.scad>
use <../basic_scad/radial_bearing_housing.scad>
include <../basic_scad/config.scad>
include <../basic_scad/params_radial_bearings_housing.scad>
use <../basic_scad/stepper_motors_utils.scad>

use <../basic_scad/functions_3d.scad>
use <../basic_scad/masa.scad>
include <../basic_scad/params_nuts_housing.scad>
use <../basic_scad/parametric_involute_gear_v5.0.scad>

include <params_leg.scad>


angle_knee = -10;

piesa_prindere_motor_pe_ax_sizes = [nema_17_width, nema_17_width, 10];

dist_to_oscior = dist_to_incheietura + 60;

grosime_L_mic = 3;

dist_to_piulitza_tractiune = 26;

piesa_impingere_sizes = [30, 30, 24];
lateral_talpa_motor_sizes = [30, grosime_placa_alu, grosime_placa_alu + dist_to_incheietura_talpa_motor + 10];
lateral_talpa_os_sizes = [30, grosime_placa_alu, grosime_placa_alu + dist_to_incheietura_talpa_os + 10];
lateral_talpa_simple_sizes = [30, grosime_placa_alu, grosime_placa_alu + dist_to_incheietura_talpa + 10];

lateral_genunchi_simple_sizes = [lungime_talpa, grosime_placa_alu, 60];

base_extension_tail = 70;
base_extension_head = 50;
lateral_talpa_sizes = [lungime_talpa + base_extension_tail + base_extension_head, grosime_placa_alu, 40];

//-------------------------------------------------------
module lateral_talpa()
{
echo("distanta baza to gaura sustinere", grosime_placa_alu + dist_to_incheietura_talpa_motor);
    difference(){
        color (aluminium_color) cube(lateral_talpa_sizes);
     // gaura prindere os
        translate ([lateral_talpa_motor_sizes[0] / 2 + base_extension_tail, 0, dist_to_incheietura_talpa_motor] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = 4, $fn = 30);
     // gaura prindere os 2
        translate ([lateral_talpa_sizes[0] - (lateral_talpa_motor_sizes[0] / 2 + base_extension_head), 0, dist_to_incheietura_talpa_motor] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = 4, $fn = 30);
        // gaura prindere distantor 1
        translate ([base_extension_tail + lungime_talpa / 2 - 23 + 15, 0, 15] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = 4, $fn = 30);
    }
}

//-------------------------------------------------------
module lateral_genunchi()
{
//echo("distanta baza to gaura sustinere", grosime_placa_alu + dist_to_incheietura_talpa);
    difference(){
        color (aluminium_color) cube(lateral_genunchi_simple_sizes);
        translate ([lateral_talpa_os_sizes[0] / 2, 0, 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = 4, $fn = 30);
        translate ([lateral_talpa_os_sizes[0] / 2, 0, lateral_genunchi_simple_sizes[2] - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = grosime_placa_alu + 2 * display_tolerance, r = 4, $fn = 30);
    }
}

//-------------------------------------------------------
module talpa_picior_motor()
{
    translate ([-base_extension_tail, - grosime_placa_alu, 0]) lateral_talpa();
    translate ([-base_extension_tail - rb_608_external_radius, latime_talpa + rb_608_thick, 40 - rb_608_external_radius - 6]) rotate ([90, 0, 0]) 608rs();

    translate ([-base_extension_tail, latime_talpa, 0]) lateral_talpa();
    
    // distantor mijloc
    color (aluminium_color) translate ([lungime_talpa / 2 - 23, 0, 0]) cube([30, latime_talpa, 30]);
    //distantor fatza
    color (aluminium_color) translate ([lungime_talpa + base_extension_head - 30, 0, 0]) cube([30, latime_talpa, 30]);
}

//----------------------------------------------------------------------
module genunchi()
{
    translate ([0, - grosime_placa_alu, 0]) lateral_genunchi();

    translate ([0, latime_talpa, 0]) lateral_genunchi();
    
     color (aluminium_color) translate ([lateral_genunchi_simple_sizes[0] / 2, -0, lateral_genunchi_simple_sizes[2] / 2]) rotate ([-90, 0, 0]) cylinder (h = latime_talpa, r = 15 * sqrt(2), $fn = 4);
}
//----------------------------------------------------------------------
module os_picior()
{
    difference(){ 
         //U(inaltime_os_picior, latura_U_mic, latura_U_mic, grosime_perete_L);
        
        color (aluminium_color) teava_dreptunghiulara(latime_teava, lungime_teava, grosime_perete_teava, inaltime_os_picior);
       
        // gaura ax impins de motor
        pas_gauri = 16;
        for (i=[-1:1]){
          translate ([0, latime_teava / 2, dist_to_surub + dist_to_incheietura - pas_gauri * i] - display_tolerance_x) rotate ([0, 90, 0])cylinder (h = latime_teava + 2 * display_tolerance, r = 10, $fn = 50);
          echo("gaura impins ax motor", [dist_to_surub + dist_to_incheietura - pas_gauri * i, latime_teava / 2, 0]);
        }
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
        
        echo ("gaura mijloc rulment impingere", [latime_teava / 2, dist_to_surub + dist_to_incheietura, 0] + rbearing_608_housing_holes_position[0], "raza = 6");
        
        translate ([latime_teava / 2, 0, dist_to_surub + dist_to_incheietura] - display_tolerance_y) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0]) cylinder (h = latura_U_mare + 2 * display_tolerance, r = 10, $fn = 30); 


        for (i=[1:4]){
        echo ("suruburi rulment impingere", [latime_teava / 2, dist_to_surub + dist_to_incheietura, 0] + rbearing_608_housing_holes_position[i], "raza = 1.6");
            
            translate ([latime_teava / 2, 0, dist_to_surub + dist_to_incheietura] - display_tolerance_y) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) cylinder (h = lungime_teava + 2 * display_tolerance, r = 1.6, $fn = 30); 
        }

        }
}
//----------------------------------------------------------------------
module os_picior_cu_bearings()
{
    os_picior();

// tractiune    
    translate ([latime_teava / 2, 0, dist_to_surub + dist_to_incheietura]) rotate ([-90, 0, 0]) mirror([0, 0, 1]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
    
    translate ([latime_teava / 2, latime_teava + rbearing_608_housing_size[2], dist_to_surub + dist_to_incheietura]) rotate ([-90, 0, 0]) mirror([0, 0, 1]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
    
//rulment baza

    translate ([latime_teava / 2, 0, rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) mirror([0, 0, 1]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
// suruburi prindere rulment baza    
            for (i=[1:4]){            
            translate ([latime_teava / 2, - rbearing_608_housing_size[2] - m4_nut_thick - washer_4_9_thick, dist_to_incheietura]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) M4x12_hexa();
        }

    
    translate ([latime_teava / 2, latime_teava, rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();

    // ax jos
translate ([latime_teava / 2, -25, 14]) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0])
       color(shaft_color) cylinder (h = 80, r = raza_ax, $fn = 30); 
    // ax sus
translate ([latime_teava / 2, -25, inaltime_os_picior - 14]) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0]) 
        color(shaft_color) cylinder (h = 80, r = raza_ax, $fn = 30); 
/*
// piesa prindere ax motor
translate ([dist_to_surub + dist_to_incheietura, 4, dist_to_piulitza_tractiune]) 
        translate (rbearing_608_housing_holes_position[0]) 
    piesa_impingere();
*/
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
        
        // gaura ax impins de motor
        pas_gauri = 16;
        for (i=[-1:1]){
          translate ([0, latime_teava / 2, dist_to_surub_oscior + dist_to_incheietura - pas_gauri * i] - display_tolerance_x) rotate ([0, 90, 0])cylinder (h = latime_teava + 2 * display_tolerance, r = 10, $fn = 50);
          echo("gaura impins ax motor", [dist_to_surub_oscior + dist_to_incheietura - pas_gauri * i, latime_teava / 2, 0]);
        }
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
    }
}
//----------------------------------------------------------------------
module oscior_cu_rulmenti()
{
    oscior();
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
module motor_cu_balama()
{
    tabla_motor_sizes = [2 * nema_17_motor_gearbox_radius, 50, 3];
    
    nema_17_with_gearbox_and_screw(110);
  
  translate ([-tabla_motor_sizes[0] / 2, -tabla_motor_sizes[1] / 2, nema_17_height + nema_17_gearbox_base_height + nema_17_gearbox_length]) cube(tabla_motor_sizes);
    // ax balama
    //translate ([tabla_motor_sizes[0] / 2 - 10, -tabla_motor_sizes[1] / 2, nema_17_height + nema_17_gearbox_base_height + nema_17_gearbox_length + tabla_motor_sizes[2]]) cube([10, tabla_motor_sizes[1], 10]);
    
    
}
//----------------------------------------------------------------------
module leg(unghi)
{
    // placa jos
    talpa_picior_motor();
    // os
    translate ([lungime_talpa - latime_teava / 2, (latime_talpa - latime_teava) / 2, dist_to_incheietura_talpa_os]) 
    
    rotate ([0, unghi, 0]) 
    translate ([-latime_teava / 2, 0, -dist_to_incheietura])
    
    oscior();
    
       // oscior
    translate ([latime_teava / 2, (latime_talpa - latime_teava) / 2, dist_to_incheietura_talpa])     
    rotate ([0, unghi, 0]) 
    translate ([-latime_teava / 2, 0, -dist_to_incheietura]) 
    os_picior_cu_bearings();
    
    /*
    // ax jos
    translate([dist_to_incheietura, -20, dist_to_incheietura_talpa]) rotate ([-90, 0, 0]) cylinder (h = 90, r = raza_ax, $fn = 30);
    
    // ax jos prindere os
    translate([lungime_talpa - dist_to_incheietura, -20, dist_to_incheietura_talpa]) rotate ([-90, 0, 0]) cylinder (h = 90, r = raza_ax, $fn = 30);
*/

    // motor
    h1 = sin(90-unghi) * dist_to_surub;
    h2 = h1 + (dist_to_incheietura_talpa_motor - (40 - rb_608_external_radius - 6));
    echo(h2=h2);
    d1a = cos(90-unghi) * dist_to_surub;
    echo(d1a=d1a);
    d1b = (rb_608_external_radius + base_extension_tail + 15) - d1a;
    echo(d1b=d1b);
    beta = 90-atan(h2 / d1b);
    
    //beta = atan(cos(-unghi) * dist_to_surub / ((lungime_talpa - 2 * dist_to_incheietura_talpa_motor) - sin (-unghi) * dist_to_surub) );
    echo(beta=beta);
    //beta = -unghi;
    
  translate([-base_extension_tail - rb_608_external_radius, 0, 40 - rb_608_external_radius - 6])
    rotate ([0, 90 - beta, 0])
  translate([0, latime_talpa / 2, -nema_17_with_gearbox_height + 10 + 3])
    motor_cu_balama();
    
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
    leg(unghi);
    //translate ([(inaltime_os_picior - 2 * dist_to_incheietura) * sin(unghi), 0, (inaltime_os_picior - 2 * dist_to_incheietura) * cos(unghi) + 2 * dist_to_incheietura_talpa - dist_to_incheietura + dist_to_incheietura]) 
    translate ([0, 0, 2 * ((inaltime_os_picior - 2 * dist_to_incheietura) * cos(unghi) + (dist_to_incheietura_talpa + dist_to_incheietura_talpa_os)) - 20]) 
    mirror ([0, 0, 1]) leg(unghi);
    
        // placa sus
    
    translate ([(inaltime_os_picior - 2 * dist_to_incheietura) * sin(unghi), 
    0, 
    (inaltime_os_picior - 2 * dist_to_incheietura) * cos(unghi) 
    + dist_to_incheietura_talpa - 8])
    genunchi();
    
}
//----------------------------------------------------------------------


//genunchi();

//roata_genunchi();
//roata_genunchi(360/33/2);

//    echo (placa_talpa_sizes = placa_talpa_sizes);

//talpa_picior_motor();

//talpa_picior_jos_with_bearings();
//os_picior();
//os_picior_cu_bearings();
//leg(angle_knee);

//motor_cu_balama();

//oscior_cu_rulmenti();

long_leg(angle_knee);

//piesa_prindere_motor_de_ax();

//piesa_impingere();

//miez_piesa_impingere();