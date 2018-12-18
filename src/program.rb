require_relative 'fact'
require_relative 'attribute_repository'

$repository = AttributeRepository.new()

# TODO error checking
def parse_input_as_fact(input)
    are_related = input.index('/').nil?
    components = input.split(if are_related then '>' else '/' end)
    predicates_for_component_1 = components[0].split(':')
    predicates_for_component_2 = components[1].split(':')

    $repository.add(predicates_for_component_1[0], predicates_for_component_1[1])
    $repository.add(predicates_for_component_2[0], predicates_for_component_2[1])

    Fact.new(are_related, predicates_for_component_1[0], predicates_for_component_1[1], predicates_for_component_2[0], predicates_for_component_2[1])
end

# Data isn't used to generate boards, but rather used to determine when inferences can be made 
print "Enter the number of attribute types: "
num_attributes = gets.chomp.to_i

print "Enter the number of values per attribute: "
num_values = gets.chomp.to_i

all_facts_entered = false
loop do
    print "Enter a fact in the form attribute_1:value_1>attribute_2:value_2 or attribute_1:value_1/attribute_2:value_2 to indicate whether or not a relationship exists between values: "

    generated_fact = parse_input_as_fact(gets.chomp)
    puts generated_fact
    puts $repository

    print "All facts entered (y/n)? "
    break if (gets.chomp[0].casecmp "y") == 0
end