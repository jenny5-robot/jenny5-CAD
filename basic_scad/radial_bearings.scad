// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
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
	radial_bearing(rb_624_internal_radius, rb_624_external_radius, rb_624_thick);
}
////////////////////////////////////////////////////////////////
module 628rs()
{
	radial_bearing(rb_608_internal_radius, rb_608_external_radius, rb_608_thick);
}
////////////////////////////////////////////////////////////////
module 625rs()
{
	radial_bearing(rb_625_internal_radius, rb_625_external_radius, rb_625_thick);
}
////////////////////////////////////////////////////////////////
module 626rs()
{
	radial_bearing(rb_626_internal_radius, rb_626_external_radius, rb_626_thick);
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
module 688rs()
{
	radial_bearing(rb_688_internal_radius, rb_688_external_radius, rb_688_thick);
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
module 6906rs()
{
	radial_bearing(rb_6906_internal_radius, rb_6906_external_radius, rb_6906_thick);
}
////////////////////////////////////////////////////////////////
module 6907rs()
{
	radial_bearing(rb_6907_internal_radius, rb_6907_external_radius, rb_6907_thick);
}
////////////////////////////////////////////////////////////////
module 3205rs()
{
	radial_bearing(rb_3205_internal_radius, rb_3205_external_radius, rb_3205_thick);
}
////////////////////////////////////////////////////////////////
module 6909rs()
{
	radial_bearing(rb_6909_internal_radius, rb_6909_external_radius, rb_6909_thick);
}
////////////////////////////////////////////////////////////////

6002rs();