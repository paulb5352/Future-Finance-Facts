//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class RunFinancialFactsHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Run Financial Facts'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'To run is easy, simply press the top button on the home screen.', style: HC.st),
                    TextSpan(text: '\n\nYou enter your bank accounts in the Accounts section', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Accounts\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/O0q58jlh3dk');
                    },
                  style: HC.stc),],
                ), 
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '\nThen put in your salary or incomming money', style: HC.st),
                    TextSpan(text: '\n\nNext enter some outgoing transactions, such as rent or mortgage', style: HC.st),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Transactions\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/netmr-9Du4I');
                    },
                  style: HC.stc),],
                ), 
              ),
              RichText(text: TextSpan(children: <TextSpan>[TextSpan(text: 'Next set up the final date the facts run through till', style: HC.st),],),),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Set Picked Date\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/o0hf7zD0hOU');
                    },
                  style: HC.stc),],
                ), 
              ),                
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
	                  TextSpan(text: 'Now run the ', style: HC.st),
                    TextSpan(text: 'Financial Facts ', style: HC.stb),    
                    TextSpan(text: 'to view your financial future', style: HC.st),              
                  ],
                ),
              ),                  
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '\nYouTube Run Facts\n', 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://youtu.be/LAFY9-2VcI4');
                    },
                  style: HC.stc),],
                ), 
              ),                    
                  
                
                                        
            ],
          ),
        ),
      ),
      
    );
  }
}