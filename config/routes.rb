Rails.application.routes.draw do

  resources :vehicles do
    get   'edit-tags' => 'vehicles#edit_tags', as: 'edit_tags'
    patch 'update_tags' => 'vehicles#update_tags', as: 'update_tags'
    # put   'update_tags' => 'vehicles#update_tags', as: 'update-tags'
  end

  resources :tags

end
