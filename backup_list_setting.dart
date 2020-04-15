import 'package:flutter/material.dart';
import '../settings/backup_settings.dart';

class BackupListSetting extends StatelessWidget {

  final String _fileName;

  BackupListSetting(this._fileName);

  @override
  Widget build(BuildContext context) {    
       
    return ListTile(
      // leading: Text('Backup'),
      title: Text('Save File...'),
      subtitle: Text('Press the icon to start...', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
      trailing: Container(
        child: IconButton(
          icon: Icon(Icons.backup),
          onPressed:() => Navigator.push(context,MaterialPageRoute(builder: (context) => BackupSettings(_fileName)),
        ),
      ),      
    )
    );
  }
}