class TopicMailer < ApplicationMailer
  # 一斉配信設定
  default bcc: -> { User.where(mail_permission: true).pluck(:email) },
          from: "yuuta66jp@gmail.com"

  def topic
    mail(subject: '新規トピックス配信のお知らせ')
  end
end
