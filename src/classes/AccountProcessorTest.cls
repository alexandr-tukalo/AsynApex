@IsTest
public class AccountProcessorTest {
	@isTest
	static void TestAccountProcessorTest()
		{
			Account a = new Account();
			a.Name = 'Test Account';
			Insert a;

			Contact cont = New Contact();
			cont.FirstName = 'Bob';
			cont.LastName = 'Masters';
			cont.AccountId = a.Id;
			Insert cont;

			set<Id> setAccId = new Set<ID>();
			setAccId.add(a.id);

			System.Test.startTest();
			AccountProcessor.countContacts(setAccId);
			System.Test.stopTest();

			Account ACC = [SELECT Number_of_Contacts__c FROM Account WHERE id = :a.id LIMIT 1];
			System.assertEquals(Integer.valueOf(ACC.Number_of_Contacts__c), 1);
		}

}