import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateChoose extends StatelessWidget {

  final DateTime selectedDate;
  final Function datePicker;
  final BuildContext context;
  final bool disabled;


  DateChoose({this.selectedDate, this.datePicker, this.context, this.disabled});

  @override
  Widget build(BuildContext context) {
    var formatDate = DateFormat('dd-MM-yy');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(selectedDate == null
                ? 'No date chosen'
                : 'Picked Date: ${formatDate.format(selectedDate)}'),
          ),
          FlatButton(           
            highlightColor: Theme.of(context).primaryColor,
            textColor: Colors.blueGrey[800],
            child: Text(
              'Choose Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: disabled ? null : datePicker,
          ),
        ],
      ),
    );
  }
}
