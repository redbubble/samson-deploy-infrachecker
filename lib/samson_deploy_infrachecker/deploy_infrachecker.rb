require 'jsonclient'

module SamsonDeployInfrachecker
  class DeployInfrachecker

    def check_build_status
      client = JSONClient.new
      url = 'https://api.buildkite.com/v2/organizations/redbubble/pipelines/infrastructure-spec/builds'
      header = { 'Authorization' => 'Bearer a78e781a75894c0915ac9ca9fcad42c08d91511c' }
      response = client.get(url, nil, header)
      body = response.body

      last_finished_build = body.detect{|r| r[:state] != 'running'}
      last_finished_build[:state] == 'passed'
    end
  end
end
