import 'package:flutter/material.dart';
//Help
import '../settings/help/help_common.dart';

class HomeCard extends StatelessWidget {

  final String _title;
  final String _currencySymbol;
  final double _value;
  final double _gap;

  HomeCard(this._title, this._value, this._currencySymbol, this._gap);

  @override
  Widget build(BuildContext context) {

    Color valueColor = _value >= 0 ? Colors.black54 : Colors.red;

    return Container(
            margin: EdgeInsets.all(_gap),
            padding: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 5),
            width: 200,
            height: 80,
            child: Column(children: <Widget>[
              Text(_title),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text('$_currencySymbol${_value.toStringAsFixed(0)}', 
                style: TextStyle(
                  fontSize: 20,
                  color: valueColor,
                  fontWeight: FontWeight.bold,                                   
                ),
                ),
                ),
            ],),
            decoration: BoxDecoration(             
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: Colors.black,
                width: 2.0,
                style: BorderStyle.solid,
              ),
              color: Colors.purple,
              gradient: LinearGradient(
                colors: [HC.clgl, HC.clgr,],
                
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                tileMode: TileMode.clamp,               
              ),
              boxShadow: [
                BoxShadow(
                  color: HC.clbk,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                ),
                BoxShadow(
                  color: HC.clbk,
                  offset: Offset(3.0, 3.0),
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                ),                
              ],
            ),
          );    
  }
}