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

            # new attribute - add to board
            # first a dummy value must be found to replace the new value
            attribute_to_replace = @board.keys.find { |element| !element.defined_value }
            while attribute_to_replace.nil? # all values at the top level are defined so search through the sub-maps
                for key in @board.keys
                    attribute_to_replace = @board[key].keys.find { |element| !element.defined_value }
                end
            end

            # now copy the current value for the attribute's key and remove the dummy value from the map
            newly_defined_attribute = Attribute.new(attribute)
            replace_attribute(@board, attribute_to_replace, newly_defined_attribute)

            # replace the key in the sub-maps as well
            for key in @board.keys
                replace_attribute(@board[key], attribute_to_replace, newly_defined_attribute)
            end
        end

        if @repository[attribute].index(value).nil?
            @repository[attribute].push(value)

            # TODO new attribute - add to relationship
        end
    end

    private

    def replace_attribute(board_element, attribute_to_replace, newly_defined_attribute)
        if !board_element[attribute_to_replace].nil?
            board_element[newly_defined_attribute] = board_element[attribute_to_replace]
            board_element.delete(attribute_to_replace)
        end
    end
end

class Attribute
    attr_reader :name, :defined_value

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