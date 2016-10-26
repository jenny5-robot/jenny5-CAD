// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_stepper_motors.scad>

include <../basic_scad/params_basic_components.scad>
use <../basic_scad/basic_components.scad>
//use <../basic_scad/stepper_motors.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_dc_motors.scad>
use <../basic_scad/dc_motors.scad>
//use <../basic_scad/stepper_motors_housing.scad>
include <../basic_scad/params_motor_housing.scad>
use <../basic_scad/radial_bearing_housing.scad>
include <../basic_scad/config.scad>
include <../basic_scad/params_radial_bearings_housing.scad>


use <../basic_scad/functions_3d.scad>
use <../basic_scad/masa.scad>
use <../basic_scad/pulleys.scad>
use <../basic_scad/radial_bearings.scad>
use <../basic_scad/rings.scad>
use <../basic_scad/spacer.scad>

include <params_robot.scad>

include <params_leg.scad>
use <leg.scad>

include <params_base_platform.scad>
use <base_platform.scad>

use <head.scad>

include <params_body.scad>
use <body.scad>
   
//---------------------------------------------------------------------------
module body_with_head()
{
    body();
    // head
    translate ([0, -latura_L / 2 - 1, chest_height + 37]) mirror ([0, 1, 0]) head();
    // spacers for linking head with body
    translate ([29, -latura_L, chest_height + 30]) rotate ([0, 90, 0]) spacer_with_1_hole(30, 37, 11);
    translate ([-40, -latura_L, chest_height + 30]) rotate ([0, 90, 0]) spacer_with_1_hole(30, 37, 11);
}
//---------------------------------------------------------------------------
module head_body_foot()
{
    inaltime_long_leg = 2 * ((inaltime_os_picior - 2 * dist_to_incheietura) * cos(angle_knee) + (dist_to_incheietura_talpa + dist_to_incheietura_talpa_os));
    // body
    translate ([0, lungime_talpa - 40, inaltime_long_leg + 30])  body_with_head();
// legs
    long_leg_with_rotation_module();
 }
//---------------------------------------------------------------------------
module platform_foot()
{
    translate ([0, 0, base_platform_size[2]]) long_leg(angle_knee);
    // mobile platform
    translate ([-70, -base_platform_size[1] / 2, 0]) platform();
}
//---------------------------------------------------------------------------
module robot()
{
    inaltime_long_leg = 2 * ((inaltime_os_picior - 2 * dist_to_incheietura) * cos(angle_knee) + (dist_to_incheietura_talpa + dist_to_incheietura_talpa_os));
    
    echo(inaltime_long_leg = inaltime_long_leg);
    
    translate ([90, 0, inaltime_long_leg + 10]) rotate ([0, 0, 90]) body_with_head();
    platform_foot();
}
//---------------------------------------------------------------------------
module robot_with_kitchen_table()
{
    robot();
    translate ([0, 1000, 0]) masa_rotunda(750, 400);
}
//---------------------------------------------------------------------------

module gear_motor1()
{
    difference(){
      pulley(54, 32, 0, 0, 8, 4, 0, 0);// motor #1
        cylinder( h = 5, r = m8_nut_radius, $fn = 6);
    }
}
//---------------------------------------------------------------------------
//robot_with_kitchen_table();
robot();

//platform_foot();

//arm();

//body_with_head();

//belt_tensioner_base();

//motor_pulley();

//body();

//bone_body();

//clavicle();

//os_diafragma();
//os_diafragma_cu_piese();

//vertebral_column();