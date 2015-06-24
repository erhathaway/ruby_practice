class QuestionsController < ApplicationController
	# helper markdown
	def index
		@questions = Question.all.order(created_at: :desc)
	end

	def show
		@question = Question.where(id: params[:id])[0]
		@time = format_time(@question.created_at)
		@answers = @question.answers.order(created_at: :desc)
	end

	def new
		@question = Question.new
	end

	def create
		@question = Question.new(question_params)
		if @question.save
			flash[:notice] = 'Question added.'
			redirect_to '/questions'
		elsif question_params['title'].length < 40
			flash[:notice] = 'Please make the question title longer than 40 characters'
			render :new
		elsif question_params['question'].length < 150
			flash[:notice] = 'Please make the question contents longer than 150 characters'
			render :new
		else
			flash[:notice] = 'You did something wrong'
			render :new
		end
	end

	def edit
		@question = Question.find(params[:id])
	end

	def update
		question = Question.find(params[:id])
		# binding.pry
		question.update(question_params)
		redirect_to '/questions/'+question.id.to_s
	end


	def destroy
		@question = Question.find(params[:id])
		@question.answers.each do |answer|
			answer.destroy
		end
		# binding.pry
		@question.destroy

		redirect_to '/'
	end

	def format_time(time)
		time.strftime("Asked on %dth of %B at %I:%M%p")
	end

	  protected
	  def question_params
	    params.require(:question).permit(:title, :question)
	    # in the params, require that it has the :drink key, and the drink key needs these methods (title, description)
	  end
end