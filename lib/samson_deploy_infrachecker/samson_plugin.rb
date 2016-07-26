require_relative '../infrachecker_failed_mailer'
module SamsonDeployInfrachecker
  class Engine < ::Rails::Engine
  end
end

Samson::Hooks.view :project_form, "samson_deploy_infrachecker/fields"

Samson::Hooks.callback :project_permitted_params do
  [:check_infraspec_before_autodeploy, :buildkite_api_token]
end

Samson::Hooks.callback :release_deploy_conditions do |stage, release|
  project = release.project
  return true if !project.check_infraspec_before_autodeploy

  infrastructue_build_status = SamsonDeployInfrachecker::DeployInfrachecker.new.check_build_status(project)
  InfracheckerFailedMailer.deliver_failed_email(release, stage) unless infrastructue_build_status
  infrastructue_build_status
end
