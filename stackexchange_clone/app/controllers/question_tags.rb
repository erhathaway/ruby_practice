class TagsController < ApplicationController
	def new
		@question = Question.find(params[:question_id])
		@tag = Question.find(params[:tag_id])
		@question_tag = QuestionTag.new
	end

	def create
		@question = Question.find(params[:question_id])
		@tag = Question.find(params[:tag_id])
		@question_tag = QuestionTag.new(question_tag_params)
		@question_tag.save
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
	def question_tag_params
	    params.require(:question_tag).permit(:question_id, :tag_id)
	    # in the params, require that it has the :drink key, and the drink key needs these methods (title, description)
	end