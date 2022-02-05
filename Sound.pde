import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

class Sound {

  Minim minim;
  HashMap<String, AudioPlayer> sound = new HashMap<String, AudioPlayer>();
  String nowMusicName;
  
  

  Sound(pgBp2 obj) {
    String absolutePath = dataPath("sound");
    String musicPath = absolutePath+"\\music";
    String soundEffectPath = absolutePath+"\\soundeffect";
    String musicName[] = getFileName(musicPath);
    String soundEffectName[] = getFileName(soundEffectPath);
    this.minim = new Minim(obj);
    for(String name : musicName)
      this.sound.put(name.substring(0, name.indexOf(".")), this.minim.loadFile(musicPath + "\\" + name));
    for(String name : soundEffectName)
      this.sound.put(name.substring(0, name.indexOf(".")), this.minim.loadFile(soundEffectPath + "\\" + name));
      
  }

  void loopMusic(String musicName, float gain) {
    this.sound.get(musicName).setGain(gain);
    this.sound.get(musicName).loop();
    this.nowMusicName = musicName;
  }

  void playSound(String soundName, float gain) {
    this.sound.get(soundName).setGain(gain);
    this.sound.get(soundName).play();
    this.sound.get(soundName).rewind();
  }

  void stopMusic() {
    this.sound.get(nowMusicName).pause();
    this.sound.get(nowMusicName).rewind();
  }
}
