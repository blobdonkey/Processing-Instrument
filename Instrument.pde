import processing.sound.*;

Sound s;
Env env;

ArrayList<SinOsc> note = new ArrayList<SinOsc>();
boolean[] note_pressed = new boolean[12];

void setup() {
  fullScreen();
  //size(500,200);
  background(255);
  
  env  = new Env(this); 
  
  for(int i=0; i<12; i++)
  {
    note_pressed[i] &= false;
    
    note.add(new SinOsc(this));
    note.get(i).stop();
    note.get(i).freq(440*pow(2,(float)i/12));
    note.get(i).amp(1);
  }
}

void draw() {
  background(255);
}

void keyTyped() {
  char[] keys = {'q','s','d','f','g','h','j','k','l','m','ù','*'};
  int i = 0;
  
  float attackTime = 0.1;
  float sustainTime = 1;
  float sustainLevel = 0.5;
  float releaseTime = 0.5;
  
  for(i=0; (i<12);i++)
  {
    if((keys[i]==key)&&(note_pressed[i]==false))
    {
      note_pressed[i] |= true;
      env.play(note.get(i), attackTime, sustainTime, sustainLevel, releaseTime);
      note.get(i).play();
    }
  }
}

void keyReleased() {
  char[] keys = {'q','s','d','f','g','h','j','k','l','m','ù','*'};
  int i = 0;
  
  for(i=0; (i<12);i++)
  {
    if((keys[i]==key)&&(note_pressed[i]==true))
    {
      note_pressed[i] &= false;
      note.get(i).stop();
    }
  }
} //<>//
