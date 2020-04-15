import 'package:flutter/material.dart';
import '../settings/help_setting.dart';


class HelpListSetting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {    
       
    return ListTile(
      
      title: Text('Help Menu...'),
      subtitle: Text('Press the icon to load help...', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
      trailing: Container(
        child: IconButton(
          icon: Icon(Icons.help),
          onPressed:() => Navigator.push(context,MaterialPageRoute(builder: (context) => HelpSetting()),
        ),
      ),      
    )
    );
  }
}