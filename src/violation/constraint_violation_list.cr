require "./constraint_violation_list_interface"

struct Athena::Validator::Violation::ConstraintViolationList
  include Athena::Validator::Violation::ConstraintViolationListInterface
  include Indexable(Athena::Validator::Violation::ConstraintViolationInterface)

  @violations : Array(AVD::Violation::ConstraintViolationInterface) = [] of AVD::Violation::ConstraintViolationInterface

  def initialize(violations : Array(AVD::Violation::ConstraintViolationInterface) = [] of AVD::Violation::ConstraintViolationInterface)
    violations.each do |violation|
      add violation
    end
  end

  def find_by_code(error_code : String) : AVD::Violation::ConstraintViolationListInterface
    self.class.new @violations.select &.code.==(error_code)
  end

  def add(violation : AVD::Violation::ConstraintViolationInterface) : Nil
    @violations << violation
  end

  def add(violations : AVD::Violation::ConstraintViolationListInterface) : Nil
    @violations.concat violations
  end

  def has?(index : Int) : Bool
    !@violations[index]?.nil?
  end

  def set(index : Int, violation : AVD::Violation::ConstraintViolationInterface) : Nil
    @violations[index] = violation
  end

  def remove(index : Int) : Nil
    @violations.delete_at index
  end

  def size : Int
    @violations.size
  end

  @[AlwaysInline]
  def unsafe_fetch(index : Int) : AVD::Violation::ConstraintViolationInterface
    @violations[index]
  end

  def to_s(io : IO) : Nil
    @violations.each do |violation|
      violation.to_s io
    end
  end

  def to_json(builder : JSON::Builder) : Nil
    builder.array do
      @violations.each do |violation|
        violation.to_json builder
      end
    end
  end
end