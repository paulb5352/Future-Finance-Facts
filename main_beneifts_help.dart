import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//help
import './help_common.dart';

class MainBenefitsHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Benefits'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: 'Make Financial ',
                  style: HC.st,
                  children: <TextSpan>[
                    TextSpan(text: 'Decisions', style: HC.stb),
                    TextSpan(text: ' based upon ', style: HC.st),
                    TextSpan(text: 'Facts', style: HC.stb),
                    TextSpan(text: '\n\nSee where the low points are in your financial future', style: HC.st),
                    TextSpan(text: '\n\nAvoid financial ', style: HC.st),
                    TextSpan(text: 'shocks', style: HC.stb),
                    TextSpan(text: '\n\nKnow ', style: HC.stb),
                    TextSpan(text: 'what the future holds, take the fear away by the power of ', style: HC.st),
                    TextSpan(text: 'facts.', style: HC.stb),
                    TextSpan(text: '\n\nPlan big purchases with confidence, because you ', style: HC.st),
                    TextSpan(text: 'know', style: HC.stb),
                    TextSpan(text: ' you can afford it', style: HC.st),
                    TextSpan(text: '\n\nTry a  mortage using the ', style: HC.st),
                    TextSpan(text: 'Mortgage Calculator', style: HC.stb),
                    TextSpan(text: ' and put in a recurring Planned Transaction to see if you can afford it', style: HC.st),
                    TextSpan(text: '\n\nVary the ', style: HC.st),
                    TextSpan(text: 'interest rate', style: HC.stb),
                    TextSpan(text: ' to see how much safety net you have',  style: HC.st),
                    TextSpan(text: '\n\nUse this principle for any purchases, put in your incomming money and outgoing money and then see what you can afford.', style: HC.st),
                    TextSpan(text: '\n\nVary how much it may cost and run the future facts again to see how much ', style: HC.st),  
                    TextSpan(text: 'safety net ', style: HC.stb),
                    TextSpan(text: ' you have', style: HC.st),                  
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\n\nYouTube Main Benefits\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/hmV4Bi6GKbk');
                    },
                  style: HC.stbl),],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '\n\nTry removing categories that take sections of transactions away, to see their effect. This powerful feature allows you to try out ideas to see how they affect your financial future.', style: HC.st),
                    TextSpan(text: '\nWatch the following YouTube video to see examples of this feature.', style: HC.st),
                  ],
                ),
              ),
              
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\n\nYouTube In Future Facts\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/9GX_Be0vxds');
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
