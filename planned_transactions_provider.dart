import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
//Screens
import '../screens/planned_transaction_screen.dart';
//Helpers
import '../helpers/DbHelper.dart';
//Models
import '../models/planned_transaction.dart';
import '../models/account.dart';
import '../models/category.dart';
//Providers
import '../providers/accounts_provider.dart';
import '../providers/categories_provider.dart';

class PlannedTransactionProvider with ChangeNotifier{

  String plannedTransactionRouteName = PlannedTransactionScreen.routeName;
  List<PlannedTransaction> _items = [];

  List<PlannedTransaction>  get items => dirty ?  null : _items;
  bool dirty = true;

  List<PlannedTransaction> getCopiedPlans(){
    List<PlannedTransaction> copied = [];
    for(var plan in _items){
      copied.add(plan.clone());
    }
    return copied;
  }

  void sortTransactions(BuildContext context, int type){
    try{
      if(_items == null || _items.length == 0) return;
      switch (type){
        case PlannedTransactionNames.byAccount:
          List<Account> accounts = Provider.of<AccountsProvider>(context).items;
          _items.sort((a, b) =>  accounts.firstWhere((account)=> account.id == a.accountId).accountName.compareTo(accounts.firstWhere((account)=> account.id == b.accountId).accountName)); //sort the transactions by the account name
        break;
        case PlannedTransactionNames.byCategory:
          List<Category> categories = Provider.of<CategoriesProvider>(context).items;
          _items.sort((a, b) =>  categories.firstWhere((category)=> category.id == a.categoryId).categoryName.compareTo(categories.firstWhere((category)=> category.id == b.categoryId).categoryName)); //sort the transactions by the account name
        break;
        case PlannedTransactionNames.byName:
          _items.sort((a, b) => a.title.compareTo(b.title));
        break;

      }
    } catch(error){
      throw Exception('PlannedTransactionProvider.sortTransactions: ' + error.toString());
    }
  }  
  
  Future<void> addTransaction(PlannedTransaction aT) async {
    try{
      await DBHelper.insert(PlannedTransactionNames.tableName, {     
        PlannedTransactionNames.title: aT.title,
        PlannedTransactionNames.description: aT.description,
        PlannedTransactionNames.accountId: aT.accountId,
        PlannedTransactionNames.categoryId: aT.categoryId,
        PlannedTransactionNames.recurrenceId: aT.recurrenceId, 
        PlannedTransactionNames.plannedDate: aT.plannedDate,
        PlannedTransactionNames.amount:  aT.amount,  
        PlannedTransactionNames.credit: aT.credit,       
        PlannedTransactionNames.usedForCashFlow: aT.useForCashFlow,
      });
      dirty = true;
    } catch(error){
      throw Exception('PlannedTransactionProvider.addTransaction: ' + error.toString());
    }
  }
  Future<void> updateTransaction(PlannedTransaction aT) async {
    try{
      await DBHelper.update(PlannedTransactionNames.tableName, aT.id, {     
        PlannedTransactionNames.title: aT.title,
        PlannedTransactionNames.description: aT.description,
        PlannedTransactionNames.accountId: aT.accountId,
        PlannedTransactionNames.categoryId: aT.categoryId,
        PlannedTransactionNames.recurrenceId: aT.recurrenceId, 
        PlannedTransactionNames.plannedDate: aT.plannedDate,  
        PlannedTransactionNames.amount: aT.amount,
        PlannedTransactionNames.credit: aT.credit,       
        PlannedTransactionNames.usedForCashFlow: aT.useForCashFlow,
      });
      dirty = true;
    } catch(error){
      throw Exception('PlannedTransactionProvider.updateTransaction: ' + error.toString());
    }
  }
  Future<void> fetchAndSetTransactions() async {
    try{
      if(_items != null && _items.length != 0 && dirty == false) return;
      final dataList = await DBHelper.getData(PlannedTransactionNames.tableName);
      _items = dataList.map(
        (item) => PlannedTransaction(
          id: item[PlannedTransactionNames.id],
          title: item[PlannedTransactionNames.title],
          description: item[PlannedTransactionNames.description],
          accountId: item[PlannedTransactionNames.accountId],
          categoryId: item[PlannedTransactionNames.categoryId],
          recurrenceId: item[PlannedTransactionNames.recurrenceId],
          plannedDate: item[PlannedTransactionNames.plannedDate],
          amount: item[PlannedTransactionNames.amount],
          credit: item[PlannedTransactionNames.credit] == 1 ? true : false,
          useForCashFlow: item[PlannedTransactionNames.usedForCashFlow] == 1 ? true : false,
        ), 
      ).toList();
      dirty = false;
    } catch(error){
      throw Exception('PlannedTransactionProvider.fetchAndSetTransactions: ' + error.toString());
    }
  }
  Future<void> deleteTransaction(BuildContext context, int id) async {
    try{
      await DBHelper.delete(PlannedTransactionNames.tableName, id);
      notifyListeners();
      dirty = true;
    } catch(error){
      throw Exception('PlannedTransactionProvider.deleteTransaction: ' + error.toString());
    }
  }

  PlannedTransaction findById(int id) {
    try{
      return _items.firstWhere((transaction) => transaction.id == id, orElse: null);
    } catch(error){
      throw Exception('PlannedTransactionProvider.findById: ' + error.toString());
    }
  }
  bool canAccountBeDeleted(int id){
    try{
      bool ans = (null == _items.firstWhere((transaction) => transaction.accountId == id, orElse: () => null));
      return ans;
    } catch(error){
      throw Exception('PlannedTransactionProvider.canAccountBeDeleted: ' + error.toString());
    }
  }
  bool canRecurenceBeDeleted(int id){
    try{
      bool ans = (null == _items.firstWhere((transaction) => transaction.recurrenceId == id, orElse: () => null));
      return ans;
    } catch(error){
      throw Exception('PlannedTransactionProvider.canRecurenceBeDeleted: ' + error.toString());
    }
  } 
  bool canCategoryBeDeleted(int id){
    try{
      bool ans = (null == _items.firstWhere((transaction) => transaction.categoryId == id, orElse: () => null));
      return ans;
    } catch(error){
      throw Exception('PlannedTransactionProvider.canCategoryBeDeleted: ' + error.toString());
    }
  }   
}

class PlannedTransactionNames {
  static const id = 'id';
  static const title = 'title';
  static const description = 'description';
  static const accountId = 'accountId';
  static const categoryId = 'categoryId';
  static const recurrenceId = 'recurrenceId';
  static const plannedDate = 'plannedDate';
  static const amount = 'amount';
  static const credit = 'credit';
  static const usedForCashFlow = 'usedForCashFlow';
  static const tableName = 'plannedTransactions';
  static const byName = 0;
  static const byAccount = 1;
  static const byCategory = 2;
}