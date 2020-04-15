import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class IntroductionHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Introduction Help'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
RichText(text: TextSpan(text: 'Future ', style: HC.st, children: <TextSpan>[TextSpan(text: 'Financial', style: HC.stb), TextSpan(text: ' Facts!\n'),],),),
RichText(textAlign: TextAlign.left, text: TextSpan(text: 'This app enables you to plan your financial future using the facts you ', style: HC.st, children: <TextSpan>[TextSpan(text: 'know', style: HC.stb), TextSpan(text: '. It looks forwards to your future, this enables you to answer simple questions, such as...\n'),],)),

RichText(
	textAlign: TextAlign.left, 
	text: TextSpan(
		text: 'Can I buy the house we ', 
		style: HC.st, 
		children:<TextSpan>[
			TextSpan(text: 'want ', style: HC.stb),
			TextSpan(text: 'to purchase?\n', style: HC.st),
			TextSpan(text: 'Can we go on the holiday we ', style: HC.st),
			TextSpan(text: 'really ', style: HC.stb),
			TextSpan(text: 'want?\n', style: HC.st),
      TextSpan(text: 'Can I buy that car I ', style: HC.st),
      TextSpan(text: 'want', style: HC.stb),
      TextSpan(text: ' to buy?\n\n'),
      TextSpan(text: 'How does it do this?\n\n'),
      TextSpan(text: 'Your put in your future financial transactions, such as your wages that arrive each month.\n\n', style: HC.st),
      TextSpan(text: 'You put in your outgoings such as rent or mortgage, weekly food costs etc.', style: HC.st),
      TextSpan(text: '\n\nThe App will guide you through the common outgoings each year', style: HC.st),
      TextSpan(text: '\n\nThe App will then show you ', style: HC.st),
      TextSpan(text: 'your', style: HC.stb),
      TextSpan(text: ' financial future.')
		]),
	),
RichText(
  text: TextSpan(
    children: <TextSpan>[
      TextSpan(
        text: '\n\nYouTube Introduction\n', 
        recognizer: TapGestureRecognizer()..onTap = () {
          launch('https://youtu.be/IhSqX9zuMag');
        },
        style: HC.stbl
      ),
    ],
  ),
),

                
             
            ],
          ),
        ),
      ),
    );
  }
}
