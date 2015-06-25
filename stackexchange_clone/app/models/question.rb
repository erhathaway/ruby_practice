class Question < ActiveRecord::Base
	has_many :answers
	has_many :question_tags
	has_many :tags, through: :question_tags
	
	validates :title, presence: true, length: { minimum: 40} 
	validates :question, presence: true, length: { minimum: 150}
end


