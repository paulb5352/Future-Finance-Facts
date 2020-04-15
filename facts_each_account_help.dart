//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class FactsEachAccountHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Facts for each Account Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'If you have multiple accounts the App will calculate the ', style: HC.st),
                    TextSpan(text: 'Future Financial Facts', style: HC.stb),
                    TextSpan(text: ' for each account and the total of all accounts, as such you can examine all of the your accounts to ensure they are healthy. The total is very interesting but ', style: HC.st),
                    TextSpan(text: 'remember', style: HC.stb),
                    TextSpan(text: ' to view each single account, to ensure it does not incurr ', style: HC.st),
                    TextSpan(text: 'bank charges.', style: HC.stb),
                    TextSpan(text: '\n\nUse the dropdown box on the second box on the main screen to show the accounts you can view.', style: HC.st),
                    TextSpan(text: '\n\nWatch the YouTube video which shows how to do this.', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Facts for Each Account\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/LTL-eYzvU3o');
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