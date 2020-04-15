import 'package:flutter/foundation.dart';
import '../helpers/DbHelper.dart';
import '../models/setting.dart';

class SettingsProvider with ChangeNotifier {

final cS = 0;
final eD = 1;
final fS = 2;

final settingSymbols = [
    {'Dollar': '\u0024', 'Pound': '\u00A3', 'Yen': '\u00A5', 'Euro': '\u20AC'}, 
    {'next': 'one', 'then': 'two', 'all': 'three'}
  ];  

 List<Setting> _items = [];
  List<Setting> get items {
    return _items;
  }
  Future<void> addSettings(Setting sG) async {
    try{
      await DBHelper.insert(SettingNames.tableName, {     
        SettingNames.id: sG.id,
        SettingNames.identifier: sG.identifier,
        SettingNames.value: sG.value,
      });
    } catch(error){
      throw Exception('SettingsProvider.addSettings: ' + error.toString());
    }
  }

  Future<void> updateSetting(Setting sG) async {
    try{
      await DBHelper.update(SettingNames.tableName, sG.id, {
        SettingNames.value: sG.value,
        SettingNames.identifier: sG.identifier, 
      }    
    );
    notifyListeners(); //The one and only needed, due to being on the same screen
    } catch(error){
      throw Exception('SettingsProvider.updateSetting: ' + error.toString());
    }
  }

  Future<void> fetchAndSetSettings() async {
    try{
    final dataList = await DBHelper.getData(SettingNames.tableName);
    if(dataList.length > 0){
      _items = dataList.map(
        (item) => Setting(
          id: item[SettingNames.id],
          identifier: item[SettingNames.identifier],
          value: item[SettingNames.value],
        ), 
      ).toList();      
    } else {
      _items = [];
    }

    } catch(error){
       debugPrint('I was in fetchAndSetSettings in settings provider');
      throw Exception('SettingsProvider.fetchAndSetSettings: ' + error.toString());
     
    }
  }

  Setting findById(int id) {
    try{
      return _items.firstWhere((setting) => setting.id == id);
    } catch(error){
      throw Exception('SettingsProvider.findById: ' + error.toString());
    }      
  }

  Setting findCurrency() {
    try{
      return _items.firstWhere((setting) => setting.identifier == 'currency');
    } catch(error){
      throw Exception('SettingsProvider.findCurrency: ' + error.toString());
    }    
  }
  Setting findEndDate(){
    try{
      return _items.firstWhere((setting) => setting.identifier == 'EndDate');
    } catch(error){
      throw Exception('SettingsProvider.findEndDate: ' + error.toString());
    }    
  }
}

class SettingNames{
  static const c_dollar = 0;
  static const c_pound = 1;
  static const c_yen = 2;
  static const c_euro = 3;
  static const id = 'id';
  static const value = 'value';
  static const identifier = 'identifier';
  static const tableName = 'settings';
  static const currencyNames = ['Dollar', 'Pound', 'Yen', 'Euro'];
}