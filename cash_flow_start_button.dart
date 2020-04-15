//System
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Providers
import '../providers/cash_flow_provider.dart';

class CashFlowStart extends StatelessWidget {
  final CashFlowProvider _cfp;

  CashFlowStart(this._cfp);

  @override
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Cash Flow',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        try {
            _cfp.cashFlowTillEndDate(context);
        } catch (error) {
          var outError = 'Running Cash Flow Error ' + error.toString();
          Clipboard.setData(new ClipboardData(text: outError));
          showDialog(
            context: context,
            child: AlertDialog(
              title: Text('Trying to Run Cash Flow Error'),
              content: Text(
                  'Error Data has been copied to the clipboard: ' + outError),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
