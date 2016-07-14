// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
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