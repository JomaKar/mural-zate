// This example code is in the public domain.

import processing.serial.*;

//Objetos
Serial myPort;       

//Variables
int[] serialInArray = new int[256];    
int[][] matriz = new int [16][16];
PVector[][] vertices = new PVector[16][16];
int serialCount = 0;                 
long latencia = 0;
long tiempotranscurrido = 0;
int segundoant = 0;
String imprimesegundo=" ";

boolean firstContact = false;       
boolean frameFlag = false;

int maximo = 0;

void setup() {
  //size(1024, 768, P3D);  
  fullScreen(P3D);
  noStroke();     

  println(Serial.list());


  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 115200);
 
}

void draw() {
  
  background(0);
  lights();
 
  stroke(255);
  //noStroke();
  smooth();
  
  if(second()!=segundoant){
    segundoant = second();
    imprimesegundo = str(latencia);
  }  
  
  fill(255);
  textAlign(LEFT);
  text("latencia: " + imprimesegundo + " milisegundos",20,20);
   
  translate(0, height/12,-400);
  rotateX(PI/4);
  
  fill(200);
  for(int j=0; j < 16; j++){
    for(int i=0; i < 16; i++){
      vertices[i][j] = new PVector(i*(width/16),j*(height/16),(matriz[i][j]-1)*(2));
    }
  }
  
  for(int j=0; j < 15; j++){
    beginShape(QUAD_STRIP);
    for(int i=0; i < 16; i++){
      
      if(matriz[i][j] > 50){
        fill(200);
        
      }
      else{
        fill(0,0,0);
        
      }
      
      vertex( vertices[i][j].x  , vertices[i][j].y  , vertices[i][j].z );
      vertex( vertices[i][j+1].x, vertices[i][j+1].y, vertices[i][j+1].z);
    }
    endShape();
  }
  
  for(int j=0; j < 16; j++){
    for(int i=0; i < 16; i++){
      fill(0,255,0);
      textSize(20);
      textAlign(CENTER, CENTER);
      text(str(vertices[i][j].z),vertices[i][j].x,vertices[i][j].y, vertices[i][j].z+10);
    }
  }
  
  rotateX(-PI/1.75);
  translate(0,0,0);
  
}



void serialEvent(Serial myPort) {
  
  int inByte = myPort.read();
  
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          // Borra el puerto Serial
      firstContact = true;     // Se acaba de hacer el primer contacto con el microcontrolador
      myPort.write('A');       // Pregunta por el primer arreglo
    }
  }
  else {
    // Agrega el último byte recibido al arreglo
    serialInArray[serialCount] = inByte;
    serialCount++;

    // Si tenemos 256 bytes
    if (serialCount > 255 ) {
      
      maximo = 0;
      //Llena la matriz con todos los bytes
      for(int i=0; i < 16; i++){
        for(int j=0; j < 16; j++){
          matriz[i][j] = serialInArray[16*i+j];
          if(matriz[i][j] > maximo){
            maximo = matriz[i][j];
          }
        }
      }
          
      // Escribe el byte 'A' para mandar pedir de nuevo la matriz al microcontrolador
      myPort.write('A');
      // Resetea la cuenta de bytes
      serialCount = 0;
      frameFlag = true;
      
      //Cálculo de la latencia
      long tiempoactual = millis();
      latencia = (tiempoactual - tiempotranscurrido);
      tiempotranscurrido = tiempoactual;
    }
  }
}