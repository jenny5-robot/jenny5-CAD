// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
use <basic_components.scad>

include <params_screws_nuts_washers.scad>

include <material_colors.scad>

include <tolerance.scad>

include <as5147_params.scad>


//--------------------------------------------------------------
module as5147_sensor_support(distance_between_screws, width = 60)
{
    
    echo(distance_between_screws = distance_between_screws);
    length = distance_between_screws + 2 * m4_nut_radius + 2 * wall_thick_2;
    height = 4;
    screw_holder_size = 12;
    
    difference(){
        color(plastic_color)
        union(){
            translate ([- length / 2, -screw_holder_size / 2, 0]) cube([length, width + 2, height]);
        }
// first screw for connecting to the next part
        translate ([-distance_between_screws / 2, 0, 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = 2, $fn = 10);
// second screw hole
        translate ([distance_between_screws / 2, 0, 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = 2, $fn = 10);
        
        // sensor screw holes
        for (i = [0: 3])
             translate ([0, width - screw_holder_size / 2 - as5147_space_between_holes_length / 2 - as5147_distance_hole_from_margin, 0]) rotate ([0, 0, 90]) translate ([-as5147_distance_hole_from_margin - as5147_space_between_holes_length / 2, -as5147_distance_hole_from_margin - as5147_space_between_holes_width / 2, 0] + as5147_holes_position[i] - display_tolerance_z) cylinder (h = height + 2 * display_tolerance, r = 1.2);
        
        // sensor connector holes
        translate ([-as5147_board_size[1] / 2, width - screw_holder_size / 2 - as5147_board_size[0] - 6, 0] - display_tolerance_z)  cube ([as5147_board_size[1], as5147_pin_area_length + 7, height] + 2 * display_tolerance_z);
        
        // slope
        translate ([-as5147_board_size[1] / 2, width - screw_holder_size / 2 - as5147_board_size[0] - 6 - 6, 0] - display_tolerance_z)  rotate ([-45, 0, 0]) cube ([as5147_board_size[1], height + 2, height + 2] + 2 * display_tolerance_z);

    // sensor voltage select pins hole
        translate ([-as5147_voltage_selector_pins_length / 2, width - screw_holder_size / 2 - as5147_voltage_selector_pins_position - 2.54 - 1 - 1, 0] - display_tolerance_z) cube ([as5147_voltage_selector_pins_length, 2.54 + 2, height] + 2 * display_tolerance_z);        
    }
}
//---------------------------------------------------------------------------

as5147_sensor_support(20, 60);