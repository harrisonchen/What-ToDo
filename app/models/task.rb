class Task < ActiveRecord::Base
	belongs_to :list
	default_scope -> { order('created_at DESC') }
	validates :list_id, presence: true
	validates :content, presence: true, length: { maximum: 50 }
end
