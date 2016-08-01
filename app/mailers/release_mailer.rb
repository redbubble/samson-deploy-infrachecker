class ReleaseMailer < ApplicationMailer
  add_template_helper(DeploysHelper)
  add_template_helper(ApplicationHelper)

  def infrachecker_failed_email(release, stage, emails)
    prepare_mail(release, stage)

    mail(
      to: emails,
      subject: "[NO-AUTO-DEPLOY] Your code change to #{@release.project.name} is not deployed to #{@stage.name} because infrastructure-spec is broken.",
      template_name: "infrachecker_failed_email"
    )
  end


  private

  def prepare_mail(release, stage)
    @release = release
    @stage = stage
    @project = @release.project
    @changeset = @release.changeset
  end
end
