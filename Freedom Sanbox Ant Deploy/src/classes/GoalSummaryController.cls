/**
*
* Author:   
*
* Revision History:
*   Version     Version Author     Date       		Comments
*   1.0        		 --				--		   		This class is having logic to show asset allocation on asset allocation page.
													It retrieves asset, investment asset and insurance records from respective table and 
													association entries.
													
	2.0			Niket Chandane	   1 June 2011		Issue Id :F0010:
													1) Added the Function "getInflationRateFromGlobalAssumptions" to get Inflation rate
													   from the Global assumption. (if Inflation Rate for the Goal is not Specified.)
								  					2) added Property "GlobalAssumptionInflationRate" which is bind on the GoalSummaryComponent 
								  					   this Property "GlobalAssumptionInflationRate" is get displayed the InflationRate of the Global assumption. 
								  					   
*/
public class GoalSummaryController
{
    public list<goal__c> financialGoalList{get;set;}
    string entityId;
    public Decimal GlobalAssumptionInflationRate{get;set;}
 	public Static String eId {get;set;} 
    public GoalSummaryController()
    {
      entityId = eId == null ? ApexPages.currentPage().getParameters().get('EntityId'):eId;
      // Error.debuglog('-----------------entityId GoalSummaryController --------'+entityId);
      if(entityId!=null || entityId!='')
      {
          /*
		  	Updated By : Kiran Patil
		  	Updated At : 5-Jun-2013
		  	Summary    : FP changes-part2 - issue 6 
		  */
          financialGoalList = [
                        Select Id, Inflation_Rate__c, Cost_of_Goal_Annual__c, Priority__c, SelectedGoalProfile__r.name, Name, Goal_Type__c,
                               description__c, Goal_End_Year__c, Goal_Start_Year__c, CreatedDate
                          from Goal__c
                         where entity__c =: entityId
                      order by CreatedDate
          ];
          if(financialGoalList != null && financialGoalList.size() > 0)
          {
          	for(goal__c objGoal: financialGoalList)
          	{
          		if(objGoal.Inflation_Rate__c == null)
          		 {
          		 	 GlobalAssumptionInflationRate = getInflationRateFromGlobalAssumptions(entityId);
          		 	 break;
          		 }
          	}
          }
          
        /*
		  Updated By : Kiran Patil
		  Updated At : 5-Jun-2013
		  Summary    : FP changes-part2 - issue 6 
		*/
        if(!(financialGoalList).isEmpty()) {
	        list<Goal__c> tempaddNewListView = new list<Goal__c>();
        	list<Goal__c> tempaddNewListViewRetirement = new list<Goal__c>();
        	for (Goal__c goal : financialGoalList) {
        		if (goal.Goal_Type__c.equalsIgnoreCase('Retirement'))
        		    tempaddNewListViewRetirement.add(goal);
        		else     
        		    tempaddNewListView.add(goal);
        	}
        	financialGoalList = new list<Goal__c>();
        	financialGoalList.addall(tempaddNewListView);
        	financialGoalList.addall(tempaddNewListViewRetirement);
        }
        
      }
      // Error.debuglog('-----------------Limit GoalSummaryController --------'+Limits.getQueries());
    }
    
    /*
     Created By : Niket Chandane.
     Date  		: 1 June 2011.
     Method 	: getInflationRateFromGlobalAssumptions(String strEntityId)
     Return   	: Decimal [Get Value from the Global Assumption]
     Summary 	: It Accept the Entity Id and give the Inflation Rate fron the Global assumption Object.
    */
    public Decimal getInflationRateFromGlobalAssumptions(String strEntityId)
    {
    	Decimal iGlobalAssumptionInflationRate;
    	try
    	{
    		DatabaseSOQL bdSOQL = new DatabaseSOQL();
    		Entity_Global_Assumption__c objGlobalAssumption = bdSOQL.getGlobalAssumptions(entityId);
    		iGlobalAssumptionInflationRate = objGlobalAssumption.Inflation_Rate__c;
    	}
    	catch(Exception ex)
    	{
    		system.debug('==========GoalSummaryController Exception=========='+ex.getmessage());
         }
    	return iGlobalAssumptionInflationRate;
    }
}