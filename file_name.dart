import 'package:flutter/material.dart';
//Providers
import '../providers/settings_provider.dart';
import 'package:provider/provider.dart';
import '../models/setting.dart';

class FileName extends StatelessWidget {

  final String _identifier;
  final String _value;
  final SettingsProvider _sp;
  final int _index;

  FileName(this._index, this._identifier, this._value, this._sp);


  final _titleController = TextEditingController();

  String updateFileName(BuildContext context){
    List<Setting> st = Provider.of<SettingsProvider>(context, listen: false).items;
    return st[2].value;
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = updateFileName(context);
    return 
      Container(
        margin: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Text('File name for the file used for saving and opening, eg: for macf.txt enter macf'),
          Row(children: <Widget>[
            Expanded(
              child: TextField(                        
                decoration: InputDecoration(labelText: 'File Name', icon: Icon(Icons.folder)),
                controller: _titleController,                 
              ),
            ),
            FlatButton(
              child: Text('Save'),
              onPressed: (){  
                if(_titleController.text.length == 0){
                  showDialog(
                    context: context,
                    builder: (context) =>   
                    AlertDialog(
                      title: Text('File name must contain a valid name'), 
                      content: Text('For macf.txt enter macf in the field'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('OK'),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                  return;
                }             
                _sp.items[_index].value = _titleController.text;  //Save the file to settings using provider etc
                _sp.updateSetting(_sp.items[_index]); 
                _sp.fetchAndSetSettings();                                                
            },
            ),
          ],),           
        ],),
      );      
  }
}