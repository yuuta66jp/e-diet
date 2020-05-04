class TopicMailer < ApplicationMailer
  # 一斉配信設定
  default bcc: -> { User.where(mail_permission: true).pluck(:email) },
          from: "yuuta66jp@gmail.com"

  def topic(topic)
    @topic = topic
    # メール内でURLが必要な場合は*_urlヘルパーを使用
    @url = topic_url(@topic.id)
    mail(subject: '【e-diet】新規トピックス配信のお知らせ')
  end
end
