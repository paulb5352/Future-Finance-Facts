//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class TransferHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transfer Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'To transfer funds between accounts use a Transfer. Transfers can have recurrences so if you transfer on a ', style: HC.st),
                    TextSpan(text: 'regular ', style: HC.stb),
                    TextSpan(text: 'basis use a transfer', style: HC.st),
                    TextSpan(text: '\n\nTransfers do not affect your financial future but they are included in the ', style: HC.st),
                    TextSpan(text: 'Future Financial Facts ', style: HC.stb),
                    TextSpan(text: 'as they affect the balance in each account. You can view each account\'s ', style: HC.st),
                    TextSpan(text: 'financial facts', style: HC.stb),
                    TextSpan(text: ' separately so transfers are important for accurate ', style: HC.st),
                    TextSpan(text: 'finacial facts', style: HC.stb),
                    TextSpan(text: '\n\nWatch the YouTube video that describles how to enter a new Transfer', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Add Transfer\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/B-yo-Eke4zY');
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