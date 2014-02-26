import processing.video.*;

// Create camera object
Capture cam;

// Overlay coords, X & W are hoizontal, Y & H are vertical
int ovlX, ovlY, ovlW, ovlH;

// Button indicators (Green, Red, Yellow. Blue, Orange)
int btnIndexMax = 5;
boolean[] btnInd = new boolean[btnIndexMax];

// Average color
color avgColor;

// Runs once after restart
void setup() {
  /*
  // Display cameras
  // Init array of cameras
  String[] cameras = Capture.list();
  // Any cameras?
  if (cameras.length == 0) {
    // No, Give user the bad news
    println("There are no cameras available for capture.");
    exit();
  }
  else {
    // Yes, Display cameras
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  }
  */
  // Create display window
  size(320, 240);
  frameRate(30);
  // Init camera
  println(width, height);
  cam = new Capture(this, width, height);
  cam.start();     
  // Init overlay coords
  ovlX = 118;
  ovlY = 132;
  ovlW = 79;
  ovlH = 6;
  // Init button indicators
  btnInd = new boolean[] {false, false, false, false, false};
}      

// Runs every display window refresh
void draw() {
  // New frame?
  if (cam.available() == true) {
    // Yes, read camera
    cam.read();
    // Display camera
    image(cam, 0, 0);
    // The following does the same, and is faster when just drawing the image
    // without any additional resizing, transformations, or tint.
    //set(0, 0, cam);
    // Display overlaycolor
    // Display btnIndexMax buttons (Green, Red, Yellow, Blue, Orange)
    for(int btn = 0; btn < btnIndexMax; btn++) {
      // Get strum indicator average color
      loadPixels();
      avgColor = pixels[(ovlY +1) * width + ovlX + ovlW / 5 * btn + 1];
      for(int h = ovlY + 1; h < ovlY + ovlH; h++) {
        for(int w = ovlX + ovlW / 5 * btn + 1; w < ovlX + ovlW / 5 * (btn + 1); w++) {
          avgColor = avgRGB(pixels[h * width + w]);
        }
      }
      // Display strum indicator
      fill(avgColor);
      stroke(255);
      rect(ovlX + ovlW / 5 * btn, ovlY, ovlW / 5, ovlH);
      // Display button indicator
      switch(btn) {
        case 0: // Green
          stroke(#00CC1E);
          fill(#00CC1E);
          break;
        case 1: // Red
          stroke(#DD2100);
          fill(#DD2100);
          break;
        case 2: // Yellow
          stroke(#FCFC00);
          fill(#FCFC00);
          break;
        case 3: // Blue
          stroke(#0007E0);
          fill(#0007E0);
          break;
        case 4: // Orange
          stroke(#FC8A00);
          fill(#FC8A00);
          break;
      }
      // Display Indicator?
      if(!btnInd[btn]) {
        // Off, No Fill
        noFill();
      }
      ellipse(ovlX + ovlW / btnIndexMax * btn + ovlW / btnIndexMax / 2, ovlY + ovlH + 10, 10, 10);
    } 
  }
}

// Shift indicator
boolean shftInd;
// 
void keyPressed() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      shftInd = true;
    }
    else if (keyCode == DOWN) {
      if (shftInd) {
        ovlH++;
      }
      else {
        ovlY++;
      }
    }
    else if (keyCode == UP) {
      if (shftInd) {
        ovlH--;
      }
      else {
        ovlY--;
      }
    }
    else if (keyCode == RIGHT) {
      if (shftInd) {
        ovlW += btnIndexMax;
      }
      else {
        ovlX++;
      }
    }
    else if (keyCode == LEFT) {
      if (shftInd) {
        ovlW -= btnIndexMax;
      }
      else {
        ovlX--;
      }
    }
  }
}

//
void keyReleased() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      shftInd = false;
    }
  }
}

// Average RGB
color avgRGB(color c){ 
  // Extract RGB values
  int r = (c >> 16) & 0xFF;
  int g = (c >> 8) & 0xFF;
  int b = c & 0xFF;
  int ra = (avgColor >> 16) & 0xFF;
  int ga = (avgColor >> 8) & 0xFF;
  int ba = avgColor & 0xFF;
  return color((r + ra) / 2, (g + ga) / 2, (b + ba) / 2);
}

// Convert RGB to grayscale
int grayscale(color c){ 
  // Extract RGB values
  int r = (c >> 16) & 0xFF;
  int g = (c >> 8) & 0xFF;
  int b = c & 0xFF;
 
  //typical NTSC color to luminosity conversion
  int intensity = int(0.2989*r + 0.5870*g + 0.1140*b);
  if (intensity> 0) intensity=int(map(intensity,0,255,0,100));
  return intensity;
}

