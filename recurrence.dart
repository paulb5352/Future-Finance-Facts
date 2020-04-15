//System
import 'package:flutter/widgets.dart';
//Providers
import 'package:cash_flow/providers/cash_flow_provider.dart';
import 'package:cash_flow/providers/recurrences_provider.dart';
//Models
import './trans_base.dart';
import './cash_action.dart';
import './account.dart';


class Recurrence {
  final int id;
  String title;
  String description;
  String iconPath;
  int type;
  int noOccurences;
  String endDate;

  Recurrence({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.iconPath,
    @required this.type,
    this.noOccurences,
    this.endDate
  });


  List<CashAction> processTransBase(DateTime cfend, TransBase tb, CashFlowProvider cfp, Account account){
    try{
      var today = DateTime.now();
      today = DateTime(today.year, today.month, today.day);
      DateTime nextDate;
      DateTime start = DateTime.tryParse(tb.plannedDate);

      if(start == null) return null;
      List<CashAction> actions = [];
      
      var c = noOccurences ?? 0;
      if(c == 0 && endDate == null){
        actions = justCashFlowEnd(nextDate, cfp, start, today, cfend, tb, tb.amount, account);
      }
      if(c > 0 && endDate == null){
        actions = justOccurences(nextDate, cfp, start, today, cfend, tb, tb.amount, account);
      }
      if(c == 0 && endDate != null){
        actions = justEndDate(nextDate, cfp, start, today, cfend, tb, tb.amount, account);
      }
      return actions;
    } catch(error){
      throw Exception('recurrence.processTransBase: ' + error.toString());
    }
  }  

  List<CashAction> justEndDate(DateTime nextDate, CashFlowProvider cfp, DateTime start, DateTime today, DateTime cfend, TransBase tb, double amount, Account account){
    try{
      List<CashAction> actions = [];
      DateTime endDateDate = DateTime.tryParse(endDate);
      switch(type){
        case RecurrenceOptions.weekly:
          nextDate = cfp.getWeeklyNextDate(start, today);
          while(cfp.isBeforeOrEqual(nextDate, cfend) && cfp.isBeforeOrEqual(nextDate, endDateDate)){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            nextDate = DateTime(nextDate.year, nextDate.month, nextDate.day + 7);
            actions.add(action);
          }        
        break;
        case RecurrenceOptions.monthly:                 
          nextDate = cfp.getMonthlyNextDate(start, today);
          while(cfp.isBeforeOrEqual(nextDate, cfend) && cfp.isBeforeOrEqual(nextDate, endDateDate)){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            nextDate = DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
            actions.add(action);
          }
        break;
        case RecurrenceOptions.yearly:          
          nextDate = cfp.getYearlyNextDate(start, today);
          while(cfp.isBeforeOrEqual(nextDate, cfend) && cfp.isBeforeOrEqual(nextDate, endDateDate)){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            nextDate = DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
            actions.add(action);
          }        
        break;
        case RecurrenceOptions.quarterly:
          nextDate = cfp.getQuarterlyNextDate(start, today);
          while(cfp.isBeforeOrEqual(nextDate, cfend) && cfp.isBeforeOrEqual(nextDate, endDateDate)){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            nextDate = DateTime(nextDate.year, nextDate.month + 3, nextDate.day);
            actions.add(action);
          }
        break;
      }
      return actions;
    } catch(error){
      throw Exception('recurrence.justEndDate: ' + error.toString());
    }
  }

  List<CashAction> justOccurences(DateTime nextDate, CashFlowProvider cfp, DateTime start, DateTime today, DateTime cfend, TransBase tb, double amount, Account account){
    try{
      List<CashAction> actions = [];
      switch(type){
        case RecurrenceOptions.weekly:
          OccurenceData oD = cfp.occurencesSinceStart(start, today, RecurrenceOptions.weekly);                 
          nextDate = oD.nextDate;
          int noBeenPaid = oD.noPaid;
          while(cfp.isBeforeOrEqual(nextDate, cfend) && noBeenPaid < noOccurences ){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            noBeenPaid++;
            nextDate = DateTime(nextDate.year, nextDate.month, nextDate.day + 7);
            actions.add(action);
          }        
        break;
        case RecurrenceOptions.monthly:
          OccurenceData oD = cfp.occurencesSinceStart(start, today, RecurrenceOptions.monthly);                 
          nextDate = oD.nextDate;
          int noBeenPaid = oD.noPaid;
          while(cfp.isBeforeOrEqual(nextDate, cfend) && noBeenPaid < noOccurences ){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            noBeenPaid++;
            nextDate = DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
            actions.add(action);
          }
        break;
        case RecurrenceOptions.yearly:          
          OccurenceData oD = cfp.occurencesSinceStart(start, today, RecurrenceOptions.yearly);                 
          nextDate = oD.nextDate;
          int noBeenPaid = oD.noPaid;
          while(cfp.isBeforeOrEqual(nextDate, cfend) && noBeenPaid < noOccurences ){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            noBeenPaid++;
            nextDate = DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
            actions.add(action);
          }        
        break;
        case RecurrenceOptions.quarterly:
          OccurenceData oD = cfp.occurencesSinceStart(start, today, RecurrenceOptions.quarterly);                 
          nextDate = oD.nextDate;
          int noBeenPaid = oD.noPaid;
          while(cfp.isBeforeOrEqual(nextDate, cfend) && noBeenPaid < noOccurences ){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            noBeenPaid++;
            nextDate = DateTime(nextDate.year, nextDate.month + 3, nextDate.day);
            actions.add(action);
          }
        break;
      }
      return actions;
    } catch(error){
      throw Exception('recurrence.justOccurences: ' + error.toString());
    }
  }

  List<CashAction> justCashFlowEnd(DateTime nextDate, CashFlowProvider cfp, DateTime start, DateTime today, DateTime cfend, TransBase tb, double amount, Account account){
    try{
      List<CashAction> actions = [];
      switch(type){
        case RecurrenceOptions.weekly:
          nextDate = cfp.getWeeklyNextDate(start, today);
          while(cfp.isBeforeOrEqual(nextDate, cfend)){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            nextDate = DateTime(nextDate.year, nextDate.month, nextDate.day + 7);
            actions.add(action);
          }        
        break;
        case RecurrenceOptions.monthly:                 
          nextDate = cfp.getMonthlyNextDate(start, today);
          while(cfp.isBeforeOrEqual(nextDate, cfend)){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            nextDate = DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
            actions.add(action);
          }
        break;
        case RecurrenceOptions.yearly:          
          nextDate = cfp.getYearlyNextDate(start, today);
          while(cfp.isBeforeOrEqual(nextDate, cfend)){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            nextDate = DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
            actions.add(action);
          }        
        break;
        case RecurrenceOptions.quarterly:
          nextDate = cfp.getQuarterlyNextDate(start, today);
          while(cfp.isBeforeOrEqual(nextDate, cfend)){
            CashAction action = CashAction(tb: tb, account: account, amount: amount, plannedDate: nextDate);
            nextDate = DateTime(nextDate.year, nextDate.month + 3, nextDate.day);
            actions.add(action);
          }
        break;
      }
      return actions;
    } catch(error){
      throw Exception('recurrence.justCashFlowEnd: ' + error.toString());
    }
  }
}
