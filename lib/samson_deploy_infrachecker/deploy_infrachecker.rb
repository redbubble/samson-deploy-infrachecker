class SamsonDeployInfrachecker::DeployInfrachecker

  def check_build_status
    conn = Faraday.new("https://api.buildkite.com") do |c|
     c.use Faraday::Adapter::NetHttp
     c.use FaradayMiddleware::ParseJson,       content_type: 'application/json'
     c.use FaradayMiddleware::FollowRedirects, limit: 3
     c.use Faraday::Response::RaiseError
     c.headers['Authorization'] = "Bearer a78e781a75894c0915ac9ca9fcad42c08d91511c"
    end

    connection = infraspec_connection
  end

  private
  def infraspec_connection

  end
end
