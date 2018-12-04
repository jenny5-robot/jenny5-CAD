// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
use <utils.scad>

include <config.scad>
include <tolerance.scad>


//--------------------------------------------------------------
module my_cube_rounded(length, width, height)
{
	radius = 3;

	if (height > radius){
		difference(){
			cube([length, width, height]);
			translate ([length - radius+tolerance, width - radius+tolerance, 0] - tolerance_z) coloana_sferica(height + 2 * tolerance, 3);
			translate ([radius - tolerance, width - radius+tolerance, 0] - tolerance_z) rotate ([0, 0, 90]) coloana_sferica(height + 2 * tolerance, 3);
			translate ([length - radius+tolerance, radius - tolerance, 0] - tolerance_z) rotate ([0, 0, -90]) coloana_sferica(height + 2 * tolerance, 3);
			translate ([radius-tolerance, radius - tolerance, 0] - tolerance_z) rotate ([0, 0, 180]) coloana_sferica(height + 2 * tolerance, 3);
		}	
	}
	else{
		difference(){
			cube([length, width, height]);
			translate ([length - height + tolerance, width - height + tolerance, 0] - tolerance_z) coloana_sferica(height + 2 * tolerance, height);
			translate ([height - tolerance, width - height+tolerance, 0] - tolerance_z) rotate ([0, 0, 90]) coloana_sferica(height + 2 * tolerance, height);
			translate ([length - height+tolerance, height - tolerance, 0] - tolerance_z) rotate ([0, 0, -90]) coloana_sferica(height + 2 * tolerance, height);
			translate ([height-tolerance, height - tolerance, 0] - tolerance_z) rotate ([0, 0, 180]) coloana_sferica(height + 2 * tolerance, height);
		}	
	}
}
//--------------------------------------------------------------
module my_cube_rounded2(cube_sizes)
{
	radius = 3;

	if (cube_sizes[2] > radius){
		difference(){
			cube(cube_sizes);
			translate ([cube_sizes[0] - radius + tolerance, cube_sizes[1] - radius + tolerance, 0] - tolerance_z) coloana_sferica(cube_sizes[2] + 2 * tolerance, 3);
			translate ([radius - tolerance, cube_sizes[1] - radius + tolerance, 0] - tolerance_z) rotate ([0, 0, 90]) coloana_sferica(cube_sizes[2] + 2 * tolerance, 3);
			translate ([cube_sizes[0] - radius + tolerance, radius - tolerance, 0] - tolerance_z) rotate ([0, 0, -90]) coloana_sferica(cube_sizes[2] + 2 * tolerance, 3);
			translate ([radius-tolerance, radius - tolerance, 0] - tolerance_z) rotate ([0, 0, 180]) coloana_sferica(cube_sizes[2] + 2 * tolerance, 3);
		}	
	}
	else{
		difference(){
			cube(cube_sizes);
			translate ([cube_sizes[0] - cube_sizes[2] + tolerance, cube_sizes[1] - cube_sizes[2] + tolerance, 0] - tolerance_z) coloana_sferica(cube_sizes[2] + 2 * tolerance, cube_sizes[2]);
			translate ([cube_sizes[2] - tolerance, cube_sizes[1] - cube_sizes[2]+tolerance, 0] - tolerance_z) rotate ([0, 0, 90]) coloana_sferica(cube_sizes[2] + 2 * tolerance, cube_sizes[2]);
			translate ([cube_sizes[0] - cube_sizes[2]+tolerance, cube_sizes[2] - tolerance, 0] - tolerance_z) rotate ([0, 0, -90]) coloana_sferica(cube_sizes[2] + 2 * tolerance, cube_sizes[2]);
			translate ([cube_sizes[2]-tolerance, cube_sizes[2] - tolerance, 0] - tolerance_z) rotate ([0, 0, 180]) coloana_sferica(cube_sizes[2] + 2 * tolerance, cube_sizes[2]);
		}	
	}
}
//--------------------------------------------------------------
module my_cube_rounded2_strengthen(cube_sizes, strength_h = 2, strength_w = 2)
{
	radius = 3;
    
    

