use <../basic_scad/parametric_involute_gear_v5.0.scad>
include <../basic_scad/params_screws_nuts_washers.scad>

//--------------------------------------------------------------------
module gear_bone()
{
    height = 10;
    difference(){
        rotate ([0, 0, 15])
		gear ( 
			number_of_teeth=12,
			circular_pitch=400,
			//pressure_angle=20,
			clearance = 0,
			gear_thickness=10,
			rim_thickness=10,
			rim_width=5,
			hub_thickness=0,
			hub_diameter=0,
			bore_diameter=0,
			//circles=6,
			backlash=0.1,
			//twist=--2,
			involute_facets=0,
			flat=false
        );
        translate ([-5.25, -5.25, 0]) cube([10.5, 10.5, 11]);
        
          // m3 screw hole
    translate ([0, 0, height / 2]) rotate([0, 90, 0]) cylinder (h = 20, r = 1.4, $fn = 30);  
    // m3 nut hole
    translate ([10.5 / 2, 0, height / 2]) rotate([0, 90, 0]) cylinder (h = 3, r = m3_nut_radius + 0.1, $fn = 6);  

    }
}
//--------------------------------------------------------------------
module pot_gear(num_teeth, screw_angle, internal_radius = 3.3, height = 8)
{
    
    difference(){
        rotate ([0, 0, screw_angle])
		gear ( 
			number_of_teeth=num_teeth,
			circular_pitch=400,
			//pressure_angle=20,
			clearance = 0,
			gear_thickness=height,
			rim_thickness=height,
			rim_width=5,
			hub_thickness=0,
			hub_diameter=0,
			bore_diameter=0,
			//circles=6,
			backlash=0.1,
			//twist=--2,
			involute_facets=0,
			flat=false
        );
        cylinder (h = height + 1, r = internal_radius, $fn = 30);
        
          // m3 screw hole
    translate ([0, 0, height / 2]) rotate([0, 90, 0]) cylinder (h = 22, r = 1.4, $fn = 30);  
    // m3 nut hole
    hull(){
      translate ([internal_radius + 2, 0, 0]) rotate([0, 90, 0]) cylinder (h = 2.5, r = m3_nut_radius, $fn = 6);  
      translate ([internal_radius + 2, 0, height]) rotate([0, 90, 0]) cylinder (h = 2.5, r = m3_nut_radius, $fn = 6);  
    }

    }
}
//--------------------------------------------------------------------

pot_gear(num_teeth = 12, screw_angle = 10, height = 8);// 2x cot, inainte de cot

//pot_gear(11, 13, 6.6, 10); // rulment

//pot_gear(13, 13);

//pot_gear(18, 10);

//pot_gear(19, 10);

//pot_gear(12, 15, 4, 10);

//gear_bone();