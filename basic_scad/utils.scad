// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

module colt(radius, height)
{
	difference(){
		cube ([radius, radius, height]);
		cylinder	(h = height, r = radius, $fn = 30);
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module colt_sferic(radius)
{
	difference(){
		cube ([radius, radius, radius]);
		sphere(r = radius, $fn = 40);
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module coloana_sferica(height, radius)
{
		difference(){
			cube ([height, height, height]);
			cylinder(h= height, r = radius, $fn = 50);
		}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
