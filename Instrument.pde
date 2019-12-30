import processing.sound.*;

Sound s;

Piano piano;

char[] keys = {'q','s','d','f','g','h','j','k','l','m','ù','*','w','x','c','v','b','n',',',';',':','!'};

void setup() {
  background(0,0,0);
  fullScreen();
  //size(500,200);
  
  piano = new Piano(0,100,width,height-200);
}

void draw() {
  piano.Draw();
}

void keyTyped() {
  int i = 0;
  
  for(i=0; (i<22);i++)
  {
    if(keys[i]==key)
    {
      piano.Play(i);
    }
  }
  
}

void keyReleased() {
  int i = 0;
  /*
  for(i=0; (i<12);i++)
  {
    if((keys[i]==key)&&(note_pressed[i]==true))
    {
      note_pressed[i] &= false;
      note.get(i).stop();
    }
  }
  */
  for(i=0; (i<22);i++)
  {
    if(keys[i]==key)
    {
      //env.play(note.get(i), attackTime, sustainTime, sustainLevel, releaseTime);
      piano.Stop(i);
    }
  }
} //<>//
