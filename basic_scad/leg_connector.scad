include <params_leg_connector.scad>
include <config.scad>
use <radial_bearings.scad>

//-------------------------------------------------------------------------
module leg_connector_half(tube_radius)
{
    leg_connector_width = f_leg_connector_width(tube_radius);
    leg_connector_height = f_leg_connector_height_half(tube_radius);

    difference(){
        union(){
            color(plastic_color) cube([leg_connector_length, leg_connector_width, leg_connector_height]);
            translate ([leg_connector_length, 0, 0]) color(plastic_color) cube([leg_connector_bearing_housing_length, leg_connector_width, leg_connector_height]);
        }
        // tube horizontal
        translate ([0, leg_connector_width / 2, leg_connector_base_thick + tube_radius] - display_tolerance_x) rotate([0, 90, 0]) cylinder(h = leg_connector_length + leg_connector_bearing_housing_length / 2, r = tube_radius, $fn = 50);
        
        // bearing housing hole
        translate ([leg_connector_length + leg_connector_bearing_housing_length / 2, leg_connector_width / 2, 0] - display_tolerance_z) cylinder(h = 15 + 2 * display_tolerance, r = rb_6000_external_radius, $fn = 30);
      // bearing middle hole
        translate ([leg_connector_length + leg_connector_bearing_housing_length / 2, leg_connector_width / 2, 0] - display_tolerance_z) cylinder(h = leg_connector_height + 2 * display_tolerance, r = rb_6000_external_radius - 1, $fn = 30);
    
        for (i = [0 : 7])
            translate(leg_connector_holes[i] - display_tolerance_z) cylinder (h = leg_connector_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
    }
}
//-------------------------------------------------------------------------
module leg_connector_sheet(tube_radius)
{
        difference(){
            color(aluminium_color) cube(leg_connector_sheet_size);
            leg_connector_height = f_leg_connector_height_half(tube_radius);
            leg_connector_width = f_leg_connector_width(tube_radius);
            
            // screw holes
            for (i = [0 : 7])
                translate(leg_connector_holes[i] - display_tolerance_z) cylinder (h = leg_connector_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
            
            // middle hole
            translate ([leg_connector_length + leg_connector_bearing_housing_length / 2, leg_connector_width / 2, 0] - display_tolerance_z) cylinder(h = wall_thick_5 + 2 * display_tolerance, r = 11, $fn = 30);
        }
}
//-------------------------------------------------------------------------
module leg_connector_half_with_bearing(tube_radius)
{
    leg_connector_width = f_leg_connector_width(tube_radius);
    leg_connector_height = f_leg_connector_height_half(tube_radius);
    
    leg_connector_half(tube_radius);
    translate ([leg_connector_length + leg_connector_bearing_housing_length / 2, leg_connector_width / 2, 0]) 6000rs();
}
//-------------------------------------------------------------------------
module leg_connector(tube_radius)
{
    leg_connector_height = f_leg_connector_height_half(tube_radius);
    translate ([0, -leg_connector_sheet_size[1] / 2, - leg_connector_sheet_size[2] - leg_connector_base_thick - tube_radius]){
        leg_connector_sheet(tube_radius);
        translate ([0, 0, leg_connector_sheet_size[2]]) leg_connector_half_with_bearing(tube_radius);
        translate ([0, 0, 2 * tube_radius + 2 * leg_connector_base_thick + leg_connector_sheet_size[2]]) mirror([0, 0, 1]) leg_connector_half_with_bearing(tube_radius);  
        translate ([0, 0, 2 * tube_radius + 2 * leg_connector_base_thick + leg_connector_sheet_size[2]]) leg_connector_sheet(tube_radius);
    }
}
//-------------------------------------------------------------------------

leg_connector(12.5);

//leg_connector_sheet(12.5);
//leg_connector_half(12.5);