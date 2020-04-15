//System
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
//models
import '../models/transfer.dart';
import '../models/list_tile_base.dart';
import '../models/recurrence.dart';
import '../models/account.dart';
//providers
import '../providers/transfers_provider.dart';
import '../providers/accounts_provider.dart';
import '../providers/recurrences_provider.dart';
import '../providers/cash_flow_provider.dart';
//screens
import '../screens/accounts_screen.dart';
import '../screens/recurrences_screen.dart';
//widgets
import '../widgets/date_choose.dart';
import '../widgets/icon_list_image.dart';

class TransferScreen extends StatefulWidget {
  
  static const routeName = 'TransferScreen';

  @override
  
  _TransferScreenState createState() => _TransferScreenState();
}


class _TransferScreenState extends State<TransferScreen> {
  DateTime _selectedDate;
  Recurrence recurrence;
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var result;
  var _toAccountName;
  var _fromAccountName;
  var _recurrenceName;
  var _editTransfer = Transfer(
    id: -1,
    title: '',
    description: '',
    fromAccountId: -1,
    toAccountId: -1,
    plannedDate: '',
    amount: 0.0,
    recurrenceId: -1,
    useForCashFlow: true,
  );
  @override
  void didChangeDependencies() {
    try{
    if (_isInit) {
      final ListTileBase args = ModalRoute.of(context).settings.arguments;
      if (args != null) {
        _editTransfer = Provider.of<TransfersProvider>(context, listen: false).findById(args.id);
        _selectedDate = DateTime.parse(_editTransfer.plannedDate);
        var provider = Provider.of<AccountsProvider>(context, listen: false);
        _toAccountName = provider.findById(_editTransfer.toAccountId).accountName;
        _fromAccountName = provider.findById(_editTransfer.fromAccountId).accountName;
        recurrence = Provider.of<RecurrencesProvider>(context, listen: false).findById(_editTransfer.recurrenceId);
        recurrence == null ?_recurrenceName = null : _recurrenceName = recurrence.title;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
    } catch(error){
      throw Exception('TransferScreen.didChangeDependencies: ' + error.toString());
    }
  }
  Future<void> _saveForm() async {
    try{
      if(_selectedDate != null){
        _editTransfer.plannedDate = _selectedDate.toIso8601String();
      } else {
        showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select a planned date'), content: Text('e.g. Transfer must occur at a specific date'), actions: <Widget>[FlatButton(child: Text('OK'), onPressed: (){Navigator.of(context).pop();},),],),);
        return;
      }
      if(_editTransfer.toAccountId == -1 || _editTransfer.fromAccountId == -1){
         showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select a from Account'), content: Text('e.g. Select a to Account'), actions: <Widget>[FlatButton(child: Text('OK'), onPressed: (){Navigator.of(context).pop();},),],),);
        return;     
      }  
      if(_editTransfer.toAccountId == _editTransfer.fromAccountId){
        showDialog(context: context, builder: (context) => AlertDialog(title: Text('Both accounts must be different'), content: Text('Use two different accounts'),actions: <Widget>[FlatButton(child: Text('OK'),onPressed: (){Navigator.of(context).pop();},),],),);
        return;     
      }        
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });

      if (_editTransfer.id >= 0) {
        await Provider.of<TransfersProvider>(context, listen: false).updateTransfer(_editTransfer);         
      } else {
        await Provider.of<TransfersProvider>(context, listen: false).addTransfer(_editTransfer);          
      }
      Navigator.of(context).pop();
      setState(() {
        _isLoading = false;
      });
      Provider.of<CashFlowProvider>(context).cashFlowDirty = true;
    } catch (error){
      var outError = 'Saving Transfer ' + error.toString();
      Clipboard.setData(new ClipboardData(text: outError));
      showDialog(
        context: context,
        builder: (context) =>   
         AlertDialog(
          title: Text('Trying to save Transfer Error'), 
          content: Text('Error Data has been copied to the clipboard: ' + outError),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: (){
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  } 

  void _navigateAndDisplayToAccounts(BuildContext context) async {
    try{
      result = await Navigator.push(context,MaterialPageRoute(builder: (context) => AccountsScreen(true)),);
      Account account = Provider.of<AccountsProvider>(context, listen: false).findById(result);
      _editTransfer.toAccountId = account.id;
      setState(() {
        _toAccountName = account.accountName;
      });  
    } catch(error){
      throw Exception('TransferScreen._navigateAndDisplayToAccounts: ' + error.toString());
    }
  }   
  void _navigateAndDisplayFromAccounts(BuildContext context) async {
    try{
      result = await Navigator.push(context,MaterialPageRoute(builder: (context) => AccountsScreen(true)),);
      Account account = Provider.of<AccountsProvider>(context, listen: false).findById(result);
      _editTransfer.fromAccountId = account.id;
      setState(() {
        _fromAccountName = account.accountName;
      }); 
    } catch(error){
      throw Exception('TransferScreen._navigateAndDisplayFromAccounts: ' + error.toString());
    } 
  }  
  void _navigateAndDisplayRecurrences(BuildContext context) async {
    try{
      result = await Navigator.push(context,MaterialPageRoute(builder: (context) => RecurrencesScreen(true)),);
      recurrence = Provider.of<RecurrencesProvider>(context, listen: false).findById(result);
      _editTransfer.recurrenceId = recurrence.id;
      setState(() {
        _recurrenceName = recurrence.title;
      }); 
    } catch(error){
      throw Exception('TransferScreen._navigateAndDisplayRecurrences: ' + error.toString());
    } 
  }
  void _presentDatePicker() {
    try{
      showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      });
    } catch(error){
      throw Exception('TransferScreen._presentDatePicker: ' + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    try{
      return Scaffold(
        appBar: AppBar(
          title: Text('Transfer'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: (){
                _saveForm();
              },
            ),
          ],
          ),
        body: _isLoading
        ? Center(child: CircularProgressIndicator(),)
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  //Title
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      maxLength: 40,
                      decoration: InputDecoration(
                        labelText: 'Transfer Name',
                      ),
                      initialValue: _editTransfer.title,
                      textInputAction: TextInputAction.none,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a valid Transfer Name';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) => _editTransfer.title = value,
                    ),
                  ),
                  //Description
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      maxLength: 80,
                      decoration: InputDecoration(
                        labelText: 'Transfer Description',
                      ),
                      initialValue: _editTransfer.description,
                      textInputAction: TextInputAction.none,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a valid Transfer Description';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) => _editTransfer.description = value,
                    ),
                  ),
                  //Amount
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      maxLength: 8,
                      decoration: InputDecoration(
                        labelText: 'Transaction Amount', 
                      ),
                      initialValue: _editTransfer.amount.toString(),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.none,
                      onFieldSubmitted: (_) => _saveForm(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter a transfer amount ';
                        }
                        if (double.tryParse(value) == null) {
                          return 'please enter a valid number for the planned transaction';
                        } else if (double.parse(value) == 0.0){
                          return 'please enter a value for the transfer, not 0.00';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          _editTransfer.amount = double.parse(value),
                    ),
                  ),
                  //From Account
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Text(_fromAccountName == null ? 'No account chosen' : _fromAccountName),
                      ),
                      FlatButton(
                        highlightColor: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).disabledColor,
                        child: Text(
                          'From Account',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          _navigateAndDisplayFromAccounts(context);
                        }
                      ),
                    ],),                     
                  ),                
                  //To Account
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Text(_toAccountName == null ? 'No account chosen' : _toAccountName),
                      ),
                      FlatButton(
                        highlightColor: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).disabledColor,
                        child: Text(
                          'To Account',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          _navigateAndDisplayToAccounts(context);
                        }
                      ),
                    ],),                     
                  ),
                  //Recurrence                    
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(children: <Widget>[
                      Expanded(                           
                          child: _recurrenceName == null 
                          ? Text('No recurrence chosen')                                
                          : Row(children: <Widget>[Text(_recurrenceName), IconListImage(recurrence.iconPath)], mainAxisAlignment: MainAxisAlignment.spaceAround,),
                      ),
                      FlatButton(
                        highlightColor: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).disabledColor,
                        child: Text(
                          'Recurrence',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: (){
                          _navigateAndDisplayRecurrences(context);
                        },
                      ),
                    ],),                     
                  ),
                  //Date
                  DateChoose(selectedDate: _selectedDate, datePicker: _presentDatePicker, disabled: false,), 
                  //Use for cash flow                  
                  SwitchListTile(
                    title: Text('Use in Cash Flow'),
                    value: _editTransfer.useForCashFlow,
                    subtitle:
                        Text('Include or Exclude from the cash flow run'),
                    onChanged: (bool val) {
                      setState(() => _editTransfer.useForCashFlow = val);
                    },
                  ),
                  Divider(thickness: 2.0,),                
                ],
              ),
            ),
        ),    
      );
    } catch(error){
      throw Exception('TransferScreen.build: ' + error.toString());
    }
  }
}