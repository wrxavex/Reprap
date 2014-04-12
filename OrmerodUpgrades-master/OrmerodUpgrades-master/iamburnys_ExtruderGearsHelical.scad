$fn=200;
include <MCAD/involute_gears.scad>; 
include <MCAD/regular_shapes.scad>;

gap = 29.884; //distance between centres of gears 
height=10;

module bigGear(
	pressure_angle=30,
	twist=200,
	dia = 45.3,
	teeth=34,
	circles=6) 
{
pitch =dia / (teeth /180);

//Big Gear
gear (number_of_teeth=teeth,
	circular_pitch=pitch,
	pressure_angle=pressure_angle,
	clearance = 0.2,
	gear_thickness = height/2*0.5,
	rim_thickness = height/2,
	rim_width = 1,
	hub_thickness = 5,
	hub_diameter=12,
	bore_diameter=5,
	circles=circles,
	twist=twist/teeth,
	circle_facets=3,
	involute_facets=6);
	
mirror([0,0,1])
gear (number_of_teeth=teeth,
	circular_pitch=pitch,
	pressure_angle=pressure_angle,
	clearance = 0.2,
	gear_thickness = height/2, //flat bottom
	rim_thickness = height/2,
	rim_width = 1,
	hub_thickness = 4,
	hub_diameter=12,
	bore_diameter=3,
	circles=circles,
	twist=twist/teeth,
	circle_facets=3,
	involute_facets=6);
}

module smallGear(
	pressure_angle=30,
	twist=200,
	dia = 14.4,
	teeth=11,
	circles=6) 
{
pitch =dia / (teeth /180);

//Small Gear
gear (number_of_teeth=teeth,
	circular_pitch=pitch,
	pressure_angle=pressure_angle,
	clearance = 0.2,
	gear_thickness = height/2,
	rim_thickness = height/2,
	rim_width = 1,
	hub_thickness = 4,
	hub_diameter=10,
	bore_diameter=5.2,
	circles=circles,
	twist=twist/teeth,
	circle_facets=3,
	involute_facets=6);
	
mirror([0,0,1])
gear (number_of_teeth=teeth,
	circular_pitch=pitch,
	pressure_angle=pressure_angle,
	clearance = 0.2,
	gear_thickness = height/2, //flat bottom
	rim_thickness = height/2,
	rim_width = 1,
	hub_thickness = 4,
	hub_diameter=10,
	bore_diameter=5.2,
	circles=circles,
	twist=twist/teeth,
	circle_facets=3,
	involute_facets=6);
}


difference() {
	bigGear();
	translate([0,0, (height/2)-5.1]) hexagon_prism(5.2,3.1); //Nut Trap hole
	translate([0,0, -(height/2)-0.1]) hexagon_prism(5.2,1.7); //thread hole
	difference() {  //top bevel
		cylinder(30,30,0);
		cylinder(28,28,0);
	}
	mirror([0,0,180]) 
	difference() { //bottom bevel
		cylinder(30,30,0);
		cylinder(28,28,0);
	}
	
}


difference() {
	union() {
		translate([gap,0,0]) rotate([180,0,0])	smallGear();
		translate([gap-3,-3,-(height/2) ]) cube([.8,6,height]); //hole flat
	}
	translate([gap,0,0]) 
	difference() {  //top bevel
		cylinder(14,14,0);
		cylinder(12.8,12.8,0);
	}
	mirror([0,0,180]) 
	translate([gap,0,0]) 
	difference() {  //top bevel
		cylinder(14,14,0);
		cylinder(12.8,12.8,0);
	}
}
