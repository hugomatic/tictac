DimX=70;
DimY=70;
DimZ=5.2;

BigH=2;
BigW=66;
SmallH=3;
BorderW=2;

module tictactoeBase()
{
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
						cube([(BigW-(2*BorderW))/3, (BigW-(2*BorderW))/3, SmallH+BigH], center = true);	
					}
				}
			}
		}
	}
}

tictactoeBase();

