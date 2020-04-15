//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class MainScreenHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Screen Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'The main screen has 5 shaded boxes.', style: HC.st),
                    TextSpan(text: '\n\nRun Financial Facts', style: HC.stb),
                    TextSpan(text: '\nThis button runs the Future Financial Facts and enables the dropdown box in the second box', style: HC.st),
                    TextSpan(text: '\n\nFinancial Facts', style: HC.stb),
                    TextSpan(text: '\nThis box has the dropdown that shows the accounts that are available to select', style: HC.st),
                    TextSpan(text: '\n\nToday\'s Balance', style: HC.stb),
                    TextSpan(text: '\nThis box shows the total  balance when you open the app, it includes any transactions for today', style: HC.st),
                    TextSpan(text: '\n\nEnd of this Month\'s Balance', style: HC.stb),
                    TextSpan(text: '\nThis box shows the total balance when you open the app, it includes any transactions upto the end of the current month', style: HC.st),
                    TextSpan(text: '\n\nEnd of next Month\' Balance', style: HC.stb),
                    TextSpan(text: '\nThis box shows the total balance when you open the app, it includes any transactions upto the end of the following month', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Main Screen\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/HYvB96nl1t0');
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