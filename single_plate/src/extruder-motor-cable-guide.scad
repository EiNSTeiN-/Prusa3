use <inc/42BYG48HJ50.scad>;

$fn=80;

motor_width = 44;
motor_hole_spacing = 36;
motor_hole_dia = 3.5;
wall = 1;
thickness = 6;

module motor_cable_clip()
{
  y = (motor_width/2)-(motor_hole_spacing/2);
  difference() {
    union() {
      for(x=[1,-1]) hull()
        for(my=[1,-1])
        translate([x*motor_hole_spacing/2, my*y, 0]) 
        cylinder(r=(motor_hole_dia/2)+wall, h=thickness);
      
      intersection() {
        hull()
        for(x=[1,-1])
        translate([x*motor_hole_spacing/2, -y, 0])
          cylinder(r=(motor_hole_dia/2)+wall, h=thickness);
        
        translate([0, -y-(motor_hole_dia/2)-wall-1, thickness/2])
          rotate([0, 90, 0])
          translate([0, 0, -motor_width/2])
          cylinder(r=10/2, h=motor_width);
      }
    }
    union() {
      translate([0, -y-(motor_hole_dia/2)-wall-1, thickness/2])
        rotate([0, 90, 0])
        translate([0, 0, -motor_width/2])
        cylinder(r=4/2, h=motor_width);
      
      for(x=[1,-1])
        translate([x*motor_hole_spacing/2, y, 0]) 
        cylinder(r=(motor_hole_dia/2), h=thickness);
    }
  }
}

%translate([0, motor_width/2, 0])
  rotate([180, 0, 0]) 
  motor_42BYG48HJ50();
motor_cable_clip();