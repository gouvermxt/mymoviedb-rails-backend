# Top level mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@mmdb.me'
  layout 'mailer'
end
