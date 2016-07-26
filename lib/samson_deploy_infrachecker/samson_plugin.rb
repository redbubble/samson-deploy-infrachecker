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
  check_infraspec = project.check_infraspec_before_autodeploy
  auto_deploy = true
  if check_infraspec
    auto_deploy = SamsonDeployInfrachecker::DeployInfrachecker.new.check_build_status(project)
    InfracheckerFailedMailer.deliver_failed_email(release, stage) unless auto_deploy
  end
  auto_deploy
end
