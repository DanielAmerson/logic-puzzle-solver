class AttributeRepository
    def initialize()
        @repository = Hash.new()
    end

    def add(name, value)
        if @repository[name].nil?
            @repository[name] = []
        end

        if @repository[name].index(value).nil?
            @repository[name].push(value)
        end
    end

    def to_s
        @repository.to_s
    end
end