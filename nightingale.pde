Table table; 
PImage img;
ArrayList<Row> first = new ArrayList<Row>();
ArrayList<Row> second = new ArrayList<Row>();

// How every row in the data imported will be saved
class Row {
  public String month = "";
  public int avg_size = 0;  
  public float d_zymotic_diseases = 0;
  public float d_wounds = 0;
  public float d_other = 0;
  public float a_zymotic_diseases = 0;
  public float a_wounds = 0;
  public float a_other = 0;
}

void setup() {
  size(1300, 700);
  table = loadTable("nightingale-data-1.csv", "header");
  img = loadImage("bg.jpg");
  img.resize(width,height);
   int i = 0;
  for (TableRow row : table.rows()) {
    Row r = new Row();
    r.month = row.getString(0);
    r.avg_size = row.getInt(1);
    r.d_zymotic_diseases = row.getFloat(2);
    r.d_wounds = row.getFloat(3);
    r.d_other = row.getFloat(4);
    r.a_zymotic_diseases = row.getFloat(5);
    r.a_wounds = row.getFloat(6);
    r.a_other = row.getFloat(7);
    if (i >= 12) {
      second.add(r);
    } else {
      first.add(r);
      i++;
    }
  }  
}

void draw() {
 background(img);
  // Draw Pies
  drw_year1(width/2 - width/4, height/2 - 70);
  drw_year2(width/2 + width/4, height/2 + 80);

  // Top Label
  textAlign(CENTER);
  textSize(30); 
  fill(#FFFAFA, 2000);
  text("DIAGRAM of the CAUSES of MORTALITY\nin the ARMY in the EAST", width/2, height/2 - 300);    

  // Draw LabelBox
  label(#FF2705, #FF2705, width/2 + 200, height/2 + 250, "Deaths by Zymotic Diseases");
  label(#2ecc71, #2ecc71, width/2 + 200, height/2 + 270, "Deaths by Other Causes");
  label(#050FFF, #050FFF, width/2 + 200, height/2 + 290, "Deaths by Wounds");

  noFill();
  stroke(#ffffff, 150);
  rect(width/2 + 190, height/2 + 240, 240, 70);
}

void label(color c1, color strokeC, float x, float y, String text) {
  fill(c1, 150);
  stroke(strokeC);
  rect(x, y, 10, 10);
  textSize(15); 
  fill(#FFFFFF, 190);
  textAlign(LEFT, CENTER);
  text(text, x+20, y+3);
  saveFrame("nightingale.jpg");
}
void drw_year1(float centerX, float centerY) {  
  // Top Label
  textAlign(CENTER);
  textSize(26); 
  fill(#FFFFFF, 200);
  text("APRIL 1854 to MARCH 1855", centerX, centerY - 140);    
  textSize(15); 

  for (int i = 1; i<first.size(); i++) {  
    Row r = first.get(i);
    // Calculate Pie Properties
    float s1 = r.a_zymotic_diseases/1.5;
    float s3 = r.a_wounds*1.2/1.5;
    float s2 = r.a_other*1.2/1.5;
    float angle1 = i*(360/first.size()) - 175;
    float angle2 = (360/first.size());   

    // Draw Text Labels
    float highest = max(s1, max(s2, s3));
    float distance = max(80, highest/2 + 10);
    float textX = centerX + distance * cos(radians(angle1+angle2/2));
    float textY = centerY + distance * sin(radians(angle1+angle2/2));    
    fill(#FFFFFF, 190);    
    textAlign(CENTER);
    pushMatrix();
    translate(textX, textY);
    rotate(radians(angle1+angle2/2+90));
    translate(-textX, -textY);
    String t = r.month;
    String m = t.substring(0, t.indexOf(" "));
    text(m, textX, textY);
    popMatrix();

    // Draw Pie Sections
    drw_pie(centerX, centerY, s1, angle1, angle2, #FF2705, #ff2705, 150);
    drw_pie(centerX, centerY, s2, angle1, angle2, #2ecc71, #2ecc71, 190);
    drw_pie(centerX, centerY, s3, angle1, angle2, #050FFF, #050FFF, 190);
  }
}

void drw_year2(float centerX, float centerY) {

  // Top Label
  textAlign(CENTER);
  textSize(26); 
  fill(#FFFFFF, 200);
  text("APRIL 1855 to MARCH 1856", centerX, centerY - 290);    
  textSize(15); 

  for (int i = 1; i<second.size(); i++) {
    Row r = second.get(i);
    // Calculate Pie Properties
    float s1 = r.a_zymotic_diseases * 2;
    float s3 = r.a_wounds*1.2 * 2;
    float s2 = r.a_other*1.2 * 2;
    float angle1 = i*(360/second.size()) - 200;
    float angle2 = (360/second.size());   

    // Draw Text Labels
    float highest = max(s1, max(s2, s3));
    float distance = max(80, highest/2 + 10);
    float textX = centerX + distance * cos(radians(angle1+angle2/2));
    float textY = centerY + distance * sin(radians(angle1+angle2/2));
    fill(#FFFFFF, 190); 
    textAlign(CENTER);
    pushMatrix();
    translate(textX, textY);
    rotate(radians(angle1+angle2/2+90));
    translate(-textX, -textY);
    String t = r.month;
    String m = t.substring(0, t.indexOf(" "));    
    text(m, textX, textY);
    popMatrix();

    // Draw Pie Sections
     drw_pie(centerX, centerY, s1, angle1, angle2, #FF2705, #ff2705, 150);
    drw_pie(centerX, centerY, s2, angle1, angle2, #2ecc71, #2ecc71, 190);
    drw_pie(centerX, centerY, s3, angle1, angle2, #050FFF, #050FFF, 190);
  }
}

void drw_pie(float centerX, float centerY, float size, float angle1, float angle2, color color1, color strokeColor, int alpha) {
  fill(color1, alpha);
  stroke(strokeColor);
  arc(centerX, centerY, size, size, radians(angle1), radians(angle1 + angle2), PIE);
}
