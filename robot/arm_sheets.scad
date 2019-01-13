// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


include <arm_params.scad>

include <../basic_scad/params_motor_housing.scad>
use <../basic_scad/point_transformations_3d.scad>

include <../basic_scad/tolerance.scad>
include <body_params.scad>

include <../basic_scad/params_tube_bracket.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
use <../basic_scad/radial_bearings.scad>


//---------------------------------------------------------------
module shoulder_sheet()
{
    difference(){
        echo("shoulder sheet");
        echo(shoulder_plate_size = shoulder_plate_size);

        color (aluminium_color) cube(shoulder_plate_size);

        echo("bearing housing holes:");
        for (i = [0 : 1]){
            echo(rbearing_6907_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_6907_enclosed_housing_holes_position[0][0] + rbearing_6907_enclosed_housing_holes_position[1][0]) / 2, first_bearing_shoulder_offset + rbearing_6907_enclosed_housing_size[1] / 2, 0]);
            translate (rbearing_6907_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_6907_enclosed_housing_holes_position[0][0] + rbearing_6907_enclosed_housing_holes_position[1][0]) / 2, first_bearing_shoulder_offset+ rbearing_6907_enclosed_housing_size[1] / 2, 0] - display_tolerance_z) cylinder (h = shoulder_plate_size[2] + 2 * display_tolerance, r = m4_screw_radius);
        }
        // other side holes for bearing
        
        for (i = [0 : 1]){
            echo(rbearing_6907_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_6907_enclosed_housing_holes_position[0][0] + rbearing_6907_enclosed_housing_holes_position[1][0]) / 2, shoulder_plate_size[1] - rbearing_6907_enclosed_housing_size[1] / 2, 0]);

            translate (rbearing_6907_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_6907_enclosed_housing_holes_position[0][0] +rbearing_6907_enclosed_housing_holes_position[1][0]) / 2, shoulder_plate_size[1] - rbearing_6907_enclosed_housing_size[1] / 2, 0] - display_tolerance_z) cylinder (h = shoulder_plate_size[2] + 2 * display_tolerance, r = m4_screw_radius);
        }
        // holes for brackets
        echo("shoulder holes for brackets");
        
        shoulder_bracket_holes_position = f_tube_bracket_holes(shoulder_bracket_length, arm_shaft_radius);
        for (i = [0 : 3]){
            echo(shoulder_bracket_holes_position[i] + [0, offset_shoulder_plate_bracket, 0]);
            translate(shoulder_bracket_holes_position[i] + [0, offset_shoulder_plate_bracket, 0] - display_tolerance_z)
        cylinder (h = shoulder_plate_size[2] + 2 * display_tolerance, r = m4_screw_radius);
        }
        // other side
        for (i = [0 : 3]){
            echo(shoulder_bracket_holes_position[i] + [shoulder_plate_size[0] - shoulder_bracket_length, offset_shoulder_plate_bracket, 0]);
            translate(shoulder_bracket_holes_position[i] + [shoulder_plate_size[0] - shoulder_bracket_length, offset_shoulder_plate_bracket, 0] - display_tolerance_z)
        cylinder (h = shoulder_plate_size[2] + 2 * display_tolerance, r = m4_screw_radius);  
        }
    }
}
//---------------------------------------------------------------------------
module upper_arm_motor_base_sheet()
{
    difference(){
        color(aluminium_color) cube(sheet_upper_arm_motor_base_size);
        echo(sheet_upper_arm_motor_base_size=sheet_upper_arm_motor_base_size);
        // motor holes
        echo("motor holes");
        for (i = [1 : 4]){
            translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2 +  distance_upper_arm_motor_shaft, 0] + nema_17_holes[i] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 1.5, $fn = 10);
            echo([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2 +  distance_upper_arm_motor_shaft, 0] + nema_17_holes[i], "radius = 1.5");
        }
        // rb608 bearing housing holes
        echo("rb608 bearing housing holes");
        for (i = [1 : 4]){
            translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 1.5, $fn = 10);
            echo([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0] + rbearing_608_housing_holes_position[i], "radius = 2");
        }
