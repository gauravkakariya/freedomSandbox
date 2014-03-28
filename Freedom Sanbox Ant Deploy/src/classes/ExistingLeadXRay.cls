public with sharing class ExistingLeadXRay 
{
		//Properties added for Partner Portal Implementation purpose
		//Added by : Prajakta Sanap
		//Date     : 03/08/2012
	//==============================================================
	public Boolean isFreedomUser{get;set;}
	public String Accname{get;set;}
	//public String Title{get;set;} 
	public Account Partnerlogo{get;set;}
	
	public String leadId {set;get;}
	public String entityId {set;get;}
	public ID parentId {set;get;}
	public Lead objLead {set; get;}
	//public Lead_Platform_User__c objCustLead {set; get;}
	public Account objAccount{set; get;}
	public Set<ID>  setOfScoreCardIds{set;get;} 
	public List<Questionnaire__c> lstQuestionnaire {set;get;}
	public List<X_Ray_Score_Card_Detail__c> lstXrayScorecardDetails {set;get;}
	public List<X_Ray_Score_Card_Detail__c> lstCustomXrayScorecardDetails {set;get;}
	public List<XRay_ScoreCard__c> lstScoreCards {set;get;}
	public List<Option_Detail__c> lstOptionDetails {set;get;}
	public List<Question_Bank__c> lstQuestionBank {set;get;}
	public List<ExistingQuestionAnswer> lstExistingQuesAnswer {set;get;}
	
	Map<ID,List<Question_Option_List__c>> mapQuesIdAnswerList {set;get;}
	Map<ID,List<Option_Detail__c>> mapQuesSelectedAnswerList {set;get;} 
	Map<ID,XRay_ScoreCard__c> mapQuesIdXrayScoreCard {set;get;}
	Map<ID,Option_Detail__c> mapOfOpDetailIdOpDetail {set;get;}
	Map<ID,X_Ray_Score_Card_Detail__c> mapLeadIdScoreCardDetail {set;get;}
	
	//Constructor starts
	public ExistingLeadXRay()
	{
		if(ApexPages.currentPage().getParameters().get('leadId') != null)
			leadId = ApexPages.currentPage().getParameters().get('leadId');
		else if(ApexPages.currentPage().getParameters().get('entityId') != null )
			entityId = ApexPages.currentPage().getParameters().get('entityId') ;
		
		if(leadId != null)
			objLead = new Lead();
		else if(entityId != null)
			objAccount = new Account();
			
		lstXrayScorecardDetails = new  List<X_Ray_Score_Card_Detail__c> ();
		lstCustomXrayScorecardDetails = new  List<X_Ray_Score_Card_Detail__c> ();
		lstQuestionnaire = new List<Questionnaire__c>();
		lstScoreCards = new List<XRay_ScoreCard__c> ();
		lstOptionDetails = new  List<Option_Detail__c>();
		lstQuestionBank = new List<Question_Bank__c>();
		lstExistingQuesAnswer = new List<ExistingQuestionAnswer>();
		
		mapQuesIdXrayScoreCard = new Map<ID,XRay_ScoreCard__c>();
		mapQuesIdAnswerList = new Map<ID,List<Question_Option_List__c>>();
		mapQuesSelectedAnswerList = new Map<ID,List<Option_Detail__c>>();
		mapLeadIdScoreCardDetail  = new Map<ID,X_Ray_Score_Card_Detail__c>(); 
	}
	
	public Pagereference Init()
	{
		set<ID> setQuestionBankId = new Set<ID>();
		Id objOwnerId;
		Account acc;
	 	Contact con;
	 	String strPrefix;
	 	
		if(leadId != null)
		{
			//Code Added by Aditi For Platform User related changes
			//Date : 31/08/12
			//==========================================================================================================================
			/*strPrefix = leadId.substring(0, 3);
			if(strPrefix.equals('a1H')) //Custom Lead Prefix
    		{
    			objCustLead = [select Id from Lead_Platform_User__c where Id = : leadId];
    			objLead =  [select Id,Status,Platform_User_Lead__c,OwnerId from Lead where Platform_User_Lead__c = : objCustLead.Id];
    		}
    		else
    		{
				objLead = [select Id, Ffreedom_Score__c, OwnerId,Platform_User_Lead__c from Lead where Id = :leadId];
				if(objLead.Platform_User_Lead__c != null)
				{
					List<Lead_Platform_User__c> custLeadList = [select Id from Lead_Platform_User__c where Id =: objLead.Platform_User_Lead__c];
					objCustLead = custLeadList[0];
				}
    		}*/
    		//==========================================================================================================================
    		objLead = [select Id, Ffreedom_Score__c, OwnerId from Lead where Id = :leadId];
		 	//Code added to get the owner Id for Partner Portal
		 	objOwnerId = objLead.OwnerId;
		
			if(objLead != null)
			{
				lstXrayScorecardDetails = [Select x.Id, x.Question_Bank__c, x.Overall_Analysis__c, x.Name,x.MasterScore__c, x.Lead__c 
								    	From X_Ray_Score_Card_Detail__c x where Lead__c =: objLead.Id limit 1];
			}
			//PU
			
		}
		else if(entityId != null)
		{
			objAccount = [select Id,OwnerId,Ffreedom_Score__c from Account where Id = :entityId];
			system.debug('*********objAccount*********'+objAccount);
			//Code added to get the owner Id for Partner Portal
			
			if(objAccount != null)
			{
				system.debug('*********in if**********');
				objOwnerId = objAccount.OwnerId;
				lstXrayScorecardDetails = [Select x.Id, x.Question_Bank__c,x.Entity__c, x.Overall_Analysis__c, x.Name,x.MasterScore__c, x.Lead__c 
								    	From X_Ray_Score_Card_Detail__c x where Entity__c =: objAccount.Id limit 1];
			}
		}
		
		//Added by : Prajakta Sanap
		//Date     : 03/08/2012
		   	List<User> user=[select Id,Name,ProfileId,ContactId,Profile.Name from User where Id=:objOwnerId];
		  if(user !=null)
		  {
		   	if(user[0].ContactId==null)
		  	{
		    	isFreedomUser = true;
		    	Accname='Ffreedom';
		    	//Title = 'Ffreedom X-RAY';
		   	}
		   	else //Else is for Partner Portal
		   	{
		    	Id contactId = user[0].ContactId;
		    	con=[select AccountId from Contact where id =: user[0].ContactId];
		    	acc=[select Id,Logo__c, Email_ID__c, Company_Address__c,Phone,Name from account where id =: con.AccountId];
		    	Partnerlogo = acc;
		    	Accname = acc.Name;
		    //	Title = acc.Name + ' X-RAY';
		    	isFreedomUser = false;
		   }
					
		  }
		if(lstXrayScorecardDetails  != null && lstXrayScorecardDetails.size() > 0 || lstCustomXrayScorecardDetails  != null && lstCustomXrayScorecardDetails.size() > 0 )
		{
			setQuestionBankId.add(lstXrayScorecardDetails[0].Question_Bank__c);
			
			setOfScoreCardIds = new Set<ID>();
			
			if(lstXrayScorecardDetails[0].Lead__c != null)
				mapLeadIdScoreCardDetail.put(lstXrayScorecardDetails[0].Lead__c , lstXrayScorecardDetails[0]);
			else
				mapLeadIdScoreCardDetail.put(lstXrayScorecardDetails[0].Entity__c , lstXrayScorecardDetails[0]);
			
			lstScoreCards = [Select x.XRayScoreCardMaster__c, 
										x.Score_Master__c, 
										x.Question_Bank_List__c, 
										x.Name, 
										x.Id,x.Question_Bank_List__r.Parent_Question__c,
										x.Question_Bank_List__r.Question_Type__c,
										x.Question_Bank_List__r.Question__c, 
							            x.Display_Sequence__c,
							            x.Analysis_Commentary__c 
										From XRay_ScoreCard__c x 
										where XRayScoreCardMaster__c = :lstXrayScorecardDetails[0].Id 
										order by Display_Sequence__c Asc];
										
			
			if(lstScoreCards.size() > 0)
			{
				for(XRay_ScoreCard__c scoreCard :lstScoreCards)
				{
					setOfScoreCardIds.add(scoreCard.Id);
					mapQuesIdXrayScoreCard.put(scoreCard.Question_Bank_List__c,scoreCard); 
				}
				if(setOfScoreCardIds.size() > 0)
			 	{	
					lstOptionDetails = [Select o.XRayScoreCard__r.Display_Sequence__c, 
					                                            o.XRayScoreCard__c, 
					                                            o.QuestionMaster__r.IsDummy__c, 
					                                            o.QuestionMaster__r.Question_Type__c, 
					                                            o.QuestionMaster__r.Question__c, 
					                                            o.QuestionMaster__c, o.Name, 
															    o.Id, o.Answer__c, o.Answer_Text__c 
															    From Option_Detail__c  o 
															    where XRayScoreCard__c IN : setOfScoreCardIds  
															    order by o.XRayScoreCard__r.Display_Sequence__c];
																			    
					if(lstOptionDetails.size() > 0)
					{
						
						for(Option_Detail__c quesOptionDetails:lstOptionDetails)
						{
							//Populating the value of Answers which User has given.
							if(!mapQuesSelectedAnswerList.isEmpty() && mapQuesSelectedAnswerList.containsKey(quesOptionDetails.QuestionMaster__c))
							{
								List<Option_Detail__c> lstAnswers = mapQuesSelectedAnswerList.get(quesOptionDetails.QuestionMaster__c);
								lstAnswers.add(quesOptionDetails);
								mapQuesSelectedAnswerList.put(quesOptionDetails.QuestionMaster__c,lstAnswers);
							}
							else
							{
								List<Option_Detail__c> lstAnswers = new List<Option_Detail__c>();
								lstAnswers.add(quesOptionDetails);
								mapQuesSelectedAnswerList.put(quesOptionDetails.QuestionMaster__c, lstAnswers);
							}
						}
					} 
				}							
			}
		}
		else
		{
			Map<String, QuestionBank__c> QuestionBank = QuestionBank__c.getAll();
	    	String finXRayId = QuestionBank.get('FinancialXRay').Question_Bank__c;
			lstQuestionBank = [select Id,Name,IsActive__c from Question_Bank__c where IsActive__c = true and Id =: finXRayId limit 1];
			if(lstQuestionBank != null && lstQuestionBank.size() > 0)
			{
				setQuestionBankId.add(lstQuestionBank[0].Id);
			}	
		}
		
		if(setQuestionBankId != null && setQuestionBankId.size() > 0)
		{ 
			lstQuestionnaire =[Select q.Question_Bank__c, q.Question_Bank_List__r.Parent_Question__c,q.Question_Bank_List__r.Master_Parent__c,
													   q.Question_Bank_List__r.IsDummy__c, q.Question_Bank_List__r.Question_Type__c,
													   q.Question_Bank_List__r.Question__c, q.Question_Bank_List__c, q.Id, 
													   q.Display_Sequence__c From Questionnaire__c q 
													   where Question_Bank__c In :setQuestionBankId Order By Display_Sequence__c ASC];
		}					    	
							    	
		
		if(lstQuestionnaire.size()> 0)
		{
			set<ID> setQuesId = new Set<ID> ();
			for(Questionnaire__c  objQues:lstQuestionnaire)
			{
				setQuesId.add(objQues.Question_Bank_List__c);
			}
			if(setQuesId.size() > 0)
			{
				mapQuesIdAnswerList = getQuestionAnswers(setQuesId);
			}
			
			//Populating inner class
			for(Questionnaire__c  objQues:lstQuestionnaire)
			{
				ExistingQuestionAnswer objExistingQuesInner = new ExistingQuestionAnswer();
				objExistingQuesInner.objQuestionnaire = objQues;
				
				if(objExistingQuesInner.objQuestionnaire.Question_Bank_List__r.Parent_Question__c == null )
				{
					objExistingQuesInner.isParent = true;
				}
				else
				{
					objExistingQuesInner.isParent = false;
				}
				
				/*** Populating answers  ***/
				if(objQues.Question_Bank_List__r.Question_Type__c == 'Yes/No')
				{
					objExistingQuesInner.isMultiChoice = false;
					if(!mapQuesSelectedAnswerList.isEmpty() && mapQuesSelectedAnswerList.containsKey(objQues.Question_Bank_List__c))
					{
						List<Option_Detail__c> lstOptionDetailsToFill = mapQuesSelectedAnswerList.get(objQues.Question_Bank_List__c);
						if(lstOptionDetailsToFill.size() > 0)
						{
							objExistingQuesInner.selectedAnswer = lstOptionDetailsToFill[0].Answer__c;
						}
					}
				}
				else if(objQues.Question_Bank_List__r.Question_Type__c == 'Multichoice')
				{
					objExistingQuesInner.isMultiChoice = true;
					if(!mapQuesSelectedAnswerList.isEmpty() && mapQuesSelectedAnswerList.containsKey(objQues.Question_Bank_List__c))
					{
						List<Option_Detail__c> lstOptionDetailsToFill = mapQuesSelectedAnswerList.get(objQues.Question_Bank_List__c);
						if(lstOptionDetailsToFill.size() > 0)
						{
							for(Option_Detail__c objOptionToFill :lstOptionDetails)
								objExistingQuesInner.selMultipleAnswrs.add(objOptionToFill.Answer__c);
						}
					}
				}
				
				if(!mapQuesIdAnswerList.isEmpty()&& mapQuesIdAnswerList.containsKey(objQues.Question_Bank_List__c))
				{
					List<Question_Option_List__c> lstAnswer = mapQuesIdAnswerList.get(objQues.Question_Bank_List__c);
					if(lstAnswer != null && lstAnswer.size() > 0 )
					{
						for(Question_Option_List__c objAns :lstAnswer)
						{
							objExistingQuesInner.strAnswer.add(new Selectoption(objAns.Id, objAns.Name));
							objExistingQuesInner.lstofAnswers.add(objAns.Name); 
						}
					}
				}
				lstExistingQuesAnswer.add(objExistingQuesInner);
			}
		}
	return null; 
	}
	
	

	public Map<ID,List<Question_Option_List__c>>  getQuestionAnswers(set<ID> setOfQuestionIds)
	{
		Map<ID,List<Question_Option_List__c>> mapQuesIdAnswers = new Map<ID,List<Question_Option_List__c>>();
		for(Question_Option_List__c objAnswer: [Select q.Score__c, 
													q.Question_Bank_List__c, 
													q.Name, 
													q.Id 
													From Question_Option_List__c q 
													where Question_Bank_List__c IN :setOfQuestionIds])
			{
				if(!mapQuesIdAnswers.isEmpty() && mapQuesIdAnswers.containsKey(objAnswer.Question_Bank_List__c))
				{
					List<Question_Option_List__c> lstAnswers = mapQuesIdAnswers.get(objAnswer.Question_Bank_List__c);
					lstAnswers.add(objAnswer);
					mapQuesIdAnswers.put(objAnswer.Question_Bank_List__c,lstAnswers);
				}
				else
				{
					List<Question_Option_List__c> lstAnswers = new List<Question_Option_List__c>();
					lstAnswers.add(objAnswer);
					mapQuesIdAnswers.put(objAnswer.Question_Bank_List__c, lstAnswers);
				}
			}
		return mapQuesIdAnswers;
	}
	
	
	public Pagereference Save()
	{
		PageReference pgRef = null;
		Database.Upsertresult objUpsertXrayDetail = null;
		X_Ray_Score_Card_Detail__c objXrayScoreCardDetail;
		Map<ID,Question_Option_List__c> mapOfOptionList = new Map<ID,Question_Option_List__c>();
		List<Option_Detail__c> lstOptionDetailTobeUpdate =  new List<Option_Detail__c>();
		ID recentScoreCardDetailId ;
		List<XRay_ScoreCard__c> lstScoreCardTobeUpdate =  new List<XRay_ScoreCard__c>();
		
		/**** Anwser id and its object****/
		for(Question_Option_List__c objOptionList : [Select q.Score__c, q.Question_Bank_List__c, q.Name, q.Id From Question_Option_List__c q ])
		{
			mapOfOptionList.put(objOptionList.Id,objOptionList);
		}
		
		/**** Deleting all the option if already exists ****/
			/*if(lstOptionDetails.size() > 0)
		{
			Database.delete(lstOptionDetails);
		}*/
		
		if(lstScoreCards.size() > 0)
		{
			Database.delete(lstScoreCards);
		}
		
		/**** Create or update XRayScoreCardDetail for respective lead   ****/
		if(leadId != null)
		{
			if(!mapLeadIdScoreCardDetail.isEmpty() && mapLeadIdScoreCardDetail.containsKey(objLead.Id))
			{
				 objXrayScoreCardDetail = mapLeadIdScoreCardDetail.get(objLead.Id);
			}
			else
			{
				objXrayScoreCardDetail = new X_Ray_Score_Card_Detail__c();
				system.debug('!!!!!!!!!!!!!!objLead.Id===>'+objLead.Id);
				objXrayScoreCardDetail.Lead__c = objLead.Id;
				/*if(objCustLead != null) 
					objXrayScoreCardDetail.Platform_User_Lead__c = objCustLead.id;*/
				if(lstQuestionBank.size() > 0)
				{
					objXrayScoreCardDetail.Question_Bank__c = lstQuestionBank[0].Id ;
				} 
			}
		}
		else if(entityId != null)
		{
			if(!mapLeadIdScoreCardDetail.isEmpty() && mapLeadIdScoreCardDetail.containsKey(objAccount.Id))
			{
				 objXrayScoreCardDetail = mapLeadIdScoreCardDetail.get(objAccount.Id);
			}
			else
			{
				objXrayScoreCardDetail = new X_Ray_Score_Card_Detail__c();
				objXrayScoreCardDetail.Entity__c = objAccount.Id;
				if(lstQuestionBank.size() > 0)
				{
					objXrayScoreCardDetail.Question_Bank__c = lstQuestionBank[0].Id ;
				} 
			}
		}
		
		if(objXrayScoreCardDetail != null)
			objUpsertXrayDetail = Database.upsert(objXrayScoreCardDetail);
		if(objUpsertXrayDetail != null)	
		{
			recentScoreCardDetailId = objUpsertXrayDetail.getId(); 
			
			if(objUpsertXrayDetail.isSuccess())
			{
				if(lstExistingQuesAnswer.size() > 0)
				{
					XRay_ScoreCard__c objXrayScoreCard;
					for(ExistingQuestionAnswer objExisting :lstExistingQuesAnswer)
					{
						//if(!mapQuesIdXrayScoreCard.isEmpty() && mapQuesIdXrayScoreCard.containsKey(objExisting.objQuestionnaire.Question_Bank_List__c))
							//objXrayScoreCard = mapQuesIdXrayScoreCard.get(objExisting.objQuestionnaire.Question_Bank_List__c);
						//else
						//{
							objXrayScoreCard = new XRay_ScoreCard__c();
							objXrayScoreCard.XRayScoreCardMaster__c = objUpsertXrayDetail.getId();
						//}
						objXrayScoreCard.Display_Sequence__c = Double.valueOf(objExisting.objQuestionnaire.Display_Sequence__c);
						objXrayScoreCard.Question_Bank_List__c = objExisting.objQuestionnaire.Question_Bank_List__c;
						
						if(!objExisting.objQuestionnaire.Question_Bank_List__r.IsDummy__c)
						{
							ID userAnswer = objExisting.selectedAnswer;
							if(!mapOfOptionList.isEmpty() && mapOfOptionList.containsKey(userAnswer))
							{
								Question_Option_List__c objOptionList = mapOfOptionList.get(userAnswer);
								if(objOptionList.Score__c != null)
								{
									objXrayScoreCard.Score_Master__c = objOptionList.Score__c;
								}
							}
						}
						lstScoreCardTobeUpdate.add(objXrayScoreCard);	
					}
					
					List<Database.Saveresult> lstUpsertScoreCard ;
					
					if(lstScoreCardTobeUpdate != null && lstScoreCardTobeUpdate.size() > 0)
						 lstUpsertScoreCard = Database.insert(lstScoreCardTobeUpdate);
					
					if(lstUpsertScoreCard != null && lstUpsertScoreCard.size() > 0)
					{
						Set<ID> setOfUpsertedScoreId =  new Set<ID>(); 
						for(Database.Saveresult upsertResult :lstUpsertScoreCard)
						{
							setOfUpsertedScoreId.add(upsertResult.getId()); 
						}
						
						if(setOfUpsertedScoreId.size() > 0)
						{
							mapQuesIdXrayScoreCard = new Map<ID,XRay_ScoreCard__c>();
							
							for(XRay_ScoreCard__c  objXrayScorecardInserted:[Select x.Score_Master__c, x.Question_Bank_List__c, x.Name, x.Id, x.Display_Sequence__c, x.Answer_Question_Master__c 
																	 From XRay_ScoreCard__c x where Id In : setOfUpsertedScoreId])
							{
								mapQuesIdXrayScoreCard.put(objXrayScorecardInserted.Question_Bank_List__c,objXrayScorecardInserted);
							}
						}
						
						Option_Detail__c   objOptionDetails;
						for(ExistingQuestionAnswer objWrapper : lstExistingQuesAnswer)
						{
							if(objWrapper.objQuestionnaire.Question_Bank_List__r.Question_Type__c =='Yes/No')
							{
								ID userAnswer = objWrapper.selectedAnswer;
								if(!mapOfOptionList.isEmpty() && mapOfOptionList.containsKey(userAnswer))
								{
									objOptionDetails = new Option_Detail__c ();
									Question_Option_List__c objOptionList = mapOfOptionList.get(userAnswer);
									objOptionDetails.Answer__c = objOptionList.Id;
							  		objOptionDetails.Answer_Text__c = objOptionList.Name;
							  		objOptionDetails.QuestionMaster__c = objOptionList.Question_Bank_List__c;
							  		if(!mapQuesIdXrayScoreCard.isEmpty() && mapQuesIdXrayScoreCard.containsKey(objWrapper.objQuestionnaire.Question_Bank_List__c))
							  		{
							  			objOptionDetails.XRayScoreCard__c = mapQuesIdXrayScoreCard.get(objWrapper.objQuestionnaire.Question_Bank_List__c).Id;
							  		}
							  		lstOptionDetailTobeUpdate.add(objOptionDetails);
							  	}
							 
								
							}
							else if(objWrapper.objQuestionnaire.Question_Bank_List__r.Question_Type__c == 'Multichoice')
							{
								List<String> lstMultichoiceAnswer = objWrapper.selMultipleAnswrs;
								for(String idAnswer:lstMultichoiceAnswer)
								{ 
								  ID userAnswer = String.valueOf(idAnswer);
								  if(!mapOfOptionList.isEmpty() && mapOfOptionList.containsKey(userAnswer))
								  {	
								  	 	objOptionDetails = new Option_Detail__c ();
										Question_Option_List__c objOptionList = mapOfOptionList.get(userAnswer);
										objOptionDetails.Answer__c = objOptionList.Id;
								  		objOptionDetails.Answer_Text__c = objOptionList.Name;
								  		objOptionDetails.QuestionMaster__c = objOptionList.Question_Bank_List__c;
								  		if(!mapQuesIdXrayScoreCard.isEmpty() && mapQuesIdXrayScoreCard.containsKey(objWrapper.objQuestionnaire.Question_Bank_List__c))
								  		{
								  			objOptionDetails.XRayScoreCard__c = mapQuesIdXrayScoreCard.get(objWrapper.objQuestionnaire.Question_Bank_List__c).Id;
								  		}
								   	lstOptionDetailTobeUpdate.add(objOptionDetails);
	 							  }
	 							}
							}
						}
						if(lstOptionDetailTobeUpdate.size() > 0)
						{
							List<Database.Upsertresult> lstUpserOptionDetails = Database.upsert(lstOptionDetailTobeUpdate);
						}
					}
				}//recentScoreCardDetailId
				
				X_Ray_Score_Card_Detail__c objRecentScoreCardDetail = new X_Ray_Score_Card_Detail__c();
				objRecentScoreCardDetail = [Select x.MasterScore__c, x.Id From X_Ray_Score_Card_Detail__c x where  Id =:recentScoreCardDetailId];
				if(objRecentScoreCardDetail != null)
				{
					if(leadId != null)
					{
						objLead.Ffreedom_Score__c = objRecentScoreCardDetail.MasterScore__c;
						update(objLead);
						/*if(objCustLead !=null)
						{
							objCustLead.Ffreedom_Score__c = objRecentScoreCardDetail.MasterScore__c;
							update(objCustLead);
						}*/
					}
					else if(entityId != null )
					{
						objAccount.Ffreedom_Score__c = objRecentScoreCardDetail.MasterScore__c;
						update(objAccount);
					}
				}
			}
		}
		return null;
	}
	
	
	/****** Method called from Action support ******/
	public Pagereference resetAllChild()
	{
		if(lstExistingQuesAnswer.size() > 0)
		{
			for(ExistingQuestionAnswer objExist :lstExistingQuesAnswer)
			{
				if(objExist.objQuestionnaire.Question_Bank_List__r.Master_Parent__c == parentId)
				{
					objExist.selectedAnswer = null;
				}	
			}
		}
		return null;
	}
	
	/**** Inner Class ****/	
	public class ExistingQuestionAnswer
	{
		public Questionnaire__c objQuestionnaire {set;get;}
		public List<Selectoption> strAnswer {get;set;}
		public List<String> selMultipleAnswrs {get;set;}
		public Boolean isMultiChoice{set;get;}
		public ID selectedAnswer {get;set;}
		public Boolean isParent{set;get;}
		public List<String> lstofAnswers {set;get;}
		ExistingQuestionAnswer()
		{
			isParent = false;
			Questionnaire__c  objQuestionnaire = new Questionnaire__c();
			strAnswer = new List<SelectOption>();
			selMultipleAnswrs = new List<String>();
			lstofAnswers =  new List<String>();
		}
	}
}