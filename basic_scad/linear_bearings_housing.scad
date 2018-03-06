// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_linear_bearings_housing.scad>
include <func_3d.scad>
include <params_alu_profiles.scad>
include <tolerance.scad>

///////////////////////////////////////////////////////////////////////////////////////////////
module gauri_bearing_housing_3(bearing_external_radius, inaltime, latime)
{
	dist_to_screw = f_dist_to_screw_linear_bearing_housing(bearing_external_radius);

	translate ([0, 0, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = inaltime + 2 * display_tolerance, $fn = 30);
	translate ([2 * dist_to_screw, -latime/2 + 7, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = inaltime + 2 * display_tolerance, $fn = 30);
	translate ([2 * dist_to_screw, latime/2 - 7, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = inaltime + 2 * display_tolerance, $fn = 30);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
module gauri_bearing_housing_2(bearing_external_radius, inaltime, latime)
{
	dist_to_screw = f_dist_to_screw_linear_bearing_housing(bearing_external_radius);

//	translate ([0, 0, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = inaltime + 2 * display_tolerance, $fn = 30);
	translate ([2 * dist_to_screw, -latime/2 + 7, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = inaltime + 2 * display_tolerance, $fn = 30);
	translate ([2 * dist_to_screw, latime/2 - 7, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = inaltime + 2 * display_tolerance, $fn = 30);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
module linear_bearing_housing_cu_3_urechi(bearing_external_radius, bearing_internal_radius, bearing_height)
{
	latime = f_latime_linear_bearing_housing_small(bearing_height);
	lungime = f_lungime_linear_bearing_housing(bearing_external_radius) - 12;
	inaltime = f_inaltime_linear_bearing_housing(bearing_external_radius);

	dist_to_screw = f_dist_to_screw_linear_bearing_housing(bearing_external_radius);

	difference (){
		union(){
			translate ([-lungime / 2, -latime / 2, 0]) my_cube_rounded(lungime, latime, inaltime);
// urechile
			translate ([-(lungime / 2 - 2), 0, 0]) cylinder(h = inaltime, r = 7, $fn = 50);
			translate ([lungime / 2 - 2, -(latime / 2 - 7), 0]) cylinder(h = inaltime, r = 7, $fn = 50);
			translate ([lungime / 2 - 2, latime / 2 - 7, 0]) cylinder(h = inaltime, r = 7, $fn = 50);
		}
        
		// canal ghidaj
		hull(){
			translate ([0, -latime / 2, inaltime] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = latime + 2 * display_tolerance, r = bearing_internal_radius + 1, $fn = 100);
			translate ([0, -latime / 2, inaltime - bearing_external_radius] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = latime + 2 * display_tolerance, r = bearing_internal_radius + 1, $fn = 100);
		}
		// rulment
		hull(){
			translate ([0, -bearing_height / 2, inaltime]) rotate([-90, 0, 0]) cylinder (h = bearing_height, r = bearing_external_radius, $fn = 100);
			translate ([0, -bearing_height / 2, inaltime - bearing_external_radius]) rotate([-90, 0, 0]) cylinder (h = bearing_height, r = bearing_external_radius, $fn = 100);
		}
		// m4 holes
		translate ([-dist_to_screw, 0, 0])gauri_bearing_housing_3(bearing_external_radius, inaltime, latime);
// taietura
		translate ([dist_to_screw , 0, 0] - display_tolerance_z) cylinder (h = inaltime + 2 * display_tolerance, r = 12);
        
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
module linear_bearing_housing_cu_4_urechi(bearing_external_radius, bearing_internal_radius, bearing_height, dist_between_ears)
{
	latime = f_latime_linear_bearing_housing_small(bearing_height);
	lungime = f_lungime_linear_bearing_housing(bearing_external_radius) - 12;
	inaltime = f_inaltime_linear_bearing_housing(bearing_external_radius);

	dist_to_screw = f_dist_to_screw_linear_bearing_housing(bearing_external_radius);

	difference (){
		union(){
			translate ([-lungime / 2, -latime / 2, 0]) my_cube_rounded(lungime, latime, inaltime);
// urechile
			//translate ([-(lungime / 2 - 2), 0, 0]) cylinder(h = inaltime, r = 7, $fn = 50);
            
			translate ([lungime / 2, - dist_between_ears / 2, 0]) cylinder(h = inaltime, r = 6, $fn = 50);
			translate ([lungime / 2, dist_between_ears / 2, 0]) cylinder(h = inaltime, r = 6, $fn = 50);
			translate ([-lungime / 2, - dist_between_ears / 2, 0]) cylinder(h = inaltime, r = 6, $fn = 50);
			translate ([-lungime / 2, dist_between_ears / 2, 0]) cylinder(h = inaltime, r = 6, $fn = 50);
		}
        
		// canal ghidaj
		hull(){
			translate ([0, -latime / 2, inaltime] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = latime + 2 * display_tolerance, r = bearing_internal_radius + 1, $fn = 100);
			translate ([0, -latime / 2, inaltime - bearing_external_radius] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = latime + 2 * display_tolerance, r = bearing_internal_radius + 1, $fn = 100);
		}
		// rulment
		hull(){
			translate ([0, -bearing_height / 2, inaltime]) rotate([-90, 0, 0]) cylinder (h = bearing_height, r = bearing_external_radius, $fn = 100);
			translate ([0, -bearing_height / 2, inaltime - bearing_external_radius]) rotate([-90, 0, 0]) cylinder (h = bearing_height, r = bearing_external_radius, $fn = 100);
		}
		// m4 holes
		translate ([lungime / 2, -dist_between_ears / 2, 0] - display_tolerance_z) 
            cylinder (h = inaltime + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        translate ([lungime / 2, dist_between_ears / 2, 0] - display_tolerance_z) 
            cylinder (h = inaltime + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        
		translate ([-lungime / 2, -dist_between_ears / 2, 0] - display_tolerance_z) 
            cylinder (h = inaltime + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        translate ([-lungime / 2, dist_between_ears / 2, 0] - display_tolerance_z) 
            cylinder (h = inaltime + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        
        
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
module gauri_bearing_housing(bearing_external_radius, inaltime)
{
	dist_to_screw = f_dist_to_screw_linear_bearing_housing(bearing_external_radius);

	translate ([0, 0, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = inaltime + 2 * display_tolerance, $fn = 30);
	translate ([2 * dist_to_screw, 0, 0] - display_tolerance_z) cylinder (r = m4_screw_radius, h = inaltime + 2 * display_tolerance, $fn = 30);
}
///////////////////////////////////////////////////////////////////////////////////////////////
module linear_bearing_housing(bearing_external_radius, bearing_internal_radius, bearing_height)
{
	latime = f_latime_linear_bearing_housing(bearing_height) ;
	lungime = f_lungime_linear_bearing_housing(bearing_external_radius) - 12;
	inaltime = f_inaltime_linear_bearing_housing(bearing_external_radius);

	dist_to_screw = f_dist_to_screw_linear_bearing_housing(bearing_external_radius);
	//echo("diameter = ", lungime);
	//echo("diameter mic (taiat) = ", latime);

	//echo ("dist between screws linear_bearing_housing", dist_to_screw);

	difference (){
		union(){
			translate ([-lungime / 2, -latime / 2, 0]) my_cube_rounded(lungime, latime, inaltime);
// urechile
			translate ([-(lungime / 2 - 2), 0, 0]) cylinder(h = inaltime, r = 8, $fn = 50);
			translate ([lungime / 2 - 2, 0, 0]) cylinder(h = inaltime, r = 8, $fn = 50);
		}
		// canal ghidaj
		hull(){
			translate ([0, -latime / 2, inaltime] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = latime + 2 * display_tolerance, r = bearing_internal_radius + 1, $fn = 100);
			translate ([0, -latime / 2, inaltime - bearing_external_radius] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = latime + 2 * display_tolerance, r = bearing_internal_radius + 1, $fn = 100);
		}
		// gaura rulment
		hull(){
			translate ([0, -bearing_height / 2, inaltime]) rotate([-90, 0, 0]) cylinder (h = bearing_height, r = bearing_external_radius, $fn = 100);
			translate ([0, -bearing_height / 2, inaltime - bearing_external_radius]) rotate([-90, 0, 0]) cylinder (h = bearing_height, r = bearing_external_radius, $fn = 100);
		}
		// m4 holes
		translate ([-dist_to_screw, 0, 0])  gauri_bearing_housing(bearing_external_radius, inaltime);
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
module linear_bearing_housing_y()
{
	linear_bearing_housing(lm10uu_external_radius, smooth_rod_10_radius, lm10uu_height);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module linear_bearing_housing_z()
{
	linear_bearing_housing_cu_4_urechi(lm10uu_external_radius, smooth_rod_10_radius, lm10uu_height, 18);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module linear_bearing_housing_x()
{
	linear_bearing_housing_cu_3_urechi(lm10luu_external_radius, smooth_rod_10_radius, lm10luu_height);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

linear_bearing_housing_z();
