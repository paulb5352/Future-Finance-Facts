import 'package:flutter/material.dart';
import '../providers/settings_provider.dart';
import 'package:provider/provider.dart';
//Settings
import './currency_settings.dart';
import './end_date_settings.dart';
import './backup_list_setting.dart';
import './restore_list_setting.dart';
import './file_name.dart';
import './help_list_setting.dart';
import './mortgage_list_setting.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = 'SettingsScreen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  Future<void> _refreshSettings(BuildContext context, ) async {
    try{
      await Provider.of<SettingsProvider>(context, listen: true).fetchAndSetSettings();   //True to listening here
    } catch (error) {
      //debugPrint('I was here for certain');
      throw Exception('SettingsScreen._refreshSettings: ' + error.toString());
      
    }   
  }
  Widget _checkSettings(SettingsProvider sp){
    
    if(sp != null && sp.items != null && sp.items.length > 1) {
      return Column(children: <Widget>[
        BackupListSetting(sp.items[2].value),
        Divider(thickness: 1.0,),        
        RestoreListSetting(),
        Divider(thickness: 1.0,),                
        FileName(2, sp.items[2].identifier, sp.items[2].value ,sp),
        Divider(thickness: 1.0,),        
        CurrencySettings(0, sp.items[0].identifier, sp.settingSymbols[0][sp.items[0].value] ,sp),
        Divider(thickness: 1.0,), 
        EndDateSettings(1, sp.items[1].identifier, sp.settingSymbols[1][sp.items[1].value] ,sp),
        Divider(thickness: 1.0,),
      ],);     
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    try{
      return Scaffold(
      appBar: AppBar(title: Text('Settings',),),
        body: FutureBuilder(
          future: _refreshSettings(context),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshSettings(context),
                      child: Consumer<SettingsProvider>( 
                        builder: (context, sD, _) => Padding(
                          padding: EdgeInsets.all(8), 
                          child: SingleChildScrollView(
                              child: Column(
                              children: <Widget>[
                                _checkSettings(sD),
                                HelpListSetting(),
                                Divider(thickness: 1.0,),
                                MortgageListSettings(),
                                                                                                                                                                 
                              ],
                            ),
                          ),                       
                        ),
                      ),
                    ),
        ),    
      );
    } catch(error){
      throw Exception('SettingsScreen.build: ' + error.toString());
      
    }
  }
}