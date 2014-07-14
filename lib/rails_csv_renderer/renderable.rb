require 'active_record'
require 'csv'

module RailsCsvRenderer
  module Renderable
    # Converts an collection of active records to CSV formatted string
    # Options is configuration set for generated CSV file

    def to_custom_csv(options = {})
      csv_options = default_csv_options.merge(options[:csv_options] || {})

      if is_active_record?
        if !(model.respond_to?(:csv_header) || model.method_defined?(:csv_row)) || model.class_variable_defined?(:@@dynamic_generated_csv_methods)
          define_csv_methods(options)
        end
      end

      CSV.generate(csv_options) do |csv|
        if is_active_record?
          csv << model.csv_header
          self.each do |obj|
            csv << obj.csv_row
          end
        else
          csv << self if respond_to?(:to_csv)
        end
      end
    end

    private

    def define_csv_methods(options)
      columns = options[:columns] || model.column_names

      model.class_variable_set(:@@dynamic_generated_csv_methods, true)
      model.class_eval(%Q/
        class << self
          def csv_header
            ["#{ columns.map { |column_name| model.human_attribute_name(column_name) }.join('", "') }"]
          end
        end
      /)
      model.class_eval(%Q/
        def csv_row
         [#{ columns.join(', ') }]
       end
      /)
    end

    def is_active_record?
      is_a?(ActiveRecord::Relation) ||
      (present? && first.is_a?(ActiveRecord::Base)) ||
      try(:decorator_class).respond_to?(:column_names)
    end

    def model
      if is_active_record?
        is_ar_array = ->(obj) { obj.present? && obj.first.is_a?(ActiveRecord::Base)}
        is_drapper_collection = ->(obj) { try(:decorator_class) }

        @model ||=
          case self
          when ActiveRecord::Relation
            klass
          when is_ar_array
            first.class
          when is_drapper_collection
            decorator_class
          end
      end
    end

    def default_csv_options
      { encoding: 'utf-8' }
    end
  end
end
