class Enemy {
  Image image;
  int imageEdge = 80;
  String enemyName[] = new String[2];
  int enemy_prob;
  int startPoint_prob;
  float x, y, vx, vy;
  boolean damage, death;

  Enemy(Image image) {
    this.image = image;
    this.enemy_prob = (int)random(100);
    this.startPoint_prob = (int)random(100);
    if(startPoint_prob >= 0 && startPoint_prob < 25){
      this.x = -imageEdge/2;
      this.y = random(height);
      this.vx = random(5, 9);
    }else if(startPoint_prob >= 25 && startPoint_prob < 50){
      this.x = width + imageEdge/2;
      this.y = random(height);
      this.vx = random(-9, -5);
    }else if(startPoint_prob >= 50 && startPoint_prob < 75){
      this.x = random(width);
      this.y = -imageEdge/2;
      this.vy = random(5, 9);
    }else{
      this.x = random(width);
      this.y = height + imageEdge/2;
      this.vy = random(-9, -5);
    }
    
    if(this.x <= -imageEdge/2 || this.x >= width+imageEdge/2){
      if(this.y < height/2){
        this.vy = 6;
      }else{
        this.vy = -6;
      }
    }else if(this.y <= -imageEdge/2 || this.y >= height+imageEdge/2){
      if(this.x < width/2)
        this.vx = 6;
      else
        this.vx = -6;
    }
    
    if(enemy_prob >= 0 && enemy_prob < 90){
      this.damage = true;
      this.death = false;
      this.enemyName[0] = "Clow1";
      this.enemyName[1] = "Clow2";
      this.vx *= random(1.1, 1.3);
      this.vy *= random(1.1, 1.3);
    }else{
      this.damage = false;
      this.death = true;
      this.enemyName[0] = "RedClow1";
      this.enemyName[1] = "RedClow2";
      this.vx *= random(1.1, 1.5);
      this.vy *= random(1.1, 1.5);
    }
  }
  void showEnemy() {
    if(this.vx <= 0){
      if(frameCount % 40 < 20)
        setImage(this.image.useImage(enemyName[0], imageEdge, imageEdge), this.x, this.y, this.imageEdge);
      else
        setImage(this.image.useImage(enemyName[1], imageEdge, imageEdge), this.x, this.y, this.imageEdge);
    }else{
      if(frameCount % 40 < 20)
        setImage(this.image.useImage(enemyName[0] + "_r", imageEdge, imageEdge), this.x, this.y, this.imageEdge);
      else
        setImage(this.image.useImage(enemyName[1] + "_r", imageEdge, imageEdge), this.x, this.y, this.imageEdge);
    }
  }
  
  void move() {
    this.x += this.vx;
    this.y += this.vy;
  }
  
}
