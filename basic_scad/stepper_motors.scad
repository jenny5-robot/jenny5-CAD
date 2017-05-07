// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

use <basic_components.scad>
include <params_stepper_motors.scad>
include <params_basic_components.scad>
include <params_screws_nuts_washers.scad>

//--------------------------------------------------------------
module nema_motor_without_shaft(motor_width, motor_height, top_cylinder_radius, top_cylinder_height = 2, nema_holes)
{
	union (){
		difference(){
			union(){
				color("Gainsboro") translate ([-motor_width / 2, -motor_width / 2, 0]) cube([motor_width, motor_width, 10]);
				translate([0, 0, 10]) color("black")  translate ([-motor_width / 2, -motor_width / 2, 0]) cube([motor_width, motor_width, motor_height - 20]);
				translate([0, 0, motor_height - 10]) color("Gainsboro")  translate ([-motor_width / 2, -motor_width / 2, 0]) cube([motor_width, motor_width, 10]);
				translate([0, 0, motor_height])color("Gainsboro") cylinder_empty (top_cylinder_height, top_cylinder_radius, 5);
			}

		// base holes
			for (i = [1 : 4])
                translate (nema_holes[i]) cylinder (r = m5_screw_radius, h = 5, $fn = 20); 
		// top M3 holes
            for (i = [1 : 4])
                translate (nema_holes[i] + [0, 0, motor_height - 4]) cylinder (r = m3_screw_radius, h = 5, $fn = 10); 
		// shaft hole bottom
			color("Silver") translate (- display_tolerance_z) cylinder (h = 3, r = 5, $fn = 30); 
		}
			// cables
		translate ([-3, motor_width / 2 + 10, 3]) rotate([90, 0, 0]) color("Red") cylinder (h= 10, r = 0.5);
		translate ([-1, motor_width / 2 + 10, 3]) rotate([90, 0, 0]) color("Black") cylinder (h= 10, r = 0.5);
		translate ([1, motor_width / 2 + 10, 3]) rotate([90, 0, 0]) color("Blue") cylinder (h= 10, r = 0.5);
		translate ([3, motor_width / 2 + 10, 3]) rotate([90, 0, 0]) color("Green") cylinder (h= 10, r = 0.5);
	}
}
//--------------------------------------------------------------
module nema_motor(motor_width, motor_height, shaft_length = nema_17_shaft_length, shaft_radius = m5_screw_radius, top_cylinder_radius, top_cylinder_height = 2, nema_holes)
{
    nema_motor_without_shaft(motor_width=motor_width, motor_height=motor_height, top_cylinder_radius=top_cylinder_radius, top_cylinder_height = top_cylinder_height, nema_holes=nema_holes);
	// shaft
	color("Silver")cylinder (h = motor_height + shaft_length, r = shaft_radius, $fn = 30); 
}
//--------------------------------------------------------------
module linear_nema_motor(motor_width, motor_height, shaft_length, shaft_radius = m5_screw_radius, top_cylinder_radius, top_cylinder_height = 2, nema_holes, shaft_position)
{
    nema_motor_without_shaft(motor_width=motor_width, motor_height=motor_height, top_cylinder_radius=top_cylinder_radius, top_cylinder_height = top_cylinder_height, nema_holes=nema_holes);
	// shaft
	color("Silver") 
    translate ([0, 0, shaft_position]) cylinder (h = shaft_length, r = shaft_radius, $fn = 30); 
}
//--------------------------------------------------------------
module nema_motor_with_gearbox(motor_width, motor_height, gearbox_length, gearbox_radius, gearbox_base_height, gearbox_screw_holes_position, gearbox_shaft_length, gearbox_shaft_radius)
{
	nema_motor(motor_width, motor_height);
    // gearbox base
    if (gearbox_base_height > 0)
        color ("gray") translate ([-motor_width / 2, -motor_width / 2, motor_height]) cube([motor_width, motor_width, gearbox_base_height]);
// gearbox
	difference(){
        color ("gray") translate ([0, 0, motor_height + gearbox_base_height]) cylinder ( h =  gearbox_length, r = gearbox_radius, $fn = 50);
// gearbox holes
        for (i=[0:4])
    translate ([0, 0, motor_height + gearbox_length + gearbox_base_height - 3] + gearbox_screw_holes_position[i]) cylinder (h = 4, r = m3_screw_radius, $fn = 20);
	}
// gearbox shaft
	color("black") translate ([0, 0, motor_height + gearbox_length + gearbox_base_height]) cylinder ( h =  gearbox_shaft_length, r = gearbox_shaft_radius, $fn = 30);

}
//--------------------------------------------------------------
module nema_17()
{
	nema_motor(nema_17_42BYGHW804_width, nema_17_42BYGHW804_height, nema_17_42BYGHW804_shaft_length, nema_17_42BYGHW804_shaft_radius, nema_17_42BYGHW804_top_radius, nema_17_42BYGHW804_top_cylinder_height, gauri_nema_17);
}
//--------------------------------------------------------------
module nema_14_39BYGL215A(shaft_length = 100, shaft_position = 0)
{
    linear_nema_motor(motor_width = nema_14_39BYGL215A_width, motor_height = nema_14_39BYGL215A_height, shaft_length = shaft_length, shaft_radius = m5_screw_radius, top_cylinder_radius = nema_14_39BYGL215A_top_radius, top_cylinder_height = 2, nema_holes = nema_14_39BYGL215A_screw_hole_position, shaft_position = shaft_position);
}
//--------------------------------------------------------------
module nema_17_42BYGHW804()
{
	nema_motor(nema_17_42BYGHW804_width, nema_17_42BYGHW804_height, nema_17_42BYGHW804_shaft_length, nema_17_42BYGHW804_shaft_radius, nema_17_42BYGHW804_top_radius, nema_17_42BYGHW804_top_cylinder_height, gauri_nema_17);
}
//--------------------------------------------------------------
module nema_23_57BYGH603()
{
	nema_motor(nema_23_57BYGH603_width, nema_23_57BYGH603_height, nema_23_57BYGH603_shaft_length);
}
//--------------------------------------------------------------
module nema_17_with_screw()
{
	nema_motor(nema_17_width, nema_17_height, 200, 4);
}
//--------------------------------------------------------------
module nema_11()
{
	nema_motor(nema_11_width, nema_11_height);
}
//--------------------------------------------------------------
module nema_11_with_27_1_gearbox()
{
	nema_motor_with_gearbox(nema_11_width, nema_11_height, nema_11_27_1_gearbox_length, nema_11_motor_gearbox_radius, 0, gearbox_nema_11_holes_position, nema_11_gearbox_shaft_length, 3);
}
//--------------------------------------------------------------
module nema_11_with_13_1_gearbox()
{
	nema_motor_with_gearbox(nema_11_width, nema_11_height, nema_11_13_1_gearbox_length, nema_11_motor_gearbox_radius, 0, gearbox_nema_11_holes_position, nema_11_gearbox_shaft_length, 3);
}
//--------------------------------------------------------------
module nema_17_with_5_1_gearbox()
{
	nema_motor_with_gearbox(nema_17_width, nema_17_height, nema_17_5_1_gearbox_height, nema_17_motor_gearbox_radius, nema_17_gearbox_base_height, gearbox_nema_17_holes_position, nema_17_shaft_length, nema_17_gearbox_shaft_radius);
}
//--------------------------------------------------------------
module nema_17_with_13_1_gearbox()
{
	nema_motor_with_gearbox(nema_17_width, nema_17_height, nema_17_13_1_gearbox_height, nema_17_motor_gearbox_radius, nema_17_gearbox_base_height, gearbox_nema_17_holes_position, nema_17_shaft_length, nema_17_gearbox_shaft_radius);
}
//--------------------------------------------------------------
module nema_17_with_19_1_gearbox()
{
	nema_motor_with_gearbox(nema_17_width, nema_17_height, nema_17_19_1_gearbox_height, nema_17_motor_gearbox_radius, nema_17_gearbox_base_height, gearbox_nema_17_holes_position, nema_17_shaft_length, nema_17_gearbox_shaft_radius);
}
//--------------------------------------------------------------
module nema_17_with_13_1_gearbox_and_screw(gearbox_shaft_length = 100)
{
    nema_17_with_13_1_gearbox();
    //conector 
        color ("gray") translate ([0, 0, nema_17_height + nema_17_gearbox_base_height + nema_17_13_1_gearbox_height]) cylinder (h = 25, r = 6);
    // screw
    color ("gray") translate ([0, 0, nema_17_height + nema_17_gearbox_base_height + nema_17_13_1_gearbox_height + nema_17_gearbox_shaft_length]) cylinder (h = gearbox_shaft_length, r = 4);
}
//--------------------------------------------------------------
//nema_17();

nema_14_39BYGL215A(100, -50);

//nema_17_42BYGHW804();

//nema_11_with_27_1_gearbox();

//nema_17_with_5_1_gearbox();

//nema_17_with_13_1_gearbox_and_screw();