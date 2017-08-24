class AnswersController < ApplicationController
  before_action :set_poll, only: [:create]

  def new
    @answer = Answer.new
    @user = current_user
  end

  def create
    @answer = current_user.answers.new(answer_params)
    @answer.poll = @poll

    if @answer.save!
      respond_to do |format|
        format.html { redirect_to polls_path }
        format.js # render app/views/answers/create.js.erb
      end
    end
  end

  private

  def set_poll
    @poll = Poll.find(params[:poll_id])
  end

  def answer_params
    params.require(:answer).permit(:value)
  end
end
