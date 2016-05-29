// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

module masa_rotunda(inaltime, raza)
{
    grosime_placa = 30;
// baza
	cylinder (h = 50, r = 150);
	// picior
	cylinder (h = inaltime, r = 50);
	// masa
	translate ([0, 0, inaltime - grosime_placa]) cylinder (h = grosime_placa, r = raza);
}

masa_rotunda(750, 400);