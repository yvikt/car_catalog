class VehiclesController < ApplicationController

  before_action :load_vehicle, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.order(:tag_name) # для draw_tag

    # если в строке запроса ?tag=1 ищем машины с таким тегом
    if (tag = params[:tag])
      @tag = tag
      vehicles_count = Tag.find(tag).vehicles.count
      vehicles_on_page = 9
      pages_count = vehicles_count / vehicles_on_page
      pages_count += 1 if vehicles_count % vehicles_on_page
      @pages_count = pages_count
      current_page = params[:page].to_i
      current_page = 1 if current_page == 0
      @current_page = current_page
      @vehicles = Tag.find(tag).vehicles.offset((current_page-1)*vehicles_on_page).limit(vehicles_on_page)
    else
      vehicles_count = Vehicle.count
      vehicles_on_page = 9
      pages_count = vehicles_count / vehicles_on_page
      pages_count += 1 if vehicles_count % vehicles_on_page
      @pages_count = pages_count
      current_page = params[:page].to_i
      current_page = 1 if current_page == 0
      @current_page = current_page
      @vehicles = Vehicle.offset((current_page-1)*vehicles_on_page).limit(vehicles_on_page)
    end

  end

  def show
  end

  def edit
    @tags = Tag.order(:tag_name)
  end

  def update
    if @vehicle.update vehicle_params
      # debugger
      # new_tag = Tag.find( params['vehicle']['tags'])
      # @vehicle.tags << new_tag
      # debugger
      flash[:success] = "<b>Successfully updated !</b> <br> #{params.inspect}"
      redirect_to @vehicle
      # render :text => 'done'
    else
      render :edit
    end
  end

  def destroy
  end

  def edit_tags
    # страница для добавления удаления тегов
    # debugger
    @vehicle= Vehicle.find_by id: params[:vehicle_id]
    @tags = Tag.order(:tag_name)
  end

  def update_tags
    # метод который производит изменение списка тегов для машины
    # debugger
    # массивы id-шников для добавлени, изменения, удаления. Если не пришло, то инициализирем пустым массивом
    params['update_tags'].nil? ? tags_to_update = [] : tags_to_update = params['update_tags'].map! {|t| t.to_i}
    # это было раньше (старая версия)
    params['add_tags'].nil? ? tags_to_add = [] : tags_to_add = params['add_tags'].map! {|t| t.to_i}
    params['dell_tags'].nil? ? tags_to_dell = [] : tags_to_dell = params['dell_tags'].map! {|t| t.to_i}

    @vehicle= Vehicle.find_by id: params[:vehicle_id]
    vehicle_tag_ids = @vehicle.tags.map {|t| t.id} # достать все id привязаных тегов и положить в массив
    # debugger

    unless tags_to_update.empty? # если нам прислали id-шники для обновления
      # перебераем все, и если еще такие привязаны - удаляем, не привязаны - добавляем,
      all_tags = Tag.all.map { |t| t.id }
      vehicle_tags = @vehicle.tags.map { |t| t.id }
      # debugger
      # наполняем массывы тегов для удаления и добавлени
      tags_to_update.each { |tag| tags_to_add << tag unless vehicle_tags.include? tag }
      vehicle_tags.each { |tag| tags_to_dell << tag unless tags_to_update.include? tag }
      # debugger
      # нижеследующие блоки проделают дяльнейную работу
    end
    # debugger
    # старая версия
    unless tags_to_add.empty? # если нам прислали id-шники для добавления
      # перебераем все, и если еще такие не привязаны - добавляем
      tags_to_add.each { |t| (@vehicle.tags << Tag.find(t)) unless vehicle_tag_ids.include? t }
    end
    # debugger
    # старая версия
    unless tags_to_dell.empty?  # если нам прислали id-шники для удаленя
      # удаляем те которые есть
      tags_to_dell.each { |t| @vehicle.tags.delete Tag.find(t) if vehicle_tag_ids.include? t }
    end

    redirect_to @vehicle
    # render :text => 'ok'
  end


  private

  def load_vehicle
    unless (@vehicle= Vehicle.find_by id: params[:id])
      # редирект 404 в случае отсутствия объекта
      render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
    end
  end

  def vehicle_params
    params.require(:vehicle).permit(:model, :year, :description )
  end
end
