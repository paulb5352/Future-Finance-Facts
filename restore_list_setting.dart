import 'package:flutter/material.dart';
import '../settings/restore_setting.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../models/setting.dart';

class RestoreListSetting extends StatelessWidget {

  
  RestoreListSetting();

  String updateFileName(BuildContext context){
    List<Setting> st = Provider.of<SettingsProvider>(context, listen: false).items;
    return st[2].value;
  }

  @override
  Widget build(BuildContext context) {   
    String _fileName; 
    _fileName = updateFileName(context);
    return ListTile(
      // leading: Text('Backup'),
      title: Text('Open file, press icon to start, all existing data will be lost'),
      subtitle: Text('Your file (eg: $_fileName.txt) must be in your downloads foloder', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
      trailing: Container(
        child: IconButton(
          icon: Icon(Icons.restore),
          onPressed:() {
            showDialog(
              context: context, 
              builder: (context) => AlertDialog(
                title: Text('Open file $_fileName.txt'), 
                content: Text('All exisiting data will be lost.'),
                actions: <Widget>[
                  Column(children: <Widget>[
                    Row(children: <Widget>[
                      FlatButton(
                        child: Text('Cancel'),
                        onPressed: (){
                          Navigator.pop(context);                         
                        },
                      ),                       
                      FlatButton(
                        child: Text('OK'),
                        onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(context,MaterialPageRoute(builder: (context) => RestoreSettings(_fileName)));
                        },
                      ),
                     
                    ],),
                  ],
                  
                  ),
                ],
              ),
            );                           
          }           
        ),
      ),      
    );    
  }
}