
module tictactoeBase(DimX, DimY,DimZ, BigH, SmallH,BigW, BorderW )
{
	PocketWidth = (BigW-(2*BorderW) ) / 3;
	difference() {
		cube([DimX,DimY,DimZ], center = true);
		translate([0,0,(DimZ/2)-(BigH/2)])	
		{	
			cube([BigW,BigW,BigH], center = true);	
		}
		union() {			
			for(i=[-1,0,1])		
			{
				for(j=[-1,0,1])		
				{
					translate([(i*(BigW-(2*BorderW))/3)+i*BorderW,(j*(BigW-(2*BorderW))/3)+j*BorderW,(DimZ/2)-((SmallH+BigH)/2)])	
					{	
						 
						cube([PocketWidth, PocketWidth, SmallH+BigH], center = true);	
					}
				}
			}
		}
	}
}

module o_piece(Width, Thick, Height)
{
	difference()
	{
		cylinder(r=Width / 2, h=Height, center=true);
		cylinder(r=Width / 2 - Thick , h=Height, center=true);	
	}
}

module x_piece(Width, Thick, Height)
{

	x=2 * Width;
	y = Thick;
	z = Height;
	w = Width;

	difference()
	{	
		union()
		{	
			rotate([0,0,45])
			cube( [x,y,z], center=true);

			rotate([0,0,-45])
			cube( [x,y,z], center=true);
		}

		difference()
		{
			cube([x,x,z], center=true);
			cube([w, w, z], center=true);
		}

	}

}

tictactoeBase(DimX=75, DimY=75, DimZ=6, BigH=2, SmallH=2, BigW=68, BorderW=4);

o_piece(Width=18, Thick=3, Height=2);

translate([24,0,0])
x_piece(Width=18, Thick=3, Height=2);