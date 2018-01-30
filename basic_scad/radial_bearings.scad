// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_radial_bearings.scad>
use <basic_components.scad>

////////////////////////////////////////////////////////////////
module radial_bearing(internal_radius, external_radius, height)
{
	union(){
		translate ([0, 0, 0.5]) color ("black") cylinder_empty(height  - 1, external_radius - 1, internal_radius + 1, 70);
		color ("Gainsboro") cylinder_empty(height, internal_radius + 1, internal_radius, 70);
		color ("Gainsboro") cylinder_empty(height, external_radius, external_radius - 1, 70);
	}
}
////////////////////////////////////////////////////////////////
module 624rs()
{
	radial_bearing(2, bearing_4_external_radius, bearing_4_height);
}
////////////////////////////////////////////////////////////////
module 628rs()
{
	radial_bearing(4, bearing_8_external_radius, bearing_8_height);
}
////////////////////////////////////////////////////////////////
module 625rs()
{
	radial_bearing(2.5, bearing_5_external_radius, bearing_5_height);
}
////////////////////////////////////////////////////////////////
module 626rs()
{
	radial_bearing(3, bearing_6_external_radius, bearing_6_height);
}
////////////////////////////////////////////////////////////////
module 6001rs()
{
	radial_bearing(rb_6001_internal_radius, rb_6001_external_radius, rb_6001_thick);
}
////////////////////////////////////////////////////////////////
module 6201rs()
{
	radial_bearing(rb_6201_internal_radius, rb_6201_external_radius, rb_6201_thick);
}
////////////////////////////////////////////////////////////////
module 6002rs()
{
	radial_bearing(rb_6002_internal_radius, rb_6002_external_radius, rb_6002_thick);
}
////////////////////////////////////////////////////////////////
module 6005rs()
{
	radial_bearing(rb_6005_internal_radius, rb_6005_external_radius, rb_6005_thick);
}
////////////////////////////////////////////////////////////////
module 6905rs()
{
	radial_bearing(rb_6905_internal_radius, rb_6905_external_radius, rb_6905_thick);
}
////////////////////////////////////////////////////////////////
module 608rs()
{
	radial_bearing(rb_608_internal_radius, rb_608_external_radius, rb_608_thick);
}
////////////////////////////////////////////////////////////////
module 698rs()
{
	radial_bearing(rb_698_internal_radius, rb_698_external_radius, rb_698_thick);
}
////////////////////////////////////////////////////////////////
module 6000rs()
{
	radial_bearing(rb_6000_internal_radius, rb_6000_external_radius, rb_6000_thick);
}
////////////////////////////////////////////////////////////////
module 6902rs()
{
	radial_bearing(rb_6902_internal_radius, rb_6902_external_radius, rb_6902_thick);
}
////////////////////////////////////////////////////////////////
module 6006rs()
{
	radial_bearing(rb_6006_internal_radius, rb_6006_external_radius, rb_6006_thick);
}
////////////////////////////////////////////////////////////////
module 3205rs()
{
	radial_bearing(rb_3205_internal_radius, rb_3205_external_radius, rb_3205_thick);
}
////////////////////////////////////////////////////////////////

6002rs();