module SamsonDeployInfrachecker
  class Engine < ::Rails::Engine
    isolate_namespace SamsonDeployInfrachecker
  end
end

Samson::Hooks.view :project_form, "samson_deploy_infrachecker/fields"

Samson::Hooks.callback :project_permitted_params do
  [:check_infraspec_before_autodeploy, :buildkite_api_token]
end

Samson::Hooks.callback :release_deploy_conditions do |_, release|
  DeployInfrachecker.new.check_build_status(release.project)
end
