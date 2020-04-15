import './trans_base.dart';
import './account.dart';

class CashAction {
  TransBase tb;
  Account account;
  double amount;
  DateTime plannedDate;

  CashAction({this.tb, this.account, this.amount, this.plannedDate});
}