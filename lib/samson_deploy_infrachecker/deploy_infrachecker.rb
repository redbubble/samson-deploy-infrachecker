require 'jsonclient'

module SamsonDeployInfrachecker
  class DeployInfrachecker

    def check_build_status
      client = JSONClient.new
      url = 'https://api.buildkite.com/v2/organizations/redbubble/pipelines/infrastructure-spec/builds'
      header = { 'Authorization' => 'Bearer a78e781a75894c0915ac9ca9fcad42c08d91511c' }
      response = client.get(url, nil, header)

      require 'pry'; binding.pry
      response.each {|r| puts r}
      last_finished_build = response.body.detect{|r| r[:state] != 'runnning'}
      last_finished_build == 'passed'
    end

    private

  end
end
