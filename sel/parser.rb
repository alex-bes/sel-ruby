class Occurence
    attr_reader :name, :is_func, :argument, :full_match
    
    def initialize name, is_func, argument, full_match 
        @name, @is_func, @argument, @full_match = name, is_func, argument, full_match   
    end
end

class Parser 

    OCCURENCE_REGEXP = %r{
        \$                              
        (?<name>\w[\d\w]*)
        (?<arg>(?<re>\(
            (?:(?> [^()]+ )|\g<re>)*
        \)))?
    }x

    def parse_occurence expression

        match = OCCURENCE_REGEXP.match(expression)

        if not match
            return nil
        end

        name = match[:name]
        is_func = (match[:arg].is_a? String and match[:arg].length > 0)

        puts match[:arg].is_a? String 
        arg = match[:arg][1, match[:arg].length-2] if match[:arg].is_a? String
        full_match = "$#{match[:name]}#{match[:arg]}"

        Occurence.new name, is_func, arg, full_match  
    end
end