class Relationship
    def initialize(number_of_values)
        @board_grid = Array.new(number_of_values) { Array.new(number_of_values) }

        # initialize an empty grid to represent the unknown state of a relationship
        for row in 0..(@board_grid.length - 1)
            row_value = Value.new("row_" + row.to_s, false)
            for column in 0..(@board_grid[row].length - 1)
                column_value = Value.new("column_" + column.to_s, false)
                
                @board_grid[row][column] = Cell.new(row_value, column_value)
            end
        end
    end
end

class Value
    def initialize(name, defined_value = true)
        @name = name
        @defined_value = @defined_value
    end
end

class Cell
    def initialize(row, column, value = nil)
        @row = row
        @column = column
        @value = value
    end
end