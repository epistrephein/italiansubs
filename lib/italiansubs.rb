require 'faraday'
require 'faraday_middleware'
require 'json'

module ItalianSubs
  VERSION = '0.1.0'.freeze
  API_KEY = '6f53c6a55288ff82591c881eda98cd8f'.freeze
  API_BASEURL = 'https://api.italiansubs.net/api/rest'.freeze
  USER_AGENT = 'italiansubs-rubygem'.freeze

  class RequestError < StandardError; end
  class APIError < StandardError; end

  class API
    # list of shows
    def shows
      res = call(
        'shows',
        {}
      )
      res.body['Itasa_Rest2_Server_Shows']['direct']['shows'].values
    end

    # show details
    def show(show_id)
      res = call(
        "shows/#{show_id}",
        {}
      )
      res.body['Itasa_Rest2_Server_Shows']['single']['show']
    end

    # next episodes
    def next_episodes
      res = call(
        'shows/nextepisodes',
        {}
      )
      res.body['Itasa_Rest2_Server_Shows']['nextepisodes']['shows'].values
    end

    # show search
    def search_show(query, page = 1)
      res = call(
        'shows/search',
        'q' => query,
        'page' => page
      )

      count = res.body['Itasa_Rest2_Server_Shows']['search']['count'].to_i
      return [] if count.zero?

      res.body['Itasa_Rest2_Server_Shows']['search']['shows'].values
    end

    # show subs
    def subtitles(show_id, version, page = 1)
      res = call(
        'subtitles',
        'show_id' => show_id,
        'version' => version,
        'page' => page
      )
      res.body['Itasa_Rest2_Server_Subtitles']['direct']['subtitles'].values
    end

    # subs detail
    def subtitle(sub_id)
      res = call(
        "subtitles/#{sub_id}",
        {}
      )
      res.body['Itasa_Rest2_Server_Subtitles']['single']['subtitle']
    end

    # subs search
    def search_subtitle(query, show_id = nil, version = nil, page = 1)
      res = call(
        'subtitles/search',
        'q' => query,
        'show_id' => show_id,
        'version' => version,
        'page' => page
      )

      count = res.body['Itasa_Rest2_Server_Subtitles']['search']['count'].to_i
      return [] if count.zero?

      res.body['Itasa_Rest2_Server_Subtitles']['search']['subtitles'].values
    end

    private

    def call(url, params)
      res = request.get do |req|
        req.url url
        req.params.merge!(params)

        req.params['format'] = 'json'
        req.params['apikey'] = API_KEY
        req.headers['User-Agent'] = USER_AGENT
      end
      raise RequestError, res.reason_phrase unless res.success?
      unless res.body.keys.any? { |k| k =~ /^Itasa_Rest2_Server/ }
        raise APIError, res['root']['error']['message']
      end

      res
    end

    # setup faraday request
    def request
      Faraday.new(url: API_BASEURL) do |faraday|
        faraday.adapter  Faraday.default_adapter
        faraday.request  :url_encoded
        faraday.response :json
      end
    end
  end
end