// middle hole
        echo("bearing housing middle hole", [sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0], "radius = 10");
        translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 10, $fn = 30);
        
    }
}
//---------------------------------------------------------------------------
module upper_arm_motor_top_sheet()
{
    difference(){
        color(aluminium_color) cube(sheet_upper_arm_motor_top_size);
        echo(sheet_upper_arm_motor_top_size = sheet_upper_arm_motor_top_size);
        echo("motor gearbox holes");
        for (i = [1 : 4]){
            translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2 + distance_upper_arm_motor_shaft, 0] + gearbox_nema_17_holes_position[i] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 1.5, $fn = 10);
            translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2 + distance_upper_arm_motor_shaft, 0] + gearbox_nema_17_holes_position[i] + [0, 0, 1.5]) cylinder (h = 1.5, r1 = 1.5, r2 = 3, $fn = 20);
            echo([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2 + distance_upper_arm_motor_shaft, 0] + gearbox_nema_17_holes_position[i], "radius = 1.5");
        }
// bearbox middle hole
            translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2 + distance_upper_arm_motor_shaft, 0] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 11, $fn = 30);
            echo([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2 + distance_upper_arm_motor_shaft, 0], "radius = 11");
        // rb608 bearing housing holes
        echo("rb608 bearing housing holes");
        for (i = [1 : 4]){
            translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 2, $fn = 10);
            translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0] + rbearing_608_housing_holes_position[i] + [0, 0, 1]) cylinder (h = 2, r1 = 2, r2 = 3.8, $fn = 20);

            echo([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0] + rbearing_608_housing_holes_position[i], "radius = 2");
        }
// middle hole
        translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 10, $fn = 30);
        echo("bearing housing middle hole", [sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0]);
        
        // belt tensioner holes
       translate ([sheet_upper_arm_motor_top_size[0] / 2 - 10, sheet_upper_arm_motor_top_size[1] / 2 - 4, 0]) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 2, $fn = 10); 
       translate ([sheet_upper_arm_motor_top_size[0] / 2 + 10, sheet_upper_arm_motor_top_size[1] / 2 - 4, 0]) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 2, $fn = 10); 
        
        echo("belt tensioner holes");
        echo([sheet_upper_arm_motor_top_size[0] / 2 - 10, sheet_upper_arm_motor_top_size[1] / 2 - 4, 0]);
        echo([sheet_upper_arm_motor_top_size[0] / 2 + 10, sheet_upper_arm_motor_top_size[1] / 2 - 4, 0]);
    }
}
//---------------------------------------------------------------------------
module arm_up_down_motor_top_sheet()
{
    difference(){
        color(aluminium_color) cube(arm_up_down_motor_sheet_size);
        echo(arm_up_down_motor_sheet_size = arm_up_down_motor_sheet_size);
        echo("motor gearbox holes");
        for (i = [1 : 4]){
            translate([arm_up_down_motor_sheet_size[0] / 2, distance_arm_up_down_motor_to_shaft, 0] + gearbox_nema_17_holes_position[i] - display_tolerance_z) cylinder (h = arm_up_down_motor_sheet_size[2] + 2 * display_tolerance, r = 1.5, $fn = 10);
            translate([arm_up_down_motor_sheet_size[0] / 2, distance_arm_up_down_motor_to_shaft, 0] + gearbox_nema_17_holes_position[i] + [0, 0, 1.5]) cylinder (h = 1.5, r1 = 1.5, r2 = 3, $fn = 20);
            echo([arm_up_down_motor_sheet_size[0] / 2, distance_arm_up_down_motor_to_shaft, 0] + gearbox_nema_17_holes_position[i], "radius = 1.5");
        }
// motor gearbox middle hole
            translate([arm_up_down_motor_sheet_size[0] / 2, distance_arm_up_down_motor_to_shaft, 0] - display_tolerance_z) cylinder (h = arm_up_down_motor_sheet_size[2] + 2 * display_tolerance, r = 11, $fn = 30);
            echo([arm_up_down_motor_sheet_size[0] / 2, distance_arm_up_down_motor_to_shaft, 0], "radius = 11");
        // rb6907 bearing housing holes
        echo("rb6907 bearing housing holes");
        for (i = [1 : 4]){
            translate([arm_up_down_motor_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] - display_tolerance_z) cylinder (h = arm_up_down_motor_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10);
            translate([arm_up_down_motor_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] + [0, 0, 1]) cylinder (h = 2, r1 = 2, r2 = 3.8, $fn = 20);

            echo([arm_up_down_motor_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i], "radius = 2");
        }
// middle hole
        translate([arm_up_down_motor_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] - display_tolerance_z) cylinder (h = arm_up_down_motor_sheet_size[2] + 2 * display_tolerance, r = 18, $fn = 30);
        echo("bearing housing middle hole", [arm_up_down_motor_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0], "radius = 18");
        
        // belt tensioner holes
        echo("belt tensioner holes");
        echo([arm_up_down_motor_sheet_size[0] / 2 - arm_up_down_motor_top_sheet_distance_between_belt_tensioners / 2, distance_arm_up_down_motor_to_shaft - nema_17_motor_gearbox_radius - 2, 0]);
       translate ([arm_up_down_motor_sheet_size[0] / 2 - arm_up_down_motor_top_sheet_distance_between_belt_tensioners / 2, distance_arm_up_down_motor_to_shaft - nema_17_motor_gearbox_radius - 2, 0] -display_tolerance_z) cylinder (h = arm_up_down_motor_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10); 
        echo([arm_up_down_motor_sheet_size[0] / 2 + arm_up_down_motor_top_sheet_distance_between_belt_tensioners / 2, distance_arm_up_down_motor_to_shaft -  nema_17_motor_gearbox_radius - 2, 0]);
       translate ([arm_up_down_motor_sheet_size[0] / 2 + arm_up_down_motor_top_sheet_distance_between_belt_tensioners / 2, distance_arm_up_down_motor_to_shaft -  nema_17_motor_gearbox_radius - 2, 0]-display_tolerance_z) cylinder (h = arm_up_down_motor_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10); 
    }
}
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
module arm_up_down_motor_bottom_sheet()
{
    difference(){
        color(aluminium_color) cube(arm_up_down_motor_sheet_size);
        echo(arm_up_down_motor_sheet_size = arm_up_down_motor_sheet_size);
        
        echo("motor holes");
        for (i = [1 : 4]){
            translate([arm_up_down_motor_sheet_size[0] / 2, distance_arm_up_down_motor_to_shaft, 0] + nema_17_holes[i] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 1.5, $fn = 10);
            echo([arm_up_down_motor_sheet_size[0] / 2, distance_arm_up_down_motor_to_shaft, 0] + nema_17_holes[i], "radius = 1.5");
        }
        // rb6907 bearing housing holes
        echo("rb6907 bearing housing holes");
        for (i = [1 : 4]){
            translate([arm_up_down_motor_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] - display_tolerance_z) cylinder (h = arm_up_down_motor_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10);
            translate([arm_up_down_motor_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] + [0, 0, 1]) cylinder (h = 2, r1 = 2, r2 = 3.8, $fn = 20);

            echo([arm_up_down_motor_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i], "radius = 2");
        }
// middle hole
        translate([arm_up_down_motor_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] - display_tolerance_z) cylinder (h = arm_up_down_motor_sheet_size[2] + 2 * display_tolerance, r = 18, $fn = 30);
        echo("bearing housing middle hole", [arm_up_down_motor_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0], "radius = 18");
            }
}
//---------------------------------------------------------------------------
module elbow_sheet(braket_thick = 12, tube_radius = 15)
{
    echo(elbow_sheet_size = elbow_sheet_size);
    
