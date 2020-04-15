//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class MortgageCalculatorHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mortgage Calculator Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Use the mortgage calculator to find your monthly repayment for a mortgage.', style: HC.st),
                    TextSpan(text: '\n\nUse this for a Planned Transaction and a monthly recurrence to see the effect on your financial future.', style: HC.st),
                    TextSpan(text: '\n\nFill in the following sections to obtain the monthly repayment', style: HC.st),
                    TextSpan(text: '\n\nMortgage Amount', style: HC.stb),
                    TextSpan(text: '\nThe total amount of mortgage you are considering to take. This is the difference of the house cost and your deposit.', style: HC.st),
                    TextSpan(text: '\n\nInterest Rate %', style: HC.stb),
                    TextSpan(text: '\nThe amount of interest paid upon your mortgage, use a percentage, for example if 4% then enter 4', style: HC.st),
                    TextSpan(text: '\n\nMortgage Period', style: HC.stb),
                    TextSpan(text: '\nThe length of time (in years) you pay off your mortgage, the longer the period means lower monthly payments', style: HC.st),
                    TextSpan(text: '\n\nMonthly Repayment', style: HC.stb),
                    TextSpan(text: '\nThe result of the calculation, shown with your currency symbol, this is the monthly repayment, it does not include extra insurance', style: HC.st),
                    TextSpan(text: '\n\nTry adjusting the interest rate to see how that affects your financial future, predicting interest rates is either highly skilled or simply impossible, so ensure you have a buffer to adbsord an increase in interest rates', style: HC.st),
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