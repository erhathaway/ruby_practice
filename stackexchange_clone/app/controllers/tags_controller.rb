class TagsController < ApplicationController
	def create
		@question = Question.find(params[:question_id])
		@tag = Tag.new(tag_params)
		# @answer.question = @question
		# if @answer.save
		# 	flash[:notice] = 'Answer added.'
		# 	redirect_to '/questions/'+@question.id.to_s
		# elsif answer_params['answer'].length < 50
		# 	flash[:notice] = 'Please make the question title longer than 50 characters'
		# 	render :new
		# else
		# 	flash[:notice] = 'You did something wrong'
		# 	render :new
		# end
	end

	protected
	def tag_params
	    params.require(:tag).permit(:tag)
	    # in the params, require that it has the :drink key, and the drink key needs these methods (title, description)
	end
end