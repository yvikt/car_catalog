class TagsController < ApplicationController

  before_action :load_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.order(:tag_name)
  end

  def settings
    @tags = Tag.order(:tag_name)
  end

  def show
  end

  def edit
  end

  def update
    if params[:customize]
      @tag.customized = true
    else
      @tag.customized = false
    end
    if @tag.update tag_params
    flash[:success] = "<b>Successfully updated !</b> <br> #{params.inspect}"
    redirect_to @tag
    # render :text => 'done'
    else
      render :edit
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    unless params[:customize] # галочка customize при создании нового тега
      @tag.bg_color = nil
      @tag.font_color = nil
      @tag.border_color = nil
      @tag.customized = false
    else
      @tag.customized = true
    end

    if params[:tag][:tag_name] == 'new tag'
      flash[:success] = "<b>Wrong tag name !</b> <br> choose another tag name <br> #{params.inspect}"
      render :new
    else

      if @tag.save
        flash[:success] = "<b>Successfully created !</b> <br> #{params.inspect}"
        redirect_to @tag
        # render :index # как перенаправить на индекс???
      else
        render :new
      end
    end

  end

  def destroy
    if @tag.destroy
      flash[:success] = "<b>Successfully deleted !</b> <br> #{params.inspect}"
    end
    redirect_to tags_url
  end

  private

  def load_tag
    unless (@tag= Tag.find_by id: params[:id])
      # редирект 404 в случае отсутствия объекта
      render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
    end
  end

  def tag_params
    params.require(:tag).permit(:tag_name, :bg_color, :font_color, :border_color, :customize )
  end
end