	if (cube_sizes[2] > radius){
		difference(){
			cube([cube_sizes[0], cube_sizes[1], cube_sizes[2] + strength_h]);
			translate ([0, strength_w, cube_sizes[2]]) cube([cube_sizes[0], cube_sizes[1] - 2 * strength_w, strength_h + 1]);
            
			translate ([cube_sizes[0] - radius + tolerance, cube_sizes[1] - radius + tolerance, 0] - tolerance_z) coloana_sferica(cube_sizes[2] + strength_h + 2 * tolerance, 3);
			translate ([radius - tolerance, cube_sizes[1] - radius + tolerance, 0] - tolerance_z) rotate ([0, 0, 90]) coloana_sferica(cube_sizes[2] + strength_h + 2 * tolerance, 3);
			translate ([cube_sizes[0] - radius + tolerance, radius - tolerance, 0] - tolerance_z) rotate ([0, 0, -90]) coloana_sferica(cube_sizes[2] + strength_h + 2 * tolerance, 3);
			translate ([radius-tolerance, radius - tolerance, 0] - tolerance_z) rotate ([0, 0, 180]) coloana_sferica(cube_sizes[2] + strength_h + 2 * tolerance, 3);
		}	
	}
	else{
		difference(){
			cube([cube_sizes[0], cube_sizes[1], cube_sizes[2] + strength_h]);
            translate ([0, strength_w, cube_sizes[2]]) cube([cube_sizes[0], cube_sizes[1] - 2 * strength_w, strength_h + 1]);
            
			translate ([cube_sizes[0] - cube_sizes[2] + tolerance, cube_sizes[1] - cube_sizes[2] + tolerance, 0] - tolerance_z) coloana_sferica(cube_sizes[2] + strength_h + 2 * tolerance, cube_sizes[2]);
			translate ([cube_sizes[2] - tolerance, cube_sizes[1] - cube_sizes[2]+tolerance, 0] - tolerance_z) rotate ([0, 0, 90]) coloana_sferica(cube_sizes[2] + strength_h + 2 * tolerance, cube_sizes[2]);
			translate ([cube_sizes[0] - cube_sizes[2]+tolerance, cube_sizes[2] - tolerance, 0] - tolerance_z) rotate ([0, 0, -90]) coloana_sferica(cube_sizes[2] + strength_h + 2 * tolerance, cube_sizes[2]);
			translate ([cube_sizes[2]-tolerance, cube_sizes[2] - tolerance, 0] - tolerance_z) rotate ([0, 0, 180]) coloana_sferica(cube_sizes[2] + strength_h + 2 * tolerance, cube_sizes[2]);
		}	
	}
}
//--------------------------------------------------------------
module my_cube_rounded3_x(cube_sizes)
{
    translate ([cube_sizes[1] / 2, 0, 0]) cube([cube_sizes[0] - cube_sizes[1], cube_sizes[1], cube_sizes[2]]);
    
    translate ([cube_sizes[1] / 2, cube_sizes[1] / 2, 0]) cylinder (h = cube_sizes[2] , r = cube_sizes[1] / 2, $fn = 50);
    
    translate ([cube_sizes[0] - cube_sizes[1] / 2, cube_sizes[1] / 2, 0]) cylinder (h = cube_sizes[2] , r = cube_sizes[1] / 2, $fn = 50);
}
//--------------------------------------------------------------
module my_cube_rounded_opuse(length, width, height, radius)
{

