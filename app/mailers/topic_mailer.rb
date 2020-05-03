class TopicMailer < ApplicationMailer
  # 一斉配信設定
  default to: -> { User.pluck(:email) },
          from: "from@example.com"

  def topic
    mail(subject: '新規トピックス配信のお知らせ')
  end
end
