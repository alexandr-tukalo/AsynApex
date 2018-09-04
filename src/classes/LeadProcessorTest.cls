@isTest
public class LeadProcessorTest {
	
     @testSetup
     static void setupLeads() {
        List<Lead> leads = new List<Lead>();
        // insert 200 Leads
        for (Integer i=0;i<200;i++) {
            leads.add(new Lead(company = 'testCompany' + i, 
                Leadsource='DreamForce', LastName = 'LeadingEdge' + i));
        }
        insert leads;
}
    
    @isTest
    static void testUpdateLeadBatch(){
        List<lead> leadsForUpdate =[select id, LeadSource from Lead where LeadSource = 'Dreamforce'];
        
        System.Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        id batchJobId = Database.executeBatch(lp,200);
        System.Test.stopTest();
        
        List<lead> leadsAfterUpdate =[select id, LeadSource from Lead where LeadSource = 'Dreamforce'];
        System.debug(leadsAfterUpdate);
		System.assertEquals(0, leadsAfterUpdate.size());
        }
    }