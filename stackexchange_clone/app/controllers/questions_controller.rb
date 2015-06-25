class QuestionsController < ApplicationController
	# helper markdown
	def index
		@questions = Question.all.order(created_at: :desc)
	end

	def show
		@question = Question.where(id: params[:id])[0]
		views = @question.views +=1
		@question.update(views: views)
		@time = format_time(@question.created_at)
		@answers = @question.answers.order(created_at: :desc)
	end

	def new
		@question = Question.new
		@tag = Tag.new
	end

	def create
		@question = Question.new(question_params)
		tags = params[:question][:tag].values[0].split(" ")


		if @question.save
			# binding.pry
			tags.each do |tag|
				new_tag = Tag.find_or_create_by(tag: tag)
				QuestionTag.find_or_create_by(question_id: @question.id, tag_id: new_tag.id)
			end
			flash[:notice] = 'Question added.'
			redirect_to '/questions'
		else
			flash[:notice] = @question.errors.full_messages
			render :new
		end
	end

	def edit
		@question = Question.find(params[:id])
		tags = @question.tags
		# binding.pry
		@tags = ""
		tags.each do |tag|
			@tags += tag.tag + " "
		end

	end

	def update
		question = Question.find(params[:id])
		# binding.pry
		tags = params[:question][:tag].split(" ")
		QuestionTag.where(question_id: question.id).destroy_all
		tags.each do |tag|
			new_tag = Tag.find_or_create_by(tag: tag)
			QuestionTag.find_or_create_by(question_id: question.id, tag_id: new_tag.id)
		end
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