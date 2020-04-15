//System
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//Providers
import './accounts_provider.dart';
import './planned_transactions_provider.dart';
import './recurrences_provider.dart';
import './settings_provider.dart';
import './transfers_provider.dart';
import './categories_provider.dart';
//Models
import '../models/account.dart';
import '../models/category.dart';
import '../models/recurrence.dart';
import '../models/planned_transaction.dart';
import '../models/transfer.dart';
import '../models/cash_action.dart';
import '../models/setting.dart';
import '../models/cash_flow_item.dart';
import '../models/dummy_data.dart';

enum DateFinish {
  this_day,
  end_this_month,
  end_next_month
}

class CashFlowProvider with ChangeNotifier {

  List<List<CashFlowItem>> cashFlowItems = [];  
  Account totalAccount = null;
  bool cashFlowDirty = true;

  // void setCashFlowDirty(bool a){
  //   try{
  //     cashFlowDirty = a;
  //     notifyListeners();
  //   } catch(error){
  //     throw Exception('CashFlowProvider.setCashFlowDirty: ' + error.toString());
  //   }
  // }

  void cashFlowTillEndDate(BuildContext context){

      SettingsProvider settingsP = Provider.of<SettingsProvider>(context);   
      Setting setting = settingsP.items[settingsP.eD];
      DateTime cfend = DateTime.tryParse(setting.value); 
      cashFlowItems = fullCashFlow(context, cfend, cashFlowItems);
  }

  List<List<CashFlowItem>> fullCashFlow(BuildContext context, DateTime cfend, List<List<CashFlowItem>> cashFlows){

    try{
      var now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      cashFlows = []; //reset after each cash flow calculation     
      if(cfend == null) cfend = today;
      //Get all data ready
      PlannedTransactionProvider plansP = Provider.of<PlannedTransactionProvider>(context, listen: false);
      List<PlannedTransaction> plans = plansP.getCopiedPlans(); // here is the copy being done
      AccountsProvider accountsP = Provider.of<AccountsProvider>(context, listen: false);
      List<Account> accounts = accountsP.items;
      TransfersProvider transfersP = Provider.of<TransfersProvider>(context, listen: false);
      List<Transfer> transfers = transfersP.items;
      CategoriesProvider categoriesP = Provider.of<CategoriesProvider>(context, listen: false);
      RecurrencesProvider recurrencesP = Provider.of<RecurrencesProvider>(context, listen: false);
      List<CashAction> actions = [];

      //Reset Accounts after cash flow
      for(var account in accounts){
        account.actions = [];
        account.cashFlow = [];
      }
      //process transfers
      for(var trans in transfers){
        Recurrence recurrence = recurrencesP.findById(trans.recurrenceId);
        Account toAccount = accountsP.findById(trans.toAccountId);
        Account fromAccount = accountsP.findById(trans.fromAccountId);
        DateTime transDate = DateTime.tryParse(trans.plannedDate);
        if (recurrence == null && trans.useForCashFlow && toAccount != null && toAccount.usedForCashFlow){ //No recurrence, a one off
          if(isAfterOrEqual(transDate, today) && isBeforeOrEqual(transDate, cfend)){
            CashAction toAction = CashAction(tb: trans, account: toAccount, amount: trans.amount, plannedDate: DateTime.parse(trans.plannedDate));
            CashAction fromAction = CashAction(tb: trans, account: fromAccount, amount: (-1 * trans.amount), plannedDate: DateTime.parse(trans.plannedDate));
            actions.add(toAction);
            actions.add(fromAction);
          }
        } else {
          if(trans.useForCashFlow && toAccount != null && toAccount.usedForCashFlow && recurrence != null){
            List<CashAction> pActions = recurrence.processTransBase(cfend, trans, this, toAccount);
            actions.addAll(pActions);
            for(var action in pActions){
              CashAction from = CashAction(tb: action.tb, account: fromAccount, amount: (-1 * trans.amount), plannedDate: action.plannedDate);
              actions.add(from);
            }
          }
        }
      }

      //process planned transactions
      for(var plan in plans){
        plan.amount = plan.amount * (plan.credit ? 1 : -1); //Here and only here is where credit or debit is used on a copy of the planned transactions
        Recurrence recurrence = recurrencesP.findById(plan.recurrenceId);
        Account account = accountsP.findById(plan.accountId);
        Category category = categoriesP.findById(plan.categoryId); 
        DateTime planDate = DateTime.tryParse(plan.plannedDate);
        if (recurrence == null && plan.useForCashFlow && account != null && account.usedForCashFlow && category != null && category.useForCashFlow){ //No recurrence, a one off
          if(isAfterOrEqual(planDate, today) && isBeforeOrEqual(planDate, cfend)){
            CashAction action = CashAction(tb: plan, account: account, amount: plan.amount, plannedDate: planDate);
            actions.add(action);            
          }

        } else {
          if(plan.useForCashFlow && account != null && account.usedForCashFlow && category != null && category.useForCashFlow && recurrence != null){
            List<CashAction> pActions = recurrence.processTransBase(cfend, plan, this, account);
            actions.addAll(pActions);
          }
        }
      }
      for(var action in actions) action.account.actions.add(action); // the best line of code in the app

      Account total = Account(accountName: 'Total', balance: 0.0, description: 'Summary of all accounts', id: -1, usedForCashFlow: true, usedForSummary: false);    
      var totalBalance = 0.0;

      for(var account in accounts){
        if(account.usedForCashFlow){
          totalBalance += account.balance;
          total.actions.addAll(account.actions);
          account.actions.sort((a, b) => a.plannedDate.compareTo(b.plannedDate)); //sort the actions by planned date
          account.buildCashFlow();
          List<CashFlowItem> cfs = account.compressCashFlow(this);
          cashFlows.add(cfs);
          account.printCashFlow(context);
        }
      
      }
      total.balance = totalBalance;
      total.actions.sort((a, b) => a.plannedDate.compareTo(b.plannedDate)); //sort the total actions by planned date
      total.buildCashFlow();
      List<CashFlowItem> cfs = total.compressCashFlow(this);
      //Here only add in total if more than one accounts
      cashFlows.add(cfs);
      //This is the addition of the total cashFlow
      totalAccount = total;
      
      total.printCashFlow(context);
      // plansP.dirty = true;
      plans = null;
      cashFlowDirty = false; //The cash flow is good
      return cashFlows;
    } catch(error){
      throw Exception('CashFlowProvider.fullCashFlow: ' + error.toString());
    }
  }

