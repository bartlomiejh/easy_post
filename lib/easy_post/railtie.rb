module EasyPost
  class Railtie < Rails::Railtie
    initializer 'easy_post.view_helpers' do
      ActiveSupport.on_load(:action_view) { include EasyPost::ViewHelpers }
    end
  end
end
