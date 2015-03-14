# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validates :subs, presence: true, length: { minimum: 1 }

  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs
  belongs_to :author, class_name: :User


  # def set_up_post_subs
  #   @subs.each do |sub|
  #     PostSub.create!(sub_id: sub.id, post_id: @post.id)
  #   end
  # end
end