    bracket_width = f_bracket_width(tube_radius);
   
    holes = f_tube_bracket_single_hole(braket_thick, tube_radius);
    
    difference(){
        color (aluminium_color) cube(elbow_sheet_size);

    // screw holes
    echo("fixer screw_hole=");
        for (i = [0 : 1]){
            translate ([bracket_width / 2, braket_thick / 2, 0]) rotate ([0, 0, -90]) translate(holes[i] - [braket_thick / 2, bracket_width / 2, 0] - display_tolerance_z) cylinder (h = elbow_sheet_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
            echo(rotate_z(90, holes[i] - [braket_thick / 2, bracket_width / 2, 0]) + [bracket_width / 2, braket_thick / 2, 0]); //
        // other side
           translate ([bracket_width / 2, elbow_sheet_grip_length - arm_bracket_thick / 2, 0]) rotate ([0, 0, -90]) translate(holes[i] - [braket_thick / 2, bracket_width / 2, 0] - display_tolerance_z) cylinder (h = elbow_sheet_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
            echo(rotate_z(90, holes[i] - [braket_thick / 2, bracket_width / 2, 0]) + [bracket_width / 2, elbow_sheet_grip_length - arm_bracket_thick / 2, 0]); //
        } // end for
        
        // holes for belt tensioner
    echo("belt tensioner screw_hole = ");
    translate ([elbow_sheet_size[0] / 2 - 12, elbow_sheet_grip_length + elbow_connector_belt_tensioner_offset, 0] - display_tolerance_z)
        cylinder (h = elbow_sheet_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
    translate ([elbow_sheet_size[0] / 2 + 12, elbow_sheet_grip_length + elbow_connector_belt_tensioner_offset, 0] - display_tolerance_z)
        cylinder (h = elbow_sheet_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
        echo([elbow_sheet_size[0] / 2 - 12, elbow_sheet_grip_length + elbow_connector_belt_tensioner_offset, 0]);
        echo([elbow_sheet_size[0] / 2 + 12, elbow_sheet_grip_length + elbow_connector_belt_tensioner_offset, 0]);
        
    } // end difference
}
//---------------------------------------------------------------------------
module body_articulation_sheet()
{
  difference(){
      echo("Body-arm plate size: ", plate_body_size);
      color (aluminium_color) cube(plate_body_size);
        // screws holes for body bone connection
        // rest of arms screws
        // first bearing housing support holes
      echo("first bearing housing support holes:");
      for (i = [0 : 1]){
            echo([plate_body_size[0] / 2, f_rbearing_6907_vertical_housing_size_bounded_half_small(0)[1] / 2, 0] + rbearing_6907_enclosed_housing_holes_position[i]);
            translate ([plate_body_size[0] / 2, f_rbearing_6907_vertical_housing_size_bounded_half_small(0)[1] / 2, 0] - display_tolerance_z) translate(rbearing_6907_enclosed_housing_holes_position[i])  cylinder ( h = plate_body_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
      }
        // motor housing base screw holes
//      echo("motor holes position:");
//      for (i = [[-1, -1], [-1, 1], [1, -1], [1, 1]]){
//            echo([plate_body_size[0] / 2, plate_body_size[1] - nema_17_motor_gearbox_radius - 3, 0] + rotate_z(90, [i[0] * 28 / 2, i[1] * 33 / 2, 0]));
//            translate ([plate_body_size[0] / 2, plate_body_size[1] - nema_17_motor_gearbox_radius - 3, 0] - display_tolerance_z) rotate ([0, 0, 90]) translate([i[0] * 28 / 2, i[1] * 33 / 2, 0])  cylinder ( h = plate_body_size[2] + 2 * display_tolerance, r = 1.5, $fn = 20);
//      }
        // holes for the other bearing housing
      echo("second bearing housing support holes:");     
      for (i = [0 : 1]){
            echo([plate_body_size[0] / 2, plate_body_size[1] - f_rbearing_6907_vertical_housing_size_bounded_half_small(0)[1] / 2, 0] + rbearing_6907_enclosed_housing_holes_position[i]);
            translate ([plate_body_size[0] / 2, plate_body_size[1] - f_rbearing_6907_vertical_housing_size_bounded_half_small(0)[1] / 2, 0] - display_tolerance_z) translate(rbearing_6907_enclosed_housing_holes_position[i]) cylinder (h = plate_body_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
      }
      //holes for body shaft
      echo("shaft support holes = ");
      holes = f_tube_bracket_holes(body_arm_bracket_thick, body_shaft_radius);
      
      bracket_width = f_bracket_width(body_shaft_radius);
      for (i = [0 : 3]){
          echo([0, -bracket_width / 2 + body_arm_offset, 0] + holes[i]);
          translate ([0, -bracket_width / 2 + body_arm_offset, 0] + holes[i] - display_tolerance_z) cylinder(h = plate_body_size[2] + 2 * display_tolerance, r = m4_screw_radius);
          echo([plate_body_size[0] - body_arm_bracket_thick, -bracket_width / 2 + body_arm_offset, 0] + holes[i]);
          translate ([plate_body_size[0] - body_arm_bracket_thick, -bracket_width / 2 + body_arm_offset, 0] + holes[i] - display_tolerance_z) cylinder(h = plate_body_size[2] + 2 * display_tolerance, r = m4_screw_radius);
      }
    }
}
//---------------------------------------------------------------------------
module gripper_motor_sheet()
{
    color (aluminium_color) cube(gripper_motor_sheet_size);
}
//---------------------------------------------------------------------------
module fore_arm_rotation_motor_support_sheet_top()
{
    difference(){
        color(aluminium_color)cube(fore_arm_rotation_motor_support_sheet_size);
       
        echo(fore_arm_rotation_motor_support_sheet_size = fore_arm_rotation_motor_support_sheet_size);
        echo("motor gearbox holes");
        for (i = [1 : 4]){
            translate([fore_arm_rotation_motor_support_sheet_size[0] / 2, distance_fore_arm_rotation_motor_to_shaft, 0] + gearbox_nema_17_holes_position[i] - display_tolerance_z) cylinder (h = fore_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 1.5, $fn = 10);
            translate([fore_arm_rotation_motor_support_sheet_size[0] / 2, distance_fore_arm_rotation_motor_to_shaft, 0] + gearbox_nema_17_holes_position[i] + [0, 0, 1.5]) cylinder (h = 1.5, r1 = 1.5, r2 = 3, $fn = 20);
            echo([fore_arm_rotation_motor_support_sheet_size[0] / 2, distance_fore_arm_rotation_motor_to_shaft, 0] + gearbox_nema_17_holes_position[i], "radius = 1.5");
        }
// motor gearbox middle hole
            translate([fore_arm_rotation_motor_support_sheet_size[0] / 2, distance_fore_arm_rotation_motor_to_shaft, 0] - display_tolerance_z) cylinder (h = fore_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 11, $fn = 30);
            echo([fore_arm_rotation_motor_support_sheet_size[0] / 2, distance_fore_arm_rotation_motor_to_shaft, 0], "radius = 11");
        // rb6907 bearing housing holes
        echo("rb6907 bearing housing holes");
        for (i = [1 : 4]){
            translate([fore_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] - display_tolerance_z) cylinder (h = fore_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10);
            translate([fore_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] + [0, 0, 1]) cylinder (h = 2, r1 = 2, r2 = 3.8, $fn = 20);

            echo([fore_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i], "radius = 2");
        }
// middle hole
        translate([fore_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] - display_tolerance_z) cylinder (h = fore_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 20, $fn = 30);
        echo("bearing housing middle hole", [fore_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0], "radius = 20");
        
        // belt tensioner holes
        echo("belt tensioner holes");
        echo([fore_arm_rotation_motor_support_sheet_size[0] / 2 - fore_arm_rotation_motor_support_sheet_distance_between_belt_tensioners / 2, distance_fore_arm_rotation_motor_to_shaft - nema_17_motor_gearbox_radius - 2, 0]);
       translate ([fore_arm_rotation_motor_support_sheet_size[0] / 2 - fore_arm_rotation_motor_support_sheet_distance_between_belt_tensioners / 2, distance_fore_arm_rotation_motor_to_shaft - nema_17_motor_gearbox_radius - 2, 0] -display_tolerance_z) cylinder (h = fore_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10); 
        echo([fore_arm_rotation_motor_support_sheet_size[0] / 2 + fore_arm_rotation_motor_support_sheet_distance_between_belt_tensioners / 2, distance_fore_arm_rotation_motor_to_shaft -  nema_17_motor_gearbox_radius - 2, 0]);
       translate ([fore_arm_rotation_motor_support_sheet_size[0] / 2 + fore_arm_rotation_motor_support_sheet_distance_between_belt_tensioners / 2, distance_fore_arm_rotation_motor_to_shaft -  nema_17_motor_gearbox_radius - 2, 0]-display_tolerance_z) cylinder (h = fore_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10); 
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
module upper_arm_rotation_motor_support_sheet_top()
{
    difference(){
        color(aluminium_color)cube(upper_arm_rotation_motor_support_sheet_size);
       
        echo(upper_arm_rotation_motor_support_sheet_size = upper_arm_rotation_motor_support_sheet_size);
        echo("motor gearbox holes");
        for (i = [1 : 4]){
            translate([upper_arm_rotation_motor_support_sheet_size[0] / 2, distance_upper_arm_rotation_motor_to_shaft, 0] + gearbox_nema_17_holes_position[i] - display_tolerance_z) cylinder (h = upper_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 1.5, $fn = 10);
            translate([upper_arm_rotation_motor_support_sheet_size[0] / 2, distance_upper_arm_rotation_motor_to_shaft, 0] + gearbox_nema_17_holes_position[i] + [0, 0, 1.5]) cylinder (h = 1.5, r1 = 1.5, r2 = 3, $fn = 20);
            echo([upper_arm_rotation_motor_support_sheet_size[0] / 2, distance_upper_arm_rotation_motor_to_shaft, 0] + gearbox_nema_17_holes_position[i], "radius = 1.5");
        }
// motor gearbox middle hole
            translate([upper_arm_rotation_motor_support_sheet_size[0] / 2, distance_upper_arm_rotation_motor_to_shaft, 0] - display_tolerance_z) cylinder (h = upper_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 11, $fn = 30);
            echo([upper_arm_rotation_motor_support_sheet_size[0] / 2, distance_upper_arm_rotation_motor_to_shaft, 0], "radius = 11");
        // rb6907 bearing housing holes
        echo("rb6907 bearing housing holes");
        for (i = [1 : 4]){
            translate([upper_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] - display_tolerance_z) cylinder (h = upper_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10);
            translate([upper_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] + [0, 0, 1]) cylinder (h = 2, r1 = 2, r2 = 3.8, $fn = 20);

            echo([upper_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i], "radius = 2");
        }
// middle hole
        translate([upper_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] - display_tolerance_z) cylinder (h = upper_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 20, $fn = 30);
        echo("bearing housing middle hole", [upper_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0], "radius = 20");
        
        // belt tensioner holes
        echo("belt tensioner holes");
        echo([upper_arm_rotation_motor_support_sheet_size[0] / 2 - fore_arm_rotation_motor_support_sheet_distance_between_belt_tensioners / 2, distance_upper_arm_rotation_motor_to_shaft - nema_17_motor_gearbox_radius - 2, 0]);
       translate ([upper_arm_rotation_motor_support_sheet_size[0] / 2 - fore_arm_rotation_motor_support_sheet_distance_between_belt_tensioners / 2, distance_upper_arm_rotation_motor_to_shaft - nema_17_motor_gearbox_radius - 2, 0] -display_tolerance_z) cylinder (h = upper_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10); 
        echo([upper_arm_rotation_motor_support_sheet_size[0] / 2 + fore_arm_rotation_motor_support_sheet_distance_between_belt_tensioners / 2, distance_upper_arm_rotation_motor_to_shaft -  nema_17_motor_gearbox_radius - 2, 0]);
       translate ([upper_arm_rotation_motor_support_sheet_size[0] / 2 + fore_arm_rotation_motor_support_sheet_distance_between_belt_tensioners / 2, distance_upper_arm_rotation_motor_to_shaft -  nema_17_motor_gearbox_radius - 2, 0]-display_tolerance_z) cylinder (h = upper_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10); 
    }
}
//---------------------------------------------------------------------------
module upper_arm_rotation_motor_support_sheet_bottom()
{
    difference(){
        color(aluminium_color)cube(upper_arm_rotation_motor_support_sheet_size);
       
        echo(upper_arm_rotation_motor_support_sheet_size = upper_arm_rotation_motor_support_sheet_size);

        
                echo("motor holes");
        for (i = [1 : 4]){
            translate([upper_arm_rotation_motor_support_sheet_size[0] / 2, distance_upper_arm_rotation_motor_to_shaft, 0] + nema_17_holes[i] - display_tolerance_z) cylinder (h = upper_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 1.5, $fn = 10);
            echo([upper_arm_rotation_motor_support_sheet_size[0] / 2, distance_upper_arm_rotation_motor_to_shaft, 0] + nema_17_holes[i], "radius = 1.5");
        }

        // rb6907 bearing housing holes
        echo("rb6907 bearing housing holes");
        for (i = [1 : 4]){
            translate([upper_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] - display_tolerance_z) cylinder (h = upper_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10);
            translate([upper_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] + [0, 0, 1]) cylinder (h = 2, r1 = 2, r2 = 3.8, $fn = 20);

            echo([upper_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i], "radius = 2");
        }
// middle hole
        translate([upper_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] - display_tolerance_z) cylinder (h = upper_arm_rotation_motor_support_sheet_size[2] + 2 * display_tolerance, r = 20, $fn = 30);
        echo("bearing housing middle hole", [upper_arm_rotation_motor_support_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0], "radius = 20");
        

    }
}
//---------------------------------------------------------------------------

//upper_arm_rotation_motor_support_sheet_top();

//upper_arm_rotation_motor_support_sheet_bottom();

//fore_arm_rotation_motor_support_sheet_top_with_belt_tensioner();

//fore_arm_rotation_motor_support_sheet_top();

arm_up_down_motor_top_sheet();

//arm_up_down_motor_top_sheet_with_belt_tensioner();

//arm_up_down_motor_bottom_sheet();

//body_articulation_sheet();
//shoulder_sheet();

//elbow_sheet();


//upper_arm_motor_top_sheet();
//upper_arm_motor_base_sheet();
