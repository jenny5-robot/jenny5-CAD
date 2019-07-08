// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT
//--------------------------------------------------------------

include <material_colors.scad>
//--------------------------------------------------------------

module rounded_table(height, radius)
{
    sheet_thickness = 30;
// base
	cylinder (h = 50, r = 150);
	// leg
	color(aluminium_color) cylinder (h = height, r = 50);
	// top sheet
	translate ([0, 0, height - sheet_thickness]) 
        color(wood_color)
            cylinder (h = sheet_thickness, r = radius);
}
//--------------------------------------------------------------

rounded_table(750, 400);