private class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    @isTest
    static void testScheduleLeadProcessor() {
        // Test data setup - create leads with empty LeadSource
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++) {
            Lead ld = new Lead(LastName='LastName ' + i, Company='Company Name', Status='Open - Not Contacted', LeadSource='');
            leads.add(ld);
        }
        insert leads;
        
        Test.startTest();
        String jobId = System.schedule('ScheduleLeadProcessorTest', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        // Verify leads were updated
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'DreamForce'];
        System.assertEquals(200, updatedLeads.size());
    }
    
    @isTest
    static void testDailyLeadProcessorExecuteWithLeads() {
        // Create test leads with empty LeadSource
        List<Lead> testLeads = new List<Lead>();
        for(Integer i = 0; i < 5; i++) {
            Lead ld = new Lead(LastName='Test' + i, Company='Test Company' + i, Status='Open - Not Contacted', LeadSource='');
            testLeads.add(ld);
        }
        insert testLeads;
        
        Test.startTest();
        DailyLeadProcessor dailyProcessor = new DailyLeadProcessor();
        dailyProcessor.execute(null);
        Test.stopTest();
        
        // Verify the leads were updated
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'DreamForce'];
        System.assertEquals(5, updatedLeads.size(), 'Expected 5 leads to be updated');
    }
    
    @isTest 
    static void testDailyLeadProcessorExecuteWithoutLeads() {
        // Don't create any leads with empty LeadSource - create leads with existing LeadSource
        List<Lead> testLeads = new List<Lead>();
        for(Integer i = 0; i < 3; i++) {
            Lead ld = new Lead(LastName='TestExisting' + i, Company='Test Company' + i, Status='Working - Contacted', LeadSource='Web');
            testLeads.add(ld);
        }
        insert testLeads;
        
        Test.startTest();
        DailyLeadProcessor dailyProcessor = new DailyLeadProcessor();
        dailyProcessor.execute(null);
        Test.stopTest();
        
        // Verify no leads were updated to DreamForce
        List<Lead> dreamforceLeads = [SELECT Id FROM Lead WHERE LeadSource = 'DreamForce'];
        System.assertEquals(0, dreamforceLeads.size(), 'Expected 0 leads to be updated to DreamForce');
        
        // Verify original leads still have 'Web' as LeadSource
        List<Lead> webLeads = [SELECT Id FROM Lead WHERE LeadSource = 'Web'];
        System.assertEquals(3, webLeads.size(), 'Expected 3 leads to still have Web as LeadSource');
    }
}