Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Viralbitminer::Application.twitter[:key], Viralbitminer::Application.twitter[:secret],
           {
               :secure_image_url => 'true',
               :image_size => 'original',
               :authorize_params => {
                   :lang => 'en'
               }
           }
end