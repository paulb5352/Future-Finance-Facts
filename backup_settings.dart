//System
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
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

class BackupSettings extends StatelessWidget {

  final String _fileName;

  BackupSettings(this._fileName);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(     
      appBar: AppBar(title: Text('Save File'),),
      body: FutureBuilder<Text>(
        future: _createFile(context),
        builder: (context, AsyncSnapshot<Text> snapshot){
          if(snapshot.hasError){  
            var errorOutput = 'Error message: ' + snapshot.error.toString();          
            return SingleChildScrollView(
                child: Center(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(60),
                    child: Text(
                      'ERROR',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(60),
                    child: Text('Your file $_fileName.txt not be saved, this may well be down to permissions on your device, to solve this please enter settings, then app permissions and then storage, give the app permission to use storage.', 
                            style: TextStyle(fontSize: 18), softWrap: true,
                            ),
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
            
          } else if (snapshot.connectionState == ConnectionState.waiting) {  
            
            return Center(child: new CircularProgressIndicator());
          
          } else {

            return SingleChildScrollView(
                child: Center(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(60),
                    child: Text(
                      'SAVE SUCCESS',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(60),
                    child: Text('Your file $_fileName.txt has been saved, it is in your downloads directory. Use your file app to find it, maybe use Google Drive or Dropbox app to save it. You can email it to your computer as well.', 
                            style: TextStyle(fontSize: 18), softWrap: true,
                            ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(60),
                    child: Text('To restore the file ($_fileName.txt) put it back in the downloads directory. This can be used for a new phone or to load a new data file.', 
                            style: TextStyle(fontSize: 18), softWrap: true,
                            ),
                  ),                
                ],),
              ),
            );
          }
        },
      ),
    );
  }
  Future<Text> _createFile(BuildContext context) async {
    try{
      var data = convertToJsonAndStore(context);           
      await saveJson(data);
      return Text('**** Saved Correctly ****');
    } catch (error){
      throw Exception('Failed to save backup file ' + error.toString());
    }
  }
  String convertToJsonAndStore(BuildContext context){

    List<Account> accounts = Provider.of<AccountsProvider>(context, listen: false).items;
    List<Category> categories = Provider.of<CategoriesProvider>(context, listen: false).items;
    List<Recurrence> recurrences = Provider.of<RecurrencesProvider>(context, listen: false).items;
    List<Transfer> transfers = Provider.of<TransfersProvider>(context, listen: false).items;
    List<PlannedTransaction> transactions = Provider.of<PlannedTransactionProvider>(context, listen: false).items;
    List<Setting> settings = Provider.of<SettingsProvider>(context, listen: false).items;
    // String out = '';
    
    var startJson = '{'; //start of the json file
    List<String> sections = [];
      
      if(accounts != null && accounts.length > 0){
        var out = '\"Account\": ';
        out = out + '[';
          for(var account in accounts){
            out = out + '{';
            out = out + '\"${AccountNames.id}\": ${account.id}, ';
            out = out + '\"${AccountNames.accountName}\": \"${account.accountName}\", ';
            out = out + '\"${AccountNames.description}\": \"${account.description??""}\", ';
            out = out + '\"${AccountNames.balance}\": ${account.balance}, ';
            out = out + '\"${AccountNames.usedForCashFlow}\": ${account.usedForCashFlow} ';
            out = out + '},';
          }
          out = out.substring(0, out.length - 1); //last object without a trailing comma
        out = out + ']';
        sections.add(out);      
      }

      if(settings != null && settings.length > 0){
        var out = '\"Setting\": ';
        out = out + '[';
          for(var setting in settings){
            out = out + '{';
            out = out + '\"${SettingNames.id}\": ${setting.id}, ';
            out = out + '\"${SettingNames.identifier}\": \"${setting.identifier}\", ';
            out = out + '\"${SettingNames.value}\": \"${setting.value}\" ';
            out = out + '},';
          }
          out = out.substring(0, out.length - 1); //last object without a trailing comma
        out = out + ']';
        sections.add(out);
      }
       
      if(categories != null && categories.length > 0){
        var out = '\"Category\": ';
        out = out + '[';
          for(var category in categories){
            out = out + '{';
            out = out + '\"${CategoryNames.id}\": ${category.id}, ';
            out = out + '\"${CategoryNames.categoryName}\": \"${category.categoryName}\", ';
            out = out + '\"${CategoryNames.description}\": \"${category.description??""}\", ';
            out = out + '\"${CategoryNames.iconPath}\": \"${category.iconPath}\", ';
            out = out + '\"${CategoryNames.usedForCashFlow}\": ${category.useForCashFlow} ';
            out = out + '},';          
          }
          out = out.substring(0, out.length - 1); //last object without a trailing comma
        out = out + ']';
        sections.add(out);        
      }

      if(recurrences != null && recurrences.length > 0){
        var out = '\"Recurrence\": ';
        out = out + '[';
          for(var recurrence in recurrences){
            out = out + '{';
            out = out + '\"${RecurrenceNames.id}\": ${recurrence.id}, ';
            out = out + '\"${RecurrenceNames.title}\": \"${recurrence.title}\", ';
            out = out + '\"${RecurrenceNames.description}\": \"${recurrence.description}\", ';
            out = out + '\"${RecurrenceNames.iconPath}\": \"${recurrence.iconPath}\", ';
            out = out + '\"${RecurrenceNames.endDate}\": \"${recurrence.endDate??""}\", '; //may need to convert dates later
            out = out + '\"${RecurrenceNames.noOccurences}\": ${recurrence.noOccurences}, ';
            out = out + '\"${RecurrenceNames.type}\": ${recurrence.type} ';
            out = out + '},';          
          }
          out = out.substring(0, out.length - 1); //last object without a trailing comma
        out = out + ']';
        sections.add(out);        
      }

      if(transfers != null && transfers.length > 0){
        var out = '\"Transfer\": ';
        out = out + '[';
          for(var transfer in transfers){
            out = out + '{';
            out = out + '\"${TransfersNames.id}\": ${transfer.id}, ';
            out = out + '\"${TransfersNames.title}\": \"${transfer.title}\", ';
            out = out + '\"${TransfersNames.description}\": \"${transfer.description}\", ';
            out = out + '\"${TransfersNames.toAccountId}\": ${transfer.toAccountId}, ';
            out = out + '\"${TransfersNames.fromAccountId}\": ${transfer.fromAccountId}, ';
            out = out + '\"${TransfersNames.recurrenceId}\": ${transfer.recurrenceId??""}, ';
            out = out + '\"${TransfersNames.plannedDate}\": \"${transfer.plannedDate}\", '; //may need to convert dates later
            out = out + '\"${TransfersNames.amount}\": ${transfer.amount}, ';
            out = out + '\"${TransfersNames.usedForCashFlow}\": ${transfer.useForCashFlow} ';
            out = out + '},';          
          }
          out = out.substring(0, out.length - 1); //last object without a trailing comma
        out = out + ']';
        sections.add(out);        
      }

      if(transactions != null && transactions.length > 0){
        var out = '\"Planned Transactions\": ';
        out = out + '[';
          for(var transaction in transactions){
            out = out + '{';
            out = out + '\"${PlannedTransactionNames.id}\": ${transaction.id}, ';
            out = out + '\"${PlannedTransactionNames.title}\": \"${transaction.title}\", ';
            out = out + '\"${PlannedTransactionNames.description}\": \"${transaction.description}\", ';
            out = out + '\"${PlannedTransactionNames.accountId}\": ${transaction.accountId}, ';
            out = out + '\"${PlannedTransactionNames.categoryId}\": ${transaction.categoryId}, ';
            out = out + '\"${PlannedTransactionNames.recurrenceId}\": ${transaction.recurrenceId??""}, ';
            out = out + '\"${PlannedTransactionNames.plannedDate}\": \"${transaction.plannedDate}\", '; //may need to convert dates later
            out = out + '\"${PlannedTransactionNames.amount}\": ${transaction.amount}, ';
            out = out + '\"${PlannedTransactionNames.credit}\": ${transaction.credit}, ';
            out = out + '\"${PlannedTransactionNames.usedForCashFlow}\": ${transaction.useForCashFlow} ';
            out = out + '},';          
          }
          out = out.substring(0, out.length - 1); //last object without a trailing comma
        out = out + ']';
        sections.add(out);        
      }

    var endJson = '}'; //end of the json file
    String out = '';
    for(var section in sections){
      out = out + section + ',';
    }
     out = out.substring(0, out.length - 1);
    return startJson + out + endJson;
  }
  Future<Directory> get _downloadsPath async {
    try{
      final directory = DownloadsPathProvider.downloadsDirectory;
      return directory;
    } catch (error) {
      throw error;
    }
  }
  Future<File> get _localFile async {
    try{
    final Directory directory = await _downloadsPath;
    final file = File('${directory.path}/$_fileName.txt');
    return file;
    } catch (error){
      throw error;
    }
  }
  Future<File> saveJson(String data) async {
    try{
    final file = await _localFile;
    return file.writeAsString(data);
    } catch (error){
      throw error;
    }
  }     
}