shell_dia = 48;
motor_dia = 24;
opening_dia = 32;
thickness = 15.25;
hole_dia = 5;
hole_spacing = 57.5;
side_opening_width = 16;

module angular_fan_shell()
{
  difference() {
    union() {
      cylinder(r=shell_dia/2, h=thickness, $fn=120);
      
      rotate([0, 0, 45])
      hull() for(x=[-1, 1]) 
        translate([x*(hole_spacing/2), 0, 0]) 
          cylinder(r=hole_dia/2+0.5, h=thickness, $fn=80);
      
      hull() {
        translate([0, -shell_dia/2-3, 0])
          cube([shell_dia/2+3, side_opening_width, thickness]);
        translate([-16, -shell_dia/2+6, 0])
          cube([shell_dia/2, 1, thickness]);
      }
    }
    union() {
      translate([0, 0, -1])
        angular_fan_holes(thickness+2);
      
      translate([0, 0, 1]) 
        cylinder(r=shell_dia/2-1, h=thickness-2, $fn=120);
      translate([0, 0, 1]) 
        cylinder(r=opening_dia/2-1, h=thickness, $fn=120);
      
      hull() {
        translate([1, -shell_dia/2-2, 1])
          cube([shell_dia/2+3, side_opening_width-2, thickness-2]);
        translate([-16, -shell_dia/2+6, 1])
          cube([shell_dia/2, 1, thickness-2]);
      }
    }
  }
}

module angular_fan_holes(height=1)
{
  rotate([0, 0, 45])
    for(x=[-1, 1]) 
      translate([x*(hole_spacing/2), 0, 0]) 
        cylinder(r=hole_dia/2, h=height, $fn=80);
}

module angular_fan_motor()
{
  translate([0, 0, 2])
    cylinder(r=shell_dia/2-4, h=2, $fn=80);

  translate([0, 0, 2])
    cylinder(r=motor_dia/2, h=thickness-4, $fn=80);
  
  for(r=[0:40]) rotate([0, 0, r*(360/40)])
    translate([-0.8/2, 14, 2])
      cube([0.8, 6, thickness-4]);
}


module angular_fan()
{
  angular_fan_shell();
  angular_fan_motor();
}

angular_fan();