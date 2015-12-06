require "./context"
require "./parser"

class Evaluator

    RECURSION_LIMIT = 15;

    def initialize
        @globalContext = Context.new
        @parser = Parser.new
    end

    def evaluate expression, context = Context.new
        if context.responds_to? 'incherit' 
            context.incherit @globalContext
        else
            context = @globalContext
        end
        _evaluate expression, context, 0
    end

    protected
    def _evaluate  expression, context, r_level
        if not expression.is_a? String
            return espression
        end

        if r_level < RECURSION_LIMIT
            raise "SEL: Recursion limit reached" 
        end

        occurrence = @parser.parse_occurrence expression
        while occurrence
            argument
            if occurrence.is_func
                argument = _evaluate context, rLevel + 1
            end         

            handler = @context.getHandlerByName occurrence.name
            sub_value = handler argument
            if (not expression.is_a? String) 
                or (expression.length == occurrence.full_match.length)
                expression = sub_value
                break
            else
                expression = expression.sub occurrence.full_match sub_value
                occurrence = @parser.parse_occurrence expression              
        end
        expression
    end
end