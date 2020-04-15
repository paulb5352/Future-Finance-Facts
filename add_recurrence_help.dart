//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class AddRecurrenceHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Recurrence Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'To add an recurrence open the side drawer menu and select Recurrences', style: HC.st),
                    TextSpan(text: '\n\nFrom there enter the name, description and various options available.', style: HC.st),
                    TextSpan(text: '\n\nIcon Select', style: HC.stb),
                    TextSpan(text: '\nChoose an icon to represent this Recurrence from the list of icons', style: HC.st),
                    TextSpan(text: '\n\nType', style: HC.stb),
                    TextSpan(text: '\nSelect from Weekly, Monthly, Quarterly or Yearly for the recurring transaction', style: HC.st),
                    TextSpan(text: '\n\nNumber of Occurences', style: HC.stb),
                    TextSpan(text: '\nSome transactions only occurr a number of times, if you buy a car the payments only last a number of time, use this option to stop the transactions after the fixed number of occurrences', style: HC.st),
                    TextSpan(text: '\n\nEnd Date', style: HC.stb),
                    TextSpan(text: '\nSome transactions finish after a period of time, if you pay this way select the end date to stop the transactions.', style: HC.st),
                    TextSpan(text: '\n\nWatch the YouTube video that describes how to set up a new Recurrence if this helps', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Add Recurrence\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/wkz6Axz2IBg');
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