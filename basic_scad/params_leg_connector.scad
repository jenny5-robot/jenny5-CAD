include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <params_radial_bearings.scad>

//---------------------------------------------------------------------
leg_connector_length = 40;
leg_connector_bearing_housing_length = 2 * (rb_6000_external_radius + wall_thick_2);

leg_connector_base_thick = wall_thick_2;

function f_leg_connector_width(tube_radius) = 2 * tube_radius + 4 * m4_screw_radius + 2 * wall_thick_3;
function f_leg_connector_height_half(tube_radius) = leg_connector_base_thick + tube_radius - 0.5;

leg_connector_height = 2 * (leg_connector_base_thick + 12.5 + wall_thick_5);

leg_connector_holes = [
    [5.5, wall_thick_3 + m4_screw_radius, 0],
    [5.5, f_leg_connector_width(12.5) - (wall_thick_3 + m4_screw_radius), 0],
    [leg_connector_length - 5.5, wall_thick_3 + m4_screw_radius, 0],
    [leg_connector_length - 5.5, f_leg_connector_width(12.5) - (wall_thick_3 + m4_screw_radius), 0],
    [leg_connector_length + leg_connector_bearing_housing_length / 2 - 8, wall_thick_3 + m4_screw_radius, 0],
    [leg_connector_length + leg_connector_bearing_housing_length / 2 - 8, f_leg_connector_width(12.5) - (wall_thick_3 + m4_screw_radius), 0],
    [leg_connector_length + leg_connector_bearing_housing_length / 2 + 8, wall_thick_3 + m4_screw_radius, 0],
    [leg_connector_length + leg_connector_bearing_housing_length / 2 + 8, f_leg_connector_width(12.5) - (wall_thick_3 + m4_screw_radius), 0],
];

leg_connector_sheet_size = [leg_connector_length + leg_connector_bearing_housing_length, leg_connector_length, wall_thick_5];

//---------------------------------------------------------------------

//echo(leg_connector_sheet_size = leg_connector_sheet_size);

//echo(leg_connector_holes = leg_connector_holes);