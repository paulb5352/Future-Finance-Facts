import 'package:cash_flow/providers/transfers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../providers/planned_transactions_provider.dart';
import '../helpers/DbHelper.dart';
import '../models/account.dart';
import '../screens/account_screen.dart';
import 'package:provider/provider.dart';

class AccountsProvider with ChangeNotifier {
  
  String accountRouteName = AccountScreen.routeName;
  List<Account> _items = [];
  List<Account> get items => dirty ?  null : _items;
  bool dirty = true;   
  
  Future<void> addAccount(Account aC) async {

   try{
    await DBHelper.insert(AccountNames.tableName, {     
        AccountNames.accountName: aC.accountName,
        AccountNames.description: aC.description,
        AccountNames.balance: aC.balance,
        AccountNames.usedForCashFlow: aC.usedForCashFlow,
        AccountNames.usedForSummary: aC.usedForSummary,
      });
      dirty = true;
   } catch (error){
     throw Exception ('Provider.addAccount ' + error.toString());
   }
  }
  Future<void> updateAccount(Account aC) async {
   
    try{
      await DBHelper.update(AccountNames.tableName, aC.id, {     
        AccountNames.accountName: aC.accountName,
        AccountNames.description: aC.description,
        AccountNames.balance: aC.balance,
        AccountNames.usedForCashFlow: aC.usedForCashFlow,
        AccountNames.usedForSummary: aC.usedForSummary,      
      }); 
      dirty = true;
    } catch(error){
      throw Exception('AccountProvider.update ' + error.toString());
    }
      
  }
  Future<void> fetchAndSetAccounts() async {
    try{
      if(_items != null && _items.length != 0 && dirty == false) return;
      final dataList = await DBHelper.getData(AccountNames.tableName);
      _items = dataList.map(
        (item) => Account(
          id: item[AccountNames.id],
          accountName: item[AccountNames.accountName],
          description: item[AccountNames.description],
          balance: item[AccountNames.balance],
          usedForCashFlow: item[AccountNames.usedForCashFlow] == 1 ? true : false,
          usedForSummary: item[AccountNames.usedForSummary] == 1 ? true : false,
        ), 
      ).toList();
      dirty = false;
    } catch (error){
      throw Exception('AccountsProvider.fetchandset: ' + error.toString());
    }
    // debugPrint(dataList);
  }
  Future<void> deleteAccount(BuildContext context, int id) async {
    try{
      //Check no Planned Transactions have the accountId
      bool ans = Provider.of<PlannedTransactionProvider>(context, listen: false).canAccountBeDeleted(id);
      //Check no Transfers have the toAccountId or fromAccountId
      if(ans) ans = Provider.of<TransfersProvider>(context, listen: false).canAccountBeDeleted(id);
      //If so show a dialog saying it can't be removed.
      if(ans){
        DBHelper.delete(AccountNames.tableName, id);
        dirty = true;
        notifyListeners();
      } else {
        showDialog(context: context, builder: (context) => AlertDialog(title: Text('Can not delete account'), content: Text('Transer or Transaction is linked to this account'),actions: <Widget>[FlatButton(child: Text('OK'),onPressed: (){Navigator.of(context).pop();},),],),);
      }      
    } catch (error){
      throw Exception('AccountsProvider.deleteAccount: ' + error.toString());
    }
  }

  Account findById(int id) {
    try{
      return _items.firstWhere((account) => account.id == id, orElse: () => null);
    } catch (error){
      throw Exception('AccountsProvider.findById: ' + error.toString());
    }
  }
}

class AccountNames {
  static const id = 'id';
  static const accountName = 'accountName';
  static const description = 'description';
  static const balance = 'balance';
  static const usedForCashFlow = 'usedForCashFlow';
  static const usedForSummary = 'usedForSummary';
  static const tableName = 'accounts';
}