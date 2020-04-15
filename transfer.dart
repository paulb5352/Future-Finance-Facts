import 'package:flutter/widgets.dart';
import './trans_base.dart';

class Transfer extends TransBase {
  
  String description;
  int fromAccountId;
  int toAccountId;
  int recurrenceId;
  bool useForCashFlow;
  Transfer({
    @required id,
    @required title,
    @required this.description,
    @required this.fromAccountId,
    @required this.toAccountId,
    @required this.recurrenceId,
    @required amount,
    @required plannedDate,
    this.useForCashFlow = true,
  }) : super(id: id, title: title, plannedDate: plannedDate, amount: amount);
}