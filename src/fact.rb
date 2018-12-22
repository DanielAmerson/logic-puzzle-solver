class Fact    
    attr_reader :attributes_related, :first_attribute, :first_value, :second_attribute, :second_value

    def initialize(attributes_related, first_attribute, first_value, second_attribute, second_value)
        @attributes_related = attributes_related
        @first_attribute = first_attribute
        @first_value = first_value
        @second_attribute = second_attribute
        @second_value = second_value
    end

    def to_s
        relationship = if @attributes_related then "is related to" else "is not related to" end
        "The #{@first_attribute} with value #{@first_value} #{relationship} the #{@second_attribute} with value #{@second_value}."
    end
end