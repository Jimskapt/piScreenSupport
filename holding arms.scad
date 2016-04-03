lugW=6;
lugH=8;
lugT=2;

lugDrillDia=3.5;
lugsGapX=123.6;
lugsGapY=73.5;

lugScreenPlatformL=45;
lugEnlarg=5;

lugCenterGapX=(lugsGapX+lugDrillDia)/2;
lugCenterGapY=(lugsGapY-lugH)/2;

$fn=50;

for(x=[-1:+2:+1])
{
  for(y=[-1:+2:+1])
  {
    union()
    {
      translate( [x*lugCenterGapX,  y*lugCenterGapY,  1./2])
      {
        union()
        {
          // lug On Screen
          difference()
          {
            union()
            {
              size=(lugH-1-lugDrillDia)/2;
              
              translate([0,-(lugH+1)/2+size/2,0])
                cube(size=[lugW-1, size,  1],center=true);
              
              translate([0,0,1+lugT+0.5])
              {
                cube(size=[lugW-1+2*1,  lugH+1,  lugT],center=true);
                
                translate([0,-(lugH+1)/2,+lugT/2])
                {
                  for(i=[-1:+2:+1])
                  {
                    translate([i*(lugW-i)/2,0,0])
                    {
                      polyhedron(points=[
                        [0,0,0],  [1,0,0],
                        [0,0,lugH+1],  [1,0,lugH+1],
                        [0,lugH+1,0],  [1,lugH+1,0],
                      ],faces=[
                        [4,2,0],
                        [1,3,5],
                        [2,3,1,0],
                        [0,1,5,4],
                        [4,5,3,2]
                      ]);
                    }
                  }
                }
              }
            }
            
            translate([0,0,1+lugT+0.5])
              cylinder(d=lugDrillDia,h=lugT+1,center=true);
          }
          
          // lug Between Screen And Platform
          translate([-(lugW-1)/2, -((lugH+1)/2+lugT), -1./2])
          {
            polyhedron(points=[
              [-1,0,0],[lugW-1+1,0,0],
              [-1,lugT,0],[lugW-1+1,lugT,0],
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
              [(lugW-1)/2-lugT/2,lugT,lugT+15],[(lugW-1)/2+lugT/2,lugT,lugT+15],
              [(lugW-1)/2-lugT/2,lugT+lugT,lugT+15],[(lugW-1)/2+lugT/2,lugT+lugT,lugT+15],
              [(lugW-1)/2-lugT/2,lugT+lugT+lugEnlarg,lugScreenPlatformL],[(lugW-1)/2+lugT/2,lugT+lugT+lugEnlarg,lugScreenPlatformL],
              [(lugW-1)/2-lugT/2,lugT,lugScreenPlatformL],[(lugW-1)/2+lugT/2,lugT,lugScreenPlatformL],
            ],faces=[
              [0,1,3,2],
              [2,3,5,4],
              [4,5,7,6],
              [3,1,7,5],
              [4,6,0,2]
            ]);
          }
          
          // platform lugs cylinders
          translate([0,-(lugH+1)/2,lugScreenPlatformL])
          {
            difference()
            {
              cylinder(d=2*2*lugEnlarg,h=lugT,center=true);
              translate([0,0,+0.8])
                cylinder(d=3,h=lugT,center=true);
            }
          }
        }
      }
      
      // platform arms
      translate([0,0,lugScreenPlatformL-1./2])
      {
        // horizontal lugs
        coordsLugs=[
          [x*(40/2-2*lugEnlarg),  10+y*(15/2-0),  0],
          [x*(40/2-0),  10+y*(15/2-2*lugEnlarg),  0],
          [x*(lugCenterGapX-lugEnlarg),  y*(lugCenterGapY-0)-(lugH+1)/2,  0],
          [x*(lugCenterGapX-0),  y*(lugCenterGapY-lugEnlarg)-(lugH+1)/2,  0],
          [x*(40/2-2*lugEnlarg),  10+y*(15/2-0),  +lugT],
          [x*(40/2-0),  10+y*(15/2-2*lugEnlarg),  +lugT],
          [x*(lugCenterGapX-lugEnlarg),  y*(lugCenterGapY-0)-(lugH+1)/2,  +lugT],
          [x*(lugCenterGapX-0),  y*(lugCenterGapY-lugEnlarg)-(lugH+1)/2,  +lugT]
        ];
        // horizontal ribs
        coordsRibs=[
          [x*(40/2-lugT-2),  10+y*(15/2-0-2),  0-lugT],
          [x*(40/2-0-2),  10+y*(15/2-lugT-2),  0-lugT],
          [x*(lugCenterGapX-lugT+2),  y*(lugCenterGapY-0+2)-(lugH+1)/2,  0-lugT],
          [x*(lugCenterGapX-0+2),  y*(lugCenterGapY-lugT+2)-(lugH+1)/2,  0-lugT],
          [x*(40/2-lugT-2),  10+y*(15/2-0-2),  +lugT-lugT],
          [x*(40/2-0-2),  10+y*(15/2-lugT-2),  +lugT-lugT],
          [x*(lugCenterGapX-lugT+2),  y*(lugCenterGapY-0+2)-(lugH+1)/2,  +lugT-lugT],
          [x*(lugCenterGapX-0+2),  y*(lugCenterGapY-lugT+2)-(lugH+1)/2,  +lugT-lugT]
        ];
        
        if(x==y)
        {
          polyhedron(points=coordsLugs,faces=[
            [0,1,3,2],
            [5,4,6,7],
            [5,7,3,1],
            [0,2,6,4],
            [1,0,4,5],
            [2,3,7,6]
          ]);
          polyhedron(points=coordsRibs,faces=[
            [0,1,3,2],
            [5,4,6,7],
            [5,7,3,1],
            [0,2,6,4],
            [2,3,7,6],
            [4,5,1,0]
          ]);
        }
        else
        {
          polyhedron(points=coordsLugs,faces=[
            [1,0,2,3],
            [4,5,7,6],
            [7,5,1,3],
            [2,0,4,6],
            [0,1,5,4],
            [3,2,6,7]
          ]);
          polyhedron(points=coordsRibs,faces=[
            [1,0,2,3],
            [4,5,7,6],
            [7,5,1,3],
            [2,0,4,6],
            [6,7,3,2],
            [0,1,5,4]
          ]);
        }
      }
    }
  }
}

// center cube
translate([0,10,lugScreenPlatformL-1./2-8./2+lugT])
{
  difference()
  {
    cube(size=[40,15,8],center=true);
    
    polyhedron(points=[
      [-20/2+5,-(15/2+1),+1+8./2],
      [-20/2+0,-(15/2+1),-5+8./2],
      [+20/2+0,-(15/2+1),-5+8./2],
      [+20/2-5,-(15/2+1),+1+8./2],
      [-20/2+5,+(15/2+1),+1+8./2],
      [-20/2+0,+(15/2+1),-5+8./2],
      [+20/2+0,+(15/2+1),-5+8./2],
      [+20/2-5,+(15/2+1),+1+8./2]
    ],faces=[
      [1,0,3,2],
      [4,5,6,7],
      [0,1,5,4],
      [2,3,7,6],
      [1,2,6,5],
      [3,0,4,7]
    ]);
    
    for(i=[-1:+2:+1])
    {
      translate([i*(40/2-5),0,0])
        cylinder(d=4.5,h=8+2,center=true);
    }
  }
}