//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class AddMortgageHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Morgage Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'To add your mortgage, which is paid out on a regular timescale you use a ', style: HC.st),
                    TextSpan(text: 'Planned Transaction', style: HC.stb),
                    TextSpan(text: ' and a ', style: HC.st),
                    TextSpan(text: 'Recurrence', style: HC.stb),
                    TextSpan(text: ' and link this to a ', style: HC.st),
                    TextSpan(text: 'Category.', style: HC.stb),
                    TextSpan(text: '\n\nThe ', style: HC.st),
                    TextSpan(text: 'Planned Transaction', style: HC.stb),
                    TextSpan(text: ' is a debit, so the money goes out from your account.', style: HC.st),
                    TextSpan(text: '\n\nThe ', style: HC.st),
                    TextSpan(text: 'Recurrence', style: HC.stb),
                    TextSpan(text: ' can be ', style: HC.st),
                    TextSpan(text: 'weekly', style: HC.stb),
                    TextSpan(text: ' or ', style: HC.st),
                    TextSpan(text: 'monthly.', style: HC.stb),
                    TextSpan(text: '\n\nThe ', style: HC.st),
                    TextSpan(text: 'Category', style: HC.stb),
                    TextSpan(text: ' is up to you, choose from any ', style: HC.st),
                    TextSpan(text: 'category', style: HC.stb),
                    TextSpan(text: ' or add your own', style: HC.st),
                    TextSpan(text: '\n\nWatch the YouTube video that describles how to enter your mortgage into a new Planned Transaction', style: HC.st),                    
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Add Mortgage\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/G_Ntbw5yJM0');
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