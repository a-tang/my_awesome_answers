class QuestionsController < ApplicationController

  def destroy
    puts
  end

  def edit
  end

  def show
    puts "#{params.inspect}"
    puts "questions#show id = #{params[:id]}";
    render text: "questions#show id = #{params[:id]}";
  end

  def create
  end

end
