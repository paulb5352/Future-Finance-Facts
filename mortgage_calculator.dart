import 'package:flutter/material.dart';
import 'dart:math';
import '../providers/settings_provider.dart';
import 'package:provider/provider.dart';



class MortgageCalculator extends StatefulWidget {
  @override
  _MortgageCalculatorState createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator> {
  double ir;
  double mv;
  double mp;

  void _saveForm(){
    try{
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }    
      _form.currentState.save();
      debugPrint('ir $ir mv $mv mp $mp');
      var ans = calcMonthly(mv, ir, mp);
      SettingsProvider sp = Provider.of<SettingsProvider>(context, listen: false); 
      String currencySymbol = sp.settingSymbols[0][sp.items[0].value];      
      _monthlyRepayment.text = currencySymbol + ans.toStringAsFixed(2);

    } catch(error){
      throw Exception('MortgageCalculator._saveForm ' + error.toString());
    }
  }
  double calcMonthly(double mv, double ir, double mp){

    ir = ir/12.0;
    ir = ir/100.0;
    mp = mp * 12.0;
    return (ir * mv)/(1-pow((1+ir), -1*mp));
  }

final _form = GlobalKey<FormState>(); 
TextEditingController _monthlyRepayment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mortgage Calculator'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 80, right: 80),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Mortgage Amount
                Container(
                  height: 100,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Mortgage Amount'),
                    initialValue: 100000.toStringAsFixed(0),
                    textInputAction: TextInputAction.none,
                    keyboardType: TextInputType.number,
                    maxLength: 30,
                    validator: (value){
                      if (value.isEmpty) {
                        return 'please enter an amount for the mortgage ';
                      }
                      if (double.tryParse(value) == null) {
                        return 'please enter a valid number for the mortgage';
                      } else if(double.parse(value) == 0.0){
                        return 'please enter a value for the mortgage, not 0.00';
                      }
                      return null;                      
                    },
                    onSaved: (value) => mv = double.tryParse(value),
                  ),
                ),
                //Interest Rate
                Container(
                  height: 100,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Interest Rate (%)'),
                    initialValue: 6.5.toStringAsFixed(1),
                    textInputAction: TextInputAction.none,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value){
                      if (value.isEmpty) {
                        return 'please enter an interest rate in % ';
                      }
                      if (double.tryParse(value) == null) {
                        return 'please enter a valid number for the interest rate';
                      } else if(double.parse(value) == 0.0){
                        return 'please enter a value for the mortgage, not 0.00';
                      }
                      return null;                      
                    },
                    onSaved: (value) => ir = double.tryParse(value),
                  ),
                ),
                //Mortgage Period
                Container(
                  height: 100,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Mortgage Period (years)'),
                    initialValue: 30.toStringAsFixed(1),
                    textInputAction: TextInputAction.none,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value){
                      if (value.isEmpty) {
                        return 'please enter a mortage period rate in years ';
                      }
                      if (double.tryParse(value) == null) {
                        return 'please enter a valid number for the mortgage period';
                      } else if(double.parse(value) == 0.0){
                        return 'please enter a value for the mortgage period, not 0';
                      }
                      return null;                      
                    },
                    onSaved: (value) => mp = double.tryParse(value),
                  ),
                ),
                //Answer
                Container(
                  height: 100,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Monthly Repayment'),
                    initialValue: null,
                    controller: _monthlyRepayment,
                    textInputAction: TextInputAction.none,
                    maxLength: 10,
                  ),
                ),
                RaisedButton(
                  child: Text('Calculate Mortgage'),
                  onPressed: () => _saveForm(),
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}