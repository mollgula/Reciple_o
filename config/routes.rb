Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'reciple/search_recipe', to: 'reciple#search_recipe'
  get 'reciple/recipe_search2', to: 'reciple#recipe_search2'
  get 'reciple/food_join', to: 'reciple#food_join'
  get 'reciple/join_search', to: 'reciple#join_search'
  post 'reciple/food_join', to: 'reciple#food_join'
  post 'reciple/recipe_search2', to: 'reciple#recipe_search2'
end
