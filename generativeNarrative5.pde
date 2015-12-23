import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

import controlP5.*;



//
// GET GOOGLE IMAGES SEARCH RESULTS
//
// I use the ajax.googleapis.com json search results to fetch the image
// urls into a string array and display them one at a time
//
// Youssef Faltas, Feb 2014

//colors & layout
color blue2 = color(0, 166, 255);
PImage logo;


//alertFader
int alpha = 0;
int click;
float easing =0.05;
int target_alpha = 0;


color blue = color(10, 166, 255);
color orange = color(247, 108, 15);
PFont pfont=  createFont("Georgia", 24);
ControlFont font = new ControlFont(pfont, 22);


String searchTerm = "Brighton";
String oldSearchTerm;
String newSearchTerm;
int numofResults = 60;                  // choose a multiple of four

//variables Google
String[] imgUrls = new String[0];
String[] links = new String[0];
processing.data.JSONArray results;
processing.data.JSONObject response;
PImage img;
PImage oldImg;
int i =0;
int t =0;

//googleSearchTags
String[] searchTermArray =
{
  "Digital", "Art", "Whitehawk", "Festival", "Henrik", "Pier", "Sunshine", "Marcel", "RCA", "Design"
}; 

Button[] tags = new Button[searchTermArray.length];

Boolean[] booleanOld = new Boolean[tags.length];


//variables Twitter
Twitter twitter;
//String searchString = "digital art";
List<Status> tweets;

int currentTweet;


double lat = 50.00;
double lon = -0.11;
double res = 5;
String resUnit = "km";

GeoLocation brightonLocation = new GeoLocation(51.50939, -0.11832);


//variables ScreenCap
File file;
String filePath = "/Users/marcelhelmer/Desktop/theNewDigitalArchaeologists/";
String lastImg;

//variables customTag
String oldTag;

//variables CP5
ControlP5 cp5;
float n, n1;

void setup()
{
  size(1920, 1080);
  background(50, 166, 255);
  textFont(pfont, 12);
  logo = loadImage("logo.png");


  cp5 = new ControlP5(this);

  addButtons();
  addTextFields();
  //searchTermConstructor();

  println("Searching for: "+ searchTerm);
  thread("updateLinks");
  //links = img_urls(numofResults/4);      // returns an array of image url strings
  int t = second();                      // start a clock

  //TwitterSetup
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("IVtM75e3QO7a3z1EyoccEMt2v");
  cb.setOAuthConsumerSecret("Gln8iAwAaxRYtgaeDCYfLAySC2UmrN2u59jogEtAJmMxCyupcw");
  cb.setOAuthAccessToken("2767176235-qlFbFNdkfRPKcCRCafEIIQG9IiLeRE6vkjGcydO");
  cb.setOAuthAccessTokenSecret("65PXyATeJxDkEJ4f7TIY8CnVO5E0KAjNr8vGdM6il8HN1");

  TwitterFactory tf = new TwitterFactory(cb.build());
  twitter = tf.getInstance();

  oldTag = cp5.get(Textfield.class, "customTag").getText();

  getNewTweets();

  i = int(random(0, links.length));
}

void draw() {

  background(255);

  //googleImageSearch
  //tagEvent();

  try {
    img = loadImage(links[i], "jpg");
    if (img != null) {

      image(img, 0, 0, width, height);
      if (img.height <= img.width) {
        img.resize( 0, height);
      }
      else {
        img.resize( width, 0);
      }
      //image(img, 0, 0, width, height);
    }
    else {
      println("Image cant be loaded");
      i = (i+1) % links.length;
    }
  }
  catch(Exception e) {
    println("Image cant be accessed: ");
    if(links.length > 0){
      i = (i++)%links.length ;
    }
  }


  Status status = tweets.get(currentTweet);
  noStroke();
  fill(orange);
  backgroundLines(width/2-320, 0, 640, 120, 255);
  backgroundLines(width/2-320, height-120, 640, 120, 255);

  fill(239, 153, 18);
  //rect(width/2-300, 0, 600, 100);


  fill(255);
  textAlign(CENTER, CENTER);
  textFont(pfont, 33);
  fill(0);
  text(status.getText().toUpperCase(), width/2 - 322, 2, 640, height);
  fill(255);
  text(status.getText().toUpperCase(), width/2 - 320, 0, 640, height);
  fill(255);

  cp5.get(Textfield.class, "myNarrative").getCaptionLabel().setText("100/"+cp5.get(Textfield.class, "myNarrative").getText().length());

  logo.resize(200, 0);
  image(logo, width/2-85, 100);
  drawTriangles(200, 66);


  //overlay

  //  float dx = target_alpha - alpha;
  //  if (abs(dx) > 1) {
  //    alpha += dx * easing;
  //  }

//  if (alpha > 0) {
//    fill(255, 0, 0, alpha);
//    rect(0, 0, width, height);
//    fill(0, 255, 0, alpha);
//    textAlign(CENTER, CENTER);
//    text("hello world", 0, 0, width, height);
//    float dx = abs(target_alpha - alpha);
//    alpha-= dx* easing;
//    println(alpha);
//  }

}

