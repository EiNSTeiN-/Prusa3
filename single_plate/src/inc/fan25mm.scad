width = 25;
hole_spacing = 32;
corner = 5;
thickness = 10.5;
hole_dia = 3.5;
hole_top_height = 3.5;
plate_thickness = 3.5;
motor_dia = 16;

module fan25mm_shell()
{
  difference() {
    union() {
      hull()
      for(y=[-1, 1]) translate([0, y*(width/2-corner/2), 0]) 
        for(x=[-1, 1]) translate([x*(width/2-corner/2), 0, 0]) 
          cylinder(r=corner/2, h=plate_thickness, $fn=80);
      for(r=[0, 90]) rotate([0, 0, r])
      hull() for(x=[-1, 1]) 
        translate([x*(width/2-corner/2), x*(width/2-corner/2), 0]) 
          cylinder(r=corner/2, h=thickness, $fn=80);
      cylinder(r=width/2, h=thickness, $fn=80);
      
    }
    union() {
      fan25mm_holes($fn=80);
    }
  }
}

module fan25mm_holes(dia=hole_dia, height=thickness+2)
{
  translate([0, 0, -1])
    cylinder(r=width/2-0.5, h=height);
  
  for(y=[-1, 1]) translate([0, y*(width/2-corner/2), -1]) 
    for(x=[-1, 1]) translate([x*(width/2-corner/2), 0, 0]) 
      cylinder(r=dia/2, h=height);
}

module fan25mm_motor()
{
  for(r=[0, 120, 240]) rotate([0, 0, r])
    translate([-2.8/2, 0, 0]) cube([2.8, width/2, 0.8]);
  cylinder(r=motor_dia/2, h=0.8, $fn=80);

  translate([0, 0, 2])
    cylinder(r=motor_dia/2, h=thickness-2, $fn=80);

  intersection() {
    cylinder(r=width/2-1, h=thickness, $fn=80);
    for(r=[0:8]) rotate([0, 0, r*(360/9)])
      translate([-2, 0, 2])
        rotate([0, 35, 0]) cube([0.8, width/2, thickness]);
  }
}

module fan25mm()
{
  fan25mm_shell();
  fan25mm_motor();
}

fan25mm();