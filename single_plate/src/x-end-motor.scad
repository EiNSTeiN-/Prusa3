include <x-end-base.scad>;
use <inc/rrd-switch.scad>;

motor_nut_spacing = 31;
motor_nut_dia = 12;
motor_nut_thickness = 6;
motor_center_dia = 28;

mirror([0, 1, 0]) x_motor();

%translate([-3, 34, -20.5])
  rotate([0, -90, 0])
  rrd_switch();
%translate([-body_thickness+6, 60, 6]) rotate([90, 0, 0]) cylinder(r=rod_dia_clip/2, h=length);

module motor_invertor(h=16)
{
  difference() {
    cylinder(r=12/2, h=h);
    translate([0, 0, -1]) cylinder(r=3.5/2, h=h+2);
  }
}

translate([20, 0, 0]) motor_invertor();

module switch_holder()
{
  difference() {
    union() {
      cube([12, 30, 2]);
      hull() translate([0, 27.5, 0]) {
        spacing = 36-19;
        translate([12/2-spacing/2, 0, 0])
          cylinder(r=7/2, h=17);
        translate([12/2+spacing/2, 0, 0])
          cylinder(r=7/2, h=17);
      }
    }
    union() {
      translate([0, 27.5, -1]) {
        spacing = 19;
        translate([12/2-spacing/2, 0, 0])
          cylinder(r=3.3/2, h=40);
        translate([12/2+spacing/2, 0, 0])
          cylinder(r=3.3/2, h=40);
        
        translate([12/2, -5, 9.25])
          rotate([-90, 0, 0])
          cylinder(r=8/2, h=10);
        
        translate([-14/2+12/2, -6, 9])
          cube([14, 10, 20]);
      }
    }
  }
}

translate([-50, 0, 0]) 
  switch_holder();

%translate([-22.5, 20, 12]) 
  rotate([0, 90, 0])
  switch_holder();

module x_motor()
{
  motor_spacing = 5;
  motor_plate_thickness = 3;
  motor_height = motor_nut_spacing+motor_nut_dia+motor_plate_thickness+4;
  
  difference() {
    union() {
      x_base_body();
      
      // motor side
      translate([-bearing_outer_dia/2, 0, 0]) cube([bearing_outer_dia/2, bearing_outer_dia/2, motor_height]);
      
      translate([-bearing_outer_dia/2+motor_nut_dia/2+6-0.1, 6+bearing_outer_dia/2-0.1, 0]) rotate([0, 0, 180]) corner(6, motor_height);
      translate([-bearing_outer_dia/2-motor_nut_thickness+0.1, 6+bearing_outer_dia/2-0.1, 0]) rotate([0, 0, -90]) corner(6, motor_height);
      translate([-bearing_outer_dia/2, bearing_outer_dia/2, 0]) cube([motor_nut_thickness, motor_spacing+motor_nut_dia/2, motor_height]);
      
      translate([-bearing_outer_dia/2, motor_nut_dia/2+bearing_outer_dia/2+motor_spacing, motor_nut_dia/2+motor_plate_thickness+4]) {
        hull() for(z=[0, motor_nut_spacing]) translate([0, 0, z]) rotate([0, 90, 0]) cylinder(r=motor_nut_dia/2, h=motor_nut_thickness);
        hull() for(y=[0, motor_nut_spacing]) translate([0, y, 0]) rotate([0, 90, 0]) cylinder(r=motor_nut_dia/2, h=motor_nut_thickness);
      }
      
      translate([-bearing_outer_dia/2, bearing_outer_dia/2, 0]) cube([motor_nut_thickness, motor_spacing+motor_nut_dia+motor_nut_spacing, motor_plate_thickness+motor_nut_dia/2+4]);
      translate([-bearing_outer_dia/2, 0, 0]) difference() {
        cube([motor_nut_thickness+bearing_outer_dia/2, motor_spacing+motor_nut_dia+motor_nut_spacing+bearing_outer_dia/2, motor_plate_thickness]);
        translate([motor_nut_thickness+bearing_outer_dia/2-10+0.1, motor_spacing+motor_nut_dia+motor_nut_spacing-10+0.1+bearing_outer_dia/2, -1]) corner(10, motor_plate_thickness+2);
        
        for(i=[0:2])
        translate([11, 12+(i*14), -1])
        cube([3, 10, motor_plate_thickness+2]);
      }
    }
    union() {
      x_base_holes();
      
      // belt slot
      translate([0, 15, 0]) hull() {
          translate([-body_thickness+6, 2, 6+12]) rotate([90, 0, 0]) cylinder(r=rod_dia/2, h=length);
          translate([-body_thickness+6, 2, height-6-12]) rotate([90, 0, 0]) cylinder(r=rod_dia/2, h=length);
      }
      
      // side cutaway
      hull() {
        for(z=[height+10,rod_dia/2+12]) for(y=[10, (length-bearing_dia-5/2-rod_dia-5/2)+5]) {
          translate([-body_thickness-1, -rod_dia/2-bearing_outer_dia/2-y, z]) rotate([0, 90, 0]) cylinder(r=rod_dia/2, h=30);
        }
      }
      
      translate([-bearing_outer_dia/2-1, motor_nut_dia/2+bearing_outer_dia/2+motor_spacing, motor_nut_dia/2+motor_plate_thickness+4]) {
        
        translate([8, motor_nut_spacing/2, motor_nut_spacing/2]) 
        rotate([0, -90, 0]) 
        cylinder(r=motor_center_dia/2, h=motor_nut_thickness+2);
        
        translate([8, 0, 0]) rotate([0, -90, 0]) cylinder(r=screw_dia_small/2, h=20);
        translate([8, 0, motor_nut_spacing]) rotate([0, -90, 0]) cylinder(r=screw_dia_small/2, h=20);
        translate([8, motor_nut_spacing, 0]) rotate([0, -90, 0]) cylinder(r=screw_dia_small/2, h=20);
        
      }
    }
  }
}
