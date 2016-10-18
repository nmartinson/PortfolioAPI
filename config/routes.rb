Rails.application.routes.draw do
	namespace :api, defaults: { format: 'json' } do
		namespace :v1 do
			resources :galleries do
				resources :photos do
					resources :settings
				end
			end
			resources :gallery do
			end
			resource :galleries
			resource :photos
			resource :setting
			resource :gallery
		end
	end
end
