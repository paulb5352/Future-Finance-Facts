//System
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Help
import './help_common.dart';

class OngoingCostsHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ongoing Costs Help'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'This list may help you to put all future transactions into the App, only when you believe you have put all ', style: HC.st),
                    TextSpan(text: 'known', style: HC.stb),
                    TextSpan(text: ' costs into the App will you gain the full benefits. Then you can ', style: HC.st),
                    TextSpan(text: 'trust', style: HC.stb),
                    TextSpan(text: ' the  ', style: HC.st),
                    TextSpan(text: 'Future Financial Facts', style: HC.stb),
                    TextSpan(text: ' provided. Then you can plan future purchases or commitments with ', style: HC.st),
                    TextSpan(text: 'confidence.', style: HC.stb),
                    TextSpan(text: '\n\nGas Account', style: HC.st),
                    TextSpan(text: '\nElectricity Account', style: HC.st),
                    TextSpan(text: '\nInternet Account', style: HC.st),
                    TextSpan(text: '\nCouncil or State Tax', style: HC.st),
                    TextSpan(text: '\nRent or Mortgage', style: HC.st),
                    TextSpan(text: '\nCar Loan', style: HC.st),
                    TextSpan(text: '\nWeekly or Monthly food shopping', style: HC.st),
                    TextSpan(text: '\nTV or Entertainment Account', style: HC.st),
                    TextSpan(text: '\nPhone Account', style: HC.st),
                    TextSpan(text: '\nRent or Mortgage', style: HC.st),
                    TextSpan(text: '\nCar Petrol Costs, per week or month', style: HC.st),
                    TextSpan(text: '\nShared rental costs, if applicable', style: HC.st),
                    TextSpan(text: '\nWeekly or Monthly clothing costs', style: HC.st),
                    TextSpan(text: '\nWeekly or Monthly entertainment costs', style: HC.st),
                    TextSpan(text: '\nWeekly or Monthly restaurant costs', style: HC.st),
                    TextSpan(text: '\nClubs or Social event costs', style: HC.st),
                    TextSpan(text: '\nHome Improvements', style: HC.st),
                    TextSpan(text: '\nHome Repairs', style: HC.st),
                    TextSpan(text: '\nPet Insurance', style: HC.st),
                    TextSpan(text: '\nPet Vet Fees', style: HC.st),
                    TextSpan(text: '\nGym Fees', style: HC.st),

                    TextSpan(text: '\nCar Insurance', style: HC.st),
                    TextSpan(text: '\nCar Tax', style: HC.st),
                    TextSpan(text: '\nCar MOT estimate, if applicable', style: HC.st),
                    TextSpan(text: '\nBuilding\'s Content Insurance', style: HC.st),
                    TextSpan(text: '\nBuilding\'s Structure Insurance', style: HC.st),

                    TextSpan(text: '\nHoliday Costs', style: HC.st),
                    
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