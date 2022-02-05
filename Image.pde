class Image{
  HashMap<String, PImage> image = new HashMap<String, PImage>();
  
  Image(String type){
    String absolutePath = dataPath("image");
    
    if(type.equals("player") || type.equals("all")){
      String playerFileName[];
      String playerPath = absolutePath + "\\player";
      playerFileName = getFileName(playerPath);
      for(String name : playerFileName)
        this.image.put(name.substring(0, name.indexOf(".")), loadImage(playerPath + "\\" + name));
    }if(type.equals("item") || type.equals("all")){
      String itemFileName[];
      String itemPath = absolutePath + "\\item";
      itemFileName = getFileName(itemPath);
      for(String name : itemFileName)
        this.image.put(name.substring(0, name.indexOf(".")), loadImage(itemPath + "\\" + name));
    }if(type.equals("enemy") || type.equals("all")){
      String enemyFileName[];
      String enemyPath = absolutePath + "\\enemy";
      enemyFileName = getFileName(enemyPath);
      for(String name : enemyFileName)
        this.image.put(name.substring(0, name.indexOf(".")), loadImage(enemyPath + "\\" + name));
    }if(type.equals("background") || type.equals("all")){
      String backgroundFileName[];
      String backgroundPath = absolutePath + "\\background";
      backgroundFileName = getFileName(backgroundPath);
      for(String name : backgroundFileName)
        this.image.put(name.substring(0, name.indexOf(".")), loadImage(backgroundPath + "\\" + name));
    }if(type.equals("status") || type.equals("all")){
      String statusFileName[];
      String statusPath = absolutePath + "\\status";
      statusFileName = getFileName(statusPath);
      for(String name : statusFileName)
        this.image.put(name.substring(0, name.indexOf(".")), loadImage(statusPath + "\\" + name));
    }
  }
  
  String[] getFileName(String fileDirectory){
    File directory1 = new File(fileDirectory);
    String[] file = directory1.list();
    return file;
  }
  
  PImage useImage(String name, int widthSize, int heightSize){
    PImage image = this.image.get(name);
    image.resize(widthSize, heightSize);
    return image;
  }
}
