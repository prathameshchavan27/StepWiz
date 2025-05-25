class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :step_completions
  has_many :completed_steps, through: :step_completions, source: :roadmap_step
  has_many :focus_sessions
end
