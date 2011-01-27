module FactoryGirl
  class Registry
    def initialize
      @items = {}
    end

    def add(item)
      add_as(item.name, item)
      item.aliases.each do |alias_name|
        add_as(alias_name, item)
      end
      item
    end

    def find(name)
      @items[name.to_sym]
    end

    def each(&block)
      @items.each(&block)
    end

    def [](name)
      find(name)
    end

    def registered?(name)
      @items.key?(name.to_sym)
    end

    private

    def add_as(name, item)
      if registered?(name)
        raise DuplicateDefinitionError, "Already defined: #{name}"
      else
        @items[name.to_sym] = item
      end
    end
  end

  def self.add(item)
    registry.add(item)
  end

  def self.registered?(name)
    registry.registered?(name)
  end

  def self.find(name)
    registry.find(name)
  end

  def self.registry
    @registry ||= Registry.new
  end

  def self.registry=(registry)
    @registry = registry
  end
end

