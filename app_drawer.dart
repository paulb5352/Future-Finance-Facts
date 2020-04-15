//System
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Screens
import '../screens/accounts_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/recurrences_screen.dart';
import '../settings/settings_screen.dart';
import '../screens/transfers_screen.dart';
import '../screens/planned_transactions_screen.dart';
import '../screens/home_screen.dart';
//Transitions
import '../transitions/slide_right_route.dart';
import '../transitions/scale_route.dart';
import '../transitions/size_route.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    try{
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/bank_of_england_fade.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: (){
                Navigator.popAndPushNamed(context, HomeScreen.routeName);
              },
            ),
            Divider(thickness: 1.0,),          
            ListTile(
              leading: Icon(Icons.account_balance),
              title: Text('Accounts'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, SlideRightRoute(page: AccountsScreen()));
            },
            ),
            Divider(thickness: 1.0,),
            ListTile(
              leading: Icon(Icons.blur_circular),
              title: Text('Categories'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context ,ScaleRoute(page: CategoriesScreen()));
              },
            ),
            Divider(thickness: 1.0,),
            ListTile(
              leading: Icon(Icons.cached),
              title: Text('Recurrences'),
              onTap: (){
                Navigator.pop(context);              
                Navigator.push(context ,SlideRightRoute(page: RecurrencesScreen()));             
              },
            ),
            Divider(thickness: 1.0,),
            ListTile(
              leading: Icon(Icons.swap_horiz),
              title: Text('Transfers'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context ,SizeRoute(page: TransfersScreen()));               
              },
            ),
            Divider(thickness: 1.0,),           
            ListTile(
              leading: Icon(Icons.swap_vert),
              title: Text('Planned Transactions'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context ,SlideRightRoute(page: PlannedTransactionsScreen()));
              },
            ),
            Divider(thickness: 1.0,),                  
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context ,SlideRightRoute(page: SettingsScreen()));
              },
            ),
        ],),
      );
    } catch(error){
      var outError = 'AppDrawer ' + error.toString();
      Clipboard.setData(new ClipboardData(text: outError));
      showDialog(
        context: context, 
        child: AlertDialog(
          title: Text('Application Error'), 
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
  }

}