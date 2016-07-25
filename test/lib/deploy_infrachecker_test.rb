require_relative '../test_helper'
require 'faraday'
require 'ostruct'

describe SamsonDeployInfrachecker::DeployInfrachecker do
  let(:infrachecker) { SamsonDeployInfrachecker::DeployInfrachecker.new }

  it 'is true when infrastructure spec last build is green' do
    infrachecker.stub(:infraspec_connection, infraspec_connection_build_passed_failed) do
      assert_equal true, infrachecker.check_build_status
    end
  end
end


private

def infraspec_connection_build_running_passed
  Faraday.new do |builder|

    builder.adapter :test do |stubs|
      stubs.get("/v2/organizations/redbubble/pipelines/infrastructure-spec/builds", [{state: "running" }, {state: "passed"}])
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
