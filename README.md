# iTunes
A Ruby wrapper around the iTunes API that lets you search for any sort of data that is available on the iTunes store.

## Example Response

    {
      "artistId" : 954266,
      "artistName" : "Green Day",
      "artistViewUrl" : "http://itunes.apple.com/us/artist/green-day/id954266?uo=4",
      "artworkUrl100" : "http://a1.phobos.apple.com/us/r1000/049/Features/1e/17/05/dj.rpihtiig.100x100-75.jpg",
      "artworkUrl30" : "http://a1.phobos.apple.com/us/r1000/049/Features/1e/17/05/dj.rpihtiig.30x30-50.jpg",
      "artworkUrl60" : "http://a1.phobos.apple.com/us/r1000/049/Features/1e/17/05/dj.rpihtiig.60x60-50.jpg",
      "collectionCensoredName" : "Dookie",
      "collectionExplicitness" : "explicit",
      "collectionId" : 5132583,
      "collectionName" : "Dookie",
      "collectionPrice" : 9.99,
      "collectionViewUrl" : "http://itunes.apple.com/us/album/she/id5132583?i=5132563&uo=4",
      "contentAdvisoryRating" : null,
      "country" : "USA",
      "currency" : "USD",
      "discCount" : 1,
      "discNumber" : 1,
      "kind" : "song",
      "previewUrl" : "http://a1.phobos.apple.com/us/r1000/027/Music/0e/86/7a/mzm.wchstext.aac.p.m4a",
      "primaryGenreName" : "Alternative",
      "releaseDate" : "2003-04-22 07:00:00 Etc/GMT",
      "trackCensoredName" : "She",
      "trackCount" : 15,
      "trackExplicitness" : "notExplicit",
      "trackId" : 5132563,
      "trackName" : "She",
      "trackNumber" : 8,
      "trackPrice" : 1.29,
      "trackTimeMillis" : 134293,
      "trackViewUrl" : "http://itunes.apple.com/us/album/she/id5132583?i=5132563&uo=4",
      "wrapperType" : "track"
    }

## Available Methods
   - movie
   - podcast
   - music
   - music_video
   - audiobook
   - short_film
   - tv_show
   - all

## Using the iTunes gem

    require 'itunes'
    
    >> itunes = ITunes.new
    >> songs = itunes.music('green day she')
    => {"result_count" => 15, "results" => [...]}
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

## Upcoming Features

- A better DSL.

## Copyright
Copyright © 2010 Garrett Bjerkhoel. See [MIT-LICENSE](http://github.com/dewski/itunes/blob/master/MIT-LICENSE) for details.