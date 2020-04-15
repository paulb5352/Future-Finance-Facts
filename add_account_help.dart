//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class AddAccountHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add an Account Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'To add an account open the side drawer menu and select Accounts', style: HC.st),
                    TextSpan(text: '\n\nFrom there enter the name, description and balance.', style: HC.st),
                    TextSpan(text: '\n\nUse in Financial Facts', style: HC.stb),
                    TextSpan(text: '\nThis is powerful feature of your App, this allows you to remove this account from the ', style: HC.st),
                    TextSpan(text: 'Future Financial Facts', style: HC.stb),
                    TextSpan(text: ' so you can see what effect this has upon your future', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Add Account\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/O0q58jlh3dk');
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