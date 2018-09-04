public class AddPrimaryContact implements Queueable {
    
    private Contact con;
    private String ab;
    
    public AddPrimaryContact (Contact cont, String abb){
        this.con= cont;
        this.ab = abb;
    }
    public void execute(QueueableContext qc){
        List<Account> acc = [SELECT id FROM Account WHERE BillingState = :ab LIMIT 200];
        for(Account a : acc){
            Contact cc = con.clone(false,true);
            cc.AccountId = a.Id;
            Database.insert(cc,false); //insert cc;
        }       
    }
}