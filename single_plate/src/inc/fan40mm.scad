width = 40;
hole_spacing = 32;
corner = 8;
thickness = 10.5;
hole_dia = 3.5;
hole_top_dia = 5.5;
hole_top_height = 3.5;
plate_thickness = 3.5;
motor_dia = 24;

module fan40mm_shell()
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
      translate([0, 0, -1])
        cylinder(r=width/2-0.5, h=thickness+2, $fn=80);
      
      for(y=[-1, 1]) translate([0, y*(width/2-corner/2), -1]) 
        for(x=[-1, 1]) translate([x*(width/2-corner/2), 0, 0]) 
          cylinder(r=hole_dia/2, h=thickness+2, $fn=80);
        
      translate([0, 0, thickness-hole_top_height])
      for(y=[-1, 1]) translate([0, y*(width/2-corner/2), 0]) 
        for(x=[-1, 1]) translate([x*(width/2-corner/2), 0, 0]) 
          cylinder(r=hole_top_dia/2, h=thickness+2, $fn=80);
    }
  }
}

module fan40mm_motor()
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

module fan40mm()
{
  fan40mm_shell();
  fan40mm_motor();
}

fan40mm();