import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/planned_transactions_provider.dart';
import '../providers/transfers_provider.dart';
import '../models/recurrence.dart';
import '../screens/recurrence_screen.dart';
import '../helpers/DbHelper.dart';

class RecurrencesProvider with ChangeNotifier {
  String recurrenceRouteName = RecurrenceScreen.routeName;
  List<Recurrence> _items = [];
  List<Recurrence> get items => dirty ?  null : _items; 
  bool dirty = true;

  Future<void> addRecurrence(Recurrence aR) async {
    try{
    await DBHelper.insert(RecurrenceNames.tableName, {     
      RecurrenceNames.title: aR.title,
      RecurrenceNames.description: aR.description,
      RecurrenceNames.iconPath: aR.iconPath,
      RecurrenceNames.type: aR.type,
      RecurrenceNames.noOccurences: aR.noOccurences,
      RecurrenceNames.endDate: aR.endDate,
    });
    dirty = true;
    } catch (error){
      throw Exception('RecurrencesProvider.addRecurrence: ' + error.toString());
    }
  }
  Future<void> updateRecurrence(Recurrence aR) async {
    try{
      await DBHelper.update(RecurrenceNames.tableName, aR.id, {     
        RecurrenceNames.title: aR.title,
        RecurrenceNames.description: aR.description,
        RecurrenceNames.iconPath: aR.iconPath,
        RecurrenceNames.type: aR.type,
        RecurrenceNames.noOccurences: aR.noOccurences,
        RecurrenceNames.endDate: aR.endDate
      });
      dirty = true;
    } catch (error){
      throw Exception('RecurrencesProvider.update: ' + error.toString());
    }
  }
  Future<void> fetchAndSetRecurrences() async {
    if(_items != null && _items.length != 0 && dirty == false) return;
    try{
      final dataList = await DBHelper.getData(RecurrenceNames.tableName);
        _items = dataList.map(
        (item) => Recurrence(
          id: item[RecurrenceNames.id],
          title: item[RecurrenceNames.title],
          description: item[RecurrenceNames.description],       
          iconPath: item[RecurrenceNames.iconPath],
          type: item[RecurrenceNames.type],
          noOccurences: item[RecurrenceNames.noOccurences],
          endDate: item[RecurrenceNames.endDate],
        ), 
      ).toList();
      dirty = false;
    } catch (error){
      throw Exception('RecurrencesProvider.fetchAndSetRecurrences: ' + error.toString());
    }
  }
  Future<void> deleteRecurrence(BuildContext context, int id) async {
    try{
      //Check no Planned Transactions have the recurranceId
      bool ans = Provider.of<PlannedTransactionProvider>(context, listen: false).canRecurenceBeDeleted(id);
      //Check no Transfers have the recurranceId
      if(ans) ans = Provider.of<TransfersProvider>(context, listen: false).canRecurrenceBeDeleted(id);
      //If so show a dialog saying it can't be removed.
      if(ans){
        DBHelper.delete(RecurrenceNames.tableName, id);
        dirty = true;
        notifyListeners();
      } else {
        showDialog(context: context, builder: (context) => AlertDialog(title: Text('Can not delete recurrence'), content: Text('Transer or Transaction is linked to this Recurrence'),actions: <Widget>[FlatButton(child: Text('OK'),onPressed: (){Navigator.of(context).pop();},),],),);
      }      
    } catch (error){
      throw Exception('RecurrencesProvider.deleteRecurrence: ' + error.toString());
    }
  }
  findById(int id) {
    try{
      return _items.firstWhere((recurrence) => recurrence.id == id, orElse: () => null);
    } catch (error){
      throw Exception('RecurrencesProvider.findById: ' + error.toString());
    }
  }
  List<String> imageList(){
    List<String> images = [];
    images.add('assets/images/recurrence_icons/r001.jpg');
    images.add('assets/images/recurrence_icons/r002.jpg');
    images.add('assets/images/recurrence_icons/r003.jpg');
    images.add('assets/images/recurrence_icons/r004.jpg');
    images.add('assets/images/recurrence_icons/r005.jpg');
    images.add('assets/images/recurrence_icons/r006.jpg');
    images.add('assets/images/recurrence_icons/r007.jpg');
    images.add('assets/images/recurrence_icons/r008.jpg');
    images.add('assets/images/recurrence_icons/r009.jpg');
    images.add('assets/images/recurrence_icons/r010.jpg');
    images.add('assets/images/recurrence_icons/r011.jpg');
    images.add('assets/images/recurrence_icons/r012.jpg');
    images.add('assets/images/recurrence_icons/r013.jpg');
    images.add('assets/images/recurrence_icons/r014.jpg');
    images.add('assets/images/recurrence_icons/r015.jpg');
    images.add('assets/images/recurrence_icons/r016.jpg');
    images.add('assets/images/recurrence_icons/r017.jpg');
    images.add('assets/images/recurrence_icons/r018.jpg');
    images.add('assets/images/recurrence_icons/r019.jpg');
    images.add('assets/images/recurrence_icons/r020.jpg');
    images.add('assets/images/recurrence_icons/r021.jpg');
    images.add('assets/images/recurrence_icons/r022.jpg');
    images.add('assets/images/recurrence_icons/r023.jpg');
    images.add('assets/images/recurrence_icons/r024.jpg');
    images.add('assets/images/recurrence_icons/r025.jpg');
    images.add('assets/images/recurrence_icons/r026.jpg');
    images.add('assets/images/recurrence_icons/r027.jpg');
    images.add('assets/images/recurrence_icons/r028.jpg');
    images.add('assets/images/recurrence_icons/r029.jpg');
    images.add('assets/images/recurrence_icons/r030.jpg');
    images.add('assets/images/recurrence_icons/r031.jpg');
    images.add('assets/images/recurrence_icons/r032.jpg');
    images.add('assets/images/recurrence_icons/r033.jpg');
    images.add('assets/images/recurrence_icons/r034.jpg');
    images.add('assets/images/recurrence_icons/r035.jpg');
    images.add('assets/images/recurrence_icons/r036.jpg');
    images.add('assets/images/recurrence_icons/r037.jpg');
    images.add('assets/images/recurrence_icons/r038.jpg');
    images.add('assets/images/recurrence_icons/r039.jpg');
    images.add('assets/images/recurrence_icons/r040.jpg');
    images.add('assets/images/recurrence_icons/r041.jpg');
    images.add('assets/images/recurrence_icons/r042.jpg');
    images.add('assets/images/recurrence_icons/r043.jpg');
    images.add('assets/images/recurrence_icons/r044.jpg');
    images.add('assets/images/recurrence_icons/r045.jpg');
    images.add('assets/images/recurrence_icons/r046.jpg');
    images.add('assets/images/recurrence_icons/r047.jpg');
    images.add('assets/images/recurrence_icons/r048.jpg');
    images.add('assets/images/recurrence_icons/r049.jpg');
    images.add('assets/images/recurrence_icons/r050.jpg');
    images.add('assets/images/recurrence_icons/r051.jpg');
    images.add('assets/images/recurrence_icons/r052.jpg');
    images.add('assets/images/recurrence_icons/r053.jpg');
    images.add('assets/images/recurrence_icons/r054.jpg');
    images.add('assets/images/recurrence_icons/r055.jpg');
    images.add('assets/images/recurrence_icons/r056.jpg');
    images.add('assets/images/recurrence_icons/r057.jpg');
    images.add('assets/images/recurrence_icons/r058.jpg');
    images.add('assets/images/recurrence_icons/r059.jpg');
    images.add('assets/images/recurrence_icons/r060.jpg');
    images.add('assets/images/recurrence_icons/r061.jpg');
    images.add('assets/images/recurrence_icons/r062.jpg');
    images.add('assets/images/recurrence_icons/r063.jpg');
    images.add('assets/images/recurrence_icons/r064.jpg');
    images.add('assets/images/recurrence_icons/r065.jpg');
    images.add('assets/images/recurrence_icons/r066.jpg');
    images.add('assets/images/recurrence_icons/r067.jpg'); 
    images.add('assets/images/recurrence_icons/r068.jpg');
    images.add('assets/images/recurrence_icons/r069.jpg');
    images.add('assets/images/recurrence_icons/r070.jpg');
    images.add('assets/images/recurrence_icons/r071.jpg');
    images.add('assets/images/recurrence_icons/r072.jpg');
    images.add('assets/images/recurrence_icons/r073.jpg');
    images.add('assets/images/recurrence_icons/r074.jpg');
    images.add('assets/images/recurrence_icons/r075.jpg');
    images.add('assets/images/recurrence_icons/r076.jpg');
    images.add('assets/images/recurrence_icons/r077.jpg');
    images.add('assets/images/recurrence_icons/r078.jpg');
    images.add('assets/images/recurrence_icons/r079.jpg');
    images.add('assets/images/recurrence_icons/r080.jpg');
    images.add('assets/images/recurrence_icons/r081.jpg');
    images.add('assets/images/recurrence_icons/r082.jpg');
    images.add('assets/images/recurrence_icons/r083.jpg');
    images.add('assets/images/recurrence_icons/r084.jpg');
    images.add('assets/images/recurrence_icons/r085.jpg');
    images.add('assets/images/recurrence_icons/r086.jpg');
    images.add('assets/images/recurrence_icons/r087.jpg');               
    return images;
  }
}

class RecurrenceNames{

  static const id = 'id';
  static const title = 'title';
  static const description = 'description';
  static const iconPath = 'iconPath';
  static const type = 'type';
  static const noOccurences = 'noOcurrences';
  static const endDate = 'endDate'; 
  static const tableName = 'recurences'; 
}

class RecurrenceOptions{

  static const weekly = 0;
  static const monthly  = 1;
  static const quarterly = 2;  
  static const yearly = 3;

  static const weeklyT = 'Weekly';
  static const monthlyT = 'Monthly';
  static const yearlyT = 'Yealy';
  static const quarterlyT = 'Quarterly';

  static String getTypeName(int typeNo){
    switch (typeNo){
      case weekly:
        return weeklyT;
      case monthly:
        return monthlyT;
      case yearly:
        return yearlyT;
      case quarterly:
        return quarterlyT;
    }
  }
}
class OccurenceData{
  DateTime nextDate;
  int noPaid;
  OccurenceData({this.nextDate, this.noPaid});
}