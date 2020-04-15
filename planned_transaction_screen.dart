//System
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
//Screens
import 'package:cash_flow/screens/accounts_screen.dart';
import 'package:cash_flow/screens/categories_screen.dart';
import 'package:cash_flow/screens/recurrences_screen.dart';
//Models
import 'package:cash_flow/models/category.dart';
import '../models/planned_transaction.dart';
import '../models/list_tile_base.dart';
import '../models/account.dart';
import '../models/recurrence.dart';
//Providers
import '../providers/planned_transactions_provider.dart';
import '../providers/accounts_provider.dart';
import '../providers/categories_provider.dart';
import '../providers/recurrences_provider.dart';
import '../providers/cash_flow_provider.dart';
//Widgets
import '../widgets/icon_list_image.dart';


class PlannedTransactionScreen extends StatefulWidget {
  static const routeName = 'PlannedTransactionScreen';

  @override
  _PlannedTransactionScreenState createState() => _PlannedTransactionScreenState();
}

class _PlannedTransactionScreenState extends State<PlannedTransactionScreen> {
  DateTime _selectedDate;
  String _accountName;
  String _categoryName;
  String _recurrenceName;
  Category category;
  Recurrence recurrence;
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var result;
  var _editTransaction = PlannedTransaction(
    id: -1,
    title: '',
    description: '',
    accountId: -1,
    categoryId: -1,
    recurrenceId: -1,
    plannedDate: null,
    amount: 0.0,
    credit: true,
    useForCashFlow: true,
  );
  @override
  void didChangeDependencies() {
    try{
      if (_isInit) {
        final ListTileBase args = ModalRoute.of(context).settings.arguments;
        if (args != null) {
          _editTransaction = Provider.of<PlannedTransactionProvider>(context, listen: false).findById(args.id);
          _selectedDate = DateTime.parse(_editTransaction.plannedDate);      
        }
      }
      _isInit = false;
      super.didChangeDependencies();
    } catch(error){
      throw Exception('PlannedTransactionScreen.didChangeDependencies: ' + error.toString());
    }
  }

