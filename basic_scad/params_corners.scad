// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <material_colors.scad>


corner_length = 46;

corner_base_thick = wall_thick_2;

corner_lateral_wall_thick = 2 * m4_screw_radius + wall_thick_3 + 1.5;

function f_corner_width(tube_radius) = 2 * (tube_radius + corner_lateral_wall_thick);
function f_corner_height(tube_radius) = corner_base_thick + tube_radius - 0.5;

corner_sheet_size = [corner_length, 90, wall_thick_3];

function f_corner_holes(tube_radius) = [
    [5, 5, 0],
    [5, f_corner_width(12.5) - (wall_thick_3 + m4_screw_radius), 0],
    [corner_length - 5, wall_thick_3 + m4_screw_radius, 0],
    [corner_length - 5, f_corner_width(12.5) - (wall_thick_3 + m4_screw_radius), 0],
    [7, corner_sheet_size[1] - 5, 0],
    [corner_length - 7, corner_sheet_size[1] - 5, 0],
    [7, corner_sheet_size[1] - 42, 0],
    [corner_length - 7, corner_sheet_size[1] - 42, 0]
];

corner_holes = f_corner_holes(12.5);



//echo(corner_sheet_size=corner_sheet_size);

//echo(corner_holes=corner_holes);