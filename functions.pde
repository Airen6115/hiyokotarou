void setImage(PImage img, float x, float y, int edge) {
  push();
  translate(x-edge/2, y-edge/2);
  image(img, 0, 0);
  pop();
}

void mousePressed() {
  game.x = mouseX;
  game.y = mouseY;
}

void mouseClicked(MouseEvent e ){
  switch(e.getButton()){
    case RIGHT:
      noLoop();
      break;
    case CENTER:
      loop();
      break;
  }
}

  String[] getFileName(String fileDirectory){
    File directory1 = new File(fileDirectory);
    String[] file = directory1.list();
    return file;
  }
