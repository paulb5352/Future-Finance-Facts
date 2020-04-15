//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class ChangeCurrencyHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Currency Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'You can choose between the Dollar, the Pound, the Euro and the Renminbi.', style: HC.st),
                    TextSpan(text: '\n\nThe currency symbol is shared accross all accounts and, currently, no action is taken for the difference in currency values, as such, all accounts share the same currency', style: HC.st),
                    TextSpan(text: '\n\nSimply open ', style: HC.st),
                    TextSpan(text: 'Settings', style: HC.stb),
                    TextSpan(text: ' and click on the right hand side icon to select the new currency, once set it will show in all currency symbols.', style: HC.st),
                    TextSpan(text: ' \n\nIf you would like another currency symbol, contact the developer using Google Play.', style: HC.st),
                    TextSpan(text: ' \n\nIf you would like each account to have different currencies, contact the developer using Google Play.', style: HC.st),
                    TextSpan(text: '\n\nWatch the YouTube video that describles how to change your currency symbol', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Change Currency\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/HVsKjhsVq5c');
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