  Future<void> fetchAndSet(BuildContext context) async {
    try{
      await Provider.of<AccountsProvider>(context, listen: false).fetchAndSetAccounts();
      await Provider.of<CategoriesProvider>(context, listen: false).fetchAndSetCategories();
      await Provider.of<RecurrencesProvider>(context, listen: false).fetchAndSetRecurrences();    
      await Provider.of<PlannedTransactionProvider>(context, listen: false).fetchAndSetTransactions();
      await Provider.of<TransfersProvider>(context, listen: false).fetchAndSetTransfers();
      await Provider.of<SettingsProvider>(context, listen: false).fetchAndSetSettings(); 
    } catch (error){
      throw Exception('CashFlowProvider.fetchAndSet: ' + error.toString());
    }   
  }

  void setUpFromNew(BuildContext context){
    List<Account> accounts = ACCOUNTS;
    for(var account in accounts){
      Provider.of<AccountsProvider>(context, listen: false).addAccount(account);
    }
    List<Category> categories = CATEGORIES;
    for(var category in categories){
      Provider.of<CategoriesProvider>(context, listen: false).addCategory(category);
    }
    List<Recurrence> recurrences = RECURRENCE;
    for(var recurrence in recurrences){
      Provider.of<RecurrencesProvider>(context, listen: false).addRecurrence(recurrence);
    }
    List<PlannedTransaction> plans = PLANNEDTRANSACTION;
    for(var plan in plans){
      Provider.of<PlannedTransactionProvider>(context, listen: false).addTransaction(plan);
    }
    List<Transfer> transfers = TRANSFERS;
    for(var transfer in transfers){
      Provider.of<TransfersProvider>(context, listen: false).addTransfer(transfer);
    }
  }  
  bool areTwoDateEqual(DateTime a, DateTime b){
    try{
      int diffDays = a.difference(b).inDays;
      bool isSame = (diffDays == 0);
      return isSame;
    } catch(error){
      throw Exception('CashFlowProvider.areTwoDateEqual: ' + error.toString());
    }
  }
  bool isMonthDayBehind(DateTime start, DateTime today){
    try{
      return start.day < today.day ? true : false;
    } catch(error){
      throw Exception('CashFlowProvider.isMonthDayBehind: ' + error.toString());
    } 
  }
  DateTime getWeeklyNextDate(DateTime start, DateTime today){
    try{
      if(start.difference(today).inDays >= 0){
        start = DateTime(start.year, start.month, start.day);
      } else {
        while(start.isBefore(today)){
          start = DateTime(start.year, start.month, start.day + 7);
        }
      }
      return start;
    } catch(error){
      throw Exception('CashFlowProvider.getWeeklyNextDate: ' + error.toString());
    }
  }  
  DateTime getMonthlyNextDate(DateTime start, DateTime today){
    try{
      if(start.difference(today).inDays >= 0){
        start = DateTime(start.year, start.month, start.day);
      } else {
        while(start.isBefore(today)){
          start = DateTime(start.year, start.month + 1, start.day);
        }  
      }
      return start;
    } catch(error){
      throw Exception('CashFlowProvider.getMonthlyNextDate: ' + error.toString());
    }
  }
  DateTime getQuarterlyNextDate(DateTime start, DateTime today){
    try{
      if(start.difference(today).inDays >= 0){
        start = DateTime(start.year, start.month, start.day);
      } else {
        while(start.isBefore(today)){
          start = DateTime(start.year, start.month + 3, start.day);
        }      
      }
      return start;
    } catch(error){
      throw Exception('CashFlowProvider.getQuarterlyNextDate: ' + error.toString());
    }
  }  
  DateTime getYearlyNextDate(DateTime start, DateTime today){
    try{
      if(start.difference(today).inDays >= 0){
        start = DateTime(start.year, start.month, start.day);
      } else {
          while(start.isBefore(today)){
            start = DateTime(start.year + 1, start.month, start.day);
          }
      }
      return start;
    } catch(error){
      throw Exception('CashFlowProvider.getYearlyNextDate: ' + error.toString());
    }
  }  
  bool isBeforeOrEqual(DateTime before, DateTime check){
    try{
      if(before.isBefore(check) || areTwoDateEqual(before, check)){
        return true;
      } 
      return false;
    } catch(error){
      throw Exception('CashFlowProvider.isBeforeOrEqual: ' + error.toString());
    }
  }
  bool isAfterOrEqual(DateTime after, DateTime check){
    try{
      if(after.isAfter(check) || areTwoDateEqual(after, check)){
        return true;
      } 
      return false;
    } catch(error){
      throw Exception('CashFlowProvider.isAfterOrEqual: ' + error.toString());
    }
  }  
  
