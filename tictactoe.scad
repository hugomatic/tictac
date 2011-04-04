//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// tic-tac-toe board by Hugomatic and Basbrun
// 
// http://basbrun.com
// http://hugomatic.ca
//
// contact: hugo@hugomatic.ca
//
// License: 
// Copying is not stealing, but cheating at tic-tac-toe is meh.
// http://en.wikipedia.org/wiki/Tic-tac-toe

// hide / show the board
//draw_board = false;
draw_board = true;

// hide / show the x and os
//draw_x_and_os = false;
draw_x_and_os = true;

// === BOARD  parameters ===
DimX=75;  // external board dimensions in mm
DimY=75;
DimZ=6;

// recess for the pockets
BigH=2;      // from top to thin walls
SmallH=2;  // from thin walls to bottom
BigW=68;   // internal size of play area
BorderW=4;  // thin wall thickness

// === X and O parameters ===
Width= 18;	
Thick=3;
Height=2;
Spacing=24;

// this module draws the board
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

// this module generates a single O
module o_piece(Width, Thick, Height)
{
	difference()
	{
		cylinder(r=Width / 2, h=Height, center=true);
		cylinder(r=Width / 2 - Thick , h=Height, center=true);	
	}
}

// this module generates a single X
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

// this modules draws multiple X and Os
module x_and_os(Width, Thick, Height, Spacing)
{
	for (i=[-Spacing, 0, Spacing])
	{
		// top line, all X
		translate([i,Spacing,0])
			x_piece(Width, Thick, Height);
		
		// bottom line, all Os
		translate([i,-Spacing,0])
			o_piece(Width, Thick, Height);
	}

	x_piece(Width, Thick, Height);

	translate([-Spacing,0,0])
		x_piece(Width, Thick, Height);

	translate([Spacing,0,0])
		o_piece(Width, Thick, Height);
	
}

if (draw_board)
{
	tictactoeBase(DimX, DimY, DimZ, BigH, SmallH, BigW, BorderW);
}

if(draw_x_and_os)
{
	x_and_os(Width, Thick, Height, Spacing);
}
