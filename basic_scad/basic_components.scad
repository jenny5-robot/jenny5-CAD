// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/utils.scad>

include <config.scad>


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
module teava_dreptunghiulara(lungime, latime, grosime_perete, inaltime)
{
    difference(){
		cube([lungime, latime, inaltime]);
		translate ([grosime_perete, grosime_perete, 0]- display_tolerance_z) cube([lungime - 2 * grosime_perete, latime - 2 * grosime_perete, inaltime + 2 * display_tolerance]);
	}
}
//--------------------------------------------------------------
module cube_empty(latura_interioara, latura_exterioara, inaltime)
{
	difference(){
		translate ([-latura_exterioara / 2, - latura_exterioara / 2, 0]) cube([latura_exterioara, latura_exterioara, inaltime]);
		translate ([- latura_interioara / 2, - latura_interioara / 2, 0] - display_tolerance_z) cube([latura_interioara, latura_interioara, inaltime + 2 * display_tolerance]);
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
module U(length, base, height, grosime_perete)
{
    //render(){
        difference(){
            cube ([length, base, height]);
            translate ([-display_tolerance, grosime_perete, grosime_perete]) cube ([length + 2 * display_tolerance, base - 2 * grosime_perete, height - grosime_perete + display_tolerance]);
        }
    //}
}
//--------------------------------------------------------------
module L(length, latura_mare_L, latura_mica_L, grosime_perete_L)
{
   
        difference(){
            cube ([latura_mica_L, length, latura_mare_L]);
            translate ([grosime_perete_L, -display_tolerance, grosime_perete_L]) cube ([latura_mica_L - grosime_perete_L + display_tolerance, length + 2 * display_tolerance, latura_mare_L - grosime_perete_L + display_tolerance]);
        }
    
}
//--------------------------------------------------------------
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
module half_cylinder(_h, _r, _fn)
{
    difference(){
        cylinder (h = _h, r = _r, $fn = _fn);
        translate ([-_r, -_r, 0] - display_tolerance_z)cube([_r, 2 * _r, _h + 2 * display_tolerance]);
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module half_box(size_x, size_y, size_z, wall_thick_x, wall_thick_y, wall_thick_z)
{
    difference(){
      cube([size_x, size_y, size_z]); 
      translate ([wall_thick_x, 0, wall_thick_z] - display_tolerance_y) cube([size_x - 2 * wall_thick_x, size_y - wall_thick_y, size_z - wall_thick_z] + display_tolerance_yz); 
        translate([0, 0, wall_thick_z] - display_tolerance_x) rotate([atan((size_z - wall_thick_z) / (size_y - wall_thick_y)), 0, 0]) cube([size_x, 2 *size_y, size_z] + 2 * display_tolerance_x); 
    }
}
////////////////////////////////////////////////////////tests/////////////////////////////////////////////////////////
cube_rounded_x_holed_z([60, 40, 10], 10);

//half_box(100, 50, 30, 2, 3, 3);
//U(400, 40, 40, 3);

//L(100);

//hexa_screw(m6_screw_radius, 60, m6_nut_radius, m6_nut_thick);

//sunken_screw(m6_screw_radius, 60, m6_nut_radius, m6_nut_thick);

//inbus_screw(m8_screw_radius, 40, m8_nut_radius, m8_nut_thick);

//screw(m8_screw_radius, 40, m8_nut_radius, m8_nut_thick);

//nut_fluture(m4_screw_radius, m4_nut_radius, m4_nut_height);