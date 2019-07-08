// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT
//--------------------------------------------------------------
module corner(radius, height)
{
	difference(){
		cube ([radius, radius, height]);
		cylinder	(h = height, r = radius, $fn = 30);
	}
}
//---------------------------------------------------------------
module spherical_corner(radius)
{
	difference(){
		cube ([radius, radius, radius]);
		sphere(r = radius, $fn = 40);
	}
}
//---------------------------------------------------------------
module spherical_column(height, radius)
{
		difference(){
			cube ([height, height, height]);
			cylinder(h= height, r = radius, $fn = 50);
		}
}
//---------------------------------------------------------------

spherical_column(height = 100, radius = 10);