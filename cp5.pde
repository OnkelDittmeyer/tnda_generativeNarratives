void addTagButtons() {
  int n = 120;


  for (int i=0; i<searchTermArray.length; i++) {
    String buttonName = "tag"+str(i);
    Button b = cp5.addButton(buttonName)
      .setValue(0)
        .setPosition(90, n)
          .setSize(55, 19)
            .setCaptionLabel(searchTermArray[i])
              .setColorBackground(blue)
                .setColorActive(color(255, 189, 10))
                  .setSwitch(true)
                    ;

    b.captionLabel()
      .setFont(font)
        ;

    tags[i] = b;
    n += 20;


    //initialize status of all tags
    for (int j=0; j<tags.length; j++) {
      booleanOld[n] = tags[j].getBooleanValue();
    }
  }
}


public void addButtons() {
  cp5.addButton("nextImage")
    .setValue(0)
      .setPosition(width/2+200, 30)
        .setSize(100, 50)
          .setColorBackground(color(239, 153, 18));
  ;
  cp5.get(Button.class, "nextImage").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);


  cp5.addButton("newSearch")
    .setValue(0)
      .setPosition(width/2+50, 30)
        .setSize(100, 50)
          .setColorBackground(color(239, 153, 18));
  ;
  cp5.get(Button.class, "newSearch").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);




  cp5.addButton("tweet")
    .setValue(0)
      .setPosition( width/2+200, 920)
        .setSize(100, 100)
          .setColorBackground(color(239, 153, 18));


  cp5.get(Button.class, "tweet").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  ;
}


public void addTextFields() {

  Textfield customTag = cp5.addTextfield("customTag")
    .setPosition(width/2-300, 30)
      .setSize(300, 50)
        .setFocus(true)
          .setColor(blue)
            .setColorBackground(color(239, 153, 18))
              .setFont(createFont("Verdana", 20))
                .setAutoClear(true)
                  ;

  customTag.getCaptionLabel().hide();



  Textfield myNarrative = cp5.addTextfield("myNarrative")
    .setPosition(width/2-300, 920)
      .setSize(480, 100)
        .setFont(ControlP5.grixel)
          .setColorBackground(color(239, 153, 18))
            .setText("What may be the narrative of this two artifacts?")
              ;        


  myNarrative.getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP);
}

public void nextImage(int theValue) {
  println("Image:" +i +" of "+ links.length);
  if(links.length > 0){
    i = (i+1) % (links.length);
  }
}

public void tweet(int theValue) {

  lastImg = filePath +"img_"+ hour() +"_"+ minute() +"_"+ second() +".jpg";
  saveFrame(lastImg);
  println(lastImg);

  //uncomment testPassingFile(file) to test if your file is good and accessible

  file = new File(lastImg);
  //testPassingFile(file);
  if (cp5.get(Textfield.class, "myNarrative").getText() != null) {
    tweetPic(file, cp5.get(Textfield.class, "myNarrative").getText() +" #TNDA");
  }
  
}


public void newSearch(int theValue) {
  if(cp5.get(Textfield.class, "customTag").getText() != ""){
  searchTerm = "Brighton+"+ deleteSpace(cp5.get(Textfield.class, "customTag").getText());
  }
  println(searchTerm);

  updateLinks();
  getNewTweets();
  i = int(random(0,links.length));

}



void testPassingFile(File _file)
{
  println(_file.exists());
  println(_file.getName());
  println(_file.getPath());
  println(_file.canRead());
}



// Controller Event of CP5
//public void controlEvent(ControlEvent theEvent) {
//  //println(theEvent.getController().getName());
//  if (theEvent.getController().getName().indexOf("tag") != -1) {
//    searchTermConstructor(); 
//    links = img_urls(numofResults/4);
//  }
//}


public void tagEvent() {
  for (int i=0; i<tags.length; i++) {
    if (tags[i].getBooleanValue() != booleanOld[i]) {
      searchTermConstructor(); 
      links = img_urls(numofResults/4);
      getNewTweets(); 
      booleanOld[i] = tags[i].getBooleanValue();
    }
  }
}

