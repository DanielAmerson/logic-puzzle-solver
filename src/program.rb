require_relative 'fact'
require_relative 'attribute_repository'
require_relative 'state'

debug = false
if ARGV.length > 0
    debug = (ARGV[0].casecmp "debug") == 0
end

ARGV.clear # clear the command line args so that calls to gets aren't impacted

# TODO error checking
def parse_input_as_fact(input, attribute_repository)
    are_related = input.index('/').nil?
    components = input.split(if are_related then '>' else '/' end)
    predicates_for_component_1 = components[0].split(':')
    predicates_for_component_2 = components[1].split(':')

    attribute_repository.add(predicates_for_component_1[0], predicates_for_component_1[1])
    attribute_repository.add(predicates_for_component_2[0], predicates_for_component_2[1])

    Fact.new(are_related, predicates_for_component_1[0], predicates_for_component_1[1], predicates_for_component_2[0], predicates_for_component_2[1])
end

# TODO move repository to state class so that values can be properly configured when generated
repository = AttributeRepository.new()

print "Enter the number of attribute types: "
num_attributes = gets.chomp.to_i

print "Enter the number of values per attribute: "
num_values = gets.chomp.to_i

state = State.new(num_attributes, num_values)
if debug
    puts state.render_state()
end

all_facts_entered = false
loop do
    print "Enter a fact in the form attribute_1:value_1>attribute_2:value_2 or attribute_1:value_1/attribute_2:value_2 to indicate whether or not a relationship exists between values: "

    generated_fact = parse_input_as_fact(gets.chomp, repository)
    puts generated_fact

    if debug
        puts $repository
    end

    print "All facts entered (y/n)? "
    break if (gets.chomp[0].casecmp "y") == 0
end