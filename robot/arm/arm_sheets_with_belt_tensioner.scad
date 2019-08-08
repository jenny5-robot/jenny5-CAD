// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT
//--------------------------------------------------------------

include <arm_params.scad>
use <arm_sheets.scad>
use <../../basic_scad/radial_bearings.scad>
use <../../basic_scad/screws_nuts_washers.scad>

//---------------------------------------------------------------------------
module arm_up_down_motor_top_sheet_with_belt_tensioner()
{
    arm_up_down_motor_top_sheet();
    // first tower of bearings
    translate ([arm_up_down_motor_sheet_size[0] / 2 - arm_up_down_motor_top_sheet_distance_between_belt_tensioners / 2, distance_arm_up_down_motor_to_shaft - nema_17_motor_gearbox_radius - 2, 0]) {
        M4_sunken(30);
        translate ([0, 0, sheet_upper_arm_motor_top_size[2] + 2]) 624rs();
        translate ([0, 0, sheet_upper_arm_motor_top_size[2] + 2 + 5]) 624rs();
        translate ([0, 0, sheet_upper_arm_motor_top_size[2] + 2 + 10]) 624rs();
    }

    translate ([arm_up_down_motor_sheet_size[0] / 2 + arm_up_down_motor_top_sheet_distance_between_belt_tensioners / 2, distance_arm_up_down_motor_to_shaft - nema_17_motor_gearbox_radius - 2, 0]) {
        M4_sunken(30);
        translate ([0, 0, sheet_upper_arm_motor_top_size[2] + 2]) 624rs();
        translate ([0, 0, sheet_upper_arm_motor_top_size[2] + 2 + 5]) 624rs();
        translate ([0, 0, sheet_upper_arm_motor_top_size[2] + 2 + 10]) 624rs();
    }
}

//---------------------------------------------------------------------------
module fore_arm_rotation_motor_support_sheet_top_with_belt_tensioner()
{
    fore_arm_rotation_motor_support_sheet_top();
    // first tower of bearings
    translate ([fore_arm_rotation_motor_support_sheet_size[0] / 2 - arm_up_down_motor_top_sheet_distance_between_belt_tensioners / 2, distance_fore_arm_rotation_motor_to_shaft - nema_17_motor_gearbox_radius - 2, fore_arm_rotation_motor_support_sheet_size[2] ]) {
        translate ([0, 0, -fore_arm_rotation_motor_support_sheet_size[2]]) M4_sunken(30);
        translate ([0, 0, + 2]) 624rs();
        translate ([0, 0,  + 2 + 5]) 624rs();
        translate ([0, 0,  + 2 + 10]) 624rs();
    }

    translate ([fore_arm_rotation_motor_support_sheet_size[0] / 2 + arm_up_down_motor_top_sheet_distance_between_belt_tensioners / 2, distance_fore_arm_rotation_motor_to_shaft - nema_17_motor_gearbox_radius - 2, fore_arm_rotation_motor_support_sheet_size[2] ]) {
        translate ([0, 0, -fore_arm_rotation_motor_support_sheet_size[2]]) M4_sunken(30);
        translate ([0, 0,  + 2]) 624rs();
        translate ([0, 0,  + 2 + 5]) 624rs();
        translate ([0, 0,  + 2 + 10]) 624rs();
    }
}
//---------------------------------------------------------------------------
//arm_up_down_motor_top_sheet_with_belt_tensioner();
fore_arm_rotation_motor_support_sheet_top_with_belt_tensioner();