	if (height > radius){
		difference(){
			cube([length, width, height]);
			translate ([length - radius+tolerance, width - radius+tolerance, 0] - tolerance_z) coloana_sferica(height + 2 * tolerance, radius);
//			translate ([radius - tolerance, width - radius+tolerance, 0]) rotate ([0, 0, 90]) coloana_sferica(height, 3);
//			translate ([length - radius+tolerance, radius - tolerance, 0]) rotate ([0, 0, -90]) coloana_sferica(height, 3);
			translate ([radius-tolerance, radius - tolerance, 0] - tolerance_z) rotate ([0, 0, 180]) coloana_sferica(height + 2 * tolerance, radius);
		}	
	}
	else{
		difference(){
			cube([length, width, height]);
			translate ([length - height + tolerance, width - height + tolerance, 0] - tolerance_z) coloana_sferica(height + 2 * tolerance, height);
//			translate ([height - tolerance, width - height+tolerance, 0]) rotate ([0, 0, 90]) coloana_sferica(height, height);
//			translate ([length - height+tolerance, height - tolerance, 0]) rotate ([0, 0, -90]) coloana_sferica(height, height);
			translate ([height-tolerance, height - tolerance, 0] - tolerance_z) rotate ([0, 0, 180]) coloana_sferica(height + 2 * tolerance, height);
		}	
	}
}
//----------------------------------------------------------------
module cube_rounded_x_holed_z(cube_size, hole_radius)
{
    difference(){
        hull(){
            translate ([0, cube_size[2] / 2, cube_size[2] / 2]) rotate([0, 90, 0]) cylinder (h = cube_size[0], r = cube_size[2] / 2, $fn = 30);
            translate ([0, -cube_size[2] / 2 + cube_size[1], cube_size[2] / 2]) rotate([0, 90, 0]) cylinder (h = cube_size[0], r = cube_size[2] / 2, $fn = 30);
        }
        translate ([cube_size[0] / 2, cube_size[1] / 2, 0] - display_tolerance_z) cylinder (h = cube_size[2] + 2 * display_tolerance, r = hole_radius);
    }
}
//----------------------------------------------------------------
module rectangular_tube(length, width, wall_thick, height)
{
    difference(){
		cube([length, width, height]);
		translate ([wall_thick, wall_thick, 0]- display_tolerance_z) cube([length - 2 * wall_thick, width - 2 * wall_thick, height + 2 * display_tolerance]);
	}
}
//--------------------------------------------------------------
module rectangular_tube_with_rounded_hole(length, width, hole_radius, height)
{
    difference(){
		cube([length, width, height]);
		translate ([length / 2, width / 2, 0] - display_tolerance_z) cylinder (h = height + 2 * display_tolerance, r = hole_radius) ;
	}
}
//--------------------------------------------------------------
module cube_empty(inside_edge, outside_edge, height)
{
	difference(){
		translate ([-outside_edge / 2, - outside_edge / 2, 0]) cube([outside_edge, outside_edge, height]);
		translate ([- inside_edge / 2, - inside_edge / 2, 0] - display_tolerance_z) cube([inside_edge, inside_edge, height + 2 * display_tolerance]);
	}
}
//--------------------------------------------------------------
module cylinder_empty(_h, external_radius, internal_radius, fn = 30)
{
	difference(){
		cylinder ( h = _h, r = external_radius, $fn = fn);
		translate ([0, 0, - display_tolerance]) cylinder ( h = _h + 2 * display_tolerance, r = internal_radius, $fn = fn);
	}
}
//--------------------------------------------------------------
module my_cube_rounded4(cube_size, height, external_radius, fn = 30)
{
    difference(){
        translate ([-cube_size / 2, -cube_size / 2, 0]) cube([cube_size, cube_size, height]);
       translate (-display_tolerance_z) cylinder_empty(_h = height + 2 * display_tolerance, external_radius = cube_size * 0.71, internal_radius = external_radius, fn = fn);
    }
}
//--------------------------------------------------------------
module half_cylinder(_h, _r, _fn)
{
    difference(){
        cylinder (h = _h, r = _r, $fn = _fn);
        translate ([-_r, -_r, 0] - display_tolerance_z)cube([_r, 2 * _r, _h + 2 * display_tolerance]);
    }
}
//--------------------------------------------------------------
module half_box(size_x, size_y, size_z, wall_thick_x, wall_thick_y, wall_thick_z)
{
    difference(){
      cube([size_x, size_y, size_z]); 
      translate ([wall_thick_x, 0, wall_thick_z] - display_tolerance_y) cube([size_x - 2 * wall_thick_x, size_y - wall_thick_y, size_z - wall_thick_z] + display_tolerance_yz); 
        translate([0, 0, wall_thick_z] - display_tolerance_x) rotate([atan((size_z - wall_thick_z) / (size_y - wall_thick_y)), 0, 0]) cube([size_x, 2 *size_y, size_z] + 2 * display_tolerance_x); 
    }
}
//--------------------------------------------------------------
module corner(length, width, height, wall_thick)
{
    difference(){
        cube([length, width, height]);
        translate ([wall_thick, wall_thick, wall_thick]) cube([length - wall_thick, width - wall_thick, height - wall_thick] + display_tolerance_xyz);
    }
}
//--------------------------------------------------------------
module arc_thick(radius_exterior = 100, radius_interior = 90, thick = 10, angle = 90)
{
    intersection(){
        difference(){
            cylinder(h = thick, r = radius_exterior);
            translate (-display_tolerance_z) cylinder(h = thick + 2 * display_tolerance, r = radius_interior);
        }
        cube([radius_exterior, radius_exterior, thick]);
        rotate(angle - 90) cube([radius_exterior, radius_exterior, thick]);
    }
}
//--------------------------------------------------------------
module arc_thick_rounded(radius_exterior = 100, radius_interior = 90, thick = 10, angle = 90)
{
    intersection(){
        difference(){
            cylinder(h = thick, r = radius_exterior, $fn = 100);
            translate (-display_tolerance_z) cylinder(h = thick + 2 * display_tolerance, r = radius_interior, $fn = 100);
        }
        cube([radius_exterior, radius_exterior, thick]);
        rotate(angle - 90) cube([radius_exterior, radius_exterior, thick]);
    }
    rotate ([0, 0, angle]) translate([(radius_exterior + radius_interior) / 2, 0, 0]) cylinder (h = thick, r = (radius_exterior - radius_interior) / 2, $fn = 30);
}
//--------------------------------------------------------------

//arc_thick_rounded(angle = 45);

//corner(40, 20, 30, 3);

//cube_rounded_x_holed_z([60, 40, 10], 10);

//half_box(100, 50, 30, 2, 3, 3);

my_cube_rounded4(cube_size = 20, height = 20, external_radius = 12.5, fn = 100);