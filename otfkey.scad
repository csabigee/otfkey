$fn=64;

keyLength = 50;
keyWidth = 9;
keyThickness = 2;


wallWidth = 2;
bodyScalerX = 1.165;
bodyScalerY = 1.9;
bodyHeight = 7;

// knob dimensions

// movement dimensions
movementPlay = 10;

module key() {
    cube([keyLength,keyWidth,keyThickness],true);
}

module base() {
    difference() {
        union() {
            cube([bodyScalerX*keyLength+2*wallWidth,bodyScalerY*keyWidth+2*wallWidth,wallWidth],true);
            translate([0,bodyScalerY*keyWidth/2+wallWidth/2,(bodyHeight+wallWidth)/2])
                cube([bodyScalerX*keyLength+2*wallWidth,wallWidth,bodyHeight],true);
            translate([0,-bodyScalerY*keyWidth/2-wallWidth/2,(bodyHeight+wallWidth)/2])
                cube([bodyScalerX*keyLength+2*wallWidth,wallWidth,bodyHeight],true);
            translate([bodyScalerX*keyLength/2+wallWidth/2,0,bodyHeight/2+wallWidth/2])
                cube([wallWidth,bodyScalerY*keyWidth+2*wallWidth,bodyHeight],true);
            translate([-bodyScalerX*keyLength/2-wallWidth/2,0,bodyHeight/2+wallWidth/2])
                cube([wallWidth,bodyScalerY*keyWidth+2*wallWidth,bodyHeight],true);
            translate([0,-bodyScalerY*keyWidth/2-wallWidth/2+2.4,2])
                cube([bodyScalerX*keyLength+2*wallWidth,5,2.2],true);
            translate([-27.6,6.6,2])
                cube([4,4,2.2],true);
            translate([-24,8.05,2])
                cube([6,2,2.2],true);
            translate([28.1,7.1,2])
                cube([5,5,2.2],true);
            translate([24,8.6,2])
                cube([4,3,2.2],true);
            
        }
        translate([30,-0.02,2.05])
                cube([5,9.25,2.1],true);
        translate([14,-10,4.25])
            cube([12,4,2.3],true);
        translate([0,9.5,10.5]) rotate([180,0,0]) scale([1.05,1.05,1.05]) latch(9);
    }
}

module latch(height) {
    outline=[[0,0],[3,0],[2,1],[7,1],[12,1.5],[20,3],[20,4],[12,2.5],[7,2],[0,2]];
    linear_extrude(height) union() {
        polygon(outline);
        //mirror([1,0,0]) polygon(outline);
    }
}

module keyHolder(insertKey) {
    union() {
        translate([-1,0,0])
            cube([10,keyWidth,2],true);
        translate([0.5,0,1])
            cylinder(4.9,2,2);
        translate([0,5,0])
            cube([5,4,2],true);
        if(insertKey) {
            translate([keyLength/2+4,0,0]) key();
        }
    }
}

module wedge(height) {
    outline=[[0,0],[20,0],[24,2.5],[0,2.5]];
    linear_extrude(height) {
        union() {
            polygon(outline);
            mirror([1,0,0]) polygon(outline);
        }
    }
}
module movement() {
    
    union() {
        difference() {
            cube([bodyScalerX*keyLength-5,bodyScalerY*keyWidth,wallWidth],true);
            cube([bodyScalerX*keyLength-2*wallWidth-5,4,1.1*wallWidth],true);
            translate([0,6.1,-2]) wedge(4);
        }
        translate([14,4,wallWidth/2]) cylinder(2.8,1.5,1.5);
        translate([-14,4,wallWidth/2]) cylinder(2.8,1.5,1.5);
        translate([14,-5,wallWidth/2]) cylinder(2.8,1.5,1.5);
        translate([-14,-5,wallWidth/2]) cylinder(2.8,1.5,1.5);
        translate([14,-10,0]) cube([6,6,wallWidth],true);
    }
}


module lid() {
    cube([bodyScalerX*keyLength+2*wallWidth,bodyScalerY*keyWidth+2*wallWidth,wallWidth],true);
}

module assembly(insertKey,keyOut) {
    translate([0,0,0]) base();    
    translate([0,9.45,5.1]) rotate([180,0,0]) color("blue")latch(4);
    if(keyOut) {
        translate([23,0,wallWidth+0]) keyHolder(insertKey);
    } else {
        translate([-23,0,wallWidth+0]) keyHolder(insertKey);
    }
    translate([0,0,2.1*wallWidth+0]) color("green", alpha=0.8) movement();
    translate([0,0,bodyHeight+wallWidth+0.1]) color("grey", alpha=0.2) lid();
}


//translate([0,0,0]) assembly(true,false);

//translate([0,0,1]) base();
translate([0,0,0]) latch(4);
//translate([0,0,1]) keyHolder(true);
//translate([0,0,1]) movement();
//translate([0,0,1]) lid();
