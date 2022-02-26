import processing.pdf.*;
import controlP5.*;

ControlP5 cp5;

boolean record=false;
boolean initialized=false;
Reed reed=new Reed();
float scale=1;
int saved=-6000;
String filename="";
void setup() {
  size(1200, 800);
  noStroke();
  cp5 = new ControlP5(this);
  path=dataPath("reed.txt");
  reed=loadReed();

  // add a vertical slider
  cp5.addSlider("slotHeight")
    .setLabel("slot height")

    .setPosition(50, 20)
    .setSize(20, 200)
    .setRange(0, 100)
    .setValue(reed.slotHeight)
    ;

  // add a vertical slider
  cp5.addSlider("slotWidth")
    .setLabel("slot width")

    .setPosition(200, 20)
    .setSize(20, 200)
    .setRange(0, 5)
    .setValue(reed.slotWidth)
    ;

  // add a vertical slider
  cp5.addSlider("slotSpacing")
    .setLabel("spacing between slots")

    .setPosition(350, 20)
    .setSize(20, 200)
    .setRange(0, 5)
    .setValue(reed.slotSpacing)
    ;

  // add a vertical slider
  cp5.addSlider("slotNumber")
    .setLabel("number of slots")
     .setNumberOfTickMarks(100) 
     .snapToTickMarks(true)
     .showTickMarks(false)
    .setPosition(500, 20)
    .setSize(20, 200)
    .setRange(1, 100)
    .setValue(reed.slotNumber)
    ;

  println(reed.slotNumber);

  // add a vertical slider
  cp5.addSlider("reedWidth")
    .setPosition(650, 20)
    .setLabel("reed width")
    .setSize(20, 200)
    .setRange(0, 500)
    .setValue(reed.reedWidth)

    ;

  // add a vertical slider
  cp5.addSlider("reedHeight")
    .setLabel("reed height")

    .setPosition(800, 20)
    .setSize(20, 200)
    .setRange(0, 200)
    .setValue(reed.reedHeight)
    ;

  // create a new button with name 'savePattern'
  cp5.addButton("savePattern")
    .setLabel("Save Pattern")
    .setValue(0)
    .setPosition(1050, 70)
    .setSize(100, 100)
    ;
  initialized=true;
}

void draw() {
  background(40);
  fill(80);
  int offsetX=100;
  int offsetY=300;
  float xFill=(width-2*offsetX)/reed.reedWidth;
  float yFill=(height-offsetY-100)/reed.reedHeight;
  scale=(xFill>yFill)? yFill: xFill;
  drawReed(g, scale, 100, 300);
  if(millis()-saved<5000)
  {
    
    fill(0,60,180);
    rect(width/2, height-200, width*.9, 100);
    fill(255);
    text("saved to "+ filename, width*.15, height-200);
  }
}

void stop() {
  println("stopping");
  print(reed);
} 


void controlEvent(ControlEvent theEvent) {
  if (initialized)   //get booted up
  {
    switch(theEvent.getController().getName()) {
      case("slotHeight"):
      reed.slotHeight=theEvent.getController().getValue();
      break;
      case("slotWidth"):
      reed.slotWidth=theEvent.getController().getValue();
      break;
      case("slotNumber"):
        reed.slotNumber=round(theEvent.getController().getValue());
      break;
      case("reedWidth"):
      reed.reedWidth=theEvent.getController().getValue();
      break;
      case("reedHeight"):
      reed.reedHeight=theEvent.getController().getValue();
      break;
      case("slotSpacing"):
      reed.slotSpacing=theEvent.getController().getValue();
      break;
      case("savePattern"):
      {
        filename="Reed Pattern/Reed pattern "+nf(reed.slotNumber,0,0)+" slots -- "+nf(reed.slotWidth,0,2)+" mm slot width X "+nf(reed.slotHeight,0,2)+" mm slot height.pdf";
        
        PGraphics pdf = createGraphics(300, 300, PDF, filename);    
        pdf.beginDraw();
        drawReed(pdf, 1, 50, 50);
        pdf.dispose();
        pdf.endDraw();
        saved=millis();
      }      
      break;
    }
  }
  saveReed();
}




void drawReed(PGraphics g, float scale, float offsetX, float offsetY)
{

  g.stroke(0);
  g.fill(255);  
  g.noFill();
  g.pushMatrix();
  g.translate(offsetX, offsetY);
  g.text(reed.slotNumber+" slots, slots are "+nf(reed.slotWidth,0,2)+" x "+nf(reed.slotHeight,0,2)+" mm with "+nf(reed.slotSpacing,0,2)+" mm spacing in between", 0, 0);
  g.translate(0, 30);
  g.rectMode(CORNER);
  g.strokeWeight(2);
  g.stroke(0);
  g.fill(#C7EAEA);
  g.rect(0, 0, scale*reed.reedWidth, scale*reed.reedHeight);
  g.translate(scale*reed.reedWidth/2, scale*reed.reedHeight/2);
  g.strokeWeight(0.25);
  g.rectMode(CENTER);
  g.fill(#D3EAC7);
  if (reed.slotNumber%2==1)
  {
    g.rect(0, 0, scale*reed.slotWidth, scale*reed.slotHeight);
    for (int i=1; i<reed.slotNumber/2+1; i++)
    {
      g.pushMatrix();
      g.translate(-scale*i*(reed.slotWidth+reed.slotSpacing), 0);
      g.rect(0, 0, scale*reed.slotWidth, scale*reed.slotHeight, scale*reed.slotWidth/2);
      g.popMatrix();    
      g.pushMatrix();
      g.translate(scale*i*(reed.slotWidth+reed.slotSpacing), 0);
      g.rect(0, 0, scale*reed.slotWidth, scale*reed.slotHeight, scale*reed.slotWidth/2);
      g.popMatrix();
    }
  } else
  {
    for (int i=0; i<reed.slotNumber/2; i++)
    {
      g.pushMatrix();
      g.translate(-scale*(float(i)+0.5)*(reed.slotWidth+reed.slotSpacing), 0);
      g.rect(0, 0, scale*reed.slotWidth, scale*reed.slotHeight, scale*reed.slotWidth/2);
      g.popMatrix();    
      g.pushMatrix();
      g.translate(scale*(float(i)+0.5)*(reed.slotWidth+reed.slotSpacing), 0);
      g.rect(0, 0, scale*reed.slotWidth, scale*reed.slotHeight, scale*reed.slotWidth/2);
      g.popMatrix();
    }
  }
  g.popMatrix();
}
