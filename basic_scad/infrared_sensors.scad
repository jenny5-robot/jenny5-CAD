include <params_basic_components.scad>
include <params_infrared_sensors.scad>

//------------------------------------------------------
module GP2Y0D805Z0F()
{
    difference(){
        color("green") cube([GP2Y0D805Z0F_size[0], GP2Y0D805Z0F_size[1], 2]);
        // screw hole
        translate([GP2Y0D805Z0F_size[0] - GP2Y0D805Z0F_dist_to_hole, GP2Y0D805Z0F_size[1] / 2, 0] - display_tolerance_z) cylinder (h = 2 + 2 * display_tolerance, r = 1, $fn = 10);
    }
    translate([3, -GP2Y0D805_size[1] / 2 + GP2Y0D805Z0F_size[1] / 2, 2]) color("black") cube(GP2Y0D805_size);
}
//------------------------------------------------------

GP2Y0D805Z0F();