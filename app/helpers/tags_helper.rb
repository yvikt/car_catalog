module TagsHelper

  # отрисовка одного тега
  def draw_tag(tag, path=vehicles_path) # path для отладки в консоли app.vehicles_path
    output = "<a href='#{path}?tag=#{tag.id}'><span class='tag'"
    output = "<a href='#{path}/#{tag.id}'><span class='tag'" if path = tags_path # костыль для tags/index.html.erb
    # кастомизация
    if tag.customized
      output += " style='"
      output += "background-color: #{tag.bg_color}; " if tag.bg_color
      output += "color: #{tag.font_color}; " if tag.font_color
      output += "border-color: #{tag.border_color || tag.bg_color}; " # такой же цвет, если не установлен особый
      output += "'"
    end
    output += ">#{tag.tag_name}</span></a>"
    output.html_safe
  end

  # вывод всех тегов
  def draw_tags(tags, path=vehicles_path)
    output = ''
    tags.each { |t| output += draw_tag t, path }
    output.html_safe
  end
  # для отладки в консоли   helper.draw_tags Tag.all, app.vehicles_path

end
