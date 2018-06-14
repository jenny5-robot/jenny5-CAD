// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


include <params_arm.scad>

include <../basic_scad/params_motor_housing.scad>
use <../basic_scad/point_transformations_3d.scad>

include <../basic_scad/tolerance.scad>
include <params_body.scad>

//---------------------------------------------------------------
module shoulder_plate()
{
    difference(){
        echo("shoulder plate");
        echo(shoulder_plate_size = shoulder_plate_size);

        color (aluminium_color) cube(shoulder_plate_size);
        echo("motor housing holes:");
      for (i = [[-1, -1], [-1, 1], [1, -1], [1, 1]]){
            echo([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - 18 - 3, 0] + rotate_z(90, [i[0] * 28 / 2, i[1] * 35 / 2, 0]));
            translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - 18 - 3, 0] - display_tolerance_z) rotate ([0, 0, 90]) translate([i[0] * 28 / 2, i[1] * 35 / 2, 0])  cylinder ( h = shoulder_plate_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
      }
        echo("bearing housing holes:");
        for (i = [0 : 1]){
            echo(rbearing_6906_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_6906_enclosed_housing_holes_position[0][0] + rbearing_6906_enclosed_housing_holes_position[1][0]) / 2, first_bearing_shoulder_offset + rbearing_6906_enclosed_housing_size[1] / 2, 0]);
            translate (rbearing_6906_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_6906_enclosed_housing_holes_position[0][0] + rbearing_6906_enclosed_housing_holes_position[1][0]) / 2, first_bearing_shoulder_offset+ rbearing_6906_enclosed_housing_size[1] / 2, 0] - display_tolerance_z) cylinder (h = shoulder_plate_size[2] + 2 * display_tolerance, r = m4_screw_radius);
        }
        // other side holes for bearing
        
        for (i = [0 : 1]){
            echo(rbearing_6906_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_6906_enclosed_housing_holes_position[0][0] + rbearing_6906_enclosed_housing_holes_position[1][0]) / 2, shoulder_plate_size[1] - rbearing_6906_enclosed_housing_size[1] / 2, 0]);

            translate (rbearing_6906_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_6906_enclosed_housing_holes_position[0][0] +rbearing_6906_enclosed_housing_holes_position[1][0]) / 2, shoulder_plate_size[1] - rbearing_6906_enclosed_housing_size[1] / 2, 0] - display_tolerance_z) cylinder (h = shoulder_plate_size[2] + 2 * display_tolerance, r = m4_screw_radius);
        }
        // holes for brackets
        echo("shoulder holes for brackets");
        shoulder_bracket_holes_position = f_tube_bracket_holes(shoulder_bracket_length, shoulder_shaft_radius);
        for (i = [0 : 1]){
            echo(shoulder_bracket_holes_position[i] + [(shoulder_plate_size[0] - ceil(nema_17_width)) / 2 - shoulder_bracket_length, shoulder_plate_size[0] - offset_shoulder_plate_bracket, 0]);
            translate(shoulder_bracket_holes_position[i] + [(shoulder_plate_size[0] - ceil(nema_17_width)) / 2 - shoulder_bracket_length, shoulder_plate_size[0] - offset_shoulder_plate_bracket, 0] - display_tolerance_z)
        cylinder (h = shoulder_plate_size[2] + 2 * display_tolerance, r = m4_screw_radius);
        }
        // other side
        for (i = [0 : 1]){
            echo(shoulder_bracket_holes_position[i] + [shoulder_plate_size[0] - (shoulder_plate_size[0] - ceil(nema_17_width)) / 2, shoulder_plate_size[0] - offset_shoulder_plate_bracket, 0]);
            translate(shoulder_bracket_holes_position[i] + [shoulder_plate_size[0] - (shoulder_plate_size[0] - ceil(nema_17_width)) / 2, shoulder_plate_size[0] - offset_shoulder_plate_bracket, 0] - display_tolerance_z)
        cylinder (h = shoulder_plate_size[2] + 2 * display_tolerance, r = m4_screw_radius);  
        }
            // potentiometer support holes
    }
}
//---------------------------------------------------------------------------
module sheet_upper_arm_motor_base()
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
module sheet_upper_arm_motor_top()
{
    difference(){
        color(aluminium_color) cube(sheet_upper_arm_motor_top_size);
        echo(sheet_upper_arm_motor_top_size = sheet_upper_arm_motor_top_size);
        echo("motor gearbox holes");
        for (i = [1 : 4]){
            translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2 + distance_upper_arm_motor_shaft, 0] + gearbox_nema_17_holes_position[i] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 1.5, $fn = 10);
            echo([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2 + distance_upper_arm_motor_shaft, 0] + gearbox_nema_17_holes_position[i], "radius = 1.5");
        }
