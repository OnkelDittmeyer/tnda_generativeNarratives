void getNewTweets()
{
    try 
    {
        //Query query = new Query(searchString);
        Query query = new Query(searchTerm);

        QueryResult result = twitter.search(query);

        //QueryResult result = twitter.search(new Query().geoCode(new GeoLocation(51.50939, -0.11832), res, resUnit));
        //QueryResult result = twitter.search(new GeoQuery(new GeoLocation(51.50939, -0.11832)));

        tweets = result.getTweets();
        
    } 
    catch (TwitterException te) 
    {
        System.out.println("Failed to search tweets: " + te.getMessage());
        System.exit(-1);
    } 
}

void refreshTweets()
{
    while (true)
    {
        getNewTweets();

        println("Updated Tweets"); 

        delay(30000);
    }
}


void tweetPic(File _file, String theTweet)
{
  try
    {
       StatusUpdate status = new StatusUpdate(theTweet);
       status.setMedia(_file);
       println("just have to update now");
       twitter.updateStatus(status);
       println("tweet image: "+ lastImg);
    }
    catch (TwitterException te)
    {
        println(" This Error: "+ te.getMessage());
    }
}
