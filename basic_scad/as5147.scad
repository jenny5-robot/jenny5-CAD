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
            translate ([as5147_board_size[0] - as5147_pin_area_length, 0, -9]) color ("black") cube([as5147_pin_area_length, as5147_board_size[1], 9]);
            // voltage selector pins
            translate ([as5147_voltage_selector_pins_position, -as5147_voltage_selector_pins_length / 2 + as5147_board_size[1] / 2, as5147_board_size[2]]) color ("black") cube([2.54, as5147_voltage_selector_pins_length, 9]);
        }
        for (i = [0 : 3])
            translate (as5147_holes_position[i] - display_tolerance_z) cylinder (h = as5147_board_size[2] + 2 * display_tolerance, r = 1.3, $fn = 10);
    }
}
//--------------------------------------------------------------
module magnet_holder(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11)
{
    difference(){
        color (plastic_color) cylinder (h = holder_height, r = tube_internal_radius, $fn = 30);
        // magnet hole
        translate ([0, 0, holder_height - magnet_thick]) cylinder (h = magnet_thick + display_tolerance, r = magnet_radius, $fn = 30);
        // hole
        cylinder (h = holder_height, r = 2.5, $fn = 30);
    }
}
//--------------------------------------------------------------
module magnet_holder2(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11, tower_height = 10, tower_external_radius = 6)
{
    difference(){
        color (plastic_color) {
            cylinder (h = holder_height, r = tube_internal_radius, $fn = 30);
            translate ([0, 0, holder_height - 0.01]) cylinder (h = 1, r1 = tube_internal_radius, r2 = tube_internal_radius + 1, $fn = 30);
            translate ([0, 0, holder_height - 0.02 + 1]) cylinder (h = tower_height, r = tower_external_radius, $fn = 30);
        }
        // magnet hole
        translate ([0, 0, holder_height - magnet_thick + tower_height]) cylinder (h = magnet_thick + display_tolerance, r = magnet_radius, $fn = 30);
        // hole
        cylinder (h = holder_height + tower_height, r = 2.5, $fn = 30);
    }
}
//--------------------------------------------------------------
module magnet_holder_hexa(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11, tower_height = 10, tower_external_radius = 6)
{
    difference(){
        color (plastic_color) {
            cylinder (h = holder_height, r = tube_internal_radius, $fn = 6);
            translate ([0, 0, holder_height - 0.01]) cylinder (h = 1.5, r1 = tube_internal_radius, r2 = tube_internal_radius + 1.5, $fn = 6);
            translate ([0, 0, holder_height - 0.02 + 1]) cylinder (h = tower_height, r = tower_external_radius, $fn = 30);
        }
        // magnet hole
        translate ([0, 0, holder_height - magnet_thick + tower_height]) cylinder (h = magnet_thick + display_tolerance, r = magnet_radius, $fn = 30);
        // hole
        cylinder (h = holder_height + tower_height, r = 2.5, $fn = 30);
    }
}
//--------------------------------------------------------------
module magnet(magnet_radius = 4, magnet_thick = 2.5)
{
    color ("DarkGray") cylinder (h = magnet_thick, r = magnet_radius);
}
//--------------------------------------------------------------

module magnet_holder_with_magnet(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11)
{
    magnet_holder(holder_height = holder_height, magnet_radius = magnet_radius, magnet_thick = magnet_thick, tube_internal_radius = tube_internal_radius);
    translate ([0, 0, holder_height - magnet_thick]) magnet(magnet_radius = magnet_radius, magnet_thick = magnet_thick);
}
//--------------------------------------------------------------

module magnet_holder2_with_magnet(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11,  tower_height = 10, tower_external_radius = 6)
{
    magnet_holder2(holder_height = holder_height, magnet_radius = magnet_radius, magnet_thick = magnet_thick, tube_internal_radius = tube_internal_radius,  tower_height = tower_height, tower_external_radius = tower_external_radius);
    translate ([0, 0, holder_height + tower_height - magnet_thick + 1]) magnet(magnet_radius = magnet_radius, magnet_thick = magnet_thick);
}
//--------------------------------------------------------------

//as5147();

//magnet_holder(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11);
//magnet_holder2(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11, tower_height = 2, tower_external_radius = 6);

magnet_holder_hexa(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11.5, tower_height = 2, tower_external_radius = 6);

//magnet_holder2_with_magnet(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11,  tower_height = 10, tower_external_radius = 6);