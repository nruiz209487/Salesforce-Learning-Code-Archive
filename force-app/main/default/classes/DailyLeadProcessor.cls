global class DailyLeadProcessor implements Schedulable{
    global void execute(SchedulableContext ctx){
        List<Lead> leads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = ''];
        
        if(leads.size() > 0){
            for(Lead lead : leads){
                lead.LeadSource = 'DreamForce';
            }
            
            update leads;
        }
    }
}