// bearbox middle hole
            translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2 + distance_upper_arm_motor_shaft, 0] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 11, $fn = 30);
            echo([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2 + distance_upper_arm_motor_shaft, 0], "radius = 11");
        // rb608 bearing housing holes
        echo("rb608 bearing housing holes");
        for (i = [1 : 4]){
            translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 1.5, $fn = 10);
            echo([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0] + rbearing_608_housing_holes_position[i], "radius = 2");
        }
// middle hole
        translate([sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0] - display_tolerance_z) cylinder (h = sheet_upper_arm_motor_base_size[2] + 2 * display_tolerance, r = 10, $fn = 30);
        echo("bearing housing middle hole", [sheet_upper_arm_motor_base_size[0] / 2, rbearing_608_housing_size[0] / 2, 0]);
    }
}
//---------------------------------------------------------------------------
module elbow_sheet()
{
    difference(){
        color (aluminium_color) cube(elbow_sheet_size);
        translate ([elbow_sheet_size[0], 60, 0] - display_tolerance_z) rotate ([0, 0, 12]) cube(elbow_sheet_size + 2 * display_tolerance_z);
        translate ([-elbow_sheet_size[0], 60, 0] - display_tolerance_z) rotate ([0, 0, -12]) cube(elbow_sheet_size + 2 * display_tolerance_z);
    }
}
//---------------------------------------------------------------------------
module plate_body_articulation()
{
  difference(){
      echo("Body-arm plate size: ", plate_body_size);
      color (aluminium_color) cube(plate_body_size);
        // screws holes for body bone connection
        // rest of arms screws
        // first bearing housing support holes
      echo("first bearing housing support holes:");
      for (i = [0 : 1]){
            echo([plate_body_size[0] / 2, f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[1] / 2, 0] + rbearing_6905_enclosed_housing_holes_position[i]);
            translate ([plate_body_size[0] / 2, f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[1] / 2, 0] - display_tolerance_z) translate(rbearing_6905_enclosed_housing_holes_position[i])  cylinder ( h = plate_body_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
      }
        // motor housing base screw holes
      echo("motor holes position:");
      for (i = [[-1, -1], [-1, 1], [1, -1], [1, 1]]){
            echo([plate_body_size[0] / 2, plate_body_size[1] - 18 - 3, 0] + rotate_z(90, [i[0] * 28 / 2, i[1] * 33 / 2, 0]));
            translate ([plate_body_size[0] / 2, plate_body_size[1] - 18 - 3, 0] - display_tolerance_z) rotate ([0, 0, 90]) translate([i[0] * 28 / 2, i[1] * 33 / 2, 0])  cylinder ( h = plate_body_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
      }
        // holes for the other bearing housing
      echo("second bearing housing support holes:");     
      for (i = [0 : 1]){
            echo([plate_body_size[0] / 2, f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[1] / 2, 0] + rbearing_6905_enclosed_housing_holes_position[i]);
            translate ([plate_body_size[0] / 2, plate_body_size[1] - f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[1] / 2, 0] - display_tolerance_z) translate(rbearing_6905_enclosed_housing_holes_position[i]) cylinder (h = plate_body_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
      }
      //holes for body shaft
      echo("shaft holes = ");
      holes = f_tube_bracket_single_hole(body_arm_bracket_thick, body_shaft_radius);
      bracket_width = f_bracket_width(body_shaft_radius);
      for (i = [0 : 1]){
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

//plate_body_articulation();
//shoulder_plate();

//elbow_sheet();

//sheet_upper_arm_motor_base();

sheet_upper_arm_motor_top();