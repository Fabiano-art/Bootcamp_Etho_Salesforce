public class ShowCallout {
    public static void createOrUpdateLead(){
        // it's not allowed realize DML before callout
        // it's not allowed realize callout inside trigger context
        CallloutToMarvel.getcharacters();
    }
}