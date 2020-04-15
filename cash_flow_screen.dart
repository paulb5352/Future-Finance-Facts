//System
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
//Providers
import '../providers/cash_flow_provider.dart';
//Models
import '../models/cash_flow_item.dart';
import '../models/account.dart';
//Helpers
import '../settings/help/help_common.dart';

class CashFlowScreen extends StatefulWidget {
  static const routeName = 'CashFlowScreen';

  @override
  _CashFlowScreenState createState() => _CashFlowScreenState();
}

class _CashFlowScreenState extends State<CashFlowScreen> {
  final double _standardScreen = 366.0;
  Account account;
  List<CashFlowItem> cashFlow;
  var _isInit = true;

  double _scaleWidth = 260.0;
  double _scaleUsed = 0.0;
  double _cfWidth = 0.0;
  double _barHeight = 23.0;
  double _barTotalHeight = 30.0;
  int _noChildren = 0;
  double maxCashFlowBalance = 0.0;
  double minCashFlowBalace = 0.0;
  Color _barColor;
  AssetImage _barGradient;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      int accountid = ModalRoute.of(context).settings.arguments;
      List<List<CashFlowItem>> cfls = Provider.of<CashFlowProvider>(context, listen: false).cashFlowItems;
      outerLoop: for(var cfl in cfls){
        if(cfl.length != 0){
          if(cfl[0].action.account.id == accountid){
            cashFlow = cfl;
            break outerLoop;
          }
        }
      }
      for(var cfi in cashFlow){
        if (cfi.balance > maxCashFlowBalance) maxCashFlowBalance = cfi.balance;
        if (cfi.balance < minCashFlowBalace) minCashFlowBalace = cfi.balance;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _showDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Transaction Details'),
          content: new Text(cashFlow[index].dialogData),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    try{
      _noChildren = cashFlow.length;
      double _maxScaling = math.max(maxCashFlowBalance, minCashFlowBalace.abs());
      double _screenWidth = MediaQuery.of(context).size.width;
      _scaleUsed = _scaleWidth * _screenWidth/_standardScreen;
      if(_maxScaling <= 0) _maxScaling = 1;
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.black26,),
              backgroundColor: Colors.white,
              pinned: true,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: RichText(text: TextSpan(children: <TextSpan>[TextSpan(text: 'Future Finance Facts', style: HC.stb),],),),
                background: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/cashFlowCoins.png')),
                  ),
                ),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: _barTotalHeight,            
              delegate: SliverChildBuilderDelegate((_, index){
                _cfWidth = _scaleUsed * cashFlow[index].balance/_maxScaling;
                if(_cfWidth < 0){
                  _barColor = Colors.red;
                  _barGradient = AssetImage('assets/images/red_gradient.jpg');
                  _cfWidth = _cfWidth.abs();
                } else {
                  _barGradient = AssetImage('assets/images/gold-gradient.jpg');
                  _barColor = Colors.black;
                }
                return Stack(
                  
                  children: <Widget>[
                    GestureDetector(
                        onTap: (){
                          _showDialog(context, index);
                        } ,
                        child: Container(
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide(width: 1, color: Colors.indigo[900]), bottom: BorderSide(width: 1, color: Colors.indigo[900]), left: BorderSide(width: 1, color: Colors.indigo[900]), right: BorderSide(width: 1, color: Colors.indigo[900])),
                          // color: _barColor,
                          image: DecorationImage(image: _barGradient, fit: BoxFit.fill,),
                        ),                     
                        constraints: BoxConstraints(
                          maxWidth: _scaleUsed,
                          minWidth: _cfWidth >=_scaleUsed ? _scaleUsed : _cfWidth,
                          minHeight: _barHeight,
                        ),                     
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, top: 4),
                          child: Text(''),
                        ),
                      ),
                    ),
                    Positioned(
                      child: 
                      GestureDetector(
                        onTap: (){
                          _showDialog(context, index);
                        } ,                        
                        child: Text(cashFlow[index].summary, style: TextStyle(fontSize: 10, color: _barColor),)
                        ),
                      left: _cfWidth + 10,
                      top: 8,
                    ),                                  
                  ],                
                );              
              },
              childCount: _noChildren,    
              ),
            ),
          ],
        ),
      );
    } catch(error){
      throw Exception('CashFlowScreen ' + error.toString());
    }    
  }
}