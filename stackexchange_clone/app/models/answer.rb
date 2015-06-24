class Answer < ActiveRecord::Base
	belongs_to :question
	
	validates :answer, presence: true, length: { minimum: 50}
	validates :question_id, presence: true
end