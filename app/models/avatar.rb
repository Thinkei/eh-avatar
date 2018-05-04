class Avatar < Sequel::Model
  STATUSES = [
    STATUS_PENDING = 'pending'.freeze,
    STATUS_ERROR = 'error'.freeze,
    STATUS_READY = 'ready'.freeze
  ].freeze

  COLORS = [
    'pink'.freeze,
    'darkred'.freeze,
    'indigo'.freeze,
    'blue'.freeze,
    'red'.freeze,
    'green'.freeze,
    'springgreen'.freeze,
    'orange'.freeze,
    'black'.freeze
  ].freeze

  def ready?
    status == STATUS_READY
  end

  def validate
    super
    errors.add(:name, "can't be empty") if name.empty?
    errors.add(:status, "can't be empty") if status.empty?
    errors.add(:status, 'is invalid') unless STATUSES.include?(status)
  end
end
