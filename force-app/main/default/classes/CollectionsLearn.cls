public class CollectionsLearn {
    
    private class Employee {
        private String id;
        private List<Function> functions;
        
        Employee(String id, List<Function> functions){
            this.id = id;
            this.functions = functions;
        }
    }
    
    private class Function{
        private String function;
        
        Function(String function){
            this.function = function;
        }        
    }
}