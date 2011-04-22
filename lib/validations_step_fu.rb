module ValidationsStepFu

  module Definition
    extend ActiveSupport::Concern

    module InstanceMethods
      def define_step_validation(name, *attrs)
        define_method "valid_step_#{name}?" do
          self.errors.clear
          validates_step_by(*attrs)
          self.errors.empty?
        end
      end
    end
  end

  module Extension
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

ActiveModel::Validations.send :include, ValidationsStepFu::Extension
ActiveModel::Validations::ClassMethods.send :include, ValidationsStepFu::Definition
