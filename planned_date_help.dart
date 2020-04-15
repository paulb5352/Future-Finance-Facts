//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class PlannedDateHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planned Date Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'This date is the final date for the App to calculate your future financial facts.', style: HC.st),
                    TextSpan(text: '\n\nYour App is optimised to calculate for many years ahead, 50 years ahead is OK.', style: HC.st),
                    TextSpan(text: '\n\nYou may choose to only run for a year or two, but this is your choice.', style: HC.st),
                    TextSpan(text: '\n\nSelect the side drawer menu and select settings and then planned date, a simple', style: HC.st),
                    TextSpan(text: 'date picker', style: HC.stb),
                    TextSpan(text: ' is shown, watch the YouTube video which shows exactly how to change the date if this helps.', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Picked Date\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/o0hf7zD0hOU');
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