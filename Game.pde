class Game {
  int score;
  int highscore;
  String  state;
  int x, y;
  int maxHP;
  PImage scoreImage;
  boolean musicFlag, damageFlag;
  int t[] = new int[6];
  String s[] = new String[11];
  String _s;
  int enemyFrame;
  PFont font = createFont("./font/jackeyfont.ttf", 50);

  Player hiyoko;
  Sound sound;
  Image image = new Image("all");
  Image playerImage = new Image("player");
  Image itemImage = new Image("item");
  Image enemyImage = new Image("enemy");
  Item item[] = new Item[3];
  Enemy enemy[] = new Enemy[3];


  Game(pgBp2 obj) {
    this.highscore = loadHighscore();
    this.state = "start";
    this.score = 0;
    this.x = 0;
    this.y = 0;
    this.font = createFont("./font/jackeyfont.ttf", 50);
    this.damageFlag = true;
    this.musicFlag = true;
    this.sound = new Sound(obj);
    this.hiyoko = new Player(this.playerImage);
    for (int i = 0; i<3; i++){
      this.item[i] = new Item(this.itemImage);
      this.enemy[i] = new Enemy(this.itemImage);
    }
    for(int i = 0; i < 6; i++)
      this.t[i] = 0;
    this.s[0] = "げーむおーばー";
    this.s[1] = "もういちど";
    this.s[2] = "たいとる";
    this.s[3] = "これまでのはいすこあ：";
    this.s[4] = "すこあ:";
    this.s[5] = "まだまだひよっこ";
    this.s[6] = "ひよこ　そつぎょう！\nにわとりれべる！";
    this.s[7] = "そのいきおい、\nぺんぎんなみ！";
    this.s[8] = "そのすばやさ、\nふくろうのよう！";
    this.s[9] = "かれいなひこう！\nまさにとんび！";
    this.s[10] = "たかなみの\nどうたいしりょく！";
  }

  void showScore() {
    fill(0);
    textAlign(LEFT);
    text("すこあ："+ this.score, 0, 50);
  }
  
  void saveHighscore(int highscore){
    JSONObject json;
    json = new JSONObject();
    json.setInt("Highscore", highscore);
    saveJSONObject(json, "./data/save/save.json");
  }
  
  int loadHighscore(){
    JSONObject json = new JSONObject();
    int highscore = 0;
    try{
      json = loadJSONObject("./data/save/save.json");
      highscore = json.getInt("Highscore");
      if(highscore > 999999999)
        highscore = 999999999;
    }catch(NullPointerException e){
      highscore = 0;
    }
    return highscore;
  }

  void showHP() {
    this.maxHP = hiyoko.HP.size();
    for(int i = 0; i < maxHP; i++){
      if(this.hiyoko.HP.get(i))  image(this.image.useImage("HP", 50, 50), i * 50, 50);
      else  image(this.image.useImage("breakHP", 50, 50), i * 50, 50);
    }
  }

  void itemCollision(int index) {
    if ( abs ( this.item[index].x - mouseX ) < 40 && abs ( this.item[index].y - mouseY ) < 40 ) {
      this.score += item[index].point;
      this.sound.playSound(item[index].soundName, -10);
      if(this.item[index].heal > 0){
        for(int i = 0; i < this.hiyoko.HP.size(); i++){
          if(!this.hiyoko.HP.get(i)){
            this.hiyoko.HP.set(i, true);
            break;
          }
        }
      }
      if(this.item[index].maxHeal){
        for(int i = 0; i < this.hiyoko.HP.size(); i++)
          this.hiyoko.HP.set(i, true);
          if(this.hiyoko.HP.size() < 5)
              this.hiyoko.HP.add(true);
      }
      this.item[index] = new Item(this.itemImage);
    }
  }
  
  void deleteItem(int index){
    if(this.item[index].numRefrection >= this.item[index].deleteNum)
      this.item[index] = new Item(this.itemImage);
  }
  
  void enemyCollision(int index){
    if ( abs ( this.enemy[index].x - mouseX ) < 40 && abs ( this.enemy[index].y - mouseY ) < 40 && this.hiyoko.collision) {
      this.damageFlag = false;
      if(this.enemy[index].damage){
        for(int i = this.hiyoko.HP.size()-1; i >= 0; i--){
          if(this.hiyoko.HP.get(i)){
            this.hiyoko.HP.set(i, false);
            if(i <= 0) break;
            this.sound.playSound("damageA", 0);
            this.sound.playSound("hiyoko_voice", -10);
            this.hiyoko.invincible();
            break;
          }
        }
      }else if(this.enemy[index].death){
        this.hiyoko.HP.set(0, false);
      }
    }
  }
  
  void deleteEnemy(int index){
    if(this.enemy[index].x < -this.enemy[index].imageEdge || this.enemy[index].x > width+this.enemy[index].imageEdge || this.enemy[index].y < -this.enemy[index].imageEdge || this.enemy[index].y > height + this.enemy[index].imageEdge)
      this.enemy[index] = new Enemy(this.enemyImage);
  }

  void display() {
    //---------------------startMenu----------------------
    if (this.state.equals("start")) {
      if (this.musicFlag) {
        this.musicFlag = false;
        this.sound.loopMusic("startBGM", -20);
      }
      background(0, 0, 90);
      textAlign(CENTER, CENTER);
      fill(0);
      text("ひよこたろう", width/2, height/3);
      //fill(0, 100, 100);
      //rect(width/2-115, height/2-30, 220, 70);
      if (mouseX >= width/2 - 115 && mouseX <= width/2+105 && mouseY >= height/2-30 && mouseY <= height/2+50)
        fill(0, 40, 100);
      else
        fill(0);
      text("はじめる", width/2, height/2);
      
      //fill(0, 100, 100);
      //rect(width/2-125, height/1.5-30, 235, 70);
      if (mouseX >= width/2 - 125 && mouseX <= width/2+110 && mouseY >= height/1.5-30 && mouseY <= height/1.5+50)
        fill(0, 40, 100);
      else
        fill(0);
      text("あそびかた", width/2, height/1.5);
      
      fill(0);
      textAlign(LEFT, TOP);
      text("これまでのはいすこあ：" + highscore, 5, 0);
      
      if(this.highscore < 300){
        scoreImage = this.image.useImage("hiyoko", 250, 250);
      }else if(this.highscore >= 300 && this.highscore < 750){
        scoreImage = this.image.useImage("chicken", 250, 250);
      }else if(this.highscore >= 750 && this.highscore < 1500){
        scoreImage = this.image.useImage("penguin", 250, 250);
      }else if(this.highscore >= 1500 && this.highscore < 3000){
        scoreImage = this.image.useImage("owl", 250, 250);
      }else if(this.highscore >= 3000 && this.highscore < 6000){
        scoreImage = this.image.useImage("kite", 250, 250);
      }else if(this.highscore >= 6000){
        scoreImage = this.image.useImage("hawk", 250, 250);
      }
      image(scoreImage, width - 250, height - 250);
      image(this.image.useImage("hiyoko_r", 250, 250), 0, height-250);
      
      hiyoko.showPlayer();
      if (this.x >= width/2 - 115 && this.x <= width/2+105 && this.y >= height/2-30 && this.y <= height/2+50) {
        this.score = 0;
        this.sound.stopMusic();
        this.state = "game";
        this.enemyFrame = frameCount;
        this.x = 0;
        this.y = 0;
        this.musicFlag = true;
        this.hiyoko = new Player(this.playerImage);
        for (int i = 0; i<3; i++){
          this.item[i] = new Item(this.itemImage);
          this.enemy[i] = new Enemy(this.enemyImage);
        }
        for(int i = 0; i < 6; i++)
          this.t[i] = 0;

      }
      
      if (this.x >= width/2 - 125 && this.x <= width/2+110 && this.y >= height/1.5-30 && this.y <= height/1.5+50) {
        this.state = "tutorial1";
        this.x = 0;
        this.y = 0;
      }
      
      
    }
    //------------------------gameScreen------------------------------
    else if (this.state.equals("game")) {
      if (this.musicFlag) {
        this.musicFlag = false;
        this.sound.loopMusic("gameBGM", -20);
      }
      image(this.image.useImage("gameBack", width, height), 0, 0);
      showScore();
      showHP();
      hiyoko.showPlayer();
      int i = 0;
      for (Item item : item) {
        item.showItem();
        item.move();
        deleteItem(i);
        itemCollision(i);
        i++;
      }
      int j = 0;
      if(frameCount - enemyFrame >= 20)
        for(Enemy enemy : enemy){
          enemy.showEnemy();
          enemy.move();
          deleteEnemy(j);
          enemyCollision(j);
          j++;
        }
      if (!hiyoko.HP.get(0)) {
        this.sound.stopMusic();
        this.state = "gameover";
        this.x = 0;
        this.y = 0;
        this.musicFlag = true;
      }
      
      hiyoko.finInvincible();
    }
    //---------------------------gameoverMenu-----------------------------
    else if (this.state.equals("gameover")) {
      if (this.musicFlag) {
        this.musicFlag = false;
        this.sound.loopMusic("gameoverBGM", -20);
      }
      
      textAlign(CENTER, CENTER);
      
      //gameover
      image(this.image.useImage("gameoverBack", width, height), 0, 0);
      if(frameCount % 8 == 0 && t[0] <s[0].length()){
        this.sound.playSound("talk", 30);
        t[0]++;
      }
      text(s[0].substring(0, t[0]), width/2, height/3);
      
      //restart
      //fill(0, 100, 100);
      //rect(width/2-140, height/2-25, 265, 65);
      
      if (mouseX >= width/2 - 140 && mouseX <= width/2+125 && mouseY >= height/2-25 && mouseY <= height/2+40)
        fill(0, 40, 100);
      else
        fill(0, 0, 100);
      if(frameCount %8 == 0 && t[0] >= s[0].length() && t[1] < s[1].length()){
        this.sound.playSound("talk", 30);
        t[1]++;
      }
      text(s[1].substring(0, t[1]), width/2, height/2);
      
      //たいとる
      //fill(0, 100, 100);
      //rect(width/2-115, height/1.5-30, 220, 70);
      if (mouseX >= width/2 - 115 && mouseX <= width/2+105 && mouseY >= height/1.5-30 && mouseY <= height/1.5+40)
        fill(0, 40, 100);
      else
        fill(0, 0, 100);
      if(frameCount %8 == 0 && t[1] >= s[2].length() && t[2] < s[2].length()){
        this.sound.playSound("talk", 30);
        t[2]++;
      }
      textAlign(CENTER, CENTER);
      text(s[2].substring(0, t[2]), width/2, height/1.5);
      
      //highscore
      fill(0, 0, 100);
      textAlign(LEFT, TOP);
      String _highscore = s[3] + String.valueOf(this.highscore);
      if(frameCount %8 == 0 && t[2] >= s[2].length() && t[3] < _highscore.length()){
        this.sound.playSound("talk", 30);
        t[3]++;
      }
      text(_highscore.substring(0, t[3]), 5, 0);
      
      //score
      fill(0, 0, 100);
      String _score = s[4] + String.valueOf(this.score);
      if(frameCount %8 == 0 && t[3] >= _highscore.length() && t[4] < _score.length()){
        this.sound.playSound("talk", 30);
        t[4]++;
      }
      textAlign(LEFT, CENTER);
      text(_score.substring(0, t[4]), 5, 80);
      
      //comment
      fill(0, 0, 100);
      if(this.score < 300){
        _s = s[5];
        scoreImage = this.image.useImage("hiyoko", 250, 250);
      }else if(this.score >= 300 && this.score < 750){
        _s = s[6];
        scoreImage = this.image.useImage("chicken", 250, 250);
      }else if(this.score >= 750 && this.score < 1500){
        _s = s[7];
        scoreImage = this.image.useImage("penguin", 250, 250);
      }else if(this.score >= 1500 && this.score < 3000){
        _s = s[8];
        scoreImage = this.image.useImage("owl", 250, 250);
      }else if(this.score >= 3000 && this.score < 6000){
        _s = s[9];
        scoreImage = this.image.useImage("kite", 250, 250);
      }else if(this.score >= 6000){
        _s = s[10];
        scoreImage = this.image.useImage("hawk", 250, 250);
      }
      if(frameCount %8 == 0 && t[4] >= _score.length() && t[5] < _s.length()){
        this.sound.playSound("talk", 30);
        t[5]++;
      }
      textAlign(LEFT, BOTTOM);
      text(_s.substring(0, t[5]), 5, height);
      
      scoreImage.resize(250, 250);
      image(scoreImage, width - 250, height - 250);
      
      hiyoko.showPlayer();
      
      if(this.score > this.highscore){
        saveHighscore(this.score);
      }
      if (this.x >= width/2 - 115 && this.x <= width/2+105 && this.y >= height/1.5-30 && this.y <= height/1.5+40) {
        this.highscore = loadHighscore();
        this.sound.stopMusic();
        this.state = "start";
        this.x = 0;
        this.y = 0;
        this.musicFlag = true;
        this.hiyoko = new Player(this.playerImage);

      }
      
      if (this.x >= width/2 - 140 && this.x <= width/2+125 && this.y >= height/2-25 && this.y <= height/2+40) {
        this.highscore = loadHighscore();
        this.score = 0;
        this.sound.stopMusic();
        this.state = "game";
        this.enemyFrame = frameCount;
        this.x = 0;
        this.y = 0;
        this.musicFlag = true;
        this.hiyoko = new Player(this.playerImage);
        for (int i = 0; i<3; i++){
          this.item[i] = new Item(this.itemImage);
          this.enemy[i] = new Enemy(this.enemyImage);
        }
        for(int i = 0; i < 6; i++)
          this.t[i] = 0;

      }
    }
    
    //-------------------------tutorial----------------------------------
    else if(this.state.equals("tutorial1")){
      image(this.image.useImage("tutorialBack", width, height), 0, 0);
      String text = "まうすそうさで\nひよこをうごかしてね";
      textAlign(CENTER, CENTER);
      fill(0);
      text(text, width/2, height/2);
      
      if(mouseX >= width-250 && mouseY <= 250)
        image(this.image.useImage("hiyoko_damage", 250, 250), width-250, 0);
      else
        image(this.image.useImage("hiyoko", 250, 250), width-250, 0);
      
      if(mouseX <= 90 && mouseY <= 90)
        image(this.image.useImage("cross_hover", 90, 90), 0, 0);
      else
        image(this.image.useImage("cross_normal", 90, 90), 0, 0);
        
      if(mouseX >= width-90 && mouseY >= height-90)
        image(this.image.useImage("arrow_hover_r", 90, 90), width-90, height-90);
      else
        image(this.image.useImage("arrow_normal_r", 90, 90), width-90, height-90);
      
      if(this.x >= width-90 && this.y >= height-90){
        this.x = 0;
        this.y = 0;
        this.state = "tutorial2";
      }
      
      if(this.x <= 90 && this.y <= 90 && this.x != 0 && this.y != 0){
        this.x = 0;
        this.y = 0;
        this.state = "start";
      }
      
      hiyoko.showPlayer();
    }
    
    else if(this.state.equals("tutorial2")){
      image(this.image.useImage("tutorialBack", width, height), 0, 0);
      String text = "おこめをたべて\nぽいんとをかせごう！";
      textAlign(CENTER,CENTER);
      fill(0);
      text(text, width/2, height/2);
      
      if(mouseX >= width-200 && mouseY <= 200 && mouseX <= width - 50 && mouseY >= 30)
        if(frameCount % 60 < 30)
          image(this.image.useImage("item_rare1", 250, 250), width-250, 0);
        else
          image(this.image.useImage("item_rare2", 250, 250), width-250, 0);
      else
        image(this.image.useImage("item_normal", 250, 250), width-250, 0);
      
      if(mouseX <= 90 && mouseY <= 90)
        image(this.image.useImage("cross_hover", 90, 90), 0, 0);
      else
        image(this.image.useImage("cross_normal", 90, 90), 0, 0);
      
      if(mouseX >= width-90 && mouseY >= height-90)
        image(this.image.useImage("arrow_hover_r", 90, 90), width-90, height-90);
      else
        image(this.image.useImage("arrow_normal_r", 90, 90), width-90, height-90);
      
      if(mouseX <= 90 && mouseY >= height-90)
        image(this.image.useImage("arrow_hover_l", 90, 90), 0, height-90);
      else
        image(this.image.useImage("arrow_normal_l", 90, 90), 0, height-90);
        
      if(this.x >= width-90 && this.y >= height-90){
        this.x = 0;
        this.y = 0;
        this.state = "tutorial3";
      }
      
      if(this.x <= 90 && this.y >= height-90){
        this.x = 0;
        this.y = 0;
        this.state = "tutorial1";
      }
      
      if(this.x <= 90 && this.y <= 90 && this.x != 0 && this.y != 0){
        this.x = 0;
        this.y = 0;
        this.state = "start";
      }
      
      hiyoko.showPlayer();
    }
    
    else if(this.state.equals("tutorial3")){
      image(this.image.useImage("tutorialBack", width, height), 0, 0);
      String text = "からすにあたると\nたいりょくがへるよ！\nあかいからすには\nとくにちゅういしよう！";
      textAlign(CENTER, CENTER);
      fill(0);
      text(text, width/2, height/2);
      
      if(mouseX >= width-250 && mouseY <= 250 && mouseY >= 50)
        image(this.image.useImage("RedClow1", 250, 250), width-250, 0);
      else
        image(this.image.useImage("Clow2", 250, 250), width-250, 0);
      
      if(mouseX <= 90 && mouseY <= 90)
        image(this.image.useImage("cross_hover", 90, 90), 0, 0);
      else
        image(this.image.useImage("cross_normal", 90, 90), 0, 0);
      
      if(mouseX >= width-90 && mouseY >= height-90)
        image(this.image.useImage("arrow_hover_r", 90, 90), width-90, height-90);
      else
        image(this.image.useImage("arrow_normal_r", 90, 90), width-90, height-90);
      
      if(mouseX <= 90 && mouseY >= height-90)
        image(this.image.useImage("arrow_hover_l", 90, 90), 0, height-90);
      else
        image(this.image.useImage("arrow_normal_l", 90, 90), 0, height-90);
      
      if(this.x >= width-90 && this.y >= height-90){
        this.x = 0;
        this.y = 0;
        this.state = "tutorial4";
      }
      
      if(this.x <= 90 && this.y >= height-90){
        this.x = 0;
        this.y = 0;
        this.state = "tutorial2";
      }
      
      if(this.x <= 90 && this.y <= 90 && this.x != 0 && this.y != 0){
        this.x = 0;
        this.y = 0;
        this.state = "start";
      }
      
      hiyoko.showPlayer();
    }
    
    else if(this.state.equals("tutorial4")){
      image(this.image.useImage("tutorialBack", width, height), 0, 0);
      String text = "たいりょくがへったら\nはーとをとってかいふくしよう！";
      textAlign(CENTER,CENTER);
      fill(0);
      text(text, width/2, height/2);
      
      if(mouseX >= width-200 && mouseY <= 220 && mouseX <= width - 50 && mouseY >= 80)
        if(frameCount % 60 < 30)
          image(this.image.useImage("recoverHP_rare1", 250, 250), width-250, 0);
        else
          image(this.image.useImage("recoverHP_rare2", 250, 250), width-250, 0);
      else
        image(this.image.useImage("recoverHP_normal", 250, 250), width-250, 0);
      
      if(mouseX <= 90 && mouseY <= 90)
        image(this.image.useImage("cross_hover", 90, 90), 0, 0);
      else
        image(this.image.useImage("cross_normal", 90, 90), 0, 0);
      
      if(mouseX <= 90 && mouseY >= height-90)
        image(this.image.useImage("arrow_hover_l", 90, 90), 0, height-90);
      else
        image(this.image.useImage("arrow_normal_l", 90, 90), 0, height-90);
      
      if(this.x <= 90 && this.y >= height-90){
        this.x = 0;
        this.y = 0;
        this.state = "tutorial3";
      }
      
      if(this.x <= 90 && this.y <= 90 && this.x != 0 && this.y != 0){
        this.x = 0;
        this.y = 0;
        this.state = "start";
      }
      
      hiyoko.showPlayer();
    }
  }
}
