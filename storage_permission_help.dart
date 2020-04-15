//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class StoragePermissionHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Storage Permission Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'The App requires your permission for \'Storage\' on your device.', style: HC.st),
                    TextSpan(text: '\n\nIt needs this to either create a file or to open one you have previously created.', style: HC.st),
                    TextSpan(text: '\n\nWithout this permission will create an ', style: HC.st),
                    TextSpan(text: 'error', style: HC.stb),
                    TextSpan(text: ' and will fail. This is simple to solve.', style: HC.st),
                    TextSpan(text: '\n\nOpen Settings and then Apps, however, the version of Adroid may now affect what you do.', style: HC.st),
                    TextSpan(text: '\n\nOn earlier versions you select the App and then click permissions.', style: HC.st),
                    TextSpan(text: '\n\nOn later versions you select permissions and then the App.', style: HC.st),
                    TextSpan(text: '\n\nThe YouTube video shows both methods using Android 6 and Android 9 phones that shows the difference approach.', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Storage Permission\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/iVAOITTlm6Y');
                    },
                  style: HC.stbl),],
                ), 
              ),              
            ],
          ),
        ),
      ),
      
    );
  }
}