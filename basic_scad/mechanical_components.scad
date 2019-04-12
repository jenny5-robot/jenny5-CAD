// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


module spring(inaltime, diametru, compresion)
{
  color ("DarkSlateGray")
  render(){ 
	  linear_extrude(height = inaltime, center = false, convexity = 10, twist = 360 * compresion, slices = 100)
		translate([diametru / 2, 0, 0])
			circle(r = 1.5);
   }
}
//---------------------------------------------------------------------------

spring(30, 10, 10);