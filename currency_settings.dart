import '../providers/settings_provider.dart';
import '../providers/cash_flow_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum CurrencyOptions {
  Dollar,
  Pound,
  Yen,
  Euro
}

class CurrencySettings extends StatefulWidget {
  final String _identifier;
  String _value;
  final SettingsProvider _sp;
  final int _i;

  CurrencySettings(this._i, this._identifier, this._value, this._sp);

  @override
  _CurrencySettingsState createState() => _CurrencySettingsState();
}

class _CurrencySettingsState extends State<CurrencySettings> {
  @override
  Widget build(BuildContext context) { 
    return ListTile(
      title: Text(widget._identifier),
      subtitle: Text(widget._value),
      trailing: PopupMenuButton(
        onSelected: (CurrencyOptions selectedCurrency) {
          switch (selectedCurrency){
            case CurrencyOptions.Dollar:
              widget._sp.items[widget._i].value = SettingNames.currencyNames[SettingNames.c_dollar];
              break;
            case CurrencyOptions.Pound:
              widget._sp.items[widget._i].value = SettingNames.currencyNames[SettingNames.c_pound];
              break;
            case CurrencyOptions.Yen:
              widget._sp.items[widget._i].value = SettingNames.currencyNames[SettingNames.c_yen];
              break;
            case CurrencyOptions.Euro:
              widget._sp.items[widget._i].value = SettingNames.currencyNames[SettingNames.c_euro];
              break;                                       
          }
          widget._sp.updateSetting(widget._sp.items[widget._i]);           
          setState(() {
            widget._value = widget._sp.settingSymbols[widget._sp.cS][widget._sp.items[widget._i].value];
            Provider.of<CashFlowProvider>(context, listen: false).cashFlowDirty = true;
          });         
        },
        icon: Icon(Icons.more_vert),
        itemBuilder: (_) => [
          PopupMenuItem(
            child: Text(SettingNames.currencyNames[SettingNames.c_dollar]),
            value: CurrencyOptions.Dollar,
          ),
          PopupMenuItem(
            child: Text(SettingNames.currencyNames[SettingNames.c_pound]),
            value: CurrencyOptions.Pound,
          ),
          PopupMenuItem(
            child: Text(SettingNames.currencyNames[SettingNames.c_yen]),
            value: CurrencyOptions.Yen,
          ),
          PopupMenuItem(
            child: Text(SettingNames.currencyNames[SettingNames.c_euro]),
            value: CurrencyOptions.Euro,
          ),                                    
        ],
      ),                                
    );
  }
}