include <../configuration.scad>;

$fn=180;
beam_width = 9.9;
rod_dia = 8.25;
rod_dia_clip = 7.9;
nut_height = 3;
screw_dia = 4;
screw_dia_small = 3.6;
driver_dia = 9;
flat_height = 4;
bearing_dia = 15.5;
bearing_length = 24.5;

motor_nut_spacing = 31;
motor_nut_dia = 12;
spacing = 6;

rod_support_dia = 24;
rod_opening_dia = 14;
rod_screw_distance = 19.5;

z_rod_spacing =17;

height = 6 + x_rod_distance + 6;
thickness = 28;
length = 50;
body_thickness = thickness-bearing_dia/2;
bearing_wall_thickness = 4;
bearing_outer_dia = bearing_dia+bearing_wall_thickness;
body_length = length - bearing_outer_dia;

module x_base() {
  difference() {
    x_base_body();
    x_base_holes();
  }
}

module z_connector_base()
{
  cylinder(r=rod_support_dia/2, h=12);
}

module z_connector_center()
{
  cylinder(r=rod_opening_dia/2, h=20);
}

module z_connector_screws(dia, hex=false)
{
  for(r=[0:1]) 
    rotate([0, 0, 45+90*(r+1)]) hull() {
      if(hex) cylinder(r=dia/2, h=hex ? 5 : 8);
      translate([rod_screw_distance/2, 0, 0]) 
        cylinder(r=dia/2, h=hex ? 6 : 12);
    }
  for(r=[2:3]) 
    rotate([0, 0, 45+90*(r+1)]) 
      translate([rod_screw_distance/2, 0, 0]) 
        cylinder(r=dia/2, h=hex ? 6 : 12);
}

module corner(size, height)
{
  difference() {
    cube([size, size, height]);
    translate([0, 0, -1]) cylinder(r=size, h=height+2); 
  }
}

module x_base_body()
{
  union() {
    cylinder(r=bearing_outer_dia/2, h=height);
    translate([-body_thickness, -bearing_dia/2-bearing_wall_thickness/2, 0]) cube([body_thickness, bearing_wall_thickness/2, height]);
  
    translate([-body_thickness, bearing_dia/2-bearing_wall_thickness/2, 0]) cube([body_thickness, bearing_wall_thickness, height]);
    
    translate([-body_thickness, -bearing_outer_dia/2, 0]) cube([bearing_wall_thickness/2, bearing_outer_dia, height]);
    translate([-bearing_outer_dia/2, -bearing_outer_dia/2, 0]) cube([bearing_outer_dia/2, bearing_outer_dia, height]);
    translate([-body_thickness, -length+bearing_dia/2+2.75, 0]) cube([12, length-bearing_dia-bearing_wall_thickness, height]);
    
    translate([-body_thickness+12+8-0.1, -8-bearing_outer_dia/2+0.1, 0]) rotate([0, 0, 90]) corner(8, height);
    translate([0, -z_rod_spacing, 0]) hull() for(x=[0, -6]) translate([x, 0, 0]) z_connector_base();
    translate([-bearing_outer_dia/2-8+0.1, -0.1, 0]) corner(8, height);
    translate([-bearing_outer_dia/2-8+0.1, -0.1, 0]) rotate([0, 0, -90]) corner(8, height);
    *translate([-0.4, -z_rod_spacing+rod_support_dia/2, 8+6-0.1]) rotate([90, 180, 0]) corner(8, rod_support_dia);
    
    // connector to bearing
    *translate([-bearing_outer_dia/2, -z_rod_spacing+3, 0]) cube([6+bearing_outer_dia/2, z_rod_spacing-bearing_outer_dia/2, 3]);
  }
}

module x_base_holes()
{
  translate([0, 0, -1]) cylinder(r=bearing_dia/2, h=height+2);
  rotate([0, 0, -(90+43)]) translate([-1/2, 0, -1]) cube([1, bearing_dia, height+2]);
  
  // rods
  translate([-body_thickness+6, bearing_outer_dia/2-bearing_wall_thickness, 6]) rotate([90, 0, 0]) cylinder(r=rod_dia_clip/2, h=length);
  translate([-body_thickness+6, bearing_outer_dia/2-bearing_wall_thickness, 6+x_rod_distance]) rotate([90, 0, 0]) cylinder(r=rod_dia_clip/2, h=length);
  
  // screw holes
  translate([-body_thickness+6, bearing_outer_dia/2+1, 6]) rotate([90, 0, 0]) cylinder(r=3.3/2, h=length);
  translate([-body_thickness+6, bearing_outer_dia/2+1, 6+x_rod_distance]) rotate([90, 0, 0]) cylinder(r=3.3/2, h=length);
  
  // nut holes
  translate([-body_thickness+6, bearing_outer_dia/2-bearing_wall_thickness/2, 6]) rotate([90, 0, 0]) cylinder(r=6.5/2, h=length, $fn=6);
  translate([-body_thickness+6, bearing_outer_dia/2-bearing_wall_thickness/2, 6+x_rod_distance]) rotate([90, 0, 0]) cylinder(r=6.5/2, h=length, $fn=6);
  
  // rod slit
  *translate([-body_thickness+6-1/2, -length, height-6+rod_dia_clip/2+0.4]) cube([1, length, 10]);
  *translate([-body_thickness+6-1/2, -length, -1]) cube([1, length, 1+6-rod_dia_clip/2-0.4]);
  
  translate([0, -z_rod_spacing, -1]) z_connector_center();
  translate([0, -z_rod_spacing, 10]) z_connector_screws(6.5, true, $fn=6);
  translate([0, -z_rod_spacing, -1]) z_connector_screws(screw_dia_small);
  
  %translate([0, -z_rod_spacing, -1])  cylinder(r=rod_dia/2, 60);
  
  difference() {
    union() for(z=[height/8+5, (height/2)-4/2, height-4-(height/8)-3]) translate([0, 0, z]) cylinder(r=(bearing_outer_dia+4)/2, h=4);
    cylinder(r=bearing_outer_dia/2, h=height);
  }
}

//x_base();

