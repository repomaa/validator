class Athena::Validator::Constraints::GreaterThanOrEqual(ValueType) < Athena::Validator::Constraint
  include Athena::Validator::Constraints::AbstractComparison(ValueType)

  TOO_LOW_ERROR = "e09e52d0-b549-4ba1-8b4e-420aad76f0de"

  @@error_names = {
    TOO_LOW_ERROR => "TOO_LOW_ERROR",
  }

  def default_error_message : String
    "This value should be greater than or equal to {{ compared_value }}."
  end

  struct Validator < Athena::Validator::Constraints::ComparisonValidator
    def compare_values(actual : Number, expected : Number) : Bool
      actual >= expected
    end

    def compare_values(actual : String, expected : String) : Bool
      actual >= expected
    end

    def compare_values(actual : Time, expected : Time) : Bool
      actual >= expected
    end

    # :inherit:
    def compare_values(actual : _, expected : _) : NoReturn
      # TODO: Support checking if arbitrarily typed values are actually comparable once `#responds_to?` supports it.
      self.raise_invalid_type actual, "Number | String | Time"
    end

    # :inherit:
    def error_code : String
      TOO_LOW_ERROR
    end
  end
end