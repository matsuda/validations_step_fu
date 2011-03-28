module ActiveModel
  module ValidationsStepFu
    extend ActiveSupport::Concern

    module InstanceMethods
      private
      def validates_step_by(*attrs)
        attrs = attrs.map(&:to_sym)
        self.class.validators.each do |validator|
          if (validator.attributes & attrs).present?
            validator.validate(self)
          end
        end
      end
    end
  end
end

ActiveModel::Validations.send :include, ActiveModel::ValidationsStepFu
