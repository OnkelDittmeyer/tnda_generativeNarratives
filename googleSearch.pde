String[] img_urls(int fours)
{
  println("New Search for: "+searchTerm);
  String[] url = new String[fours];
  String[] links = new String[4*fours];

  println("Suche google nach: "+ searchTerm );
  for (int t=0; t<fours; t++)
  {       
    url[t] = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q="+searchTerm+ "&start="+(t*4)+"&as_filetype=jpg"+"&imgsz=large"+"&userip=192.168.0.8"; //ift:jpg,isz:m";
    //url[t] = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q="+searchTerm+ "&start="+(t*4)+"&as_filetype=jpg"+"&imgsz=medium"+"&as_rights=cc_publicdomain"+"&userip=192.168.0.8"; //ift:jpg,isz:m";

    // find more search arguments here
    // https://developers.google.com/image-search/v1/jsondevguide#json_args

    //JSONObject 
    response = loadJSONObject(url[t]);
    response = response.getJSONObject("responseData");


    //        while(true){
    //          try{
    //            response = response.getJSONObject("responseData");
    //            println("success");
    //            break;
    //          }catch (Exception e){
    //            println("try again");
    //            t++;
    //            response = loadJSONObject(url[t]);
    //          }
    //        }

    //JSONArray
    results = response.getJSONArray("results");

    for (int i = 0; i < results.size(); i++) {

      processing.data.JSONObject result = results.getJSONObject(i);

      int high = result.getInt("height");
      int wide = result.getInt("width");
      String linkstring = result.getString("unescapedUrl");
      links[(i+(4*t))] = linkstring;

      //println("Photo has height " + high + " and width " + wide + " is at ");
      //println(linkstring);
    }
  }   
  return links;
}
//constructs a string out of the searchTermArray
//to be used as searchString


void searchTermConstructor() {
  searchTerm = "Brighton";

  for (int i=0; i<searchTermArray.length ; i++) {
    if (tags[i].getBooleanValue() == true && searchTerm.indexOf(searchTermArray[i]) == -1 ) {
      newSearchTerm = searchTerm +"+"+ searchTermArray[i];
      //println(searchTermArray[i] +" is part of the new searchTerm, which is "+ newSearchTerm);
      searchTerm = newSearchTerm;
    }
    else {
      //println(searchTermArray[i] +" is not part of the search");
    }
  }
}




void updateLinks() {
  links = img_urls(numofResults/4);
}

