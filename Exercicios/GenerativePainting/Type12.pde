//Algoritmo desenvolvido para a oficina Type&Code do dia 05/06 do Departamento de Arquitetura e Urbanismo
//Autores: Roberto Vieira e Denise Pompeu

// Biblioteca para acessar e criar pontos ao longo do contorno da fonte
import geomerative.*;
// Biblioteca para criar arquivo vetorizado em .pdf
import processing.pdf.*;

import processing.sound.*;
AudioIn in;

// Declaração de objetos que serão acessados pelo setup() e pelo draw()
SoundFile audio;
Amplitude amp;
float sum;
float sFactor= 0.25;
float rmsScaled;

String message1 = "#type12hce2017";
String message2 = "Tipografia";
String message3 = "Trampo";
String message4 = "Type12hCE";
String message5 = "Oficina Digital";
String message6 = "LTC";
String message7 = "UFC";
String message8 = "LTA";
String message9 = "Opa!";
String message10 = "Schaide";
String message11 = "Miligrama";
String message12 = "Letras que Flutuam";
String message13 = "Latinotype";
String message14 = "Tipos Latinos";
String message15 = "Uniart";
String message16 = "Edro";
String message17 = "Mono";
String message18 = "Carta&C.";
String message19 = "O Tipo da Fonte"; 
String message20 = "Electric Circus";
String message21 = "LocTab";
String message22 = "Chegadim"; 
String message23 = "Brada.tv";
String message24 = "Serifa Fina";
String message25 = "Riso Tropical";
String message26 = "Estereográfica";
String message27 = "Mapinguari";
String message28 = "Traq";
String message;

  int m;
  String  fonte; 
  boolean terminou=true;
  int contagem=0;

RFont f;
RShape grp;
// Vetor "pontos"
RPoint[] pontos;
// Objeto para gravação de arquivo .pdf
PGraphics arquivopdf;

void setup(){
  
  // audio = new SoundFile(this,"flauta.mp3"); 
 //audio.play();
// amp = new Amplitude(this);
// amp.input(audio);
 
 // Create the Input stream
  in = new AudioIn(this, 0);
  in.play();
  amp = new Amplitude(this);
 amp.input(in);
  
  // Define do tamanho da tela
  size(1324,900);

  // IMPORTANTE: inicialização da biblioteca geomerative no setup()
  RG.init(this);
  
  //  Carrega o arquivo da fonte que será utilizada (o arquivo deve estar no diretório data dentro do diretório do algoritmo que estamos trabalhando), 
  //  com o tamanho 100 e alinhamento CENTER
 // grp = RG.getText("SOUND", "FreeSans.ttf", 160, CENTER);

  //  Desabilita chamada do Draw() em loop 
  //noLoop();
  //  Cria arquivo pdf com mesmo tamanho da tela com nome "Saida.pdf"
  arquivopdf = createGraphics(width, height, PDF, "Saida.pdf");
  
  frameRate(15);
}

