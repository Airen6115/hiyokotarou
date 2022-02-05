class Player {
  Image image;
  PImage hiyokoImage;
  PImage hiyokoDamageImage;
  String playerImagePath;
  boolean x;
  boolean collision;
  int hitFrame;
  ArrayList<Boolean> HP = new ArrayList<Boolean>();
  int imageEdge = 60;

  Player(Image image) {
    this.image = image;
    this.hiyokoImage = this.image.useImage("hiyoko", imageEdge, imageEdge);
    this.hiyokoDamageImage = this.image.useImage("hiyoko_damage", imageEdge, imageEdge);
    this.hitFrame = -120;
    this.x = false;
    this.collision = true;
    for(int i = 0; i < 3; i++)
      this.HP.add(true);
  }
  
  void playerDirection(){
    if(mouseX > pmouseX){
      this.hiyokoImage = this.image.useImage("hiyoko_r", imageEdge, imageEdge);
      this.hiyokoDamageImage = this.image.useImage("hiyoko_damage_r", imageEdge, imageEdge);
    }
    else if(mouseX < pmouseX){
      this.hiyokoImage = this.image.useImage("hiyoko", imageEdge, imageEdge);
      this.hiyokoDamageImage = this.image.useImage("hiyoko_damage", imageEdge, imageEdge);
    }
  }
  
  void showPlayer() {
    playerDirection();
    if(frameCount - hitFrame >= 120 || !HP.get(0))
      setImage(this.hiyokoImage, mouseX, mouseY, imageEdge);
    else{
      if(frameCount % 20 < 10){
        setImage(this.hiyokoDamageImage, mouseX, mouseY, imageEdge);
      }
    }
  }
  
  void invincible(){
    hitFrame = frameCount;
    this.collision = false;
  }
  
  void finInvincible(){
    if(frameCount - hitFrame >= 120){
      this.collision = true;
    }
  }
  
}
