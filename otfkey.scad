$fn=64;

keyLength = 50;
keyWidth = 9;
keyThickness = 2;


wallWidth = 2;
bodyScalerX = 1.3;
bodyScalerY = 1.9;
bodyHeight = 9;

// knob dimensions

// movement dimensions
movementPlay = 10;

module key() {
    cube([keyLength+6,keyWidth,keyThickness],true);
}

module base() {
    difference() {
        union() {
            translate([0,0.25,0])
                cube([bodyScalerX*keyLength+2*wallWidth,bodyScalerY*keyWidth+2*wallWidth+0.5,wallWidth],true);
            translate([0,bodyScalerY*keyWidth/2+wallWidth/2,(bodyHeight+wallWidth)/2])
                cube([bodyScalerX*keyLength+2*wallWidth,wallWidth+1,bodyHeight],true);
            translate([0,-bodyScalerY*keyWidth/2-wallWidth/2,(bodyHeight+wallWidth)/2])
                cube([bodyScalerX*keyLength+2*wallWidth,wallWidth,bodyHeight],true);
            translate([bodyScalerX*keyLength/2+wallWidth/2,0,bodyHeight/2+wallWidth/2])
                cube([wallWidth,bodyScalerY*keyWidth+2*wallWidth,bodyHeight],true);
            translate([-bodyScalerX*keyLength/2-wallWidth/2,0,bodyHeight/2+wallWidth/2])
                cube([wallWidth,bodyScalerY*keyWidth+2*wallWidth,bodyHeight],true);
            translate([0,-bodyScalerY*keyWidth/2-wallWidth/2+2.4,2])
                cube([bodyScalerX*keyLength+2*wallWidth,5,2.5],true);
            translate([-29.6,6.6,2])
                cube([8,4,2.5],true);
            translate([-24,8.05,2])
                cube([6,2,2.5],true);
            translate([29.6,7.1,2])
                cube([8,5,2.5],true);
            translate([24,8.6,2])
                cube([4,3,2.5],true);
            
        }
        translate([34,-0.02,2.20])
                cube([5,9.25,2.4],true);
        translate([14,-10,4.4])
            cube([15,4,2.3],true);
        translate([0,10.2,10.91]) rotate([180,0,0]) scale([1.1,1.1,1.1]) latch(9);
    }
}

module latch(height) {
    outline=[[0,0],[4,0],[3,2],[7,2],[12,2.5],[20,4.7],[20,5.5],[19,5.4],[12,3.5],[7,3],[0,3]];
    linear_extrude(height) union() {
        polygon(outline);
        mirror([1,0,0]) polygon(outline);
    }
}

module keyHolder(insertKey) {
    union() {
        translate([-1,0,0])
            cube([16.6,keyWidth,2],true);
        translate([0.5,0,1])
            cylinder(6.9,1.8,2);
        translate([0,5,0])
            cube([5,4,2],true);
        if(insertKey) {
            translate([keyLength/2+4,0,0]) key();
        }
    }
}

module wedge(height) {
    outline=[[0,1],[12,1],[17,0],[19,0],[27,4.5],[0,4.5]];
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
            cube([bodyScalerX*keyLength-7,bodyScalerY*keyWidth-0.2,wallWidth],true);
            cube([bodyScalerX*keyLength-2*wallWidth-7,4,1.1*wallWidth],true);
            translate([0,4.8,-2]) wedge(4);
        }
        translate([10,4,wallWidth/2]) cylinder(4.8,1.4,1.6);
        translate([-10,4,wallWidth/2]) cylinder(4.8,1.4,1.6);
        translate([10,-5,wallWidth/2]) cylinder(4.8,1.4,1.6);
        translate([-10,-5,wallWidth/2]) cylinder(4.8,1.4,1.6);
        translate([14,-10,0]) cube([6,6,wallWidth],true);
    }
}


module lid() {
    union() {
        translate([0,0.25,0]) cube([bodyScalerX*keyLength+2*wallWidth,bodyScalerY*keyWidth+2*wallWidth+0.5,wallWidth],true);
        difference() {
            translate([0,-0.25,-1]) cube([bodyScalerX*keyLength-0.2,bodyScalerY*keyWidth-0.6,1],true);
            translate([0,-0.25,-1]) cube([bodyScalerX*keyLength-0.2-2,bodyScalerY*keyWidth-0.6-2,2],true);
        }
    }
}

module assembly(insertKey,keyOut) {
    translate([0,0,0]) base();    
    translate([0,9.9,7.1]) rotate([180,0,0]) color("blue")latch(6);
    if(keyOut) {
        translate([23,0,wallWidth+0]) keyHolder(insertKey);
    } else {
        translate([-23,0,wallWidth+0]) keyHolder(insertKey);
    }
    translate([0,0,2.1*wallWidth+0]) color("green", alpha=0.8) movement();
    translate([0,0,bodyHeight+wallWidth+5]) color("grey", alpha=0.4) lid();
}


translate([0,0,0]) assembly(true,false);
//translate([0,30,20]) lid();
//wedge(4);
//translate([0,0,1]) base();
//translate([0,0,0]) latch(6);
//translate([0,0,1]) keyHolder(true);
//translate([0,0,1]) movement();
//mirror([0,0,1])translate([0,0,-1]) lid();
