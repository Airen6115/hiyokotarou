Game game;

void setup() {
  game = new Game(this);
  size(800, 600);
  pixelDensity(displayDensity());
  noStroke();
  textSize(48);
  frameRate(60);
  colorMode(HSB, 360, 100, 100);
  textFont(game.font);
}

void draw() {
  game.display();
}
