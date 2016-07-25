require 'faraday'

module SamsonDeployInfrachecker
  class DeployInfrachecker

    def check_build_status
      conn = infraspec_connection
      require 'pry'; binding.pry
      response = conn.get '/v2/organizations/redbubble/pipelines/infrastructure-spec/builds'

      response.each {|r| puts r}
      last_finished_build = response.detect{|r| r[:state] != 'runnning'}
      last_finished_build == 'passed'
    end

    private

    def infraspec_connection
      conn = Faraday.new("https://api.buildkite.com") do |c|
       c.use Faraday::Adapter::NetHttp
       c.use FaradayMiddleware::ParseJson,       content_type: 'application/json'
       c.use FaradayMiddleware::FollowRedirects, limit: 3
       c.use Faraday::Response::RaiseError
       c.headers['Authorization'] = "Bearer a78e781a75894c0915ac9ca9fcad42c08d91511c"
      end
      conn
    end

  end
end
