module FactoryGirl

  # Raised when calling Factory.sequence from a dynamic attribute block
  class SequenceAbuseError < StandardError; end

  # Sequences are defined using Factory.sequence. Sequence values are generated
  # using next.
  class Sequence

    attr_reader :name

    def initialize(name, value = 1, &proc) #:nodoc:
      @name = name
      @proc  = proc
      @value = value || 1
    end

    # Returns the next value for this sequence
    def next
      @proc.call(@value)
    ensure
      @value = @value.next
    end

    # Sequences currently don't support aliases
    def aliases
      []
    end

  end

  class << self
    attr_writer :sequences
  end

  def self.sequences
    puts "WARNING: FactoryGirl.sequences is deprecated."
    puts "Use FactoryGirl.registry instead."
    @sequences
  end

  self.sequences = {}
end
