include <x-end-base.scad>;

x_carriage();

module x_carriage()
{
  difference() {
    union() {
      x_base_body();
      
      // around bearing
      *translate([-body_thickness, -rod_dia/2-bearing_outer_dia/2, height/2]) rotate([0, 90, 0]) cylinder(r=rod_dia/2+2, h=12);
    }
    union() {
      x_base_holes();
      
      // side cutaway
      hull() {
          for(z=[height+10,rod_dia/2+12]) for(y=[10, (length-bearing_dia-5/2-rod_dia-5/2)+5]) {
              translate([-body_thickness-1, -rod_dia/2-bearing_outer_dia/2-y, z]) rotate([0, 90, 0]) cylinder(r=rod_dia/2, h=30);
          }
      }
      
      // bearing rod hole
      translate([-body_thickness-1, -rod_dia/2-bearing_outer_dia/2, height/2]) rotate([0, 90, 0]) cylinder(r=rod_dia/2, h=30);
      
      // bearing opening
      *hull() for(y=[5, -30]) translate([-body_thickness+2, -rod_dia/2-bearing_outer_dia/2+y-7, height/2]) rotate([0, 90, 0]) cylinder(r=33/2, h=8);
      // belt slot
      translate([0, 15, 0]) hull() {
          translate([-body_thickness+6, 2, 6+12]) rotate([90, 0, 0]) cylinder(r=rod_dia/2, h=length);
          translate([-body_thickness+6, 2, height-6-12]) rotate([90, 0, 0]) cylinder(r=rod_dia/2, h=length);
      }
      
      // fake bearing rod
      %translate([-body_thickness-1, -rod_dia/2-bearing_outer_dia/2, height/2]) rotate([0, 90, 0]) cylinder(r=rod_dia/2, h=14);
      
      // fake bearing
      %translate([-body_thickness+2, -rod_dia/2-bearing_outer_dia/2, height/2]) rotate([0, 90, 0]) cylinder(r=12/2, h=8);
    }
  }
}
