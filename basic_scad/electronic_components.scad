// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <params_electronic_components.scad>

//--------------------------------------------------------------------
module potentiometer()
{
    cylinder (h = 6.5, r= 9.5);
    
    translate ([0, 0, 6]) cylinder (h = 10, r = 5);
    translate ([0, 0, 16]) cylinder (h = 10, r = 3);
    
}

//--------------------------------------------------------------------
module fan(latura, inaltime)
{
	difference(){
		color ("Black") cube([latura, latura, inaltime]);
		translate ([latura / 2, latura / 2, 0] - display_tolerance_z) cylinder(h = inaltime + 2 * display_tolerance, r = latura / 2 - 1, $fn = 50);
		// 4 gauri mici
		translate ([3, 3, 0] - display_tolerance_z) cylinder(h = inaltime + 2 * display_tolerance, r = 1.5, $fn = 50);
		translate ([latura - 3, 3, 0] - display_tolerance_z) cylinder(h = inaltime + 2 * display_tolerance, r = 1.5, $fn = 50);
		translate ([3, latura - 3, 0] - display_tolerance_z) cylinder(h = inaltime + 2 * display_tolerance, r = 1.5, $fn = 50);
		translate ([latura - 3, latura - 3, 0] - display_tolerance_z) cylinder(h = inaltime + 2 * display_tolerance, r = 1.5, $fn = 50);
		// mijlocu
	}
	color ("Black") translate ([latura / 2, latura / 2, 0]) cylinder (h = inaltime, r= 5, $fn = 50);
}
//--------------------------------------------------------------------

module a4988()
{
    color("green") cube(a4988_size);
}
//--------------------------------------------------------------------

fan(50, 10);

potentiometer();