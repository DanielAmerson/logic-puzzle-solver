require_relative 'relationship'

class State
    def initialize(number_of_attributes, number_of_values)
        @board = Hash.new()
        @repository = Hash.new()

        attributes = Array.new(number_of_attributes)
        for counter in 0..number_of_attributes
            attributes[counter] = Attribute.new("attribute_" + counter.to_s, false)
        end

        #board is represented by each permutation of attributes so lookups will need to check both levels of nesting
        for counter_1 in 1..(number_of_attributes - 1)
            @board[attributes[counter_1]] = Hash.new
            for counter_2 in (counter_1 + 1)..number_of_attributes
                @board[attributes[counter_1]][attributes[counter_2]] = Relationship.new(number_of_values)
            end
        end
    end

    def render_state()
        @board
    end

    def apply_fact(fact_to_apply)
        add_attribute_to_repository(fact_to_apply.first_attribute, fact_to_apply.first_value)
        add_attribute_to_repository(fact_to_apply.second_attribute, fact_to_apply.second_value)

        # TODO update relationship state with new data
        # TODO infer new facts
    end

    def add_attribute_to_repository(attribute, value)
        if @repository[attribute].nil?
            @repository[attribute] = []

            # TODO new attribute - add to board
        end

        if @repository[attribute].index(value).nil?
            @repository[attribute].push(value)

            # TODO new attribute - add to relationship
        end
    end
end

class Attribute
    def initialize(name, defined_value = true)
        @name = name
        @defined_value = defined_value
    end

    def ==(other)
        self.class === other and
            other.name = @name and
            other.defined_value = @defined_value
    end

    def hash
        @name.hash + (100 * @defined_value.hash)
    end
end