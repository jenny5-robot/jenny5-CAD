// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_radial_bearings.scad>
include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <config.scad>
include <params_radial_bearings_housing.scad>
use <radial_bearings.scad>
use <basic_components.scad>
include <tolerance.scad>
          
//---------------------------------------------------------------------------
module radial_bearing_housing(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, housing_height, screw_radius = m4_screw_radius, height_extension = 0, extra_lateral_thick = 0, bearing_support_hole_radius = -1)
{
   color(plastic_color)
    render()
        difference(){
            translate ([-rbearing_housing_size[0] / 2 - extra_lateral_thick, -rbearing_housing_size[1] / 2 - extra_lateral_thick, 0]) my_cube_rounded2 ([rbearing_housing_size[0] + 2 * extra_lateral_thick, rbearing_housing_size[1] + 2 * extra_lateral_thick, housing_height + height_extension]);
            // bearing hole
            translate ([0, 0, housing_height + height_extension - rb_thick]) cylinder (h = rb_thick, r = rb_external_radius + 0.1, $fn = 70);
            // bearing support hole
            if (bearing_support_hole_radius == -1){
                translate (rbearing_housing_holes_position[0] - display_tolerance_z) cylinder (h = housing_height + height_extension + 2 * display_tolerance, r = rb_external_radius - 1, $fn = 70);
                }
            else{
                                translate (rbearing_housing_holes_position[0] - display_tolerance_z) cylinder (h = housing_height + height_extension + 2 * display_tolerance, r = bearing_support_hole_radius, $fn = 70);
            }
            // screws holes
            for (i = [1 : 4])
                translate (rbearing_housing_holes_position[i]-display_tolerance_z) cylinder (h = height_extension + housing_height + 2 * display_tolerance, r = screw_radius, $fn = 20);
        }
}
//---------------------------------------------------------------------------
module radial_bearing_spacer(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, housing_height, screw_radius = m4_screw_radius, height_extension = 0)
{
   color(plastic_color)
    render()
        difference(){
            translate ([-rbearing_housing_size[0] / 2, -rbearing_housing_size[1] / 2, 0]) my_cube_rounded2 ([rbearing_housing_size[0], rbearing_housing_size[1], housing_height + height_extension]);
            // bearing support hole
            translate (rbearing_housing_holes_position[0] - display_tolerance_z) cylinder (h = housing_height + height_extension + 2 * display_tolerance, r = rb_external_radius - 1, $fn = 70);
            // screws holes
            for (i = [1 : 4])
                translate (rbearing_housing_holes_position[i]-display_tolerance_z) cylinder (h = height_extension + housing_height + 2 * display_tolerance, r = screw_radius, $fn = 20);
        }
}
//---------------------------------------------------------------------------
module radial_2x_bearing_housing(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, housing_height, screw_radius = m4_screw_radius, height_extension = 0)
{
   color(plastic_color)
    render()
        difference(){
            translate ([-rbearing_housing_size[0] / 2, -rbearing_housing_size[1] / 2, 0]) my_cube_rounded2 ([rbearing_housing_size[0], rbearing_housing_size[1], housing_height + height_extension]);
            // bearing hole
            translate ([0, 0, housing_height + height_extension - rb_thick]) cylinder (h = rb_thick, r = rb_external_radius, $fn = 70);
            // bearing hole
            cylinder (h = rb_thick, r = rb_external_radius, $fn = 70);
            // bearing support hole
            translate (rbearing_housing_holes_position[0] - display_tolerance_z) cylinder (h = housing_height + height_extension + 2 * display_tolerance, r = rb_external_radius - 1, $fn = 70);
            // screws holes
            for (i = [1 : 4])
                translate (rbearing_housing_holes_position[i]-display_tolerance_z) cylinder (h = height_extension + housing_height + 2 * display_tolerance, r = screw_radius, $fn = 20);
        }
}
//---------------------------------------------------------------------------
module rbearing_6002_housing()
{
    radial_bearing_housing(rbearing_6002_housing_size, rbearing_6002_housing_holes_position, rb_6002_external_radius, rb_6002_thick, rbearing_6002_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_626_housing()
{
    radial_bearing_housing(rbearing_626_housing_size, rbearing_626_housing_holes_position, rb_626_external_radius, rb_626_thick, rbearing_626_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_608_housing()
{
    radial_bearing_housing(rbearing_608_housing_size, rbearing_608_housing_holes_position, rb_608_external_radius, rb_608_thick, rbearing_608_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_608_slim_asymetric_housing()
{
    radial_bearing_housing(rbearing_housing_size = rbearing_608_slim_asymetric_housing_size, rbearing_housing_holes_position = rbearing_608_housing_holes_position, rb_external_radius = rb_608_external_radius, rb_thick = rb_608_thick, housing_height = rbearing_608_housing_size[2], screw_radius = m4_screw_radius, height_extension = 0, extra_lateral_thick = 0);
}
//---------------------------------------------------------------------------
module rbearing_608_slim_asymetric_double_side_housing()
{
    echo(rbearing_608_slim_asymetric_housing_size);
    radial_bearing_housing(rbearing_housing_size = rbearing_608_slim_asymetric_housing_size, rbearing_housing_holes_position = rbearing_608_housing_holes_position, rb_external_radius = rb_608_external_radius, rb_thick = rb_608_thick, housing_height = rbearing_608_housing_size[2], screw_radius = m4_screw_radius, height_extension = 5, extra_lateral_thick = 0, bearing_support_hole_radius = 8.75);
    
    mirror([0, 0, 1])
        radial_bearing_housing(rbearing_housing_size = rbearing_608_slim_asymetric_housing_size, rbearing_housing_holes_position = rbearing_608_housing_holes_position, rb_external_radius = rb_608_external_radius, rb_thick = rb_608_thick, housing_height = rbearing_608_housing_size[2], screw_radius = m4_screw_radius, height_extension = 5, extra_lateral_thick = 0, bearing_support_hole_radius = 8.75);

}
//---------------------------------------------------------------------------
module rbearing_6001_housing()
{
    radial_bearing_housing(rbearing_6001_housing_size, rbearing_6001_housing_holes_position, rb_6001_external_radius, rb_6001_thick, rbearing_6001_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_6005_housing()
{
    radial_bearing_housing(rbearing_6005_housing_size, rbearing_6005_housing_holes_position, rb_6005_external_radius, rb_6005_thick, rbearing_6005_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_6905_housing()
{
    radial_bearing_housing(rbearing_6905_housing_size, rbearing_6905_housing_holes_position, rb_6905_external_radius, rb_6905_thick, rbearing_6905_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_608_housing_double()
{
    radial_bearing_housing(rbearing_608_housing_size, rbearing_608_housing_holes_position, rb_608_external_radius, 2 * rb_608_thick, rbearing_608_housing_size[2] + rb_608_thick, m4_screw_radius, 0, 1);
}
//---------------------------------------------------------------------------
module rbearing_6001_double_housing()
{
    radial_bearing_housing(rbearing_housing_size = rbearing_6001_housing_size, rbearing_housing_holes_position = rbearing_6001_housing_holes_position, rb_external_radius = rb_6001_external_radius, rb_thick = 2 * rb_6001_thick, housing_height = rbearing_6001_housing_size[2] + rb_6001_thick, screw_radius = m4_screw_radius, height_extension = -1);
}
//---------------------------------------------------------------------------
module rbearing_6001_double_housing_thicker_wall(extra_height = 0)
{
    radial_bearing_housing(rbearing_housing_size = rbearing_6001_housing_size_thicker, rbearing_housing_holes_position = rbearing_6001_housing_holes_position, rb_external_radius = rb_6001_external_radius, rb_thick = 2 * rb_6001_thick, housing_height = rbearing_6001_housing_size[2] + rb_6001_thick, screw_radius = m4_screw_radius, height_extension = extra_height);
}
//---------------------------------------------------------------------------
module rbearing_6005_double_housing()
{
    radial_bearing_housing(rbearing_6005_housing_size, rbearing_6005_housing_holes_position, rb_6005_external_radius, 2 * rb_6005_thick, rbearing_6005_housing_size[2] + rb_6005_thick, m4_screw_radius, 0, 1);
}
//---------------------------------------------------------------------------
module rbearing_6002_housing_with_bearing()
{
    rbearing_6002_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 6002rs();
}
//---------------------------------------------------------------------------
module rbearing_626_housing_with_bearing()
{
    rbearing_626_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 626rs();
}
//---------------------------------------------------------------------------
module rbearing_608_housing_with_bearing()
{
    rbearing_608_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 608rs();
}
//---------------------------------------------------------------------------
module rbearing_6001_housing_with_bearing()
{
    rbearing_6001_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 6001rs();
}
//---------------------------------------------------------------------------
module rbearing_6001_double_housing_with_bearings()
{
    rbearing_6001_double_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 6001rs();
    translate ([0, 0, rb_6001_thick + radial_bearing_housing_base_wall_thickness]) 6001rs();
}
//---------------------------------------------------------------------------
module rbearing_6005_double_housing_with_bearings()
{
    rbearing_6005_double_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 6005rs();
    translate ([0, 0, rb_6001_thick + radial_bearing_housing_base_wall_thickness]) 6005rs();
}
//---------------------------------------------------------------------------
module radial_bearing_6002_enclosed_housing(height)
{
    radial_bearing_enclosed_housing(height, rb_6002_external_radius, rb_6002_thick);
}
//---------------------------------------------------------------------------
module radial_bearing_608_enclosed_housing(height)
{
    radial_bearing_enclosed_housing(height, rb_608_external_radius, rb_608_thick);
}
//---------------------------------------------------------------------------
module radial_bearing_608_enclosed_housing_half_top()
{
  radial_bearing_enclosed_housing_half(rb_608_external_radius + radial_bearing_housing_lateral_wall_thickness, rb_608_external_radius, rb_608_thick);
}
//---------------------------------------------------------------------------
module radial_bearing_608_enclosed_housing_half_bottom(height)
{
  radial_bearing_enclosed_housing_half(height, rb_608_external_radius, rb_608_thick);
}
//---------------------------------------------------------------------------
module radial_bearing_6002_enclosed_housing_with_nema_holes(height, motor_tolerance)
{
    radial_bearing_enclosed_housing_with_nema_holes(height, rb_6002_external_radius, rb_6002_thick, motor_tolerance);
}
//---------------------------------------------------------------------------
module rbearing_608_housing_thicker(extra_height = -1)
{
    echo(rbearing_608_housing_holes_position=rbearing_608_housing_holes_position);
    radial_bearing_housing(rbearing_housing_size = rbearing_608_housing_size, rbearing_housing_holes_position = rbearing_608_housing_holes_position, rb_external_radius = rb_608_external_radius, rb_thick = rb_608_thick, housing_height= rbearing_608_housing_size[2] + extra_height, screw_radius = m4_screw_radius, height_extension = 0);
}
//---------------------------------------------------------------------------
module rbearing_6907_housing_thicker(extra_height = -1)
{
    radial_bearing_housing(rbearing_housing_size = rbearing_6907_housing_size, rbearing_housing_holes_position = rbearing_6907_housing_holes_position, rb_external_radius = rb_6907_external_radius, rb_thick = rb_6907_thick, housing_height= rbearing_6907_housing_size[2] + extra_height, screw_radius = m4_screw_radius, height_extension = 0);
}
//---------------------------------------------------------------------------
module rbearing_608_housing_thicker_m3(extra_height = -1)
{
    radial_bearing_housing(rbearing_housing_size = rbearing_608_housing_size, rbearing_housing_holes_position = rbearing_608_housing_holes_position_m3, rb_external_radius = rb_608_external_radius, rb_thick = rb_608_thick, housing_height= rbearing_608_housing_size[2] + extra_height, screw_radius = m3_screw_radius, height_extension = 0, extra_thick = 1);
}
//---------------------------------------------------------------------------
module rbearing_608_spacer_thicker_m3(extra_height = -1)
{
    radial_bearing_spacer(rbearing_housing_size = rbearing_608_housing_size, rbearing_housing_holes_position = rbearing_608_housing_holes_position_m3, rb_external_radius = rb_608_external_radius, rb_thick = rb_608_thick, housing_height= rbearing_608_housing_size[2] + extra_height, screw_radius = m3_screw_radius, height_extension = 0);
}
//---------------------------------------------------------------------------


// rbearing_6002_housing_with_bearing();

// rbearing_608_housing();

// rbearing_6005_housing();
// rbearing_6905_housing();

// rbearing_6001_housing();
// rbearing_608_housing_double();
//echo(rbearing_6001_housing_size=rbearing_6001_housing_size);
 //rbearing_6001_double_housing();
//rbearing_6001_double_housing_thicker_wall(extra_height = -1);
// rbearing_608_housing_with_bearing();

// rbearing_626_housing();

 //rbearing_608_housing_thicker(10);
 //rbearing_608_housing_thicker_m3((68.5 - 25) / 2 - 8);
 //rbearing_608_spacer_thicker_m3((90.5 - 25) / 2 - 3 * 8);
 
 //rbearing_608_spacer_thicker_m3((68.5 - 25) / 2 - 3 * 8);
 
//rbearing_608_housing_thicker(-1);

//rbearing_6907_housing_thicker(0);

//rbearing_608_slim_asymetric_housing();

//rbearing_608_slim_asymetric_double_side_housing();