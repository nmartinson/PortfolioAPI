Rails.application.routes.draw do
	namespace :api, defaults: { format: 'json' } do
		namespace :v1 do
			resources :galleries do
				resources :photos do
				end
			end
			resources :gallery do
			end
			resources :galleries
			resources :photos, only: [:destroy, :put, :get]
			resources :settings, only: [:index, :show, :update] 
			resources :gallery
			resources :emails
			resources :features
			resources :mediums
			resources :gallery_photos
			match "/photos" => "photos#destroy", via: :delete
			match "/gallery" => "gallery#update", via: :put
			match "/photos" => "photos#update", via: :put
			match "/photos/:id" => "photos#show", via: :get
			match "/settings" => "settings#update", via: :put
			match "/settings/available_settings/:photo_id" => "settings#available_settings", via: :get
			match "/photo_settings/allExcept/:photo_id" => "photo_settings#show", via: :get
		end
	end
end
