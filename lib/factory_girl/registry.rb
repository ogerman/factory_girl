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
    end

    def find(name)
      @items[name.to_sym]
    end

    private

    def add_as(name, item)
      if @items.key?(name)
        raise DuplicateDefinitionError, "Already defined: #{name}"
      else
        @items[name] = item
      end
    end
  end
end
