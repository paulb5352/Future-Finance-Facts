//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class SideDrawerHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('The Side Menu'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'The side menu can be accessed via the 3 horizontal bar icon or dragging from the left hand side, if this is not clear then please watch the video on YouTube and all will become clear.', style: HC.st),
                    TextSpan(text: '\n\nThe side menu can be removed by sliding back or selecting the home icon.', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Side Menu\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/Mf5nMTwEQcc');
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