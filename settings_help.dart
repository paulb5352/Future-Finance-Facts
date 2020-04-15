//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class SettingsHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'The ', style: HC.st),
                    TextSpan(text: 'Setting', style: HC.stb),
                    TextSpan(text: ' menu has a number of options, each has its own help section which you can read and watch the YouTube video', style: HC.st),
                    TextSpan(text: '\n\nSave File...', style: HC.stb),
                    TextSpan(text: '\nTo save your data in a file, as a backup or so you can load another file. Please remember that opening another file will ', style: HC.st),
                    TextSpan(text: ' remove ', style: HC.stb),
                    TextSpan(text: 'all current data', style: HC.st),
                    TextSpan(text: '\n\nOpen File...', style: HC.stb),
                    TextSpan(text: '\nThis will open your data file in the downloads directory and load into the App. Please remember that opening a new file will', style: HC.st),
                    TextSpan(text: ' remove ', style: HC.stb),
                    TextSpan(text: 'all current data', style: HC.st), 
                    TextSpan(text: '\n\nFile Name...', style: HC.stb),
                    TextSpan(text: '\nThis shows the name of the file that will be opened or used as the backup file, the file will be saved as a text file, so if the name is macf it will be saved as macf.txt', style: HC.st),                  
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube File Save and Open\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/nqNTVJ2l07k');
                    },
                  style: HC.stbl),],
                ), 
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '\n\nCurrency', style: HC.stb),
                    TextSpan(text: '\nThis allows you to choose one of four currencies, Pound, Dollar, Yen and Euro.', style: HC.st),
                    TextSpan(text: '\nYou can watch the YouTube video which shows how to select your currency', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Currency\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/HVsKjhsVq5c');
                    },
                  style: HC.stbl),],
                ), 
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '\n\nPicked Data', style: HC.stb),
                    TextSpan(text: '\nThis allows the choice of the final date for the run of Financial Facts. Feel free to choose any date in the future as the App is highly optimised for running the Financial Facts so even 50 years ahead is OK', style: HC.st),
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
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '\n\nMortgage Calculator', style: HC.stb),
                    TextSpan(text: '\nYou can find your monthly repayment for a proposed mortgage using this calculator', style: HC.st),
                  ],
                ),
              ), 
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Mortgage Calculator\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/0f1jKOe3FmM');
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