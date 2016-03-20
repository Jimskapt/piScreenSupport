lugW=6;
lugH=8;
lugT=1;

lugDrillDia=3;
lugsGapX=123.6;
lugsGapY=73.5;

lugScreenPlatformL=40;
lugEnlarg=5;

lugCenterGapX=(lugsGapX+lugDrillDia)/2;
lugCenterGapY=(lugsGapY-lugH)/2;

/*/ screen
color("grey")
{
  translate([0,0,-1/2])
  {
      cube(size=[170,100,1],center=true);
  }
}
//*/

for(x=[-1:+2:+1])
{
  for(y=[-1:+2:+1])
  {
    translate( [x*lugCenterGapX,  y*lugCenterGapY,  lugT/2])
    {
      union()
      {
        // lug On Screen
        difference()
        {
          cube(size=[lugW-1,  lugH+1,  lugT],center=true);
          cylinder(d=3+0.5,h=4,center=true);
        }
        // lug Between Screen And Platform
        translate([-(lugW-1)/2, -((lugH+1)/2+lugT), -lugT/2])
        {
          polyhedron(points=[
            [0,0,0],[lugW-1,0,0],
            [0,lugT,0],[lugW-1,lugT,0],
            [0-lugEnlarg,0,lugScreenPlatformL],[lugW-1+lugEnlarg,0,lugScreenPlatformL],
            [0-lugEnlarg,lugT,lugScreenPlatformL],[lugW-1+lugEnlarg,lugT,lugScreenPlatformL]
          ],faces=[
            [0,1,3,2],
            [4,6,7,5],
            [1,0,4,5],
            [2,3,7,6],
            [3,1,5,7],
            [0,2,6,4]
          ]);
          
          // Vertical Rib
          polyhedron(points=[
            [(lugW-1)/2-lugT/2,lugT,lugT+10],[(lugW-1)/2+lugT,lugT,lugT+10],
            [(lugW-1)/2-lugT/2,lugT+lugT,lugT+10],[(lugW-1)/2+lugT,lugT+lugT,lugT+10],
            [(lugW-1)/2-lugT/2,lugT+lugT+lugEnlarg,lugScreenPlatformL],[(lugW-1)/2+lugT,lugT+lugT+lugEnlarg,lugScreenPlatformL],
            [(lugW-1)/2-lugT/2,lugT,lugScreenPlatformL],[(lugW-1)/2+lugT,lugT,lugScreenPlatformL],
          ],faces=[
            [1,0,2,3],
            [3,2,4,5],
            [5,4,6,7],
            [1,3,5,7],
            [6,4,2,0]
          ]);
        }
        
        translate([0,-(lugH+1)/2,lugScreenPlatformL])
        {
          cylinder(d=2*2*lugEnlarg,h=lugT,center=true);
        }
      }
    }
    
    translate([0,10,lugScreenPlatformL+lugT/2])
    {
      cube(size=[40,15,lugT],center=true);
    }
    
    polyhedron(points=[
      [x*(40/2-5),  10+y*(15/2-0),  lugScreenPlatformL],
      [x*(40/2-0),  10+y*(15/2-5),  lugScreenPlatformL],
      [x*(lugCenterGapX-5),  y*(lugCenterGapY-0)-(lugH+1)/2,  lugScreenPlatformL],
      [x*(lugCenterGapX-0),  y*(lugCenterGapY-5)-(lugH+1)/2,  lugScreenPlatformL],
      [x*(40/2-5),  10+y*(15/2-0),  lugScreenPlatformL+lugT],
      [x*(40/2-0),  10+y*(15/2-5),  lugScreenPlatformL+lugT],
      [x*(lugCenterGapX-5),  y*(lugCenterGapY-0)-(lugH+1)/2,  lugScreenPlatformL+lugT],
      [x*(lugCenterGapX-0),  y*(lugCenterGapY-5)-(lugH+1)/2,  lugScreenPlatformL+lugT]
    ],faces=[
      [0,1,3,2],
      [4,5,7,6],
      [7,5,1,3],
      [0,2,6,4]
    ]);
  }
}

/*/ platform

translate([0,0,lugScreenPlatformL])
{
  cube(size=[170,100,1],center=true);
}

//*/