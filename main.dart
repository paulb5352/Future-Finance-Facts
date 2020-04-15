//System
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
//Providers
import './providers/categories_provider.dart';
import './providers/settings_provider.dart';
import './providers/accounts_provider.dart';
import './providers/planned_transactions_provider.dart';
import './providers/recurrences_provider.dart';
import './providers/transfers_provider.dart';
import './providers/cash_flow_provider.dart';
//Screens
import './screens/planned_transaction_screen.dart';
import './screens/planned_transactions_screen.dart';
import './screens/recurrences_screen.dart';
import './screens/recurrence_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_screen.dart';
import './screens/accounts_screen.dart';
import './screens/account_screen.dart';
import './settings/settings_screen.dart';
import './screens/transfers_screen.dart';
import './screens/transfer_screen.dart';
import './screens/home_screen.dart';
import './screens/cash_flow_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PlannedTransactionProvider()),
        ChangeNotifierProvider.value(value: AccountsProvider()),
        ChangeNotifierProvider.value(value: CategoriesProvider()),
        ChangeNotifierProvider.value(value: SettingsProvider()),
        ChangeNotifierProvider.value(value: RecurrencesProvider()),
        ChangeNotifierProvider.value(value: TransfersProvider(),),
        ChangeNotifierProvider.value(value: CashFlowProvider(),)
      ],
      child: MaterialApp( 
        debugShowCheckedModeBanner: false,
        title: 'Future Finance Facts',
        theme: ThemeData(primarySwatch: Colors.blue, accentColor: Colors.grey, fontFamily: 'Quicksand', scaffoldBackgroundColor: Colors.white,
          textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 18,), button: TextStyle(color: Colors.white),),  
          appBarTheme: AppBarTheme( 
            textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontFamily: 'OpenSans',fontSize: 20,fontWeight: FontWeight.bold, color: Color(0xFFFFA726)),),
            color: Color(0xFF546E7A),
          ),
        ),             
        home: HomeScreen(),
        routes: {
          PlannedTransactionScreen.routeName: (_) => PlannedTransactionScreen(),
          PlannedTransactionsScreen.routeName: (_) => PlannedTransactionsScreen(),
          RecurrencesScreen.routeName: (_) => RecurrencesScreen(),
          RecurrenceScreen.routeName: (_) => RecurrenceScreen(),
          AccountsScreen.routeName: (_) => AccountsScreen(),
          AccountScreen.routeName: (_) => AccountScreen(),
          CategoriesScreen.routeName: (_) => CategoriesScreen(),
          CategoryScreen.routeName: (_) => CategoryScreen(),
          SettingsScreen.routeName: (_) => SettingsScreen(),
          TransfersScreen.routeName: (_) => TransfersScreen(),
          TransferScreen.routeName: (_) => TransferScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
          CashFlowScreen.routeName: (_) => CashFlowScreen(),
        },
      ),
    );    
  }
}
