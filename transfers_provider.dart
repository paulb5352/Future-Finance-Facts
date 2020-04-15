import 'package:flutter/material.dart';
import '../screens/transfer_screen.dart';
import '../models/transfer.dart';
import '../helpers/DbHelper.dart';

class TransfersProvider with ChangeNotifier {

  String transferRouteName = TransferScreen.routeName;
  List<Transfer> _items = [];
  List<Transfer> get items => dirty ?  null : _items; 
  bool dirty = true;
  
  Future<void> addTransfer(Transfer aT) async {
    try{
      await DBHelper.insert(TransfersNames.tableName, {     
        TransfersNames.title: aT.title,
        TransfersNames.description: aT.description,
        TransfersNames.fromAccountId: aT.fromAccountId,
        TransfersNames.toAccountId: aT.toAccountId,
        TransfersNames.recurrenceId: aT.recurrenceId, 
        TransfersNames.plannedDate: aT.plannedDate,
        TransfersNames.amount: aT.amount,         
        TransfersNames.usedForCashFlow: aT.useForCashFlow,
      });
      dirty = true;
    } catch (error){
      throw Exception('TransferProvider.addTransfer: ' + error.toString());
    }
  }
  
  Future<void> updateTransfer(Transfer aT) async {
    try{
      await DBHelper.update(TransfersNames.tableName, aT.id, {     
        TransfersNames.title: aT.title,
        TransfersNames.description: aT.description,
        TransfersNames.fromAccountId: aT.fromAccountId,
        TransfersNames.toAccountId: aT.toAccountId,
        TransfersNames.recurrenceId: aT.recurrenceId, 
        TransfersNames.plannedDate: aT.plannedDate,  
        TransfersNames.amount: aT.amount,       
        TransfersNames.usedForCashFlow: aT.useForCashFlow,
      });
      dirty = true;
    } catch (error){
      throw Exception('TransferProvider.updateTransfer: ' + error.toString());
    }
    
  }
  Future<void> fetchAndSetTransfers() async {
    if(_items != null && _items.length != 0 && dirty == false) return;
    try{
      final dataList = await DBHelper.getData(TransfersNames.tableName);
      _items = dataList.map(
        (item) => Transfer(
          id: item[TransfersNames.id],
          title: item[TransfersNames.title],
          description: item[TransfersNames.description],
          fromAccountId: item[TransfersNames.fromAccountId],
          toAccountId: item[TransfersNames.toAccountId],
          recurrenceId: item[TransfersNames.recurrenceId],
          plannedDate: item[TransfersNames.plannedDate],
          amount: item[TransfersNames.amount],
          useForCashFlow: item[TransfersNames.usedForCashFlow] == 1 ? true : false,
        ), 
      ).toList();
      dirty = false;
    } catch (error){
      throw Exception('TransferProvider.fetchAndSetTransfers: ' + error.toString());
    }
  }

  
  Future<void> deleteTransaction(BuildContext context, int id) async{
    try{
      DBHelper.delete(TransfersNames.tableName, id);
      dirty = true;
      notifyListeners();
    } catch(error){
      throw Exception('TransferProvider.deleteTransaction: ' + error.toString());
    }
  }

  Transfer findById(int id) {
    try{
      return _items.firstWhere((transfer) => transfer.id == id, orElse: () => null);
    } catch (error){
      throw Exception('TransferProvider.findById: ' + error.toString());
    }
  } 

  bool canAccountBeDeleted(int id){
    try{
      bool ans = (null == _items.firstWhere((transfer) => transfer.toAccountId == id, orElse: () => null)) && (null == _items.firstWhere((transfer) => transfer.fromAccountId == id, orElse: () => null));
      return ans;
    } catch(error){
      throw Exception('TransferProvider.canAccountBeDeleted: ' + error.toString());
    }
  }  

  bool canRecurrenceBeDeleted(int id){
    try{
      bool ans = (null ==  _items.firstWhere((transfer) => transfer.recurrenceId == id, orElse: () => null));
      return ans;
    } catch(error){
      throw Exception('TransferProvider.canRecurrenceBeDeleted: ' + error.toString());
    }
  } 
}

class TransfersNames {
  static const id = 'id';
  static const title = 'title';
  static const description = 'description';
  static const fromAccountId = 'fromAccountId';
  static const toAccountId = 'toAccountId';
  static const recurrenceId = 'recurrenceId';
  static const plannedDate = 'plannedDate';
  static const amount = 'amount';
  static const usedForCashFlow = 'usedForCashFlow';
  static const tableName = 'transfers';  
}