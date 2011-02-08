iTunes
======

A Ruby wrapper around the iTunes API that lets you search for any sort of data that is available on the iTunes store.

Example Response
----------------

    {
      "artist_id" : 954266,
      "artist_name" : "Green Day",
      "artist_view_url" : "http://itunes.apple.com/us/artist/green-day/id954266?uo=4",
      "artwork_url100" : "http://a1.phobos.apple.com/us/r1000/049/Features/1e/17/05/dj.rpihtiig.100x100-75.jpg",
      "artwork_url30" : "http://a1.phobos.apple.com/us/r1000/049/Features/1e/17/05/dj.rpihtiig.30x30-50.jpg",
      "artwork_url60" : "http://a1.phobos.apple.com/us/r1000/049/Features/1e/17/05/dj.rpihtiig.60x60-50.jpg",
      "collection_censored_name" : "Dookie",
      "collection_explicitness" : "explicit",
      "collection_id" : 5132583,
      "collection_name" : "Dookie",
      "collection_price" : 9.99,
      "collection_view_url" : "http://itunes.apple.com/us/album/she/id5132583?i=5132563&uo=4",
      "content_advisory_rating" : null,
      "country" : "USA",
      "currency" : "USD",
      "disc_count" : 1,
      "disc_number" : 1,
      "kind" : "song",
      "preview_url" : "http://a1.phobos.apple.com/us/r1000/027/Music/0e/86/7a/mzm.wchstext.aac.p.m4a",
      "primary_genre_name" : "Alternative",
      "release_date" : "2003-04-22 07:00:00 Etc/GMT",
      "track_censored_name" : "She",
      "track_count" : 15,
      "track_explicitness" : "notExplicit",
      "track_id" : 5132563,
      "track_name" : "She",
      "track_number" : 8,
      "track_price" : 1.29,
      "track_time_millis" : 134293,
      "track_view_url" : "http://itunes.apple.com/us/album/she/id5132583?i=5132563&uo=4",
      "wrapper_type" : "track"
    }

Available Methods
-----------------

   - movie
   - podcast
   - music
   - music_video
   - audiobook
   - short_film
   - tv_show
   - all

Using the iTunes gem
--------------------

    require 'itunes'

    >> itunes = ITunes::Client.new
    >> songs = itunes.music('green day she')
    => songs{"result_count" => 15, "results" => [...]}
    >> songs['results'].each do |song|
    >>   puts "#{song['trackName']} - #{song['artistName']} (#{song['collectionName']})"
    >> end
    => She - Green Day (Dookie)
    => She - Green Day (Dookie)
    => She - Green Day (Dookie)
    => She - Green Day (Dookie)
    => She - Green Day (Dookie)

Search directly from the class

    >> iron_man = ITunes.movie('iron man 2')
    => {"result_count" => 1, "results" => [...]}

Limit the results:

    >> foo_fighters = ITunes.music('foo fighters everlong', :limit => 1)
    => {"result_count" => 1, "results" => [{ "trackName" => "Everlong", ... }]}


Copyright
---------

Copyright © 2010 Garrett Bjerkhoel. See [MIT-LICENSE](http://github.com/dewski/itunes/blob/master/MIT-LICENSE) for details.