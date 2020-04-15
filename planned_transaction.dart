import 'package:flutter/material.dart';
import './trans_base.dart';

class PlannedTransaction extends TransBase {

  String description;
  int accountId;
  int categoryId;
  int recurrenceId;
  bool credit;
  bool useForCashFlow;
  PlannedTransaction({
    @required id,
    @required title,
    @required this.description,
    @required this.accountId,
    @required this.categoryId,
    @required this.recurrenceId,
    @required amount,
    @required this.credit,
    @required plannedDate,
    this.useForCashFlow = true,
  }) : super(id: id, title: title, plannedDate: plannedDate, amount: amount);
  PlannedTransaction clone(){
    return PlannedTransaction(
      id: this.id,
      title: this.title,
      description: this.description,
      accountId: this.accountId,
      categoryId: this.categoryId,
      recurrenceId: this.recurrenceId,
      amount: this.amount,
      credit: this.credit,
      plannedDate: this.plannedDate,
      useForCashFlow: this.useForCashFlow
    );
  }
}