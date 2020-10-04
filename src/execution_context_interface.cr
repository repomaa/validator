# Stores contextual data related to the current validation run.
#
# This includes the violations generated so far, the current constraint, value being validated, etc.
module Athena::Validator::ExecutionContextInterface
  # Adds a violation with the provided *message*, and optionally *parameters* based on the node currently being validated.
  abstract def add_violation(message : String, parameters : Hash(String, String) = {} of String => String) : Nil

  # Adds a violation with the provided *message* and *code*
  abstract def add_violation(message : String, code : String) : Nil

  # Adds a violation with the provided *message*, and *code*, *value* parameter.
  abstract def add_violation(message : String, code : String, value : _) : Nil

  # Returns an `AVD::Violation::ConstraintViolationBuilderInterface` with the provided *message*.
  #
  # Can be used to add additional information to the `AVD::Violation::ConstraintViolationInterface` being adding it to `self`.
  abstract def build_violation(message : String, parameters : Hash(String, String) = {} of String => String) : AVD::Violation::ConstraintViolationBuilderInterface

  # Returns an `AVD::Violation::ConstraintViolationBuilderInterface` with the provided *message*, and *code*.
  abstract def build_violation(message : String, code : String) : AVD::Violation::ConstraintViolationBuilderInterface

  # Returns an `AVD::Violation::ConstraintViolationBuilderInterface` with the provided *message*, and *code*, and *value*.
  #
  # The provided *value* is added to the violation's parameters as `"{{ value }}"`.
  abstract def build_violation(message : String, code : String, value : _) : AVD::Violation::ConstraintViolationBuilderInterface

  # Returns the class that is currently being validated.
  abstract def class_name

  # Returns the `AVD::Constraint` that is currently being validated.
  abstract def constraint : AVD::Constraint?

  # Returns the group that is currently being validated.
  abstract def group : String?

  # Returns the object initially passed to `#validate`.
  abstract def root

  # Returns an `AVD::Metadata::MetadataInterface` object for the value currently being validated.
  #
  # This would be an `AVD::Metadata::PropertyMetadataInterface` if the current value is an object,
  # an `AVD::Metadata::GenericMetadata` if the current value is a plain value, and an
  # `AVD::Metadata::ClassMetadataInterface` if the current value value is an entire class.
  abstract def metadata : AVD::Metadata::MetadataInterface?

  # Returns the object that is currently being validated.
  abstract def object

  # Returns the property name of the node currently being validated.
  abstract def property_name : String?

  # Returns the path to the property that is currently being validated.
  #
  # For example, given a `Person` object that has an `Address` property;
  # the property path would be empty initially.  When the `address` property
  # is being validated the *property_path* would be `address`.
  # When the street property of the related `Address` object is being validated
  # the *property_path* would be `address.street`.
  #
  # This also works for collections of objects.  If the `Person` object had multiple
  # addresses, the property path when validating the first street of the first address
  # would be `addresses[0].street`.
  abstract def property_path : String

  # Returns a reference to an `AVD::Validator::ValidatorInterface` that can be used to validate
  # additional constraints as part of another constraint.
  abstract def validator : AVD::Validator::ValidatorInterface

  # Returns the value that is currently being validated.
  abstract def value

  # Returns the `AVD::Violation::ConstraintViolationInterface` instances generated by the validator thus far.
  abstract def violations : AVD::Violation::ConstraintViolationListInterface

  # Internal

  # :nodoc:
  protected abstract def set_node(value : _, object : _, metadata : AVD::Metadata::MetadataInterface?, property_path : String) : Nil

  # :nodoc:
  protected abstract def group=(group : String)

  # :nodoc:
  protected abstract def constraint=(constraint : AVD::Constraint)
end