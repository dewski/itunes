Tunes [![Build Status](https://secure.travis-ci.org/dewski/itunes.png)](http://travis-ci.org/dewski/itunes)
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

* movie
* podcast
* music
* music_video
* audiobook
* short_film
* tv_show
* ebook
* software
* all

Using the Tunes gem
--------------------

    require 'tunes'

    >> tunes = Tunes::Client.new
    >> songs = tunes.music('green day she')
    => <#Hashie::Rash result_count=15 results=[...]>
    >> songs.results.each do |song|
    >>   puts "#{song.track_name} - #{song.artist_name} (#{song.collection_name})"
    >> end
    => She - Green Day (Dookie)
    => She - Green Day (Dookie)
    => She - Green Day (Dookie)
    => She - Green Day (Dookie)
    => She - Green Day (Dookie)

Search directly from the class

    >> iron_man = Tunes.movie('iron man 2')
    => <#Hashie::Rash result_count=1 results=[...]>

Limit the results:

    >> foo_fighters = Tunes.music('foo fighters everlong', :limit => 1)
    => <#Hashie::Rash result_count=1 results=[<#Hashie::Rash ...>]>

What is Hashie::Rash?

If you are familiar with Hashie, Rash is very similar to a Mash.  The primary difference is that Rash gives us ruby-friendly keys so instead of artistId, Rash converts that to artist_id.

Copyright
---------

Copyright © 2011 Garrett Bjerkhoel, Steve Agalloco. See [MIT-LICENSE](http://github.com/dewski/itunes/blob/master/MIT-LICENSE) for details.