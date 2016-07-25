require_relative '../test_helper'
require 'ostruct'
require 'mocha'
require 'minitest/unit'
require 'mocha/mini_test'

describe SamsonDeployInfrachecker::DeployInfrachecker do
  let(:infrachecker) { SamsonDeployInfrachecker::DeployInfrachecker.new }
  let(:response_body) { [] }
  let(:project) { mock()}
  let(:response) { mock() }

  before do
    response.expects(:body).returns(response_body)
    project.expects(:buildkite_api_token).returns('abc')

    JSONClient.any_instance.stubs(:get).with('https://api.buildkite.com/v2/organizations/redbubble/pipelines/infrastructure-spec/builds', nil, { 'Authorization' => 'Bearer abc' }).returns(response)
  end

  describe 'when current build is running and last build is passed' do
    let(:response_body) { [{state: "running" }, {state: "passed"}] }

    it 'is true' do
      assert_equal true, infrachecker.check_build_status(project)
    end
  end

  describe 'when current build is passed and last build is failed' do
    let(:response_body) { [{state: "passed" }, {state: "failed"}] }

    it 'is true' do
      assert_equal true, infrachecker.check_build_status(project)
    end
  end

  describe 'when current build is passed and last build is passed' do
    let(:response_body) { [{state: "passed" }, {state: "passed"}] }

    it 'is true' do
      assert_equal true, infrachecker.check_build_status(project)
    end
  end

  describe 'when current build is running and last build is failed' do
    let(:response_body) { [{state: "running" }, {state: "failed"}] }

    it 'is false' do
      assert_equal false, infrachecker.check_build_status(project)
    end
  end

  describe 'when current build is failed and last build is passed' do
    let(:response_body) { [{state: "failed" }, {state: "passed"}] }

    it 'is false' do
      assert_equal false, infrachecker.check_build_status(project)
    end
  end

  describe 'when current build is failed and last build is failed' do
    let(:response_body) { [{state: "faild" }, {state: "failed"}] }

    it 'is false' do
      assert_equal false, infrachecker.check_build_status(project)
    end
  end

end
