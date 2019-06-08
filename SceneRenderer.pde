import processing.video.*;
import controlP5.*;

ControlP5 cp5;
Capture video;

PImage img;
Movie m;

int points = 100;
float x;
float y;
color c = 0;
int size = (int)random(10, 30);

boolean useCam = false;
boolean useMovie = true;
boolean useImage = false;
boolean useSlider = false;
boolean useCircles = false;
boolean useRings = false;
boolean useTriangles = true;
boolean saveImage = false;
boolean drawScene = true;

void setup() {
  size(640, 480);
  background(0);
  setupSlider();
  setupCam();
  setupImage();
  setupMovie();
}

void draw() {
  if (drawScene) {
    drawScene();
  } else {
    checkVideoResolution();
  }
}

void setupSlider() {
  if (useSlider) {
    cp5 = new ControlP5(this);
    cp5.addSlider("points").setRange(50, 500)
      .setSliderMode(Slider.FLEXIBLE)
      .setColorActive(255)
      .setColorBackground(0)
      .setCaptionLabel("");
  }
}

void setupCam() {
  if (useCam) {
    video = new Capture(this, 640, 480, 30);
    video.start();
  }
}

void setupImage() {
  if (useImage) {
    img = loadImage("imageToDraw.jpg");
  }
}

void setupMovie() {
  if (useMovie) {
    m = new Movie(this, "movieToDraw.mp4");
    m.loop();
  }
}

void drawScene() {
  for (int i = 0; i < points; i++) {
    x = random(width);
    y = random(height);

    if (useCam) {
      video.read();
      c = video.get(int(x), int(y));
    }
    if (useImage) {
      c = img.get(int(x), int(y));
    }
    if (useMovie) {
      m.read();
      c=m.get(int(x), int(y));
    }

    useCircles();
    useRings();
    useTriangles();
    saveImage();
  }
}

void useCircles() {
  if (useCircles) {
    fill(c, (int)random(50, 80));
    noStroke();
    ellipse(x, y, size, size);
  }
}

void useRings() {
  if (useRings) {
    noFill();
    stroke(c, (int)random(50, 80));
    strokeWeight((int)random(1, 3));
    ellipse(x, y, size, size);
  }
}

void useTriangles() {
  if (useTriangles) {
    noFill();
    stroke(c, (int)random(50, 80));
    strokeWeight((int)random(1, 3));
    float direction = random(0, 1);
    if (direction > 0.5) {
      triangle(x-size/2, y-size/2, x+size/2, y-size/2, x, y+size/2);
    } else {
      triangle(x+size/2, y+size/2, x-size/2, y+size/2, x, y-size/2);
    }
  }
}

void saveImage() {
  if (saveImage) {
    if (millis() % 1000 == 0) {
      save("scene_"+millis()/1000+".jpg");
    }
  }
}

void checkVideoResolution() {
  Capture cam;

  int camwidth =0;
  int camheight =0;

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      // Search where the fps number is
      int p = cameras[i].indexOf("fps=");
      // Search where the width begins
      int q = cameras[i].indexOf("size=");
      // Search where the width ends and height begins
      int r = cameras[i].indexOf("x");
      // Search where the height ends
      int s = cameras[i].indexOf(",fps");

      println("fps= " + cameras[i].substring(p+4));
      // transforms the numeral string into an int
      int fps = Integer.parseInt(cameras[i].substring(p+4));

      println("width= " + cameras[i].substring(q+5, r));
      println("height= " + cameras[i].substring(r+1, s));

      // test the fps... I'm not overly picky.
      if ( fps > 20) {
        // if the fps is faster than 20, select it as camera height&width!
        camwidth = Integer.parseInt(cameras[i].substring(q+5, r));
        camheight = Integer.parseInt(cameras[i].substring(r+1, s));
      }
      println(cameras[i]);
    }
  }
  cam = new Capture(this, camwidth, camheight);
}