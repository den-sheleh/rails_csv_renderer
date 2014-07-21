require 'rails_csv_renderer/renderable'
require 'rails'

module RailsCsvRenderer
  class Railtie < Rails::Railtie
    initializer 'rails_csv_renderer' do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Renderers.add(:csv) do |obj, options|
          filename = options[:filename] || "#{ Rails.application.class.parent_name }-report-#{ Time.current }.csv"
          obj.extend RailsCsvRenderer::Renderable
          data = obj.to_custom_csv(options)
          send_data(data, type: Mime::CSV, disposition: "attachment; filename=#{filename}")
        end
      end
    end
  end
end
