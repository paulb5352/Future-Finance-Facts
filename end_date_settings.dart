import 'package:flutter/material.dart';
import '../providers/settings_provider.dart';
import '../providers/cash_flow_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EndDateSettings extends StatefulWidget {
  final String _title;
  final String _subtitle;
  final SettingsProvider _sp;
  final int _i;

  EndDateSettings(this._i, this._title, this._subtitle, this._sp);

  @override
  _EndDateSettingsState createState() => _EndDateSettingsState();
}

class _EndDateSettingsState extends State<EndDateSettings> {

  DateTime _selectedDate;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _selectedDate = DateTime.tryParse(widget._sp.items[widget._i].value);      
    }
  }

  @override
  Widget build(BuildContext context) {
    var formatDate = DateFormat('dd-MM-yy');    
    
    void _presentDatePicker() {
      showDatePicker(
        context: context,
        initialDate: _selectedDate != null && _selectedDate.isAfter(DateTime.now()) ? _selectedDate : DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2050),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
          Provider.of<CashFlowProvider>(context).cashFlowDirty = true;
        });
        widget._sp.items[widget._i].value = _selectedDate.toIso8601String();
        widget._sp.updateSetting(widget._sp.items[widget._i]);
      });
    }    
    return ListTile(
      leading: Text(_selectedDate == null
                ? 'No date chosen'
                : 'Picked Date: ${formatDate.format(_selectedDate)}'),
      title: Text('End Date for Finance Facts', style: TextStyle(fontSize: 10),),
      trailing: Container(
        child: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: _presentDatePicker,
        ),
      ),
      
    );
     
  }
}