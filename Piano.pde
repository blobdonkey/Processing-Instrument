import processing.sound.*;

ArrayList<SinOsc> Note = new ArrayList<SinOsc>();//Le différents sinus de chaque notes
boolean[] EtatNote;//Etat de la note (true : joue | false : off)

float C1 = 261.6;//DO 1 à 32.703Hz, le reste des notes seront construites à partir ce cette fondamentale
int nb_octaves = 3;//Nombre d'octaves affichées sur le piano

class Touche{
  public
    
  Touche(int x1, int y1, int w, int h, int offset)
  {    
    int note = offset;
    
    X1 = x1;
    Y1 = y1;
    W = w;
    H = h;
    
    //Touche off
    State = false;
    
    //Offset par rapport au C1
    Offset = offset;
    
    //On vérifie si c'est une noire ou une blanche
    while(note>=12)note-=12;
    if( (note==1)||(note==3)||(note==6)||(note==8)||(note==10) ) Couleur = false;//Noire
    else Couleur = true;//Blanche
    
    //Initialise les oscillateurs en fonction de l'offset des fréquences
    son = InitNote(offset);
    env = InitEnveloppe();
    reverb = InitReverb();
        
    //Dessine la note
    Draw();
  }
  
  void Draw()
  {
    if(Couleur)
    {
      //Blanche
      if(State)fill(128);//Note ON
      else fill(255);//Note OFF
      stroke(128);
      strokeWeight(4);
      rect(X1, Y1, W, H, 8);
    }
    else
    {
      //Noire
      if(State)fill(100);//Note ON
      else fill(0);//Note OFF
      stroke(100);
      strokeWeight(4);
      rect(X1, Y1, W, H, 8);
    }
  }
  
  void Play()
  {
    float attackTime = 0.1;
    float sustainTime = 1;
    float sustainLevel = 0.5;
    float releaseTime = 0.5;
  
    State |= true;
    son.play();
    reverb.process(son);
    //env.play(son, attackTime, sustainTime, sustainLevel, releaseTime);
  }
  
  void Stop()
  {
    son.stop();
    State &= false;
  }
  
  boolean Color()
  {
    return Couleur;
  }
  
  protected
  int X1, Y1, W, H;
  int Offset;//Ecart par rapport au C1
  
  boolean Couleur;//true:Blanche, false:Noire
  boolean State;//true : Joue, false : Stop
  
  SinOsc son;//Oscillateur de la note
  Env env;
  Reverb reverb;
}

SinOsc InitNote(int offset)
{
  SinOsc sin = new SinOsc(this);
  
  sin.stop();
  sin.freq(C1*pow(2,(float)offset/12));
  sin.amp(1);
  sin.add(0);
  sin.pan(0);
  
  return sin;
}

Env InitEnveloppe()
{
  Env env = new Env(this);
  return env;
}

Reverb InitReverb()
{
  float room=0.2;
  float damp=0.3;
  float wet=0.3;
  
  Reverb reverb = new Reverb(this);
  
  reverb.set(room, damp, wet);
  
  return reverb;
}

class Piano{
  public
  Piano(int x1, int y1, int w, int h)
  {
    X1 = x1;
    Y1 = y1;
    W = w;
    H = h;
    
    int dx = W/nb_octaves;//Longeur d'une octave
    int dy = H;//Le clavier est à deux étages, d'où le "/2"
    
    for(int i=0; i<(nb_octaves); i++)
    {
      //Blanches
      touche.add(new Touche(X1+(dx*i),Y1,dx/7,dy,0+(12*i)));//Blanche
      touche.add(new Touche(X1+(dx*i)+((2*dx)/(7*3)),Y1,((2*dx)/(3*7)),(dy*3)/5,1+(12*i)));//Noire
      touche.add(new Touche(X1+(dx*i)+(dx/7),Y1,dx/7,dy,2+(12*i)));//Blanche
      touche.add(new Touche(X1+(dx*i)+((5*dx)/(7*3)),Y1,((2*dx)/(3*7)),(dy*3)/5,3+(12*i)));//Noire
      touche.add(new Touche(X1+(dx*i)+(2*dx/7),Y1,dx/7,dy,4+(12*i)));//Blanche
      touche.add(new Touche(X1+(dx*i)+(3*dx/7),Y1,dx/7,dy,5+(12*i)));//Blanche
      touche.add(new Touche(X1+(dx*i)+((11*dx)/(7*3)),Y1,((2*dx)/(3*7)),(dy*3)/5,6+(12*i)));//Noire
      touche.add(new Touche(X1+(dx*i)+(4*dx/7),Y1,dx/7,dy,7+(12*i)));//Blanche
      touche.add(new Touche(X1+(dx*i)+((14*dx)/(7*3)),Y1,((2*dx)/(3*7)),(dy*3)/5,8+(12*i)));//Noire
      touche.add(new Touche(X1+(dx*i)+(5*dx/7),Y1,dx/7,dy,9+(12*i)));//Blanche
      touche.add(new Touche(X1+(dx*i)+((17*dx)/(7*3)),Y1,((2*dx)/(3*7)),(dy*3)/5,10+(12*i)));//Noire
      touche.add(new Touche(X1+(dx*i)+(6*dx/7),Y1,dx/7,dy,11+(12*i)));//Blanche
    }
  }
  
  void Draw()
  {
    for(int i=0; i<(nb_octaves);i++)
    {
      //Blanches
      touche.get(0+(12*i)).Draw();
      touche.get(2+(12*i)).Draw();
      touche.get(4+(12*i)).Draw();
      touche.get(5+(12*i)).Draw();
      touche.get(7+(12*i)).Draw();
      touche.get(9+(12*i)).Draw();
      touche.get(11+(12*i)).Draw();
      
      //Noires
      touche.get(1+(12*i)).Draw();
      touche.get(3+(12*i)).Draw();
      touche.get(6+(12*i)).Draw();
      touche.get(8+(12*i)).Draw();
      touche.get(10+(12*i)).Draw();
    }
  }
  
  void Play(int offset)
  {
    if(offset<touche.size()) touche.get(offset).Play();
  }
  
  void Stop(int offset)
  {
    if(offset<touche.size()) touche.get(offset).Stop();
  }
  
  protected
  int Touches;//Nombre de touches
  int X1, Y1;
  int W, H;
  ArrayList<Touche> touche = new ArrayList<Touche>();//Le différents sinus de chaque notes
}

void InitNotes()
{
  EtatNote = new boolean[nb_octaves*12];
  
  //Initialise les notes à 0
  for(int i=0; i<nb_octaves*12; i++)
  {
    EtatNote[i] &= false;
    Note.add(new SinOsc(this));
    Note.get(i).stop();
    Note.get(i).freq(440*pow(2,(float)i/12));
    Note.get(i).amp(1);
  }
}
