Rails.application.routes.draw do


  root 'static_pages#home'
  #  именованные маршруты для страниц Help, About и Contact
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  resources :vehicles do
    get   'edit-tags' => 'vehicles#edit_tags', as: 'edit_tags'
    patch 'update_tags' => 'vehicles#update_tags', as: 'update_tags'
    # put   'update_tags' => 'vehicles#update_tags', as: 'update-tags'
  end

  resources :tags

end