  OccurenceData occurencesSinceStart(DateTime start, DateTime today, int type){
    try{
      int noOccurences = 0;
      switch(type){
        case RecurrenceOptions.weekly:
          while(start.isBefore(today)){
            noOccurences++;
            start = DateTime(start.year, start.month, start.day + 7);
          }      
        break;
        case RecurrenceOptions.monthly:
          while(start.isBefore(today)){
            noOccurences++;
            start = DateTime(start.year, start.month + 1, start.day);
          }
        break;
        case RecurrenceOptions.yearly:
          while(start.isBefore(today)){
            noOccurences++;
            start = DateTime(start.year + 1, start.month, start.day);
          }      
        break;
        case RecurrenceOptions.quarterly:
          while(start.isBefore(today)){
            noOccurences++;
            start = DateTime(start.year, start.month + 3, start.day);
          }     
        break;
      }
      var oD = OccurenceData(nextDate: start, noPaid: noOccurences);
      return oD;
    } catch(error){
      throw Exception('CashFlowProvider.occurencesSinceStart: ' + error.toString());
    }
  }
  DateTime endOfthisMonth(DateTime start){
    start = DateTime(start.year, start.month, start.day + 1);
    while(start.day != 1){
      start = DateTime(start.year, start.month, start.day + 1);
    }
    start = DateTime(start.year, start.month, start.day - 1);
    return start;
  }
  double balanceAt(BuildContext context, DateFinish type, List<List<CashFlowItem>> cashFlowList){
    DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime toRun;
    bool _cashFlowDirty;

    switch(type){
      case DateFinish.this_day:
        toRun = today;
      break;
      case DateFinish.end_this_month:
        toRun = endOfthisMonth(today);
      break;
      case DateFinish.end_next_month:
        DateTime endMonth = endOfthisMonth(today);      
        endMonth = DateTime(endMonth.year, endMonth.month, endMonth.day + 1);
        toRun = endOfthisMonth(endMonth);      
      break;
    }
    _cashFlowDirty = cashFlowDirty; // Store cashFlow dirty before the run
    cashFlowList = fullCashFlow(context, toRun, cashFlowList);
    cashFlowDirty = _cashFlowDirty; // Put cashFlowDirty back to what is was before the 3 runs to honor a change by other classes
    List<CashFlowItem> cf = cashFlowList[cashFlowList.length - 1];
    CashFlowItem cfi = cf[cf.length - 1];
    cf = []; 
    return cfi.balance;    
  }
}