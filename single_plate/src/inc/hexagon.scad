$fn=80;
holder_height = 4.6;
holder_dia = 15.8;
collar_height = 4.3;
collar_dia = 12;
soft_height = 13.5;
hex_dia = 18.25;
hex_height = 21.75;
heatgap_dia = 4;
heatgap_height = 3.8;

block_length = 18;
block_width = 16;
block_height = 10;
block_filament_center = 4.5;
block_cartridge_center = 12;
block_cartridge_dia = 5.75;
setscrew_dia = 3;
thermistor_dia = 2.2;

nozzle_dia = 9;
nozzle_height = 5.75;
nozzle_cone = nozzle_height-2.75;
nozzle_tip = 1.5;

hexagon();

module hexagon()
{
  cylinder(r=holder_dia/2, h=holder_height);
  translate([0,0,holder_height]) cylinder(r=collar_dia/2, h=collar_height);
  translate([0,0,holder_height+collar_height]) 
    cylinder(r=holder_dia/2, h=soft_height-(holder_height+collar_height));
  translate([0, 0, soft_height])
    cylinder(r=hex_dia/2, h=hex_height, $fn=6);
  translate([0, 0, soft_height+hex_height])
    cylinder(r=heatgap_dia/2, h=heatgap_height);
  translate([-block_filament_center, -block_width/2, soft_height+hex_height+heatgap_height]) difference() {
    cube([block_length, block_width, block_height]);
    translate([block_cartridge_center, -1, block_height/2]) rotate([-90, 0, 0])
      cylinder(r=block_cartridge_dia/2, h=block_width+2);
    translate([block_cartridge_center, block_width/2, block_height/2]) rotate([0, 90, 0])
      cylinder(r=setscrew_dia/2, h=(block_length-block_cartridge_center)+1);
    translate([block_filament_center, block_width/2, block_height/2]) rotate([-90, 0, 0])
      cylinder(r=thermistor_dia/2, h=block_width/2+1);
  }
  translate([0, 0, soft_height+hex_height+heatgap_height+block_height])
    cylinder(r=nozzle_dia/2, h=nozzle_height-nozzle_cone);
  translate([0, 0, soft_height+hex_height+heatgap_height+block_height+nozzle_height-nozzle_cone])
    cylinder(r1=nozzle_dia/2, r2=nozzle_tip/2, h=nozzle_cone);
  
}