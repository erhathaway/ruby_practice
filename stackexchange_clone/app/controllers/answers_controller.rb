class AnswersController < ApplicationController
	def index
		@question = Question.find(params[:question_id])
		@answers = @question.answers
	end

	def new
		@question = Question.find(params[:question_id])
		@answer = Answer.new
	end

	def create
		@question = Question.find(params[:question_id])
		@answer = Answer.new(answer_params)
		@answer.question = @question
		if @answer.save
			flash[:notice] = 'Answer added.'
			redirect_to '/questions/'+@question.id.to_s
		elsif answer_params['answer'].length < 50
			flash[:notice] = 'Please make the question title longer than 50 characters'
			render :new
		else
			flash[:notice] = 'You did something wrong'
			render :new
		end
	end

	def edit
		# @question = Question.find(params[:question_id])
		@answer = Answer.find(params[:id])
	end

	def update
		# binding.pry
		answer = Answer.find(params[:id])
		# binding.pry
		answer.update(answer_params)
		redirect_to '/questions/'+answer.question_id.to_s
	end

	def destroy
		@answer = Answer.find(params[:id])
		question_id = @answer.question_id
		@answer.destroy

		redirect_to '/questions/'+question_id.to_s
	end


	def format_time(time)
		time.strftime("Asked on %dth of %B at %I:%M%p")
	end

	  protected
	  def answer_params
	    params.require(:answer).permit(:answer)
	    # in the params, require that it has the :drink key, and the drink key needs these methods (title, description)
	  end
end