//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class PlannedTransactionHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planned Transaction Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'A Planned Transaction either puts money into an account, or takes money from an account.', style: HC.st),
                    TextSpan(text: '\n\nPlanned Transactions can be a \"one off\" or have a regular occurence', style: HC.st),
                    TextSpan(text: '\n\nExamples are ', style: HC.st),
                    TextSpan(text: 'wages', style: HC.stb),
                    TextSpan(text: ' , ', style: HC.st),
                    TextSpan(text: 'pensions', style: HC.stb),
                    TextSpan(text: ' and ', style: HC.st),
                    TextSpan(text: 'investments income', style: HC.stb),
                    TextSpan(text: '\n\nThese are examples of money going ', style: HC.st),
                    TextSpan(text: 'into ', style: HC.stb),
                    TextSpan(text: 'one of your accounts.', style: HC.st),
                    TextSpan(text: '\n\nExamples of money going ', style: HC.st),
                    TextSpan(text: 'out', style: HC.stb),
                    TextSpan(text: ' of one of your accounts regularly are...', style: HC.st),
                    TextSpan(text: '\n\nmortgage', style: HC.stb),
                    TextSpan(text: ', ', style: HC.st),
                    TextSpan(text: 'rent', style: HC.stb),
                    TextSpan(text: ', ', style: HC.st),
                    TextSpan(text: 'food', style: HC.stb),
                    TextSpan(text: ', ', style: HC.st),
                    TextSpan(text: 'gas & electricity', style: HC.stb),
                    TextSpan(text: ', ', style: HC.st),
                    TextSpan(text: 'internet', style: HC.stb),
                    TextSpan(text: '\n\nExamples of money going ', style: HC.st),
                    TextSpan(text: 'out', style: HC.stb),
                    TextSpan(text: ' of one of your accounts each year are...', style: HC.st),   
                    TextSpan(text: '\n\ncar tax & insurance', style: HC.stb),
                    TextSpan(text: ', ', style: HC.st),
                    TextSpan(text: 'car MOT', style: HC.stb),
                    TextSpan(text: ', ', style: HC.st),
                    TextSpan(text: 'boiler service', style: HC.stb),
                    TextSpan(text: ', ', style: HC.st),
                    TextSpan(text: 'Amazon Prime', style: HC.stb),
                    TextSpan(text: ', ', style: HC.st),
                    TextSpan(text: 'Building\'s insurance', style: HC.stb),  
                    TextSpan(text: '\n\nWatch the YouTube video that describles how to enter a new Planned Transaction', style: HC.st),                                   
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Add Planned Transaction\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/netmr-9Du4I');
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