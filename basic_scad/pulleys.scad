
// adapted from the followings:

// Parametric Pulley with multiple belt profiles
// by droftarts January 2012

// Based on pulleys by:
// http://www.thingiverse.com/thing:11256 by me!
// https://github.com/prusajr/PrusaMendel by Josef Prusa
// http://www.thingiverse.com/thing:3104 by GilesBathgate
// http://www.thingiverse.com/thing:2079 by nophead

// dxf tooth data from http://oem.cadregister.com/asp/PPOW_Entry.asp?company=915217&elementID=07807803/METRIC/URETH/WV0025/F
// pulley diameter checked and modelled from data at http://www.sdp-si.com/D265/HTML/D265T016.html

/**
 * @name Pulley
 * @category Printed
 * @using 1 x m3 nut, normal or nyloc
 * @using 1 x m3x10 set screw or 1 x m3x8 grub screw
 */

include <config.scad>
include <params_basic_components.scad>

include <params_pulleys.scad>
include <params_screws_nuts_washers.scad>
include <tolerance.scad>

// The following set the pulley diameter for a given number of teeth

T2_5_pulley_dia_14 = tooth_spaceing_curvefit (0.7467,0.796,1.026, 14);
T2_5_pulley_dia_18 = tooth_spaceing_curvefit (0.7467,0.796,1.026, 18);
T2_5_pulley_dia_23 = tooth_spaceing_curvefit (0.7467,0.796,1.026, 30);
T2_5_pulley_dia_30 = tooth_spaceing_curvefit (0.7467,0.796,1.026, 49);
T2_5_pulley_dia_40 = tooth_spaceing_curvefit (0.7467,0.796,1.026, 49);
T2_5_pulley_dia_80 = tooth_spaceing_curvefit (0.7467,0.796,1.026, 101);
T2_5_pulley_dia_83 = tooth_spaceing_curvefit (0.7467,0.796,1.026, 105);
T2_5_pulley_dia_100 = tooth_spaceing_curvefit (0.7467,0.796,1.026, 127);
T2_5_pulley_dia_110 = tooth_spaceing_curvefit (0.7467,0.796,1.026, 139);
T2_5_pulley_dia_103 = tooth_spaceing_curvefit (0.7467,0.796,1.026, 130);

T5_pulley_dia_12 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 8);
T5_pulley_dia_15 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 10);
T5_pulley_dia_18 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 12);
T5_pulley_dia_20 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 13);
T5_pulley_dia_21 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 14);
T5_pulley_dia_23 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 15);
T5_pulley_dia_28 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 18);
T5_pulley_dia_31 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 20);
T5_pulley_dia_40 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 25);
T5_pulley_dia_45 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 29);
T5_pulley_dia_50 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 32);
T5_pulley_dia_51 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 33);
T5_pulley_dia_55 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 35);
T5_pulley_dia_60 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 38);
T5_pulley_dia_70 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 44);
T5_pulley_dia_78 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 50);
T5_pulley_dia_82 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 52);
T5_pulley_dia_100 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 63);
T5_pulley_dia_103 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 66);
T5_pulley_dia_26 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 17);
T5_pulley_dia_73 = tooth_spaceing_curvefit (0.6523,1.591,1.064, 46);

HTD_8mm_pulley_dia = tooth_spacing (8, 0.6858, 8);

// The following calls the pulley creation part, and passes the pulley diameter and tooth width to that module

//------------------------------------------------------------------------------------
module pulley_with_shaft(profile, num_teeth, pulley_b_ht = 7, pulley_b_dia = 17, pulley_t_ht = 8, shaft_radius = 4, nut_radius, nut_height = 0)
{  
  retainer_ht = 1.5;
  //hole for motor shaft
  difference(){
      // pulley
      pulley(profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht);
      // shaft
    translate(-display_tolerance_z) cylinder(r = shaft_radius, h = pulley_b_ht + pulley_t_ht + 2 * retainer_ht + 2 * display_tolerance, $fn = shaft_radius * 8);
      // nut hole
    if (nut_height > 0)
      translate(-display_tolerance_z) cylinder(r = nut_radius, h = nut_height + display_tolerance, $fn = 6);
  }
}
//------------------------------------------------------------------------------------
module pulley(profile, num_teeth, pulley_b_ht = 7, pulley_b_dia = 17, pulley_t_ht = 8)
{

