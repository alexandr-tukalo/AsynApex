@IsTest
public class AddPrimaryContactTest {
    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(name='Test Account'+i, BillingState='NY'));
            accounts.add(new Account(name='Test Account'+i+50, BillingState='CA'));
        }
        insert accounts;
    }
    
    static testmethod void testQueueable() {
        
        Contact co = new Contact(FirstName='Bill',LastName='Gates');
        insert co;
        String st= 'CA';
        
        AddPrimaryContact upd = new AddPrimaryContact(co, st);
        
        Test.startTest();        
        System.enqueueJob(upd);
        Test.stopTest();        
        
        //System.assertEquals(50, [select count() from account where BillingState = :st]);
        System.assertEquals(50, [ SELECT COUNT() FROM Contact WHERE AccountId IN (SELECT Id FROM Account WHERE BillingState = :st)]);
    }    
}