void draw(){
  
  if (terminou){
    m= int(random(1,28));
     if (m==0){ message = message1;}
     if (m==1){ message = message1;}
     if (m==2){ message = message2;}
     if (m==3){ message = message3;}
     if (m==4){ message = message4;}
     if (m==5){ message = message5;}
     if (m==6){ message = message6;}
     if (m==7){ message = message7;}
     if (m==8){ message = message8;}
     if (m==9){ message = message9;}
     if (m==10){ message = message10;}
     if (m==11){ message = message11;}
     if (m==12){ message = message12;}
     if (m==13){ message = message13;}
     if (m==14){ message = message14;}
     if (m==15){ message = message15;}
     if (m==16){ message = message16;}
     if (m==17){ message = message17;}
     if (m==18){ message = message18;}
     if (m==19){ message = message19;}
     if (m==20){ message = message20;}
     if (m==21){ message = message21;}
     if (m==22){ message = message22;}
     if (m==23){ message = message23;}
     if (m==24){ message = message24;}
     if (m==25){ message = message25;}
     if (m==26){ message = message26;}
     if (m==27){ message = message27;}
     if (m==28){ message = message28;}
     if (m==29){ message = message28;}
     
    
     fonte = "SCRIPTBL.TTF";
      m= int(random(1,5));
       if (m==0){fonte = "HELR45W.ttf";}
      if (m==1){fonte = "HELR45W.ttf";} 
     if (m==2){fonte = "FreeSans.ttf" ;} 
     if (m==3){fonte = "SCRIPTBL.TTF" ;} 
     if (m==4){fonte = "Futura.ttf" ;}
     if (m==5){fonte = "Lato.ttf" ;}
     if (m==6){fonte = "Lato.ttf" ;}
  
     terminou = false;
  }
  
   grp = RG.getText(message, fonte, 120, CENTER);
   
    // Limpa a tela
   fill(255, 60);
   rect(0,0, width, height);
   
   sum = (amp.analyze() )* sFactor;
   rmsScaled = sum * (height/20) * mouseY; 
   
  // Inicia gravação do arquivo .pdf
  //beginRecord(arquivopdf);
  
  // Define a origem do desenho no centro da tela
  translate(width/2, height/2);
  
  // Define as formas sem preenchimento
  noFill();
  // Define contornos em vermelho
  stroke(255,0,0);
  // Desenha as formas
 // grp.draw();
  
  // Define os pontos nas curvas
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  // Define a distância entre os pontos a partir da posição do mouse
  RG.setPolygonizerLength(15);
  // Imprime o valor da posição do mouse
  println(mouseY);
  // Define uma distância entre os pontos: 30 
  //  RG.setPolygonizerLength(30);
  // Carrega os pontos no vetor "pontos"
  pontos = grp.getPoints();
  
  //Verifica se existem pontos
  if(pontos != null){
     // Percorre o vetor de pontos desenhando cada um deles com tamanho 5x5
   /*  for(int i=0; i<pontos.length; i++){
        ellipse(pontos[i].x, pontos[i].y,5,5);  
     }*/
    
     // Desenha quantas curvas forem desejadas
     for (int j=0; j<5; j++){ 
        // Define espessura das curvas
        if (j==0){
        strokeWeight(4);
        } else {strokeWeight(1);}
        // Define cor do contorno
        stroke(j*10*rmsScaled ,j*40*(1/rmsScaled ),j*80*(1/rmsScaled ));
        // Inicia curva
        beginShape();
           // Define pontos da curva entrando na tela pela esquerda com perturbações aleatórias nas coordenadas X e Y dos pontos
           curveVertex(-width/2 +random(-5*j,5*j), +random(-5*j,5*j));
           curveVertex(-width/2 +random(-5*j,5*j), +random(-5*j,5*j));
           curveVertex(-width/2 +50 +random(-5*j,5*j), +random(-5*j,5*j));
           curveVertex(-width/2 +200 +random(-2*j,2*j), +random(-2*j,2*j));
           // Define pontos da curva com perturbações aleatórias nas coordenadas X e Y dos pontos
           for(int i=0; (i<pontos.length)&&(i<contagem); i++){
              curveVertex(pontos[i].x+random(-rmsScaled*j,rmsScaled*j), pontos[i].y+random(-rmsScaled*j,rmsScaled*j));
           }
           
           // Define pontos da curva saindo da tela pela direita com perturbações aleatórias nas coordenadas X e Y dos pontos
           curveVertex(+width/2 -200 +random(-5*j,5*j), +random(-5*j,5*j));
           curveVertex(+width/2 -50 +random(-5*j,5*j), +random(-5*j,5*j));
           curveVertex(+width/2 +random(-5*j,5*j), +random(-5*j,5*j));
           curveVertex(+width/2 +random(-5*j,5*j), +random(-5*j,5*j));
 
           endShape();
           
           if (pontos.length + 200 <= contagem){contagem =0;
            terminou = true;}
    }
  } 
  
  contagem++;
   // Finaliza gravação do arquivo .pdf
   // endRecord();
}