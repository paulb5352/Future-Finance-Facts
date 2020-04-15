import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../settings/help/help_common.dart';

class CirclePrice extends StatelessWidget {
  CirclePrice({@required this.price, });
  final double price;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context, listen: false);
    final currencySetting = provider.findCurrency();
    var numb = NumberFormat.currency(symbol: provider.settingSymbols[0][currencySetting.value]);
    return CircleAvatar(
      backgroundColor: HC.cltx,
      maxRadius: 25,
      minRadius: 20,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: FittedBox(
          child: Text(
            numb.format(price),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}