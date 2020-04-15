//System
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
//Widgets
import '../widgets/app_drawer.dart';
import '../widgets/home_card.dart';
//Screens
import '../screens/cash_flow_screen.dart';
//Providers
import '../providers/cash_flow_provider.dart';
import '../providers/accounts_provider.dart';
import '../providers/settings_provider.dart';
//Models
import '../models/account.dart';
import '../models/cash_flow_item.dart';
//Help
import '../settings/help/help_common.dart';

class HomeScreen  extends StatefulWidget {
  static const routeName = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CashFlowProvider cfp;
  AccountsProvider ap;
  SettingsProvider sp;
  List<Account> accounts;
  Account selectedAccount;
  var datt = DateFormat('dd/MM/yy');
  DateTime endDate;
  List<List<CashFlowItem>> frontCashFlows = [];

  Future<void> _refresh(BuildContext context, ) async {
    try{
      cfp = Provider.of<CashFlowProvider>(context, listen: true); //Listening
     
      await cfp.fetchAndSet(context);  //Gets everything from the database, if new sets up the database, this is the key to starting, each time home is run, all is reset
      ap = Provider.of<AccountsProvider>(context, listen: false);
      accounts = ap.items;
      if(accounts != null) accounts = ap.items.where((Account account) => account.usedForCashFlow).toList();        
      if(cfp.totalAccount != null && accounts.length > 1) accounts.add(cfp.totalAccount); 
      sp = Provider.of<SettingsProvider>(context, listen: false);  
    } catch(error){
      throw Exception('Home._refresh: ' + error.toString());
    }  
  }
  Widget _currentBalance(BuildContext context, double gap){
   
    String currencySymbol = sp.settingSymbols[0][sp.items[0].value];
    double currentBalance = cfp.balanceAt(context, DateFinish.this_day, frontCashFlows);
    double endthisMonth = cfp.balanceAt(context, DateFinish.end_this_month, frontCashFlows);
    double endNextMonth = cfp.balanceAt(context, DateFinish.end_next_month, frontCashFlows);
    return Column(children: <Widget>[
      HomeCard('Today\'s Balance', currentBalance, currencySymbol, gap),
      HomeCard('End of this Month\'s Balance', endthisMonth, currencySymbol, gap),
      HomeCard('End of next Month\'s Balance', endNextMonth, currencySymbol, gap),
    ],);
  }
  @override
  Widget build(BuildContext context) {
    try{
     
      double _screenWidth = MediaQuery.of(context).size.width;
      double _screenHeight = MediaQuery.of(context).size.height;
      // debugPrint ('Heigth used is $_screenHeight');
      double _usedWidth; double _gap;

      if(_screenHeight > 810){
        _gap = 25;
      } else if (_screenHeight > 650){
        _gap = 20;
      } else {
        _gap = 10;
      }
      
      bool _disableSetup = false;

      return Scaffold(
        
        appBar: AppBar(title: Text('Future Finance Facts'),),        
        drawer: AppDrawer(),
        body: SingleChildScrollView(
                  child: FutureBuilder(
          future: _refresh(context),
          builder: (_, snapshot) => 
          snapshot.connectionState == ConnectionState.waiting 
          ? Center(child: CircularProgressIndicator(),)
          : RefreshIndicator(
              onRefresh: () =>_refresh(context),
              child: Consumer<CashFlowProvider>(              
                builder: (__, prov, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Cash Flow Button
                      Center(                       
                        child: Container(
                            child: Builder(
                              builder: (context) => FlatButton(
                              child: Text('Run Finance Facts', style: TextStyle(fontSize: 15),),
                              onPressed: (){
                                  try{
                                    if(sp != null) endDate = DateTime.tryParse(sp.items[1].value);
                                    setState(() {
                                      cfp.cashFlowTillEndDate(context);
                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Successfully ran Facts till ' + ((endDate == null) ? '' : datt.format(endDate))),duration: Duration(seconds: 3),));
                                    });                                                                                         
                                  } catch(error){
                                    var outError = 'Running Finance Facts Error ' + error.toString();
                                    Clipboard.setData(new ClipboardData(text: outError));
                                    showDialog(
                                      context: context, 
                                      builder: (context) => AlertDialog(
                                        title: Text('Trying to Run Finance Facts Error'), 
                                        content: Text('Error Data has been copied to the clipboard: ' + outError),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('OK'),
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              },
                          ),                                                          
                            ),
                          margin: EdgeInsets.only(left: _gap, right: _gap, top: 2 * _gap, bottom: _gap),
                          width: 200,
                          height: 80,
                          padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),                        
                          decoration: BoxDecoration(             
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                            color: Colors.purple,
                            gradient: LinearGradient(
                              colors: [HC.clgl, HC.clgr],
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
                            ],),                                                                                     
                          ),
                      ),
                      
                        

                      //Combo box for selecting account
                      Container(
                          child: Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 0),
                              child: Text('Finance Facts')
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: DropdownButton<Account>(
                                disabledHint: Text('Run Facts'),
                                hint: Text('Select Account'),
                                value: null,
                                
                                onChanged: (Account newValue){
                                  try{
                                    selectedAccount = newValue; 
                                    Navigator.of(context).pushNamed(CashFlowScreen.routeName, arguments: selectedAccount.id);
                                  } catch(error){
                                    var outError = 'Showing Finance Facts Error ' + error.toString();
                                    Clipboard.setData(new ClipboardData(text: outError));
                                    showDialog(
                                      context: context, 
                                      builder: (context) => AlertDialog(
                                        title: Text('Showing Finance Facts Error'), 
                                        content: Text('Error Data has been copied to the clipboard: ' + outError),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('OK'),
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },                                                   
                                items: (prov.cashFlowItems.length == 0 || prov.cashFlowDirty) ? null : accounts.map((Account account){
                                  return DropdownMenuItem<Account>(
                                    value: account,
                                    child: Text(
                                      account.accountName,
                                      style: TextStyle(color: Colors.black),
                                      ),
                                  );
                                }).toList(),

                              ),
                            ),
                          ],),
                          margin: EdgeInsets.all(_gap),
                          width: 200,
                          height: 80,
                          padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),                        
                          decoration: BoxDecoration(             
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                            color: Colors.purple,
                            gradient: LinearGradient(
                              colors: [HC.clgl, HC.clgr],
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
                      ),
                      _currentBalance(context, _gap),
                      // RaisedButton(
                      //   elevation: 5,
                      //   child: Text('Set Up', style: TextStyle(fontSize: 10),),
                      //   onPressed: (){
                      //     _disableSetup 
                      //     ? null 
                      //     : prov.setUpFromNew(context);
                      //     debugPrint('Finished Setting Up');
                      //   },
                      // ),                    
                    ],
                  ),
              ),
          ),
          ),
        ),        
      );
    } catch (error){
      //To do 
    }
  }
}