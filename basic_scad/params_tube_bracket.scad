// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <config.scad>


tube_bracket_base_thick = wall_thick_2;
tube_bracket_base_thick_strong = wall_thick_4;

braket_lateral_wall_thick = 2 * m4_screw_radius + wall_thick_3 + 1.5;

function f_bracket_width(tube_radius) = 2 * (tube_radius + braket_lateral_wall_thick);
function f_bracket_height(tube_radius) = tube_bracket_base_thick + 2 * tube_radius - 0.5;
function f_bracket_height_half(tube_radius) = tube_bracket_base_thick + tube_radius - 0.5;
function f_bracket_height_strong(tube_radius) = tube_bracket_base_thick_strong + 2 * tube_radius - 0.5;
function f_bracket_height_strong_half(tube_radius) = tube_bracket_base_thick_strong + tube_radius - 0.5;

function f_tube_bracket_holes(bracket_length, tube_radius) = [
    [6, wall_thick_3 + m4_screw_radius, 0],
    [6, f_bracket_width(tube_radius) - (wall_thick_3 + m4_screw_radius), 0],
    [bracket_length - 6, wall_thick_3 + m4_screw_radius, 0],
    [bracket_length - 6, f_bracket_width(tube_radius) - (wall_thick_3 + m4_screw_radius), 0],
];

function f_tube_bracket_single_hole(bracket_length, tube_radius) = [
    [bracket_length / 2, wall_thick_3 + m4_screw_radius, 0],
    [bracket_length / 2, f_bracket_width(tube_radius) - (wall_thick_3 + m4_screw_radius), 0]
];
