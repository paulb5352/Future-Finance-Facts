import 'package:flutter/material.dart';
import './mortgage_calculator.dart';

class MortgageListSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Mortgage Calculator'),
      subtitle: Text('Find your monthly repayments'),
      trailing: IconButton(
        icon: Icon(Icons.launch),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MortgageCalculator())),
      ),
    );
  }
}