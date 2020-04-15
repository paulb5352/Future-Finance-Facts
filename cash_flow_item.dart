import './cash_action.dart';

class CashFlowItem {
  double balance;
  CashAction action;
  bool isMulti = false;
  List<CashAction> actions = null;
  String summary;
  String dialogData;
  
  CashFlowItem({this.balance, this.action});

  
}