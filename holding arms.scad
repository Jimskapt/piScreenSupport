lugW=6;
lugH=8;
lugT=1;

lugDrillDia=3;
lugsGapX=123.6;

lugScreenPlatformL=40;
lubEnlarg=5;

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
      translate( [x*(123.6+lugDrillDia)/2,  y*(73.5-lugH)/2,  lugT/2])
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
            //cube(size=[(lugW-1),lugT,lugScreenPlatformL],center=false);
            polyhedron(points=[
              [0,0,0],[lugW-1,0,0],
              [0,lugT,0],[lugW-1,lugT,0],
              [0-lubEnlarg,0,lugScreenPlatformL],[lugW-1+lubEnlarg,0,lugScreenPlatformL],
              [0-lubEnlarg,lugT,lugScreenPlatformL],[lugW-1+lubEnlarg,lugT,lugScreenPlatformL]
            ],faces=[
            ]);
          }
        }
      }
  }
}

/*/ platform

translate([0,0,lugScreenPlatformL])
{
  cube(size=[170,100,1],center=true);
}

//*/