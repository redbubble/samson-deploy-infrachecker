require_relative '../test_helper'

require 'ostruct'

describe SamsonDeployInfrachecker::DeployInfrachecker do
  let(:infrachecker) { DeployInfrachecker.new }

  it 'is true when infrastructure spec last build is green' do
    infrachecker.stubs(:infraspec_connection).returns(infraspec_connection_build_passed)

    assert_equal true, infrachecker.check_build_status
  end
end


private

def infraspec_connection_build_running
  Faraday.new do |builder|
    builder.response :json

    builder.adapter :test do |stubs|
      stubs.get("/v2/organizations/redbubble/pipelines/infrastructure-spec/builds", [{state: "running" }, {stage: "passed"}])
    end
  end
end

def infraspec_connection_build_passed
  Faraday.new do |builder|
    builder.response :json

    builder.adapter :test do |stubs|
      stubs.get("/v2/organizations/redbubble/pipelines/infrastructure-spec/builds", [{state: "passed" }, {stage: "failed"}])
    end
  end
end


def infraspec_connection_build_failed
  Faraday.new do |builder|
    builder.response :json

    builder.adapter :test do |stubs|
      stubs.get("/v2/organizations/redbubble/pipelines/infrastructure-spec/builds", [{state: "failed" }, {stage: "passed"}])
    end
  end
end
