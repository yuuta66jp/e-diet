class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # enum機能の定義
  enum gender:        { other: 0, man: 1, woman: 2 }
  enum public_status: { public: 0, private: 1 }
  enum rank_status:   { green: 0, silver: 1, gold: 2 }

end
