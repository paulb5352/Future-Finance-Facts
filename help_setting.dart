import 'package:flutter/material.dart';
//Help
import './help/introduction_help.dart';
import './help/main_beneifts_help.dart';
import './help/run_financial_facts_help.dart';
import './help/main_screen_help.dart';
import './help/side_drawer_help.dart';
import './help/settings_help.dart';
import './help/planned_date_help.dart';
import './help/add_account_help.dart';
import './help/add_category_help.dart';
import './help/add_recurrence_help.dart';
import './help/mortgage_calculator_help.dart';
import './help/transfer_help.dart';
import './help/planned_transaction_help.dart';
import './help/open_save_help.dart';
import './help/change_currency_help.dart';
import './help/facts_each_account_help.dart';
import './help/add_salary_help.dart';
import './help/add_car_loan_help.dart';
import './help/add_mortgage_help.dart';
import './help/ongoing_costs_help.dart';
import './help/storage_permission_help.dart';

class HelpSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help Menu'),),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
          ListTile(
            title: Text('Introduction'),
            subtitle: Text('What is Future Finance Facts?'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => IntroductionHelp())),
              ),
          ),
          ListTile(
            title: Text('Main Benefits'),
            subtitle: Text('How do I gain from using it?'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainBenefitsHelp())),
            ),
          ),
          ListTile(
            title: Text('Run Financial Facts'),
            subtitle: Text('Show your financial future'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RunFinancialFactsHelp())),
            ),
          ),
          ListTile(
            title: Text('The Main Screen'),
            subtitle: Text('What each box shows'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreenHelp())),
            ),
          ),
          ListTile(
            title: Text('Giving Storage Permission'),
            subtitle: Text('The importance of giving storage permission'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StoragePermissionHelp())),
            ),
          ),
          ListTile(
            title: Text('Accessing the Menu'),
            subtitle: Text('The side drawer'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SideDrawerHelp())),
            ),
          ),
          ListTile(
            title: Text('Settings'),
            subtitle: Text('The Settings Menu'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsHelp())),
            ),
          ),
          ListTile(
            title: Text('Change Planned Date'),
            subtitle: Text('The finish date for Financial Facts'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlannedDateHelp())),
            ),
          ),
          ListTile(
            title: Text('Add an Account'),
            subtitle: Text('Add a bank account to your App'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddAccountHelp())),
            ),
          ),
          ListTile(
            title: Text('Add a Category'),
            subtitle: Text('Add a new Category for a financial transaction'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategoryHelp())),
            ),
          ),          
          ListTile(
            title: Text('Add a Recurrence'),
            subtitle: Text('Add a new Recurrence for a financial transaction'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddRecurrenceHelp())),
            ),
          ),
          ListTile(
            title: Text('Mortgage Calculator'),
            subtitle: Text('Calculate the monthly payments'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MortgageCalculatorHelp())),
            ),
          ),
          ListTile(
            title: Text('Transfers'),
            subtitle: Text('Transfer money between accounts'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TransferHelp())),
            ),
          ),
          ListTile(
            title: Text('Planned Transactions'),
            subtitle: Text('How to setup a Planned Transaction'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlannedTransactionHelp())),
            ),
          ),
          ListTile(
            title: Text('Open and Save files'),
            subtitle: Text('Save your work in a file'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OpenSaveHelp())),
            ),
          ),
          ListTile(
            title: Text('Change Currency'),
            subtitle: Text('Change your currency'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeCurrencyHelp())),
            ),
          ),
          ListTile(
            title: Text('Facts for different Accounts'),
            subtitle: Text('Select which account to see the Financial Facts'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FactsEachAccountHelp())),
            ),
          ),
          ListTile(
            title: Text('Add Your Salary'),
            subtitle: Text('Add your salary to the App'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddSalaryHelp())),
            ),
          ),
          ListTile(
            title: Text('Add Your Car Loan'),
            subtitle: Text('Add your car loan to your financial future'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddCarLoanHelp())),
            ),
          ),
          ListTile(
            title: Text('Add Your Mortgage'),
            subtitle: Text('Add your mortgage to your financial future'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddMortgageHelp())),
            ),
          ),
          ListTile(
            title: Text('Typical Ongoing Cost'),
            subtitle: Text('To help you to put all future facts into the App'),
            trailing: IconButton(
              icon: Icon(Icons.launch),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OngoingCostsHelp())),
            ),
          ),
        ],),
      ),
      
    );
  }
}