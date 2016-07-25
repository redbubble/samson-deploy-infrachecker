require_relative '../test_helper'
require 'ostruct'
require 'mocha'
require 'minitest/unit'
require 'mocha/mini_test'

describe SamsonDeployInfrachecker::DeployInfrachecker do
  let(:infrachecker) { SamsonDeployInfrachecker::DeployInfrachecker.new }

  before do
    response = mock()
    response.expects(:body).returns([{state: "running" }, {state: "passed"}])
    JSONClient.any_instance.stubs(:get).with('https://api.buildkite.com/v2/organizations/redbubble/pipelines/infrastructure-spec/builds', nil, { 'Authorization' => 'Bearer a78e781a75894c0915ac9ca9fcad42c08d91511c' }).returns(response)
  end

  it 'is true when infrastructure spec last build is green' do
    assert_equal true, infrachecker.check_build_status
  end
end

private

def infraspec_connection_build_running_passed
  Faraday.new do |builder|

    builder.adapter :test do |stubs|
      stubs.get("/v2/organizations/redbubble/pipelines/infrastructure-spec/builds", { "@body" => [{state: "running" }, {state: "passed"}]})
    end
  end
end

def infraspec_connection_build_passed_failed
  Faraday.new do |builder|

    builder.adapter :test do |stubs|
      stubs.get("/v2/organizations/redbubble/pipelines/infrastructure-spec/builds", [{state: "passed" }, {state: "failed"}])
    end
  end
end


def infraspec_connection_build_all_failed
  Faraday.new do |builder|

    builder.adapter :test do |stubs|
      stubs.get("/v2/organizations/redbubble/pipelines/infrastructure-spec/builds", [{state: "failed" }, {state: "failed"}])
    end
  end
end

def infraspec_connection_build_running_failed
  Faraday.new do |builder|

    builder.adapter :test do |stubs|
      stubs.get("/v2/organizations/redbubble/pipelines/infrastructure-spec/builds", [{state: "running" }, {state: "failed"}])
    end
  end
end


def infraspec_connection_build_failed_passed
  Faraday.new do |builder|

    builder.adapter :test do |stubs|
      stubs.get("/v2/organizations/redbubble/pipelines/infrastructure-spec/builds", [{state: "failed" }, {state: "passed"}])
    end
  end
end
