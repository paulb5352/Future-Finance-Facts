//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class OpenSaveHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Open and Save Files Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Backup: ', style: HC.stb),
                    TextSpan(text: 'You can backup your work by saving a file in your downloads folder. You can easily find the file and choose where to save it.', style: HC.st),
                    TextSpan(text: '\n\nUse email to send it to your computer.', style: HC.st),
                    TextSpan(text: '\n\nUse Google Drive or Dropbox apps to transfer the file to them.', style: HC.st),
                    TextSpan(text: '\n\nYou can choose the name of the file before you save your work.', style: HC.st),
                    TextSpan(text: '\n\nSave: ', style: HC.stb),
                    TextSpan(text: '\nYou can save your work in a file so that you can open a different file. Some users use more than one set of data, for example a sole trader may have one set of data for their work, and another for their family. You can use as many sets of data as you wish.', style: HC.st),
                    TextSpan(text: '\n\nOpen: ', style: HC.stb),
                    TextSpan(text: '\nYou can open a previously saved file. You can specify the file name. This enables you to transfer your data to a new phone or tablet easily. It can also be used for using more than one set of data.', style: HC.st),
                    TextSpan(text: '\n\nWARNING ALL PREVIOUS DATA WILL DISSAPEAR', style: HC.stbr),
                    TextSpan(text: '\n\nWatch the YouTube video that describles how to save and open files.', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Open and Save files\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/nqNTVJ2l07k');
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