  Future<void> _saveForm() async {
    try{
      if(_selectedDate != null){
        _editTransaction.plannedDate = _selectedDate.toIso8601String();
      } else {
        showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select a planned date'), content: Text('e.g. Transaction must occur at a specific date'), actions: <Widget>[FlatButton(child: Text('OK'), onPressed: (){Navigator.of(context).pop();},),],),);
        return;
      }  
      if(_editTransaction.categoryId == -1){
        showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select a category'), content: Text('e.g. Transaction must have a category'), actions: <Widget>[FlatButton(child: Text('OK'), onPressed: (){Navigator.of(context).pop();},),],),);
        return;
      } 
      if(_editTransaction.accountId == -1){
        showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select an Account'), content: Text('e.g. Transaction must have an account'), actions: <Widget>[FlatButton(child: Text('OK'), onPressed: (){Navigator.of(context).pop();},),],),);
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

      if (_editTransaction.id >= 0) {
        await Provider.of<PlannedTransactionProvider>(context, listen: false).updateTransaction(_editTransaction);         
      } else {
        await Provider.of<PlannedTransactionProvider>(context, listen: false).addTransaction(_editTransaction);          
      }
      Navigator.of(context).pop();
      setState(() {
        _isLoading = false;
      });
      Provider.of<CashFlowProvider>(context).cashFlowDirty = true;
    } catch (error){
      var outError = 'Saving Planned Transaction ' + error.toString();
      Clipboard.setData(new ClipboardData(text: outError));
      showDialog(
        context: context, 
        child: AlertDialog(
          title: Text('Trying to save Planned Transaction Error'), 
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

  Future<void>  _navigateAndDisplayAccounts(BuildContext context) async {
    try{
      Account account;
      result = await Navigator.push(context,MaterialPageRoute(builder: (context) => AccountsScreen(true)),);
      if(result != null){
        account = Provider.of<AccountsProvider>(context, listen: false).findById(result);
        if(account != null) _editTransaction.accountId = account.id;
      }
      setState(() {
        account != null ? _accountName = account.accountName : _accountName = null;
      }); 
    } catch(error){
      throw Exception('PlannedTransactionScreen._navigateAndDisplayAccounts: ' + error.toString());
    } 
  }
  Future<void> _navigateAndDisplayCategories(BuildContext context) async {
    try{    
    result = await Navigator.push(context,MaterialPageRoute(builder: (context) => CategoriesScreen(true)),);
    if(result != null){
      category = Provider.of<CategoriesProvider>(context, listen: false).findById(result);
      if(category != null)  _editTransaction.categoryId = category.id;
    }
    setState(() {
      category != null ? _categoryName = category.categoryName : _categoryName = null;
    });  
    } catch(error){
      throw Exception('PlannedTransactionScreen._navigateAndDisplayCategories: ' + error.toString());
    }
  }
  Future<void> _navigateAndDisplayRecurrences(BuildContext context) async {
    try{      
      result = await Navigator.push(context,MaterialPageRoute(builder: (context) => RecurrencesScreen(true)),);
      if(result != null){
        recurrence = Provider.of<RecurrencesProvider>(context, listen: false).findById(result);
        if(recurrence != null)  _editTransaction.recurrenceId = recurrence.id;
      }    
      setState(() {
        recurrence != null ?  _recurrenceName = recurrence.title : _recurrenceName = null;
      }); 
    } catch(error){
      throw Exception('PlannedTransactionScreen._navigateAndDisplayRecurrences: ' + error.toString());
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
      throw Exception('PlannedTransactionScreen._presentDatePicker: ' + error.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    try{
      if(_editTransaction.accountId > -1){
        Account account = Provider.of<AccountsProvider>(context, listen: false).findById(_editTransaction.accountId);
        account != null ? _accountName = account.accountName : _accountName = null;
      }
      if(_editTransaction.categoryId > -1){
        category = Provider.of<CategoriesProvider>(context, listen: false).findById(_editTransaction.categoryId);
        category != null ? _categoryName = category.categoryName : _categoryName = null;
      }
      if(_editTransaction.recurrenceId > -1){
        recurrence = Provider.of<RecurrencesProvider>(context, listen: false).findById(_editTransaction.recurrenceId);
        recurrence != null ? _recurrenceName = recurrence.title : _recurrenceName = null;
      }    
      var formatDate = DateFormat('dd-MM-yy'); //Second setting here
      return Scaffold(
        appBar: AppBar(
          title: Text('Planned Transaction'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveForm();
              },
            ),
          ],        
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      //Title
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Transaction Name',
                          ),
                          initialValue: _editTransaction.title,
                          textInputAction: TextInputAction.none,
                          maxLength: 30,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a valid Transaction Name';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => _editTransaction.title = value,
                        ),
                      ),
                      //Description
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Transaction Description',
                          ),
                          initialValue: _editTransaction.description,
                          textInputAction: TextInputAction.none,
                          maxLength: 80,                        
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a valid Transaction Description';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => _editTransaction.description = value,
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
                          initialValue: _editTransaction.amount.toString(),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.none,
                          onFieldSubmitted: (_) => _saveForm(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'please enter a transaction amount ';
                            }
                            if (double.tryParse(value) == null) {
                              return 'please enter a valid number for the planned transaction';
                            } else if(double.parse(value) == 0.0){
                              return 'please enter a value for the transfer, not 0.00';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _editTransaction.amount = double.parse(value),
                        ),
                      ), 
                      //Date                   
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Text(_selectedDate == null ? 'No date chosen' : 'Picked Date: ${formatDate.format(_selectedDate)}'),
                          ),
                          FlatButton(
                            highlightColor: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).disabledColor,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: _presentDatePicker,
                          ),
                        ],),                     
                      ),
                      Divider(thickness: 2.0,),
                      //Account
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Text(_accountName == null ? 'No account chosen' : _accountName),
                          ),
                          FlatButton(
                            highlightColor: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).disabledColor,
                            child: Text(
                              'Account',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              _navigateAndDisplayAccounts(context);
                            }
                          ),
                        ],),                     
                      ),
                      //Category
                      Divider(thickness: 2.0,),                    
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(children: <Widget>[
                          Expanded(                           
                              child: _categoryName == null 
                              ? Text('No category chosen')                                
                              : Row(children: <Widget>[Text(_categoryName), IconListImage(category.iconPath)], mainAxisAlignment: MainAxisAlignment.spaceAround,),
                          ),
                          FlatButton(
                            highlightColor: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).disabledColor,
                            child: Text(
                              'Category',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: (){
                              _navigateAndDisplayCategories(context);
                            }
                          ),
                        ],),                     
                      ),
                      Divider(thickness: 2.0,),
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
                      Divider(thickness: 2.0,),
                      //Debit or Credit
                      SwitchListTile(
                        title: Text('Debit or Credit'),
                        value: _editTransaction.credit,
                        subtitle:
                            Text('Debit is off, Credit is on'),
                        onChanged: (bool val) {
                          setState(() => _editTransaction.credit = val);
                        },
                      ),    
                      Divider(thickness: 2.0,),
                      //Used in Cash Flow                                    
                      SwitchListTile(
                        title: Text('Use in Financial Facts'),
                        value: _editTransaction.useForCashFlow,
                        subtitle:
                            Text('Include or Exclude from the Facts run'),
                        onChanged: (bool val) {
                          setState(() => _editTransaction.useForCashFlow = val);
                        },
                      ),
                      Divider(thickness: 2.0,),
                    ],
                  ),
                ),
              ),
      );
    } catch(error){
      throw Exception('PlannedTransactionScreen.build: ' + error.toString());
    }
  }
}
