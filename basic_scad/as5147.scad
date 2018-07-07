// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <as5147_params.scad>
include <tolerance.scad>
include <config.scad>

//--------------------------------------------------------------
module as5147()
{
    difference(){
        union(){
            // PCB
            color ("green") cube(as5147_board_size);
            // connector
            translate ([as5147_board_size[0] - as5147_pin_area_length, 0, as5147_board_size[2]]) color ("black") cube([as5147_pin_area_length, as5147_board_size[1], 9]);
            // voltage selector pins
            translate ([as5147_voltage_selector_pins_position, -as5147_voltage_selector_pins_length / 2 + as5147_board_size[1] / 2, as5147_board_size[2]]) color ("black") cube([2.54, as5147_voltage_selector_pins_length, 9]);
        }
        for (i = [0 : 3])
            translate (as5147_holes_position[i] - display_tolerance_z) cylinder (h = as5147_board_size[2] + 2 * display_tolerance, r = 1.3, $fn = 10);
    }
}
//--------------------------------------------------------------
module magnetic_holder(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11)
{
    difference(){
        color (plastic_color) cylinder (h = holder_height, r = tube_internal_radius, $fn = 30);
        translate ([0, 0, holder_height - magnet_thick]) cylinder (h = magnet_thick + display_tolerance, r = magnet_radius, $fn = 30);
    }
}
//--------------------------------------------------------------
module magnet(magnet_radius = 4, magnet_thick = 2.5)
{
    color ("DarkGray") cylinder (h = magnet_thick, r = magnet_radius);
}
//--------------------------------------------------------------

module magnetic_holder_with_magnet(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11)
{
    magnetic_holder(holder_height = holder_height, magnet_radius = magnet_radius, magnet_thick = magnet_thick, tube_internal_radius = tube_internal_radius);
    translate ([0, 0, holder_height - magnet_thick]) magnet(magnet_radius = magnet_radius, magnet_thick = magnet_thick);
}
//--------------------------------------------------------------

as5147();

//magnetic_holder(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11);