  if ( profile == 1 ) { _pulley ( "MXL" , MXL_pulley_dia , 0.508 , 1.321, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 2 ) { _pulley ( "40 D.P." , 40DP_pulley_dia , 0.457 , 1.226, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 3 ) { _pulley ( "XL" , XL_pulley_dia , 1.27, 3.051, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 4 ) { _pulley ( "H" , H_pulley_dia ,1.905 , 5.359, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 5 ) { _pulley ( "T2.5" , T2_5_pulley_dia , 0.7 , 1.678, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 6 ) { _pulley ( "T5" , T5_pulley_dia , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 7 ) { _pulley ( "T10" , T10_pulley_dia , 2.5 , 6.13, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 8 ) { _pulley ( "AT5" , AT5_pulley_dia , 1.19 , 4.268, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 9 ) { _pulley ( "HTD 3mm" , HTD_3mm_pulley_dia , 1.289 , 2.27, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 10 ) { _pulley ( "HTD 5mm" , HTD_5mm_pulley_dia , 2.199 , 3.781, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 11 ) { _pulley ( "HTD 8mm" , HTD_8mm_pulley_dia , 3.607 , 6.603, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 12 ) { _pulley ( "GT2 2mm" , GT2_2mm_pulley_dia , 0.764 , 1.494 , profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 13 ) { _pulley ( "GT2 3mm" , GT2_3mm_pulley_dia , 1.169 , 2.31, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 14 ) { _pulley ( "GT2 5mm" , GT2_5mm_pulley_dia , 1.969 , 3.952, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 15 ) { _pulley ( "T2.5" , T2_5_pulley_dia_18 , 0.7 , 1.678, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 16 ) { _pulley ( "T2.5" , T2_5_pulley_dia_30 , 0.7 , 1.678, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 17 ) { _pulley ( "T2.5" , T2_5_pulley_dia_100 , 0.7 , 1.678, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 18 ) { _pulley ( "T2.5" , T2_5_pulley_dia_14 , 0.7 , 1.678, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 19 ) { _pulley ( "T2.5" , T2_5_pulley_dia_110 , 0.7 , 1.678, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 20 ) { _pulley ( "T2.5" , T2_5_pulley_dia_80 , 0.7 , 1.678, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 21 ) { _pulley ( "T2.5" , T2_5_pulley_dia_103 , 0.7 , 1.678, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 22 ) { _pulley ( "T2.5" , T2_5_pulley_dia_83 , 0.7 , 1.678, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 23 ) { _pulley ( "T2.5" , T2_5_pulley_dia_40 , 0.7 , 1.678, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 24 ) { _pulley ( "T2.5" , T2_5_pulley_dia_23 , 0.7 , 1.678, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }

  if ( profile == 50) { _pulley ( "T5" , T5_pulley_dia_12 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 51) { _pulley ( "T5" , T5_pulley_dia_20 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 52 ) { _pulley ( "T5" , T5_pulley_dia_21 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 53 ) { _pulley ( "T5" , T5_pulley_dia_78 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 54 ) { _pulley ( "T5" , T5_pulley_dia_50 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 55 ) { _pulley ( "T5" , T5_pulley_dia_82 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 56 ) { _pulley ( "T5" , T5_pulley_dia_70 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 57 ) { _pulley ( "T5" , T5_pulley_dia_18 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }

  if ( profile == 58 ) { _pulley ( "T5" , T5_pulley_dia_60 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 59 ) { _pulley ( "T5" , T5_pulley_dia_40 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 60 ) { _pulley ( "T5" , T5_pulley_dia_51 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 61 ) { _pulley ( "T5" , T5_pulley_dia_15 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 62 ) { _pulley ( "T5" , T5_pulley_dia_23 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 63 ) { _pulley ( "T5" , T5_pulley_dia_28 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 64 ) { _pulley ( "T5" , T5_pulley_dia_45 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 65 ) { _pulley ( "T5" , T5_pulley_dia_103 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 66 ) { _pulley ( "T5" , T5_pulley_dia_31 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 67 ) { _pulley ( "T5" , T5_pulley_dia_100 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 68 ) { _pulley ( "T5" , T5_pulley_dia_26 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 69 ) { _pulley ( "T5" , T5_pulley_dia_73 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
  if ( profile == 70 ) { _pulley ( "T5" , T5_pulley_dia_55 , 1.19 , 3.264, profile, num_teeth, pulley_b_ht, pulley_b_dia, pulley_t_ht); }
}


// Functions

function tooth_spaceing_curvefit (b,c,d, teeth)
	= ((c * pow(teeth,d)) / (b + pow(teeth,d))) * teeth ;

function tooth_spacing(tooth_pitch,pitch_line_offset, teeth)
	= (2*((teeth*tooth_pitch)/(3.14159265*2)-pitch_line_offset)) ;

// Main Module

module _pulley( belt_type , pulley_OD , tooth_depth , tooth_width, profile, num_teeth, pulley_b_ht = 7, pulley_b_dia = 17, pulley_t_ht = 8)
{
        
        //	********************************
//	** Scaling tooth for good fit **
//	********************************
/*	To improve fit of belt to pulley, set the following constant. Decrease or increase by 0.1mm at a time. We are modelling the *BELT* tooth here, not the tooth on the pulley. Increasing the number will *decrease* the pulley tooth size. Increasing the tooth width will also scale proportionately the tooth depth, to maintain the shape of the tooth, and increase how far into the pulley the tooth is indented. Can be negative */

additional_tooth_width = 0.2; //mm

//	If you need more tooth depth than this provides, adjust the following constant. However, this will cause the shape of the tooth to change.

additional_tooth_depth = 0; //mm



;		// pulley base height, standard = 8. Set to same as idler_ht if you want an idler but no pulley.
;	// pulley base diameter, standard = 20


   //     retainer = 1;		// Belt retainer above teeth, 0 = No, 1 = Yes
retainer_ht = 1.5;	// height of retainer flange over pulley, standard = 1.5
//idler = 1;			// Belt retainer below teeth, 0 = No, 1 = Yes
idler_ht = 1.5;		// height of idler flange over pulley, standard = 1.5

	echo (str("Belt type = ",belt_type,"; Number of teeth = ",num_teeth,"; Pulley Outside Diameter = ",pulley_OD,"mm "));
	tooth_distance_from_centre = sqrt( pow(pulley_OD/2,2) - pow((tooth_width+additional_tooth_width)/2,2));
	tooth_width_scale = (tooth_width + additional_tooth_width ) / tooth_width;
	tooth_depth_scale = ((tooth_depth + additional_tooth_depth ) / tooth_depth) ;


//	************************************************************************
//	*** uncomment the following line if pulley is wider than puller base ***
//	************************************************************************

//	translate ([0,0, pulley_b_ht + pulley_t_ht + retainer_ht ]) rotate ([0,180,0])

	difference()
	 {	 
		union()
		{
			//base
	
			if ( pulley_b_ht < 2 ) { //echo ("CAN'T DRAW PULLEY BASE, HEIGHT LESS THAN 2!!!"); 
                } else {
                    color (pulley_color)
				rotate_extrude($fn=pulley_b_dia*2)
				{
						square([pulley_b_dia/2-1,pulley_b_ht]);
						square([pulley_b_dia/2,pulley_b_ht-1]);
						translate([pulley_b_dia/2-1,pulley_b_ht-1]) circle(1);
				}
			}
	
		difference()
			{
			//shaft - diameter is outside diameter of pulley
			color (pulley_color)
                
			translate([0,0,pulley_b_ht + retainer_ht]) 
			rotate ([0,0,360/(num_teeth*4)]) 
			cylinder(r=pulley_OD/2,h=pulley_t_ht, $fn=num_teeth*4);
	
			//teeth - cut out of shaft
		
			for(i=[1:num_teeth]) 
			rotate([0,0,i*(360/num_teeth)])
			translate([0,-tooth_distance_from_centre,pulley_b_ht -1 + retainer_ht]) 
			scale ([ tooth_width_scale , tooth_depth_scale , 1 ]) {
                if ( profile == 1 ) { MXL(pulley_t_ht);}
                if ( profile == 2 ) { 40DP(pulley_t_ht);}
                if ( profile == 3 ) { XL(pulley_t_ht);}
                if ( profile == 4 ) { H(pulley_t_ht);}
                if ( profile == 5 ) { T2_5(pulley_t_ht);}
                if ( profile == 6 ) { T5(pulley_t_ht);}
                if ( profile == 7 ) { T10(pulley_t_ht);}
                if ( profile == 8 ) { AT5(pulley_t_ht);}
                if ( profile == 9 ) { HTD_3mm(pulley_t_ht);}
                if ( profile == 10 ) { HTD_5mm(pulley_t_ht);}
                if ( profile == 11 ) { HTD_8mm(pulley_t_ht);}
                if ( profile == 12 ) { GT2_2mm(pulley_t_ht);}
                if ( profile == 13 ) { GT2_3mm(pulley_t_ht);}
                if ( profile == 14 ) { GT2_5mm(pulley_t_ht);}
                if ( profile == 15 ) { T2_5(pulley_t_ht);}
                if ( profile == 16 ) { T2_5(pulley_t_ht);}
                if ( profile == 17 ) { T2_5(pulley_t_ht);}
                if ( profile == 18 ) { T2_5(pulley_t_ht);}
                if ( profile == 19 ) { T2_5(pulley_t_ht);}
                if ( profile == 20 ) { T2_5(pulley_t_ht);}
                if ( profile == 21 ) { T2_5(pulley_t_ht);}
                if ( profile == 22 ) { T2_5(pulley_t_ht);}
                if ( profile == 23 ) { T2_5(pulley_t_ht);}
                if ( profile == 24 ) { T2_5(pulley_t_ht);}
                
                if ( profile == 50 ) { T5(pulley_t_ht);}
                if ( profile == 51 ) { T5(pulley_t_ht);}
                if ( profile == 52 ) { T5(pulley_t_ht);}
                if ( profile == 53 ) { T5(pulley_t_ht);}
                if ( profile == 54 ) { T5(pulley_t_ht);}
                if ( profile == 55 ) { T5(pulley_t_ht);}
                if ( profile == 56 ) { T5(pulley_t_ht);}
                if ( profile == 57 ) { T5(pulley_t_ht);}
                if ( profile == 58 ) { T5(pulley_t_ht);}
                if ( profile == 59 ) { T5(pulley_t_ht);}
                if ( profile == 60 ) { T5(pulley_t_ht);}
                if ( profile == 61 ) { T5(pulley_t_ht);}
                if ( profile == 62 ) { T5(pulley_t_ht);}
                if ( profile == 63 ) { T5(pulley_t_ht);}
                if ( profile == 64 ) { T5(pulley_t_ht);}
                if ( profile == 65 ) { T5(pulley_t_ht);}
                if ( profile == 66 ) { T5(pulley_t_ht);}
                if ( profile == 67 ) { T5(pulley_t_ht);}
                if ( profile == 68 ) { T5(pulley_t_ht);}
                if ( profile == 69 ) { T5(pulley_t_ht);}
                if ( profile == 70 ) { T5(pulley_t_ht);}
			}

			}
			
		//belt retainer / idler
		color (pulley_color)
            translate ([0,0, pulley_b_ht + pulley_t_ht + retainer_ht]) 
		rotate_extrude($fn=num_teeth*4)  
		polygon([[0,0],[pulley_OD/2,0],[pulley_OD/2 + retainer_ht , retainer_ht],[0 , retainer_ht],[0,0]]);
            
		
		color (pulley_color)
            translate ([0,0, pulley_b_ht - idler_ht + retainer_ht]) 
		rotate_extrude($fn=num_teeth*4)  
		polygon([[0,0],[pulley_OD/2 + idler_ht,0],[pulley_OD/2 , idler_ht],[0, idler_ht],[0,0]]);
        
	
	}
    }
	   
	}


// Tooth profile modules

module MXL(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-0.660421,-0.5],[-0.660421,0],[-0.621898,0.006033],[-0.587714,0.023037],[-0.560056,0.049424],[-0.541182,0.083609],[-0.417357,0.424392],[-0.398413,0.458752],[-0.370649,0.48514],[-0.336324,0.502074],[-0.297744,0.508035],[0.297744,0.508035],[0.336268,0.502074],[0.370452,0.48514],[0.39811,0.458752],[0.416983,0.424392],[0.540808,0.083609],[0.559752,0.049424],[0.587516,0.023037],[0.621841,0.006033],[0.660421,0],[0.660421,-0.5]]);
	}

module 40DP(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-0.612775,-0.5],[-0.612775,0],[-0.574719,0.010187],[-0.546453,0.0381],[-0.355953,0.3683],[-0.327604,0.405408],[-0.291086,0.433388],[-0.248548,0.451049],[-0.202142,0.4572],[0.202494,0.4572],[0.248653,0.451049],[0.291042,0.433388],[0.327609,0.405408],[0.356306,0.3683],[0.546806,0.0381],[0.574499,0.010187],[0.612775,0],[0.612775,-0.5]]);
	}

module XL(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.525411,-1],[-1.525411,0],[-1.41777,0.015495],[-1.320712,0.059664],[-1.239661,0.129034],[-1.180042,0.220133],[-0.793044,1.050219],[-0.733574,1.141021],[-0.652507,1.210425],[-0.555366,1.254759],[-0.447675,1.270353],[0.447675,1.270353],[0.555366,1.254759],[0.652507,1.210425],[0.733574,1.141021],[0.793044,1.050219],[1.180042,0.220133],[1.239711,0.129034],[1.320844,0.059664],[1.417919,0.015495],[1.525411,0],[1.525411,-1]]);
	}

module H(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-2.6797,-1],[-2.6797,0],[-2.600907,0.006138],[-2.525342,0.024024],[-2.45412,0.052881],[-2.388351,0.091909],[-2.329145,0.140328],[-2.277614,0.197358],[-2.234875,0.262205],[-2.202032,0.334091],[-1.75224,1.57093],[-1.719538,1.642815],[-1.676883,1.707663],[-1.62542,1.764693],[-1.566256,1.813112],[-1.500512,1.85214],[-1.4293,1.880997],[-1.353742,1.898883],[-1.274949,1.905021],[1.275281,1.905021],[1.354056,1.898883],[1.429576,1.880997],[1.500731,1.85214],[1.566411,1.813112],[1.625508,1.764693],[1.676919,1.707663],[1.719531,1.642815],[1.752233,1.57093],[2.20273,0.334091],[2.235433,0.262205],[2.278045,0.197358],[2.329455,0.140328],[2.388553,0.091909],[2.454233,0.052881],[2.525384,0.024024],[2.600904,0.006138],[2.6797,0],[2.6797,-1]]);
	}

module T2_5(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-0.839258,-0.5],[-0.839258,0],[-0.770246,0.021652],[-0.726369,0.079022],[-0.529167,0.620889],[-0.485025,0.67826],[-0.416278,0.699911],[0.416278,0.699911],[0.484849,0.67826],[0.528814,0.620889],[0.726369,0.079022],[0.770114,0.021652],[0.839258,0],[0.839258,-0.5]]);
	}

module T5(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.632126,-0.5],[-1.632126,0],[-1.568549,0.004939],[-1.507539,0.019367],[-1.450023,0.042686],[-1.396912,0.074224],[-1.349125,0.113379],[-1.307581,0.159508],[-1.273186,0.211991],[-1.246868,0.270192],[-1.009802,0.920362],[-0.983414,0.978433],[-0.949018,1.030788],[-0.907524,1.076798],[-0.859829,1.115847],[-0.80682,1.147314],[-0.749402,1.170562],[-0.688471,1.184956],[-0.624921,1.189895],[0.624971,1.189895],[0.688622,1.184956],[0.749607,1.170562],[0.807043,1.147314],[0.860055,1.115847],[0.907754,1.076798],[0.949269,1.030788],[0.9837,0.978433],[1.010193,0.920362],[1.246907,0.270192],[1.273295,0.211991],[1.307726,0.159508],[1.349276,0.113379],[1.397039,0.074224],[1.450111,0.042686],[1.507589,0.019367],[1.568563,0.004939],[1.632126,0],[1.632126,-0.5]]);
	}

module T10(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-3.06511,-1],[-3.06511,0],[-2.971998,0.007239],[-2.882718,0.028344],[-2.79859,0.062396],[-2.720931,0.108479],[-2.651061,0.165675],[-2.590298,0.233065],[-2.539962,0.309732],[-2.501371,0.394759],[-1.879071,2.105025],[-1.840363,2.190052],[-1.789939,2.266719],[-1.729114,2.334109],[-1.659202,2.391304],[-1.581518,2.437387],[-1.497376,2.47144],[-1.408092,2.492545],[-1.314979,2.499784],[1.314979,2.499784],[1.408091,2.492545],[1.497371,2.47144],[1.581499,2.437387],[1.659158,2.391304],[1.729028,2.334109],[1.789791,2.266719],[1.840127,2.190052],[1.878718,2.105025],[2.501018,0.394759],[2.539726,0.309732],[2.59015,0.233065],[2.650975,0.165675],[2.720887,0.108479],[2.798571,0.062396],[2.882713,0.028344],[2.971997,0.007239],[3.06511,0],[3.06511,-1]]);
	}

module AT5(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-2.134129,-0.75],[-2.134129,0],[-2.058023,0.005488],[-1.984595,0.021547],[-1.914806,0.047569],[-1.849614,0.082947],[-1.789978,0.127073],[-1.736857,0.179338],[-1.691211,0.239136],[-1.653999,0.305859],[-1.349199,0.959203],[-1.286933,1.054635],[-1.201914,1.127346],[-1.099961,1.173664],[-0.986896,1.18992],[0.986543,1.18992],[1.099614,1.173664],[1.201605,1.127346],[1.286729,1.054635],[1.349199,0.959203],[1.653646,0.305859],[1.690859,0.239136],[1.73651,0.179338],[1.789644,0.127073],[1.849305,0.082947],[1.914539,0.047569],[1.984392,0.021547],[2.057906,0.005488],[2.134129,0],[2.134129,-0.75]]);
	}

module HTD_3mm(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.135062,-0.5],[-1.135062,0],[-1.048323,0.015484],[-0.974284,0.058517],[-0.919162,0.123974],[-0.889176,0.206728],[-0.81721,0.579614],[-0.800806,0.653232],[-0.778384,0.72416],[-0.750244,0.792137],[-0.716685,0.856903],[-0.678005,0.918199],[-0.634505,0.975764],[-0.586483,1.029338],[-0.534238,1.078662],[-0.47807,1.123476],[-0.418278,1.16352],[-0.355162,1.198533],[-0.289019,1.228257],[-0.22015,1.25243],[-0.148854,1.270793],[-0.07543,1.283087],[-0.000176,1.28905],[0.075081,1.283145],[0.148515,1.270895],[0.219827,1.252561],[0.288716,1.228406],[0.354879,1.19869],[0.418018,1.163675],[0.477831,1.123623],[0.534017,1.078795],[0.586276,1.029452],[0.634307,0.975857],[0.677809,0.91827],[0.716481,0.856953],[0.750022,0.792167],[0.778133,0.724174],[0.800511,0.653236],[0.816857,0.579614],[0.888471,0.206728],[0.919014,0.123974],[0.974328,0.058517],[1.048362,0.015484],[1.135062,0],[1.135062,-0.5]]);
	}

module HTD_5mm(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.89036,-0.75],[-1.89036,0],[-1.741168,0.02669],[-1.61387,0.100806],[-1.518984,0.21342],[-1.467026,0.3556],[-1.427162,0.960967],[-1.398568,1.089602],[-1.359437,1.213531],[-1.310296,1.332296],[-1.251672,1.445441],[-1.184092,1.552509],[-1.108081,1.653042],[-1.024167,1.746585],[-0.932877,1.832681],[-0.834736,1.910872],[-0.730271,1.980701],[-0.62001,2.041713],[-0.504478,2.09345],[-0.384202,2.135455],[-0.259708,2.167271],[-0.131524,2.188443],[-0.000176,2.198511],[0.131296,2.188504],[0.259588,2.167387],[0.384174,2.135616],[0.504527,2.093648],[0.620123,2.04194],[0.730433,1.980949],[0.834934,1.911132],[0.933097,1.832945],[1.024398,1.746846],[1.108311,1.653291],[1.184308,1.552736],[1.251865,1.445639],[1.310455,1.332457],[1.359552,1.213647],[1.39863,1.089664],[1.427162,0.960967],[1.467026,0.3556],[1.518984,0.21342],[1.61387,0.100806],[1.741168,0.02669],[1.89036,0],[1.89036,-0.75]]);
	}

module HTD_8mm(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-3.301471,-1],[-3.301471,0],[-3.16611,0.012093],[-3.038062,0.047068],[-2.919646,0.10297],[-2.813182,0.177844],[-2.720989,0.269734],[-2.645387,0.376684],[-2.588694,0.496739],[-2.553229,0.627944],[-2.460801,1.470025],[-2.411413,1.691917],[-2.343887,1.905691],[-2.259126,2.110563],[-2.158035,2.30575],[-2.041518,2.490467],[-1.910478,2.66393],[-1.76582,2.825356],[-1.608446,2.973961],[-1.439261,3.10896],[-1.259169,3.22957],[-1.069074,3.335006],[-0.869878,3.424485],[-0.662487,3.497224],[-0.447804,3.552437],[-0.226732,3.589341],[-0.000176,3.607153],[0.226511,3.589461],[0.447712,3.552654],[0.66252,3.497516],[0.870027,3.424833],[1.069329,3.33539],[1.259517,3.229973],[1.439687,3.109367],[1.608931,2.974358],[1.766344,2.825731],[1.911018,2.664271],[2.042047,2.490765],[2.158526,2.305998],[2.259547,2.110755],[2.344204,1.905821],[2.411591,1.691983],[2.460801,1.470025],[2.553229,0.627944],[2.588592,0.496739],[2.645238,0.376684],[2.720834,0.269734],[2.81305,0.177844],[2.919553,0.10297],[3.038012,0.047068],[3.166095,0.012093],[3.301471,0],[3.301471,-1]]);
	}

module GT2_2mm(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[0.747183,-0.5],[0.747183,0],[0.647876,0.037218],[0.598311,0.130528],[0.578556,0.238423],[0.547158,0.343077],[0.504649,0.443762],[0.451556,0.53975],[0.358229,0.636924],[0.2484,0.707276],[0.127259,0.750044],[0,0.76447],[-0.127259,0.750044],[-0.2484,0.707276],[-0.358229,0.636924],[-0.451556,0.53975],[-0.504797,0.443762],[-0.547291,0.343077],[-0.578605,0.238423],[-0.598311,0.130528],[-0.648009,0.037218],[-0.747183,0],[-0.747183,-0.5]]);
	}

module GT2_3mm(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.155171,-0.5],[-1.155171,0],[-1.065317,0.016448],[-0.989057,0.062001],[-0.93297,0.130969],[-0.90364,0.217664],[-0.863705,0.408181],[-0.800056,0.591388],[-0.713587,0.765004],[-0.60519,0.926747],[-0.469751,1.032548],[-0.320719,1.108119],[-0.162625,1.153462],[0,1.168577],[0.162625,1.153462],[0.320719,1.108119],[0.469751,1.032548],[0.60519,0.926747],[0.713587,0.765004],[0.800056,0.591388],[0.863705,0.408181],[0.90364,0.217664],[0.932921,0.130969],[0.988924,0.062001],[1.065168,0.016448],[1.155171,0],[1.155171,-0.5]]);
	}

module GT2_5mm(pulley_t_ht)
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.975908,-0.75],[-1.975908,0],[-1.797959,0.03212],[-1.646634,0.121224],[-1.534534,0.256431],[-1.474258,0.426861],[-1.446911,0.570808],[-1.411774,0.712722],[-1.368964,0.852287],[-1.318597,0.989189],[-1.260788,1.123115],[-1.195654,1.25375],[-1.12331,1.380781],[-1.043869,1.503892],[-0.935264,1.612278],[-0.817959,1.706414],[-0.693181,1.786237],[-0.562151,1.851687],[-0.426095,1.9027],[-0.286235,1.939214],[-0.143795,1.961168],[0,1.9685],[0.143796,1.961168],[0.286235,1.939214],[0.426095,1.9027],[0.562151,1.851687],[0.693181,1.786237],[0.817959,1.706414],[0.935263,1.612278],[1.043869,1.503892],[1.123207,1.380781],[1.195509,1.25375],[1.26065,1.123115],[1.318507,0.989189],[1.368956,0.852287],[1.411872,0.712722],[1.447132,0.570808],[1.474611,0.426861],[1.534583,0.256431],[1.646678,0.121223],[1.798064,0.03212],[1.975908,0],[1.975908,-0.75]]);
	}
    
    //my_pulley(19, 139, 7, 25, 8, 0);
    
    //my_pulley(22, 105, 7, 25, 8, 0);
    
    //my_pulley(20, 101, 0, 0, 0, 0);
    
    //my_pulley(16, 49, 0, 0, 0);
    
    //my_pulley(15, 18, 0, 0, 0);
    
    //my_pulley(24, 30, 0, 0, 0);
    
    //echo(T2_5_pulley_dia_84);
    
    //echo(T5_pulley_dia_31 = T5_pulley_dia_31);
    //echo(T5_pulley_dia_100 = T5_pulley_dia_100);
    
    
    //my_pulley(16, 49, 0, 0, 8);
    
    //my_pulley(50, 8, 0, 18, 8, 0, 0, 0);
    //my_pulley(51, 13, 0, 18, 8, 0, angle = 20);
    //my_pulley(53, 50, 0, 18, 12, 0, angle = 3.68); // roata tractiune baza
    //my_pulley(52, 14, 0, 18, 8, 0);
    //my_pulley(54, 32, 0, 18, 8, 0, angle = 20);// motor #1
    //my_pulley(55, 52, 0, 18, 8, 0, angle = 20);// motor #1
    // my_pulley(56, 44, 0, 18, 8, 0, screw_head_radius = 8, 1, angle = 20);// head base motor
    
    //my_pulley(23, 49, 0, 18, 31, 0, angle = 20);// motor #1
    //my_pulley(57, 12, 0, 18, 6, 0, 0, 0);
    //my_pulley(58, 38, 0, 18, 6, 0, 0, 0, angle = 0);
    //my_pulley(59, 25, 0, 18, 2 * m8_screw_radius, 0, 0, angle = 0);
    
    
    //pulley(63, 18, 0, 0, 8);
    
    //pulley_with_shaft(57, 12, 0, 0, 8, 3, 0, 0);
    //pulley_with_shaft(66, 20, 0, 0, 8, 4, 0, 0);
    
    //pulley_with_shaft(67, 63, 0, 0, 8, 0, 0, 0);
    //pulley_with_shaft(68, 17, 0, 0, 8, 0, 0, 0);
   // echo(T5_pulley_dia_74);
    
    //pulley(profile = 11, num_teeth = 8, pulley_b_ht = 7, pulley_b_dia = 17, pulley_t_ht = 8);
    
    pulley(profile = 70, num_teeth = 35, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = 8);