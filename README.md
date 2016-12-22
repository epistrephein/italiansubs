# italiansubs
[![Gem Version](https://badge.fury.io/rb/italiansubs.svg)](https://badge.fury.io/rb/italiansubs) [![Code Climate](https://codeclimate.com/github/epistrephein/italiansubs/badges/gpa.svg)](https://codeclimate.com/github/epistrephein/italiansubs) [![Dependency Status](https://gemnasium.com/badges/github.com/epistrephein/italiansubs.svg)](https://gemnasium.com/github.com/epistrephein/italiansubs)

A ruby wrapper for Italian Subs API.

## Installation

```
gem install italiansubs
```

## Usage

This gem wraps some of the API methods available from Italian Subs.

First, require the gem and initialize a new `ItalianSubs::API` object.

```ruby
require 'italiansubs'
itasa = ItalianSubs::API.new
```

#### Shows

List all shows

```ruby
itasa.shows
# => [{"id"=>"2132", "name"=>"$#*! My Dad Says", "fans"=>"1097", "started"=>"2010-09-23", "ended"=>"2011-02-17"},
#     {"id"=>"1363", "name"=>"10 Things I Hate About You", "fans"=>"1289", "started"=>"2009-07-07", "ended"=>"2010-05-24"},
# ...
```

View details of a show. Pass `show_id` as parameter.

```ruby
itasa.show(2291)
# => {"id"=>"2291",
#     "name"=>"Game of Thrones",
#     "name_tvdb"=>"Game of Thrones",
# ...
```

Search a show. Pass `query` as parameter, with optional `page` in case there are too many results.

```ruby
itasa.search_show('game')
# => [{"id"=>"2291", "name"=>"Game of Thrones"},
#     {"id"=>"4852", "name"=>"Mind Games"},
# ...
```

List upcoming episodes.

```ruby
itasa.next_episodes
# => [{"nextep_title"=>"Episode 4",
#      "nextep_num"=>"2x04",
# ...
```

#### Subtitles

List subtitles for a show. Pass `show_id` as parameter, with optional `version` and `page`.

```ruby
itasa.subtitles(2291, '720p')
# => [{"id"=>"69168", "name"=>"Game of Thrones 6x10", "version"=>"720p"},
#     {"id"=>"69005", "name"=>"Game of Thrones 6x09", "version"=>"720p"},
# ...
```

View details of single subtitle. Pass `sub_id` as parameter.

```ruby
itasa.subtitle(69005)
# => {"id"=>"69005",
#     "name"=>"Game of Thrones 6x09",
#     "version"=>"720p",
# ...
```

Search a subtitle. Pass `query` as parameter, with optional `show_id`, `version` and `page`.

```ruby
itasa.search_subtitle('6x10')
# => {"id"=>"72278", "name"=>"New Girl 6x10", "version"=>"720p", "show_id"=>"2876", "show_name"=>"New Girl"},
#    {"id"=>"72277", "name"=>"New Girl 6x10", "version"=>"Normale", "show_id"=>"2876", "show_name"=>"New Girl"},
#    {"id"=>"72237", "name"=>"Once Upon A Time 6x10", "version"=>"WEB-DL", "show_id"=>"3042", "show_name"=>"Once Upon A Time"},
# ...

itasa.search_subtitles('6x10', nil, 'WEB-DL', 2)
# => [{"id"=>"43970", "name"=>"True Blood 6x10", "version"=>"WEB-DL", "show_id"=>"988", "show_name"=>"True Blood"},
#     {"id"=>"42301", "name"=>"Mad Men 6x10", "version"=>"WEB-DL", "show_id"=>"442", "show_name"=>"Mad Men"},
# ...

itasa.search_subtitle('6x10', 2291, '720p')
# => [{"id"=>"69168", "name"=>"Game of Thrones 6x10", "version"=>"720p", "show_id"=>"2291", "show_name"=>"Game of Thrones"}]
```

#### User

Login to Italian Subs with your username and password. This will store a string as `@authcode` and passed along the various methods that requires login.

```ruby
itasa.login('myUsername', 'myPassword')
# => "aaaabbbbccccdddd1111222233334444"

itasa.authcode
# => "aaaabbbbccccdddd1111222233334444"
```

Since authcode doesn't renew and is tied to user, you it can be pass at initialization time if needed.

```ruby
itasa = ItalianSubs::API.new('myUsername', 'myPassword')
# => #<ItalianSubs::API:0x007ff274712e78 @authcode="aaaabbbbccccdddd1111222233334444">
```

Show user info. `@authcode` must be set.

```ruby
itasa.user_profile
# => {"id"=>"000000",
#     "name"=>"myName",
#     "username"=>"myUsername",
# ...
```

#### MyItasa
All `myitasa` methods require `@authcode` to be set.

List all myItasa shows.

```ruby
itasa.myitasa_shows
# => [{"id"=>"3149", "name"=>"Black Mirror", "versions"=>{"key_0"=>"720p"}},
#     {"id"=>"4838", "name"=>"Carnivale", "versions"=>{"key_0"=>"WEB-DL"}},
# ...
```

Show myItasa last added subtitles, with optional `page`.

```ruby
itasa.myitasa_last_subtitles
# => [{"id"=>"72398",
#      "name"=>"Humans 2x03",
#      "version"=>"720p",
# ...
```

Add show to myItasa. `show_id` and `version` are required parameters. Returns all myItasa shows.

```ruby
itasa.myitasa_add_show(2132, '720p')
# => [{"id"=>"2132", "name"=>"$#*! My Dad Says", "versions"=>{"key_0"=>"720p"}},
#     {"id"=>"3149", "name"=>"Black Mirror", "versions"=>{"key_0"=>"720p"}},
# ...
```

Remove show from myItasa. `show_id` and `version` are required parameters. Returns all myItasa shows.

```ruby
itasa.myitasa_remove_show(2132, '720p')
# => [{"id"=>"3149", "name"=>"Black Mirror", "versions"=>{"key_0"=>"720p"}},
#     {"id"=>"4838", "name"=>"Carnivale", "versions"=>{"key_0"=>"WEB-DL"}},
# ...
```

#### Parameters

Valid `version` values are: `normale`, `1080i`, `1080p`, `720p`, `bdrip`, `bluray`, `dvdrip`, `hdtv`, `hr`, `web-dl`.

## Contributing

Contributions are welcome and encouraged. Feel free to open an issue or submit a pull request.

## License
[MIT License](https://github.com/epistrephein/italiansubs/blob/master/LICENSE)
