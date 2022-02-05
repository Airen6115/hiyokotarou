class Item {
  Image image;
  String itemName[];
  int probability;
  float minusVel, plusVel;
  int randomVel;
  float x, y, vx, vy;
  int numRefrection, deleteNum;
  int point;
  int heal;
  boolean maxHeal;
  int imageEdge = 50;
  String soundName;

  Item(Image image) {
    this.image = image;
    this.probability = (int)random(100);
    this.randomVel = (int)random(4);
    this.minusVel = random(-1.3, -1.2);
    this.plusVel = random(1.2, 1.3);
    this.x = random(25, width - 25);
    this.y = random(25, height + 25);
    if(probability >= 0 && probability < 86){
      itemName = new String[1];
      this.itemName[0] = "item_normal";
      this.point = 10;
      this.heal = 0;
      this.maxHeal = false;
      this.vx = 5;
      this.vy = 5;
      this.deleteNum = 15;
      this.soundName = "esa_nomralCatch";
    }else if(probability >= 86 && probability < 96){
      itemName = new String[2];
      this.itemName[0] = "item_rare1";
      this.itemName[1] = "item_rare2";
      this.point = 60;
      this.heal = 0;
      this.maxHeal = false;
      this.vx = 8;
      this.vy = 8;
      this.deleteNum = 10;
      this.soundName = "esa_rareCatch";
    }else if(probability >= 96 && probability < 99){
      itemName = new String[1];
      this.itemName[0] = "recoverHP_normal";
      this.point = 0;
      this.heal = 1;
      this.maxHeal = false;
      this.vx = 7;
      this.vy = 7;
      this.deleteNum = 8;
      this.soundName = "recover_normal";
    }else if(probability >= 99 && probability < 100){
      itemName = new String[2];
      this.itemName[0] = "recoverHP_rare1";
      this.itemName[1] = "recoverHP_rare2";
      this.point = 0;
      this.heal = 0;
      this.maxHeal = true;
      this.vx = 15;
      this.vy = 15;
      this.deleteNum = 7;
      this.soundName = "recover_rare";
    }
    
    if(randomVel <= 0){
      this.vx *= minusVel;
      this.vy *= minusVel;
    }else if(randomVel <= 1){
      this.vx *= plusVel;
      this.vy *= plusVel;
    }else if(randomVel <= 2){
      this.vx *= plusVel;
      this.vy *= minusVel;
    }else{
      this.vx *= minusVel;
      this.vy *= plusVel;
    }
  }
  void showItem() {
    if(itemName.length <= 1){
      setImage(this.image.useImage(itemName[0], imageEdge, imageEdge), this.x, this.y, this.imageEdge);
    }else{
      if(frameCount % 60 < 30)
        setImage(this.image.useImage(itemName[0], imageEdge, imageEdge), this.x, this.y, this.imageEdge);
      else
        setImage(this.image.useImage(itemName[1], imageEdge, imageEdge), this.x, this.y, this.imageEdge);
    }
    
  }
  void move() {
    this.x += this.vx;
    this.y += this.vy;

    if (this.x+20 > width || this.x < 20) {
      this.vx = -this.vx;
      this.numRefrection++;
    }
    if (this.y+20 > height || this.y < 20) {
      this.vy = -this.vy;
      this.numRefrection++;
    }
  }
}
