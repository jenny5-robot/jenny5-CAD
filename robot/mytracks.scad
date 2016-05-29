// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


include <../basic_scad/params_basic_components.scad>


module suport_tracks()
{
	difference(){
		cylinder (h = 3, r1 = 5, r2 = 3, $fn = roundness);
		cylinder (h = 3, r = 1.9, $fn = roundness);
	}
}

module suport_tracks2()
{
	difference(){
		cylinder (h = 6, r1 = 5, r2 = 2.5, $fn = roundness);
		cylinder (h = 6, r = 1.8, $fn = roundness);
	}
}

module separator()
{
	difference(){
		cylinder (h = 4, r = 4.5, $fn = roundness);
		cylinder (h = 4, r = 2, $fn = roundness);
	}
}

module track(length = 25, width = 60, zh = 8)
{
    roundness = 100;

togue_width = 12;
    
    hole_radius = 2;
togue_tolerance = 1.2;

big_interior_hole_size = 10;
small_interior_hole_size = big_interior_hole_size - zh;


	union(){
	difference(){
		union(){
			cube(size=[length, width, zh], center = false);
			rotate([-90,0,0]) translate([length,-zh/2,0]) cylinder(h=width, r = zh/2, $fn = roundness, center = false);
			rotate([-90,0,0]) translate([0,-zh/2,0]) cylinder(h=width, r = zh/2, $fn = roundness, center = false);
		}
// holes for screws
		rotate([-90,0,0]) translate([length,-zh/2,0]) cylinder(h=width+1, r = hole_radius, $fn = roundness, center = false);
		rotate([-90,0,0]) translate([0,-zh/2,0]) cylinder(h=width+1, r = hole_radius+0.1, $fn = roundness, center = false);
// front
// center
		translate([length - zh/2 - togue_tolerance/2, (width-togue_width) / 2-togue_tolerance, 0] - display_tolerance_z) cube([zh + togue_tolerance, togue_width+2*togue_tolerance , zh + 2 * display_tolerance], center = false);
// margins
		translate([length - zh/2 - togue_tolerance/2, -0.001,0] - display_tolerance_z) cube([zh + togue_tolerance, (width -3*togue_width)/2+0.5 , zh + 2 * display_tolerance], center = false);
		translate([length - zh/2 - togue_tolerance/2, width/2 + 3*togue_width/2 - 0.5, 0] - display_tolerance_z) cube([zh + togue_tolerance, (width -3*togue_width)/2+1 , zh + 2 * display_tolerance], center = false);
	
// back
		translate([-zh/2, -1,0] - display_tolerance_z) cube([zh + togue_tolerance, (width - togue_width)/2 + 1, zh + 2 * display_tolerance], center = false);
		translate([-zh/2, width/2 + togue_width/2 ,0] - display_tolerance_z) cube([zh + togue_tolerance, (width - togue_width)/2 + display_tolerance, zh + 2 * display_tolerance], center = false);

// interior hole
//circular holes		
translate([length/2, width/2, 0] - display_tolerance_z) cylinder(h = zh + 2 * display_tolerance, r1 = 2, r2= 6,$fn= roundness,center = false);
//		translate([length/2, width/2, 0]) cylinder(h = 2, r = 3, $fn= roundness,center = false);
	}
//	rounded margins
}
}


//suport_tracks();
//suport_tracks2();
track();
//separator();