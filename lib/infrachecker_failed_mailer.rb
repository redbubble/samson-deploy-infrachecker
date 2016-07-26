module InfracheckerFailedMailer
  def self.deliver_failed_email(release, stage)
    emails = release.changeset.commits.map(&:author_email).uniq
    Rails.logger.info "Sending auto deploy cancel email"
    ReleaseMailer.infrachecker_failed_email(release, stage, emails).deliver_now
    Rails.logger.info "AUTO-DEPLOY cancel email sent to to #{emails.join(',')}"
  end
end
