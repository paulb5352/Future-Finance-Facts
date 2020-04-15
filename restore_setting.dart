//System
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/services.dart';
//Models
import '../models/account.dart';
import '../models/category.dart';
import '../models/recurrence.dart';
import '../models/transfer.dart';
import '../models/planned_transaction.dart';
import '../models/setting.dart';
//Providers
import '../providers/accounts_provider.dart';
import '../providers/categories_provider.dart';
import '../providers/recurrences_provider.dart';
import '../providers/transfers_provider.dart';
import '../providers/planned_transactions_provider.dart';
import '../providers/settings_provider.dart';
//Helpers
import '../helpers/DbBase.dart';

class RestoreSettings extends StatelessWidget {

  final String _fileName;

  RestoreSettings(this._fileName);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restore Data'),),
      body: FutureBuilder<Text>(
        future: _convertJsonToObject(context, _fileName),
        builder: (context, AsyncSnapshot<Text> snapshot){
          if(snapshot.hasError){
            var errorOutput = 'Error message: ' + snapshot.error.toString();
            return SingleChildScrollView(
                child: Center(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(60),
                    child: Text('ERROR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(60),
                    child: Text('Your file could not be read, this may well be down to permissions on your device, to solve this please enter settings, then app permissions and then storage, give the app permission to use storage. Ensure you have $_fileName.txt in your downloads folder'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Text('Error text, long press to copy to clipboard', style: TextStyle(color: Colors.red),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 60, right: 60),
                    child: GestureDetector(
                      child: Text(errorOutput),
                      onLongPress: (){
                        Clipboard.setData(new ClipboardData(text: errorOutput));
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Error Text copied to clipboard'),));
                      },
                    ),
                  ),                
                ],),
              ),
            );

          } else if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
                child: Center(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(60),
                    child: Text('SUCCESS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(60),
                    child: Text('Your restore has been completed and your app is ready for use.'),
                  ),
                ],),
              ),
            );

          }
        },
        ),
      
    );
  }

  Future<Text> _convertJsonToObject(BuildContext context, String fileName) async {

    try{

      
      String jsondata;
      jsondata = await readJson(fileName);  
        
      List<Account> accounts = [];
      List<Category> categories = [];
      List<Recurrence> recurrences = [];
      List<Transfer> transfers = [];
      List<PlannedTransaction> transactions = [];
      List<Setting> settings = [];

      
      final extractedData = json.decode(jsondata) as Map<String, dynamic>;
      //Account
      List<dynamic> accountMaps = extractedData['Account'];
      if(accountMaps != null && accountMaps.length > 0){
        for(var map in accountMaps){
          accounts.add(
            Account(
              id: map[AccountNames.id],
              accountName: map[AccountNames.accountName],
              description: map[AccountNames.description],
              balance: map[AccountNames.balance],
              usedForCashFlow: map[AccountNames.usedForCashFlow],
              usedForSummary: map[AccountNames.usedForSummary]
            )
          );
        }
      }
      //Category
      List<dynamic> categoryMaps = extractedData['Category'];
      if(categoryMaps != null && categoryMaps.length > 0){
        for(var map in categoryMaps){
          categories.add(
            Category(
              id: map[CategoryNames.id],
              categoryName: map[CategoryNames.categoryName],
              description: map[CategoryNames.description],
              iconPath: map[CategoryNames.iconPath],
              useForCashFlow: map[CategoryNames.usedForCashFlow]
            )
          );
        }
       
      }
      //Recurrence
      List<dynamic> recurrenceMaps = extractedData['Recurrence'];
      if(recurrenceMaps != null && recurrenceMaps.length > 0){
        for(var map in recurrenceMaps){
          recurrences.add(
            Recurrence(
              id: map[RecurrenceNames.id],
              title: map[RecurrenceNames.title],
              description: map[RecurrenceNames.description],
              iconPath: map[RecurrenceNames.iconPath],
              type: map[RecurrenceNames.type],
              noOccurences: map[RecurrenceNames.noOccurences],
              endDate: map[RecurrenceNames.endDate].length == 0 ? null : map[RecurrenceNames.endDate]
            )
          );
        }
        
      }
      //Transfer
      List<dynamic> transferMaps = extractedData['Transfer'];
      if(transferMaps != null && transferMaps.length > 0){
        for(var map in transferMaps){
          transfers.add(
            Transfer(
              id: map[TransfersNames.id],
              title: map[TransfersNames.title],
              description: map[TransfersNames.description],
              toAccountId: map[TransfersNames.toAccountId],
              fromAccountId: map[TransfersNames.fromAccountId],
              amount: map[TransfersNames.amount],
              plannedDate: map[TransfersNames.plannedDate],
              recurrenceId: map[TransfersNames.recurrenceId],
              useForCashFlow: map[TransfersNames.usedForCashFlow]
            )
          );
        }
        
      }
      //Transactions
      List<dynamic> transactionMaps = extractedData['Planned Transactions'];
      if(transactionMaps != null && transactionMaps.length > 0){
        for(var map in transactionMaps){
          transactions.add(
            PlannedTransaction(
              id: map[PlannedTransactionNames.id],
              title: map[PlannedTransactionNames.title],
              description: map[PlannedTransactionNames.description],
              accountId: map[PlannedTransactionNames.accountId],
              categoryId: map[PlannedTransactionNames.categoryId],
              amount: map[PlannedTransactionNames.amount],
              credit: map[PlannedTransactionNames.credit],
              plannedDate: map[PlannedTransactionNames.plannedDate],
              recurrenceId: map[PlannedTransactionNames.recurrenceId],
              useForCashFlow: map[PlannedTransactionNames.usedForCashFlow]
            )
          );
        }
        
      }
      //Settings
      List<dynamic> settingMaps = extractedData['Setting'];
      if(settingMaps != null && settingMaps.length > 0){
        for(var map in settingMaps){
          settings.add(
            Setting(
              id: map[SettingNames.id],
              identifier: map[SettingNames.identifier],
              value: map[SettingNames.value]
            )
          );
        }
        
      }
      await DbBase.cleanDatabase();
      
      //Save the data to the database
      if(accounts != null){
        for(var account in accounts){
          await Provider.of<AccountsProvider>(context, listen: false).addAccount(account);
        }        
      }
      
      if(categories != null){
        for(var category in categories){
          await Provider.of<CategoriesProvider>(context, listen: false).addCategory(category);
        }        
      }
      
      if(recurrences != null){
        for(var recurrence in recurrences){
          await Provider.of<RecurrencesProvider>(context, listen: false).addRecurrence(recurrence);
        }        
      }
      
      if(transactions != null){
        for(var plan in transactions){
          await Provider.of<PlannedTransactionProvider>(context, listen: false).addTransaction(plan);
        }        
      }
      
      if(transfers != null){
        for(var transfer in transfers){
          await Provider.of<TransfersProvider>(context, listen: false).addTransfer(transfer);
        }        
      }
      
      if(settings != null){
        for(var setting in settings){
          await Provider.of<SettingsProvider>(context, listen: false).addSettings(setting);
        }        
      }
      
      return Text('restored all data');
  } catch (error){
    throw Exception('Error in Restore ' + error.toString());
  }    
}




  Future<String> readJson(String fileName) async { 
    try{  
      final directory = await _downloadsPath;
      final file = File('${directory.path}/$fileName.txt');
      return await file.readAsString();
    } catch (error){
      throw error;
    }
  } 

  Future<Directory> get _downloadsPath async {
    try{
      final directory = DownloadsPathProvider.downloadsDirectory;
      return directory;
    } catch (error){
      throw error;
    }
  }   
}