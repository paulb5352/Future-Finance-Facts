import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cash_flow_provider.dart';

class EndDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _usedWidth;
    if(_screenWidth < 400){
      _usedWidth = 50;
    } else {
      _usedWidth = 100;
    }
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.grey[300],
          padding: EdgeInsets.all(10),
          height: 400,
          child: Card( 
            color: Colors.grey[500],          
            elevation: 4,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 5),
                    child: SizedBox(                 
                    width: _usedWidth,
                    child: Text("Select End Date", style: TextStyle(color: Colors.white),),
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (data) { },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}