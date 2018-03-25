// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

module rounded_table(height, radius)
{
    sheet_thickness = 30;
// base
	cylinder (h = 50, r = 150);
	// leg
	cylinder (h = height, r = 50);
	// top sheet
	translate ([0, 0, height - sheet_thickness]) cylinder (h = sheet_thickness, r = radius);
}
//--------------------------------------------------------------

rounded_table(750, 400);