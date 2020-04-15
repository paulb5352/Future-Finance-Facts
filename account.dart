import 'package:cash_flow/models/cash_flow_item.dart';
import 'package:flutter/material.dart';
import './cash_action.dart';
import './cash_flow_item.dart';
import '../providers/cash_flow_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class Account {
  int id;
  String accountName;
  String description;
  double balance;
  bool usedForCashFlow = true;
  bool usedForSummary = true;
  List<CashAction> actions = [];
  List<CashFlowItem> cashFlow = [];
  Account({
    @required this.id,
    @required this.accountName,
    @required this.description,
    @required this.balance,
    this.usedForCashFlow = true,
    this.usedForSummary = false,
  });
  void buildCashFlow(){
    try{
      DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      cashFlow.add(CashFlowItem(action: CashAction(tb: null, plannedDate: today, amount: balance, account: this), balance: balance));
      int i = 0;
      for(var action in actions){
        cashFlow.add(CashFlowItem(balance: action.amount + cashFlow[i].balance, action: action));
        i++;
      }
      // now set account = [];
    } catch(error){
      throw Exception('account.buildCashFlow: ' + error.toString());
    }
  }

  List<CashFlowItem> compressCashFlow(CashFlowProvider cfp){
    try{
      int i = 0;
      while(i + 1 < cashFlow.length){
        CashFlowItem current = cashFlow[i];
        CashFlowItem next = cashFlow[i + 1];
        if(cfp.areTwoDateEqual(current.action.plannedDate, next.action.plannedDate)){
          current.isMulti = true;
          if(current.actions == null) current.actions = [];
          current.actions.add(next.action);
          current.balance = next.balance;
          cashFlow.removeAt(i + 1);  
        } else {
          i++;
        }      
      } 
      return cashFlow; 
    } catch(error){
      throw Exception('account.compressCashFlow: ' + error.toString());
    }  
  }
  void printCashFlow(BuildContext context){
    try{
      bool printit = false;
      var max = 0.0;
      var min = 0.0;
      for(var cfi in cashFlow){
        if (cfi.balance > max) max = cfi.balance;
        if (cfi.balance < min) min = cfi.balance;
      }
      printit ? debugPrint ('max is : ' + max.toStringAsFixed(2)) : null;
      if(printit) debugPrint ('min is : ' + min.toStringAsFixed(2));

      
      for(var cfi in cashFlow){
        
        var provider = Provider.of<SettingsProvider>(context, listen: false);
        final currencySetting = provider.findCurrency();
        var numb = NumberFormat.currency(symbol: provider.settingSymbols[0][currencySetting.value], decimalDigits: 0); 
        var datt = DateFormat('dd/MM/yy');
             
        cfi.summary = datt.format(cfi.action.plannedDate) + ' ' +  numb.format(cfi.balance);
        String output = '';
        if(cfi.isMulti){
          output = output + 'Multi : \n';
          output = output + (cfi.action.tb == null ? 'Start of Cash Flow : ' + numb.format(this.balance) : cfi.action.tb.title + ' : ' + numb.format(cfi.action.amount));
          for(var action_a in cfi.actions){          
            output = output + '\n' + (action_a.tb == null ? 'Start of Cash Flow' : action_a.tb.title + ' : ' + numb.format(action_a.amount));
          }
        } else {
          output = (cfi.action.tb == null ? 'Start of Cash Flow' : numb.format(cfi.action.amount) + ' : ' + cfi.action.tb.title);
        }
        cfi.dialogData = output;
        if(printit) debugPrint(
          cfi.balance.toStringAsFixed(2) 
          + ' : ' + cfi.action.plannedDate.year.toString() 
          + ' : ' + cfi.action.plannedDate.month.toString() 
          + ' : ' + cfi.action.plannedDate.day.toString()
          + ' : ' +  output
        );
      }
    } catch (error){
      throw Exception('account.printCashFlow: ' + error.toString());
    }
  }

}
