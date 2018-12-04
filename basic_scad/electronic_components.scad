// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <params_electronic_components.scad>
include <tolerance.scad>

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
		// 4 small holes
		translate ([3, 3, 0] - display_tolerance_z) cylinder(h = inaltime + 2 * display_tolerance, r = 1.5, $fn = 50);
		translate ([latura - 3, 3, 0] - display_tolerance_z) cylinder(h = inaltime + 2 * display_tolerance, r = 1.5, $fn = 50);
		translate ([3, latura - 3, 0] - display_tolerance_z) cylinder(h = inaltime + 2 * display_tolerance, r = 1.5, $fn = 50);
		translate ([latura - 3, latura - 3, 0] - display_tolerance_z) cylinder(h = inaltime + 2 * display_tolerance, r = 1.5, $fn = 50);
		
	}
	color ("Black") translate ([latura / 2, latura / 2, 0]) cylinder (h = inaltime, r= 5, $fn = 50);
}
//--------------------------------------------------------------------
module heat_sink(external_radius, internal_radius, number_of_wings)
{
	heatsink_wing_height = 1;
	difference(){
		union(){
			cylinder ( h = heatsink_wing_height, r = external_radius, $fn = 50);
			for (i = [1:number_of_wings - 1]){
				translate ([0, 0, (2 * i - 1) * heatsink_wing_height]) cylinder ( h = heatsink_wing_height, r = internal_radius + 1, $fn = 50);
				translate ([0, 0, 2 * i * heatsink_wing_height]) cylinder ( h = heatsink_wing_height, r = external_radius, $fn = 50);
			}
		}
		translate ([0, 0, -tolerance]) cylinder ( h = (2 * number_of_wings  - 1) * heatsink_wing_height + 2 * tolerance, r = internal_radius, $fn = 50);
	}
}
//--------------------------------------------------------------
module a4988()
{
    color("green") cube(a4988_size);
}
//--------------------------------------------------------------------

fan(50, 10);

potentiometer();