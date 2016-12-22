# italiansubs
[![Gem Version](https://badge.fury.io/rb/italiansubs.svg)](https://badge.fury.io/rb/italiansubs) [![Code Climate](https://codeclimate.com/github/epistrephein/italiansubs/badges/gpa.svg)](https://codeclimate.com/github/epistrephein/italiansubs) [![Dependency Status](https://gemnasium.com/badges/github.com/epistrephein/italiansubs.svg)](https://gemnasium.com/github.com/epistrephein/italiansubs)

A ruby wrapper for Italian Subs API.

## Installation

```
gem install italiansubs
```

## Usage

This gem wraps some of the API methods available from Italian Subs. The aim is to cover all of them, so stay tuned and check the CHANGELOG.

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

Valid `version` values are: `normale`, `1080i`, `1080p`, `720p`, `bdrip`, `bluray`, `dvdrip`, `hdtv`, `hr`, `web-dl`.

## TODOs

- [ ] add `News` methods
- [ ] add `Users` methods
- [ ] add `MyItasa` methods


## Contributing

Contributions are welcome and encouraged. Feel free to open an issue or submit a pull request.

## License
[MIT License](https://github.com/epistrephein/italiansubs/blob/master/LICENSE)
