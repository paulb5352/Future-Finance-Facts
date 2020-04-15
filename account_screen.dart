import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
//Providers
import '../providers/accounts_provider.dart';
import '../providers/cash_flow_provider.dart';
//Models
import '../models/account.dart';
//Widgets
import '../models/list_tile_base.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = 'AccountScreen';

  @override
  _AccountScreenState createState() => _AccountScreenState();
}
class _AccountScreenState extends State<AccountScreen> {

  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var _editAccount = Account(
      id: -1,
      accountName: '',
      description: '',
      balance: 0.00,
      usedForCashFlow: true,
      usedForSummary: true,
      );

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final ListTileBase args = ModalRoute.of(context).settings.arguments;
      if (args != null) {
        _editAccount = Provider.of<AccountsProvider>(context, listen: false).findById(args.id);
      }

    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    try{
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if (_editAccount.id >= 0) { 
        await Provider.of<AccountsProvider>(context, listen: false).updateAccount(_editAccount);         
      } else {
        await Provider.of<AccountsProvider>(context, listen: false).addAccount(_editAccount);          
      }
      
      Navigator.of(context).pop();
      setState(() {
        _isLoading = false;
      });
      Provider.of<CashFlowProvider>(context).cashFlowDirty = true;
    } catch (error){
      var outError = 'Saving Account ' + error.toString();
      Clipboard.setData(new ClipboardData(text: outError));
      showDialog(
        context: context, 
        child: AlertDialog(
          title: Text('Trying to save Account Error'), 
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

  @override
  Widget build(BuildContext context) {   
    try{
      return Scaffold(
        appBar: AppBar(
          title: Text('An Account'),
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
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      //Name
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          maxLength: 40,
                          decoration: InputDecoration(
                            labelText: 'Account Name',
                          ),
                          initialValue: _editAccount.accountName,
                          textInputAction: TextInputAction.none,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a valid Account Name';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => _editAccount.accountName = value,
                        ),
                      ),
                      //Description
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          maxLength: 80,
                          decoration: InputDecoration(
                            labelText: 'Account Description',
                          ),
                          initialValue: _editAccount.description,
                          textInputAction: TextInputAction.none,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a valid Account Description';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => _editAccount.description = value,
                        ),
                      ),
                      //Balance
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          maxLength: 8,
                          decoration: InputDecoration(
                            labelText: 'Account Balance',
                          ),
                          initialValue: _editAccount.balance.toString(),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.none,
                          onFieldSubmitted: (_) => _saveForm(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'please enter an Account balance';
                            }
                            if (double.tryParse(value) == null) {
                              return 'please enter a valid number for the Account balance';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _editAccount.balance = double.parse(value),
                        ),
                      ),
                      //Use in Cash Flow
                      SwitchListTile(
                        title: Text('Use in Financial Facts'),
                        value: _editAccount.usedForCashFlow,
                        subtitle:
                            Text('Include or Exclude from the Facts run'),
                        onChanged: (bool val) {
                          setState(() => _editAccount.usedForCashFlow = val);
                        },
                      ),
                      //Used in Summary
                      // SwitchListTile(
                      //   title: Text('Use in Summary'),
                      //   value: _editAccount.usedForSummary,
                      //   subtitle:
                      //       Text('Home page \"till the end of the month\" summary'),
                      //   onChanged: (bool val) {
                      //     setState(() => _editAccount.usedForSummary = val);
                      //   },
                      // ),                    
                      // Divider(thickness: 2.0,),
                    ],
                  ),
                ),
              ),
      );
    } catch(error){
      throw Exception('AccountScreen.build: ' + error.toString());
    }
  }
}
