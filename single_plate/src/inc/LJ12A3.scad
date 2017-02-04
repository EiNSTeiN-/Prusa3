threads_dia = 12;
threads_length = 55;
hex_dia = 19;
hex_height = 3.5;
cap_dia = 10.5;
cap_length = 5;
washer_dia = 21;
washer_height = 0.8;
total_length = 62;
wire_dia = 5.5;
wire_height = 4.5;

$fn=120;

module probe_cylinder(height)
{
  cylinder(r=threads_dia/2, h=height);
}

module probe(slide=0, plate=3)
{
  translate([0, 0, -10-slide]) {
    cylinder(r=cap_dia/2, h=total_length);
    translate([wire_dia/2-0.3, 0, total_length])
      cylinder(r=wire_dia/2, h=wire_height);
    translate([0, 0, cap_length])
      probe_cylinder(threads_length);
  }
  
  // bottom washer
  translate([0, 0, -washer_height-hex_height]) 
    cylinder(r=hex_dia/2, h=hex_height, $fn=6);
  translate([0, 0, -washer_height]) 
    cylinder(r=washer_dia/2, h=washer_height);
  
  // top washer
  translate([0, 0, plate]) 
    cylinder(r=washer_dia/2, h=washer_height);
  translate([0, 0, plate+washer_height]) 
    cylinder(r=hex_dia/2, h=hex_height, $fn=6);
}

probe();