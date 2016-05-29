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
include <params_leg.scad>
use <table_robot.scad>
use <gripper.scad>
use <head.scad>


unghi_trunchi = 90;// -90...90
unghi_umar = -0; // -180... 0
unghi_fore_arm = 90; // - 180 ... 0
unghi_cot = 180; // -90, 0
unghi_rotatie_gripper = 0;
angle_knee = -20;



   motor_housing_tolerance = 10;
   motor_housing_tolerance_large = 20;

   lungime_tabla_umar = 90;
   latime_tabla_umar = 60;


   placa_trunchi_size = ([50, lungime_tabla_umar + 2 * distantor + 2 * rbearing_608_enclosed_housing_size[1], 3]);
echo(placa_trunchi_size = placa_trunchi_size);

   distanta_umar_trunchi = 140;


   motor_housing_width_with_tolerance = motor_housing_width + 2 * motor_housing_tolerance;

   
   tabla_umar_sizes = [lungime_tabla_umar, latime_tabla_umar, grosime_tabla_alu];
   
   coloana_vertebrala_size = [30, 30, chest_height - 2 * grosime_perete_L];
   
   echo(coloana_vertebrala_size=coloana_vertebrala_size);
   
   inaltime_platforma_mobila = 100;
   
   bone_trunchi_size = [10, 10, chest_height - 2 * grosime_perete_L - 2 * washer_8_thick -  2 * rb_608_thick];
   
   echo(bone_trunchi_size=bone_trunchi_size);
   dist_to_roatita_fore_arm = 12;

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
    /*
    color(plastic_color)
    render(){
        difference(){
            cylinder(h = inaltime_roata_reductor_motor, r = radius_roata_motor_reductor, $fn = 40);
            // ax motor
            translate (-display_tolerance_z) cylinder(h = 15 + 2 * display_tolerance, r = 2.5, $fn = 30);
            // screw hole
            translate ([0, 0, m3_nut_radius - 1]) rotate([0, 90, 0]) cylinder (h = radius_roata_motor_reductor, r = m3_screw_radius, $fn = 20);
            // nut hole
        hull(){
            translate ([2.5 + 1, 0, m3_nut_radius - 1]) rotate([0, 90, 0]) cylinder (h = m3_nut_thick, r = m3_nut_radius, $fn = 6);
                translate ([2.5 + 1, 0, 0]) rotate([0, 90, 0]) cylinder (h = m3_nut_thick, r = m3_nut_radius, $fn = 6);
        }
            translate([0, 0, 10]){
                rotate_extrude(convexity = 1, $fn = 50)
                    translate([9, 0, 0])
                        circle(r = 4, $fn = 30);
            }
        }
    }
    */
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
    // curea
    translate ([-5, 18, 0] - display_tolerance_z) cube([10, 10, 100] + 2 * display_tolerance_z);
    // carcasa motor
    translate ([-motor_housing_width / 2, 15, 0]) rotate ([0, 90, -90]) nema_17_motor_housing(0, 0, 0);
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
        translate ([dist_to_roatita_fore_arm + m8_nut_thick + rbearing_608_enclosed_housing_slim_size[1] - 0.7, -23, -1]) cube([13, 46, 20]);
        
        for (i= [0:1]){
            translate ([dist_to_roatita_fore_arm +14.5, (rbearing_608_enclosed_housing_slim_holes_position[0][0] - rbearing_608_enclosed_housing_slim_holes_position[1][0]) / 2 - rbearing_608_enclosed_housing_slim_holes_position[0][0], 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(rbearing_608_enclosed_housing_slim_holes_position[i]) cylinder (h = 30, r = 2, $fn = 30);
            translate ([dist_to_roatita_fore_arm + 37, (rbearing_608_enclosed_housing_slim_holes_position[0][0] - rbearing_608_enclosed_housing_slim_holes_position[1][0]) / 2 - rbearing_608_enclosed_housing_slim_holes_position[0][0], 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(rbearing_608_enclosed_housing_slim_holes_position[i]) cylinder (h = 30, r = 2, $fn = 20);
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
    cube([bone_thick, bone_thick, fore_arm_length]);
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
    translate ([9 + rb_608_external_radius, 0, dist_to_roatita_fore_arm]) fore_arm();
        // roata cot
    translate ([0, 0, 0]) rotate ([-180, 0, 0]) rotate ([0, 90, 0]) roata_cot_cu_piese();
}
//---------------------------------------------------------------------------
module upper_arm_bone()
{
    difference(){
        cube([bone_thick, bone_thick, upper_arm_length]);
    }
}
//---------------------------------------------------------------------------
module upper_arm()
{
    // bone
   translate ([- bone_thick / 2, -upper_arm_length, bone_thick / 2]) rotate ([-90, 0, 0]) upper_arm_bone();
    
    // M8 screw
   translate ([0, (9), 0]) rotate ([90, 0, 0]) M8x80_hexa();
    
    // roata mare sus
    translate ([0, 9, 0]) rotate ([90, 0, 0]) roata_upper_arm_cu_piese(); 
    
    //motor rotatie cot
    translate ([0, nema_17_width / 2 + 9 + 3, -35]) nema_17();
    
    // roata reductie motor
    translate ([0, nema_17_width / 2 + 9 + 3, 33]) mirror([0, 0, 1])roata_reductor_motor();
    
    // forearm
    translate ([0, - upper_arm_length + 3 / 2 * bone_thick, 0])  rotate([0, 0, unghi_cot]) rotate([0, 90, 0]) fore_arm();
}
//---------------------------------------------------------------------------
module tabla_umar()
{
    difference(){
        echo("TABLA UMAR");
        echo(tabla_umar_sizes=tabla_umar_sizes);

        // tai o gaura
        cube(tabla_umar_sizes);
        echo("gauri motor housing:");
        for (i=[0:3]){
            echo([tabla_umar_sizes[0] / 2, tabla_umar_sizes[1] - 22 - perete_motor_motor_housing, 0] - nema_17_housing_base_holes[i]);
        translate ([tabla_umar_sizes[0] / 2, tabla_umar_sizes[1] - 22 - perete_motor_motor_housing, 0] - nema_17_housing_base_holes[i] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        }
        echo("gauri prindere carcase rulmenti:");
        for (i=[0:1]){
            echo(rbearing_608_enclosed_housing_holes_position[i] + [tabla_umar_sizes[0] / 2 - (rbearing_608_enclosed_housing_holes_position[0][0] + rbearing_608_enclosed_housing_holes_position[1][0]) / 2, bone_thick, 0]);
            translate (rbearing_608_enclosed_housing_holes_position[i] + [tabla_umar_sizes[0] / 2 - (rbearing_608_enclosed_housing_holes_position[0][0] + rbearing_608_enclosed_housing_holes_position[1][0]) / 2, bone_thick, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius);
        }
        for (i=[0:1])
            translate (rbearing_608_enclosed_housing_holes_position[i] + [tabla_umar_sizes[0] / 2 - (rbearing_608_enclosed_housing_holes_position[0][0] + rbearing_608_enclosed_housing_holes_position[1][0]) / 2, bone_thick + 40, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius);
    }
}
//---------------------------------------------------------------------------
module umar()
{
    //tabla
    tabla_umar();
    
    // motor
    translate ([tabla_umar_sizes[0] / 2, latime_tabla_umar - nema_17_height - perete_baza_motor_housing, -(nema_17_width / 2 + 3 + perete_baza_motor_housing )]) 
    rotate ([-90, 0, 0]) 
    nema_17();
// roata motor rotatie forearm
    translate ([tabla_umar_sizes[0] / 2, (latime_tabla_umar + 17), -(nema_17_width / 2 + 3 + perete_baza_motor_housing + 5)]) 
    rotate ([90, 0, 0]) 
    roata_reductor_motor();
    
    // motor housing
    translate ([tabla_umar_sizes[0] / 2 + motor_housing_width / 2, latime_tabla_umar , 0]) 
    mirror([0, 0, 1])
    rotate ([0, -90, 90]) 
    nema_17_motor_housing(10, 0, 7);
    
inaltime_rb608 = 15;//19//rb_608_internal_radius + 10;//radial_bearing_housing_grosime_perete_lateral;
    // bone support
    translate ([tabla_umar_sizes[0] / 2, latime_tabla_umar - 34, grosime_tabla_alu]) 
    //rotate([90, 0, 0])
    radial_bearing_608_u_vertical_housing();
    
    
    translate ([tabla_umar_sizes[0] / 2, latime_tabla_umar - rbearing_608_enclosed_housing_size[1], grosime_tabla_alu]) 
    //rotate([90, 0, 0])
        radial_bearing_608_u_vertical_housing();
        
    // continuare cu upper arm
    translate ([tabla_umar_sizes[0]/ 2, latime_tabla_umar + 7, inaltime_rb608 + grosime_tabla_alu]) rotate ([0, unghi_fore_arm, 0]) upper_arm();    

}
//---------------------------------------------------------------------------
module tabla_articulatie_trunchi()
{
    difference(){
        echo("DIMENSIUNI PLACA TRUNCHI: ", placa_trunchi_size);
        translate ([0, 0, 3])
        mirror([0, 0, 1])
        L(placa_trunchi_size[1], 50, 50, 3);
        echo("GAURI PLACA TRUNCHI");
        // gauri surub 
        for (i=[0:1]){
            echo(rbearing_608_enclosed_housing_holes_position[i] + [-rbearing_608_enclosed_housing_size[0] / 2 + 47 / 2 + 3, 0, 0]);
            translate (rbearing_608_enclosed_housing_holes_position[i] + [-rbearing_608_enclosed_housing_size[0] / 2 + 47 / 2 + 3, 0, 0] - display_tolerance_z) cylinder (h = 4 + 2 * display_tolerance, r = m3_screw_radius, $fn = 40);
        }
        // the other side
        for (i=[0:1]){
            echo ([0, placa_trunchi_size[1], 0] + mirror_y(rbearing_608_enclosed_housing_holes_position[i] + [-rbearing_608_enclosed_housing_size[0] / 2 + 47 / 2 + 3, 0, 0]));
            translate ([0, placa_trunchi_size[1], 0]) translate (mirror_y(rbearing_608_enclosed_housing_holes_position[i] + [-rbearing_608_enclosed_housing_size[0] / 2 + 47 / 2 + 3, 0, 0]) - display_tolerance_z) cylinder (h = 4 + 2 * display_tolerance, r = m3_screw_radius, $fn = 40);
        }
        echo("GAURI PLACA TRUNCHI - prindere ax");
        // gauri prindere ax
        for (i=[0:1]){
            echo ([placa_trunchi_size[0] /2 + 3, placa_trunchi_size[1]/2, 0] + pozitie_gauri_trunchi[i]);
            translate ([placa_trunchi_size[0] /2 + 3, placa_trunchi_size[1]/2, 0] + pozitie_gauri_trunchi[i] - display_tolerance_z) cylinder (h = 4 + 2 * display_tolerance, r = m4_screw_radius, $fn = 40);
        }
        
        // gauri prindere carcasa motor
        echo("GAURI PLACA TRUNCHI - prindere motor");
       for (i=[0:3]){
            echo([nema_17_housing_base_holes[i][0], nema_17_housing_base_holes[i][1], 0] + [3 + 47 / 2, 25, 0]);
            translate ([0, placa_trunchi_size[1], 0] + [nema_17_housing_base_holes[i][0], -nema_17_housing_base_holes[i][1], 0] + [3 + 47 / 2, -25, 0] - display_tolerance_z) cylinder (h = 4 + 2 * display_tolerance, r = m4_screw_radius, $fn = 40);
        } 
    }
}
//---------------------------------------------------------------------------
module articulatie_trunchi()
{
    // tabla
    tabla_articulatie_trunchi();
    // motor
 //   translate ([rbearing_608_enclosed_housing_size[0] / 2 + 3 + 2, placa_trunchi_size[1] - nema_17_height - perete_baza_motor_housing, -nema_17_width / 2 - 3]) rotate ([90, 0, 0]) mirror ([0,0, 1]) nema_17();
// carcasa motor
    translate ([3, placa_trunchi_size[1], 0]) 
    rotate ([90, 0, 0]) 
    rotate ([0, 0, -90]) 
    
    nema_motor_housing(motor_housing_tolerance, 0, 0);

    // roata reductie motor
    
    translate ([rbearing_608_enclosed_housing_size[0] / 2 + 3 + 2, nema_17_shaft_length + placa_trunchi_size[1] - 8, -nema_17_width / 2 - 3]) rotate ([90, 0, 0]) roata_reductor_motor();
      
    
    //sustinere upper arm
   translate ([-rbearing_608_enclosed_housing_size[0] / 2 + 47 / 2 + 3, 0, placa_trunchi_size[2]])  radial_bearing_608_enclosed_housing(distanta_umar_trunchi, motor_housing_tolerance);
    translate ([-rbearing_608_enclosed_housing_size[0] / 2 + 47 / 2 + 3, placa_trunchi_size[1] - rbearing_608_enclosed_housing_size[1], placa_trunchi_size[2]])  radial_bearing_608_enclosed_housing(distanta_umar_trunchi, motor_housing_tolerance);

            // axis
    translate ([3 + 47 / 2, rbearing_608_enclosed_housing_size[1], distanta_umar_trunchi + placa_trunchi_size[2]]) rotate ([-90, 0, 0]) 
    rotate ([0, 0, unghi_umar]) 
    translate ([- bone_thick / 2, - bone_thick / 2, 0])
    cube([bone_thick, bone_thick, placa_trunchi_size[1] - 2 * rbearing_608_enclosed_housing_size[1]]);  
    echo("ax umar length = ", placa_trunchi_size[1] - 2 * rbearing_608_enclosed_housing_size[1]);
        //roata reductie
    translate ([rbearing_608_enclosed_housing_size[0] / 2 + 3 + 2, placa_trunchi_size[1] + inaltime_roata_reductor_ax + 1 , distanta_umar_trunchi + placa_trunchi_size[2]]) rotate ([-90, 0, 0]) mirror ([0,0,1]) rotate ([0, 0, unghi_umar]) roata_umar();

// continuare  - upper arm
    translate ([rbearing_608_enclosed_housing_size[0] / 2 + bone_thick / 2, rbearing_608_enclosed_housing_size[1] + distantor, distanta_umar_trunchi + placa_trunchi_size[2]]) 
    rotate ([0, unghi_umar, 0]) 
    translate([bone_thick / 2, 0, + bone_thick / 2]) 
    rotate ([0, 0, 90]) 
    umar();
}
//---------------------------------------------------------------------------
module coloana_vertebrala()
{
    //U(chest_height, latura_L, latura_L, grosime_tabla);
    cube_empty(coloana_vertebrala_size[0] - 3, coloana_vertebrala_size[0], coloana_vertebrala_size[2]);
}
//---------------------------------------------------------------------------
module brat()
{
// vertical axis
    translate ([0, 0, grosime_perete_L + washer_8_thick + rb_608_thick]) rotate ([0, 0, unghi_trunchi])  
    //cube([bone_thick, bone_thick, chest_height -latura_L + rbearing_6002_housing_size[2] + grosime_perete_L]);
    bone_trunchi();
        
    // roata reductie mare
    translate ([0, 0, 0]) rotate([0, 0, unghi_trunchi]) mirror ([0, 0, 1]) roata_umar();
    
    // continuare
    translate ([0, 0, chest_height / 2 + placa_trunchi_size[0] / 2 + 1.5]) rotate ([0, 0, unghi_trunchi]) translate ([-bone_thick / 2 - 3, -placa_trunchi_size[1] / 2, 0]) rotate ([0, 90, 0]) articulatie_trunchi();
}
//---------------------------------------------------------------------------
module os_clavicula()
{
    difference(){
        L(chest_length, latura_L / 2, latura_L, grosime_perete_L); 
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
        L(chest_length, latura_L / 2, latura_L, grosime_perete_L);
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
        
      translate ([grosime_tabla_alu + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, 0]) rotate ([0, 0, 90]) gauri_placa_motor(placa_motor_trunchi_size[0], placa_motor_trunchi_size[1], placa_motor_trunchi_size[2], 2, 2, 0, 0);
     
     echo("gauri_os_diafragma placa motor right = ");
        for (i = [0:4])
            echo([grosime_tabla_alu + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), 0] + rotate_z(90, pozitie_gauri_placa_motor[i]));
        
      translate ([grosime_tabla_alu + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), 0]) rotate ([0, 0, 90]) gauri_placa_motor(placa_motor_trunchi_size[0], placa_motor_trunchi_size[1], placa_motor_trunchi_size[2], 2, 2, 0, 0);
        

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
    translate ([grosime_tabla_alu + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, grosime_perete_L]) rotate ([0, 0, 90]) placa_motor_trunchi(motor_housing_tolerance);
  
    // roata reductie motor
    translate ([grosime_tabla_alu + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, -2]) mirror ([0, 0, 1]) roata_reductor_motor();
    
    // cealalta parte
    translate ([grosime_tabla_alu + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, rbearing_608_housing_size[2] + grosime_tabla_alu]) mirror ([0, 0, 1]) rbearing_608_housing_with_bearing();
    // motor
    translate ([grosime_tabla_alu + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), nema_17_height + grosime_perete_L + placa_motor_trunchi_size[2]]) mirror ([0, 0, 1]) nema_17();
    // intindere curea
    translate ([grosime_tabla_alu + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), grosime_perete_L]) rotate ([0, 0, 90]) placa_motor_trunchi(motor_housing_tolerance);
  
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
    translate ([-(chest_length / 2 -dist_edge_to_shaft), -(grosime_tabla_alu + rbearing_608_housing_size[0] / 2), 0]) brat();
    // brat drept
    translate ([chest_length / 2 - dist_edge_to_shaft, -(grosime_tabla_alu + rbearing_608_housing_size[0] / 2), 0]) mirror([1, 0, 0])  brat();
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
    translate ([0, lungime_talpa - 40, inaltime_long_leg + inaltime_platforma_mobila])  body_with_head();
// legs
    long_leg_with_rotation_module();
 }
//---------------------------------------------------------------------------
module robot()
{
    head_body_foot();
    
    lungime_platforma = 400;
    latime_platorma = 300;
    // platforma mobila
    translate ([-latime_platorma / 2, -lungime_platforma / 2, 0]) cube ([latime_platorma, lungime_platforma, inaltime_platforma_mobila]);
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
//robot();
body_with_head();

//gear_motor1();


//belt_tensioner_base();

//roata_reductor_motor();

//roata_umar();



//trunchi();

//brat();

//translate ([-bone_thick / 2 - placa_trunchi_size[2], -placa_trunchi_size[1] / 2, 0]) rotate ([0, 90, 0]) 
//articulatie_trunchi();


//umar();
//upper_arm();

//roata_forearm();

//fore_arm();

//fore_arm_cu_roata_cot();

//housing_rbearing_6002();

//placa_motor_trunchi(4);

//tabla_articulatie_trunchi();

//bone_trunchi();



//os_clavicula();

//os_diafragma();
//os_diafragma_cu_piese();

//roata_cot();

//roata_cot_cu_piese();

//roata_upper_arm();
//roata_upper_arm_cu_piese();

//coloana_vertebrala();

//tabla_umar();