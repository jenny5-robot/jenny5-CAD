// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

use <stepper_motors_utils.scad>
include <params_stepper_motors.scad>
include <params_basic_components.scad>
include <params_screws_nuts_washers.scad>

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_motor(motor_width, motor_height, shaft_length = nema_17_shaft_length, shaft_radius = m5_screw_radius)
{

	latura_interioara = motor_width + 12;
	latura_exterioara = latura_interioara + 15;
	union (){
		difference(){
			union(){
				color("Gainsboro") translate ([-motor_width / 2, -motor_width / 2, 0]) cube([motor_width, motor_width, 10]);
				translate([0, 0, 10]) color("black")  translate ([-motor_width / 2, -motor_width / 2, 0]) cube([motor_width, motor_width, motor_height - 20]);
				translate([0, 0, motor_height - 10]) color("Gainsboro")  translate ([-motor_width / 2, -motor_width / 2, 0]) cube([motor_width, motor_width, 10]);
				color("Gainsboro") cylinder_empty (2, nema_17_motor_hole_radius_camiel, 5);
	// ax
			color("Silver")cylinder (h = motor_height + shaft_length, r = shaft_radius, $fn = 30); 

			}
            /*
			color("black")  translate ([motor_width / 2, motor_width / 2, 10] - display_tolerance_z) 
rotate ([0, 0, 45]) translate ([- latura_exterioara / 2, -latura_exterioara / 2, 0]) cube_empty(latura_interioara - 3, latura_exterioara, motor_height - 20 + 2 * display_tolerance);
			color("Gainsboro")  translate ([motor_width / 2, motor_width / 2, 0] - display_tolerance_z) 
rotate ([0, 0, 45]) translate ([- latura_exterioara / 2, -latura_exterioara / 2, 0]) cube_empty(latura_interioara, latura_exterioara, 10 + display_tolerance);
			color("Gainsboro")  translate ([motor_width / 2, motor_width / 2, motor_height - 10]) 
rotate ([0, 0, 45]) translate ([- latura_exterioara / 2, -latura_exterioara / 2, 0]) cube_empty(latura_interioara, latura_exterioara, 10 + display_tolerance);
            */
		// gauri baza
			 translate ([-motor_width / 2, -motor_width / 2, 0])  gauri_nema17(1, m5_screw_radius);
		// gauri m3 top
			 translate ([-motor_width / 2, -motor_width / 2, 0]) translate ([0, 0, motor_height]) gauri_nema17(3, m3_screw_radius);
		// gaura ax jos
			color("Silver") translate (- display_tolerance_z) cylinder (h = 3, r = 5, $fn = 30); 
		// taie axul
			translate ([motor_width / 2 + 2, motor_width / 2 - 2, motor_height]) cube ([2, 4, shaft_length]);
		}
			// cables
		translate ([-3, motor_width / 2 + 10, 3]) rotate([90, 0, 0]) color("Red") cylinder (h= 10, r = 0.5);
		translate ([-1, motor_width / 2 + 10, 3]) rotate([90, 0, 0]) color("Black") cylinder (h= 10, r = 0.5);
		translate ([1, motor_width / 2 + 10, 3]) rotate([90, 0, 0]) color("Blue") cylinder (h= 10, r = 0.5);
		translate ([3, motor_width / 2 + 10, 3]) rotate([90, 0, 0]) color("Green") cylinder (h= 10, r = 0.5);
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_motor_with_gearbox(motor_width, motor_height, gearbox_length, gearbox_radius, gearbox_base_height, gearbox_screw_holes_position, gearbox_shaft_length, gearbox_shaft_radius)
{
	nema_motor(motor_width, motor_height);
    // gearbox base
    if (gearbox_base_height > 0)
        translate ([-motor_width / 2, -motor_width / 2, motor_height]) cube([motor_width, motor_width, gearbox_base_height]);
// gearbox
	difference(){
        translate ([0, 0, motor_height + gearbox_base_height]) cylinder ( h =  gearbox_length, r = gearbox_radius, $fn = 50);
// gaurile gearbox
        for (i=[0:4])
    translate ([0, 0, motor_height + gearbox_length + gearbox_base_height - 3] + gearbox_screw_holes_position[i]) cylinder (h = 4, r = m3_screw_radius, $fn = 20);
	}
// ax gearbox
	translate ([0, 0, motor_height + gearbox_length + gearbox_base_height]) cylinder ( h =  gearbox_shaft_length, r = gearbox_shaft_radius, $fn = 30);

}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_17()
{
	nema_motor(nema_17_width, nema_17_height, nema_17_shaft_length);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_23_57BYGH603()
{
	nema_motor(nema_23_57BYGH603_width, nema_23_57BYGH603_height, nema_23_57BYGH603_shaft_length);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_17_with_screw()
{
	nema_motor(nema_17_width, nema_17_height, 200, 4);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_11()
{
	nema_motor(nema_11_width, nema_11_height);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_11_with_gearbox()
{
	nema_motor_with_gearbox(nema_11_width, nema_11_height, nema_11_gearbox_length, nema_11_motor_gearbox_radius, 0, gearbox_nema_11_holes_position, nema_11_shaft_length, 3);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_17_with_gearbox()
{
	nema_motor_with_gearbox(nema_17_width, nema_17_height, nema_17_gearbox_length, nema_17_motor_gearbox_radius, nema_17_gearbox_base_height, gearbox_nema_17_holes_position, nema_17_shaft_length, nema_17_gearbox_shaft_radius);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_17_with_gearbox_and_screw(gearbox_shaft_length = 100)
{
    
    nema_17_with_gearbox();
    //conector prelungire
        translate ([0, 0, nema_17_height + nema_17_gearbox_base_height + nema_17_gearbox_length]) cylinder (h = 25, r = 6);
    translate ([0, 0, nema_17_height + nema_17_gearbox_base_height + nema_17_gearbox_length + nema_17_gearbox_shaft_length]) cylinder (h = gearbox_shaft_length, r = 4);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//nema_11_with_gearbox();

nema_17_with_gearbox_and_screw();