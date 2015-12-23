public void backgroundLines(int x, int y, int l, int h, color c) {
  int distance = 5;
  int x2 = x;
  int n=0;
  int m=0;
  stroke(c);

  for (int i=distance; x+distance*n <= x+l && y+distance*m<= y+h; i = i+distance) {


    if (y+i >= y+h) {
      //println("Y :"+ (y+i) +" is as big as "+ (y+h));
      if (x+i >= x+l) { 
        line(x+l, y+distance*m, x+distance*n, y+h);
        n++;
        m++;
      }
      else { 
        line(x+i, y, x+distance*n, y+h); 
        n++;
      }
    } 
    else { 
      line(x+i, y, x, y+i);
    }
  }
  noStroke();
}




public String deleteSpace(String text) {
  String newText;
  String partA;
  String partB;

  String newString = trim(text);

  while (newString.indexOf (" ") != -1) {
    newString.indexOf(" ");
    partA = newString.substring(0, newString.indexOf(" "));
    partB = newString.substring(newString.indexOf(" ")+1, newString.length());

    newString = partA +"+"+ partB;
  }

  return newString;
}


public void drawTriangles(int sideA, int sideB) {

  fill(255);
  triangle(0, 0, 0, sideA, sideB, 0);
  triangle(width-sideB, height, width, height, width, height-sideA);
}


public void tweetConfirmed() {

  for (int i=200; i > 0; i-=1) {
    println(i);
    fill(255,255,255, i);
    rect(0, 0, width, height);
    fill(blue);
    textAlign(CENTER, CENTER);
    textFont(pfont, 33);
    text("tweet confirmed", 0, 0, width, height);
    delay(50);
  }
  delay(5000);
}

