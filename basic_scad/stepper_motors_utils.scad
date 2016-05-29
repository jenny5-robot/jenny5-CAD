// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <config.scad>
include <basic_components.scad>
include <params_stepper_motors.scad>

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module gauri_nema(nema_width, nema_dist_between_screw_holes, adancime, radius1 = 1.5, radius2 = 1.5, tolerance_x = 0, tolerance_y = 0)
{
	radius = m3_screw_radius;
hull(){
	translate ([nema_width / 2 - nema_dist_between_screw_holes / 2 - tolerance_x, nema_width / 2 - nema_dist_between_screw_holes / 2 - tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r1 = radius1, r2 = radius2, $fn = 50);
	translate ([nema_width / 2 - nema_dist_between_screw_holes / 2 + tolerance_x, nema_width / 2 - nema_dist_between_screw_holes / 2 + tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r1 = radius1, r2 = radius2, $fn = 50);
}
hull(){
	translate ([nema_width / 2 + nema_dist_between_screw_holes / 2 - tolerance_x, nema_width / 2 - nema_dist_between_screw_holes / 2 - tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r1 = radius1, r2 = radius2, $fn = 50);
	translate ([nema_width / 2 + nema_dist_between_screw_holes / 2 + tolerance_x, nema_width / 2 - nema_dist_between_screw_holes / 2 + tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r1 = radius1, r2 = radius2, $fn = 50);
}
hull(){
	translate ([nema_width / 2 - nema_dist_between_screw_holes / 2 - tolerance_x, nema_width / 2 + nema_dist_between_screw_holes / 2 - tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r1 = radius1, r2 = radius2, $fn = 50);
	translate ([nema_width / 2 - nema_dist_between_screw_holes / 2 + tolerance_x, nema_width / 2 + nema_dist_between_screw_holes / 2 + tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r1 = radius1, r2 = radius2, $fn = 50);
}
hull(){
	translate ([nema_width / 2 + nema_dist_between_screw_holes / 2 - tolerance_x, nema_width / 2 + nema_dist_between_screw_holes / 2 - tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime  + 2 * display_tolerance, r1 = radius1, r2 = radius2, $fn = 50);
	translate ([nema_width / 2 + nema_dist_between_screw_holes / 2 + tolerance_x, nema_width / 2 + nema_dist_between_screw_holes / 2 + tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime  + 2 * display_tolerance, r1 = radius1, r2 = radius2, $fn = 50);
}
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module gauri_nema17(adancime, radius1 = 1.5, radius2 = 1.5, tolerance_x = 0, tolerance_y = 0)
{
	gauri_nema(nema_17_width, nema_17_dist_between_screw_holes, adancime, radius1, radius2, tolerance_x, tolerance_y);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module gauri_nema11(adancime, radius1 = 1.5, radius2 = 1.5)
{
	gauri_nema(nema_11_width, nema_11_dist_between_screw_holes, adancime, radius1, radius2);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module gauri_nema17_with_motor_hole(adancime, radius1 = 1.5, radius2 = 1.5, tolerance_x = 0, tolerance_y = 0)
{
	gauri_nema17(adancime, radius1, radius2, tolerance_x, tolerance_y);
// gaura motor
    
    hull(){
        translate ([nema_17_width / 2 - tolerance_x, nema_17_width / 2 - tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r = nema_17_motor_hole_radius_camiel, $fn = 50);
        translate ([nema_17_width / 2 + tolerance_x, nema_17_width / 2 + tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r = nema_17_motor_hole_radius_camiel, $fn = 50);
    }

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module gauri_nema11_with_motor_hole(adancime, radius1 = 1.5, radius2 = 1.5)
{
	gauri_nema11(adancime, radius1, radius2);
// gaura motor
	translate ([nema_11_width / 2, nema_11_width / 2, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r = nema_11_motor_hole_radius, $fn = 50);

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module gauri_toleranta_nema17(adancime, tolerance)
{
	radius = m3_screw_radius;

	hull(){
		translate ([nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r = radius, $fn = 50);
		translate ([nema_17_width / 2 - nema_17_dist_between_screw_holes / 2 + tolerance, nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r = radius, $fn = 50);
	}
	hull(){
		translate ([nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r = radius, $fn = 50);
		translate ([nema_17_width / 2 + nema_17_dist_between_screw_holes / 2 + tolerance, nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r = radius, $fn = 50);
	}
	hull(){
		translate ([nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r = radius, $fn = 50);
		translate ([nema_17_width / 2 - nema_17_dist_between_screw_holes / 2 + tolerance, nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r = radius, $fn = 50);
	}
	hull(){
		translate ([nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, 0] - display_tolerance_z) cylinder (h = adancime  + 2 * display_tolerance, r = radius, $fn = 50);
		translate ([nema_17_width / 2 + nema_17_dist_between_screw_holes / 2 + tolerance, nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, 0] - display_tolerance_z) cylinder (h = adancime  + 2 * display_tolerance, r = radius, $fn = 50);
	}

	hull(){
		translate ([nema_17_width / 2 - tolerance / 2, nema_17_width / 2, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r = nema_17_motor_hole_radius_camiel, $fn = 50);
		translate ([nema_17_width / 2 + tolerance / 2, nema_17_width / 2, 0] - display_tolerance_z) cylinder (h = adancime + 2 * display_tolerance, r = nema_17_motor_hole_radius_camiel, $fn = 50);
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module screws_nema17(screw_radius, screw_length, head_radius, head_thick)
{
	translate ([nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, 0]) screw(screw_radius, screw_length, head_radius, head_thick);
	translate ([nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, 0]) screw(screw_radius, screw_length, head_radius, head_thick);
	translate ([nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, 0]) screw(screw_radius, screw_length, head_radius, head_thick);
	translate ([nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, 0]) screw(screw_radius, screw_length, head_radius, head_thick);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module sunken_screws_nema17(screw_length)
{
screw_radius = m3_screw_radius;
head_radius = m3_nut_radius;
head_thick = m3_nut_thick;

	translate ([nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, 0]) sunken_screw(screw_radius, screw_length, head_radius, head_thick);
	translate ([nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, 0]) sunken_screw(screw_radius, screw_length, head_radius, head_thick);
	translate ([nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, 0]) sunken_screw(screw_radius, screw_length, head_radius, head_thick);
	translate ([nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, 0]) sunken_screw(screw_radius, screw_length, head_radius, head_thick);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module washers_nema17(internal_radius, external_radius, thick)
{
	translate ([nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, 0]) washer(internal_radius, external_radius, thick);
	translate ([nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, 0]) washer(internal_radius, external_radius, thick);
	translate ([nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, 0]) washer(internal_radius, external_radius, thick);
	translate ([nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, 0]) washer(internal_radius, external_radius, thick);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
