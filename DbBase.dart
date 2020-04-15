//System
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
//Providers
import '../providers/categories_provider.dart';
import '../providers/accounts_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/planned_transactions_provider.dart';
import '../providers/recurrences_provider.dart';
import '../providers/transfers_provider.dart';

class DbBase {

  static DateTime _usedEndDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  static String _usedD = _usedEndDate.toIso8601String();

  //Accounts
  static const accountSql = 'CREATE TABLE ' +
      AccountNames.tableName +
      '(' +
      AccountNames.id +
      ' INTEGER PRIMARY KEY, ' +
      AccountNames.accountName +
      ' TEXT, ' +
      AccountNames.description +
      ' TEXT, ' +
      AccountNames.balance +
      ' REAL, ' +
      AccountNames.usedForCashFlow +
      ' INTEGER, ' +
      AccountNames.usedForSummary +
      ' INTEGER' +      
      ')';
  //Categories
  static const categorySql = 'CREATE TABLE ' +
      CategoryNames.tableName +
      '(' +
      CategoryNames.id +
      ' INTEGER PRIMARY KEY, ' +
      CategoryNames.categoryName +
      ' TEXT, ' +
      CategoryNames.description +
      ' TEXT, ' + 
      CategoryNames.iconPath +
      ' TEXT, ' +      
      CategoryNames.usedForCashFlow + 
      ' INTEGER )';
  //Category entries
  static const categoryEntry = 'INSERT INTO ' +
    CategoryNames.tableName +
    '(' + 
    CategoryNames.id + ', ' + CategoryNames.categoryName +  ', ' + CategoryNames.description + ', ' + CategoryNames.iconPath + ', ' + CategoryNames.usedForCashFlow + ') VALUES ' +
    '(1, "Rent", "payment for renting", "assets/images/category_icons/c008.jpg", 1) ,' +
    '(2, "Mortgage", "Payment for property", "assets/images/category_icons/c144.jpg", 1) ,' +
    '(3, "Running Costs", "Cost of running something", "assets/images/category_icons/c051.jpg", 1) ,' +
    '(4, "Cleaning", "Cost of cleaning contract", "assets/images/category_icons/c034.jpg", 1) ,' +
    '(5, "Boiler Service", "Annual boiler service cost", "assets/images/category_icons/c031.jpg", 1) ,' +
    '(6, "Holiday", "Holiday cost", "assets/images/category_icons/c142.jpg", 1) ,' +
    '(7, "Car Costs", "Car Loan etc", "assets/images/category_icons/c146.jpg", 1) ,' +
    '(8, "Petrol", "petrol costs", "assets/images/category_icons/c033.jpg", 1) ,' +
    '(9, "Savings", "loans charges etc", "assets/images/category_icons/c019.jpg", 1) ,' +
    '(10, "Living Expenses", "from experience", "assets/images/category_icons/c145.jpg", 1) ,' +
    '(11, "Car Loan", "paying for the car", "assets/images/category_icons/c090.jpg", 1) ,' +
    '(12, "Car Insurance", "to insure the car each year", "assets/images/category_icons/c112.jpg", 1), ' + 
    '(13, "Wages", "payment for my skills", "assets/images/category_icons/c072.jpg", 1)';   
  //Settings 
  static const settingsSql = 'CREATE TABLE ' +
      SettingNames.tableName + 
      '(' +
      SettingNames.id + 
      ' INTEGER PRIMARY KEY, ' +
      SettingNames.identifier +
      ' TEXT, ' +
      SettingNames.value +
      ' TEXT)';
  //Settings Entries    
  static String settingsEntry = 'INSERT INTO ' +
    SettingNames.tableName +
    '(' + 
    SettingNames.identifier + ', ' + SettingNames.value + ') VALUES' +
    '("currency", "Pound"), ("EndDate", + "$_usedD"' + ' ), ("FileName", "macf")';
  //Planned Transactions
  static const transactionSql = 'CREATE TABLE ' +
      PlannedTransactionNames.tableName +
      '(' +
      PlannedTransactionNames.id +
      ' INTEGER PRIMARY KEY, ' +
      PlannedTransactionNames.title +
      ' TEXT, ' +
      PlannedTransactionNames.description +
      ' TEXT, ' +
     PlannedTransactionNames.accountId +
      ' INTEGER, ' +
     PlannedTransactionNames.categoryId +
      ' INTEGER, ' +
     PlannedTransactionNames.recurrenceId +
      ' INTEGER, ' +                  
      PlannedTransactionNames.plannedDate +
      ' TEXT, ' +
      PlannedTransactionNames.amount +
      ' REAL, ' +  
      PlannedTransactionNames.credit +
      ' INTEGER, ' +          
      PlannedTransactionNames.usedForCashFlow +
      ' INTEGER ' +
      ')';
  //Recurrence
  static const recurrenceSql = 'CREATE TABLE ' +
      RecurrenceNames.tableName +
      '(' +
      RecurrenceNames.id +
      ' INTEGER PRIMARY KEY, ' +
      RecurrenceNames.title +
      ' TEXT, ' +
      RecurrenceNames.description +
      ' TEXT, ' +
      RecurrenceNames.iconPath +
      ' TEXT, ' +      
     RecurrenceNames.type +
      ' INTEGER, ' +
     RecurrenceNames.noOccurences +
      ' INTEGER, ' +                  
      RecurrenceNames.endDate +
      ' TEXT ' +
      ')';
  //Recurrence entries
  static const recurrenceEntry = 'INSERT INTO ' +
    RecurrenceNames.tableName +
    '(' + 
    RecurrenceNames.id + ', ' + RecurrenceNames.title +  ', ' + RecurrenceNames.description + ', ' + RecurrenceNames.iconPath + ', ' + RecurrenceNames.type + ', ' + RecurrenceNames.noOccurences + ', ' + RecurrenceNames.endDate + ') VALUES ' +
    '(1, "Weekly", "Weekly recurrence that has no finish", "assets/images/recurrence_icons/r052.jpg", 0, 0, null) ,' + 
    '(2, "Monthly", "Monthly recurrence that has no finish", "assets/images/recurrence_icons/r003.jpg", 1, 0, null) ,' +
    '(3, "Quarterly", "Quarterly recurrence that has no finish", "assets/images/recurrence_icons/r064.jpg", 2, 0, null) ,' +
    '(4, "Yearly", "Yearly recurrence that has no finish", "assets/images/recurrence_icons/r065.jpg", 3, 0, null) , ' +  
    '(5, "Weekly Occurr", "Weekly recurrence that finishes after a number of occurrences", "assets/images/recurrence_icons/r061.jpg",0, 5, null) ,' +
    '(6, "Monthly Occurr", "Monthly recurrence that finishes after a number of occurrences", "assets/images/recurrence_icons/r054.jpg", 1, 5, null) ,' +
    '(7, "Quarterly Occurr", "Quarterly recurrence that finishes after a number of occurrences", "assets/images/recurrence_icons/r066.jpg", 2, 5, null) ,' +
    '(8, "Yearly Occurr", "Yearly recurrence that finishes after a number of occurrences", "assets/images/recurrence_icons/r067.jpg", 3, 5, null) ,' +
    '(9, "Weekly End", "Weekly recurrence that finishes after a specific date", "assets/images/recurrence_icons/r063.jpg", 0, 0, "2020-10-10T00:00:00.000") ,' +
    '(10, "Monthly End", "Monthly recurrence that finishes after a specific date", "assets/images/recurrence_icons/r019.jpg", 1, 0, "2020-10-10T00:00:00.000") ,' +
    '(11, "Quarterly End", "Quarterly recurrence that finishes after a specific date", "assets/images/recurrence_icons/r021.jpg", 2, 0, "2020-10-10T00:00:00.000") ,' +
    '(12, "Yearly End", "Yearly recurrence that finishes after a specific date", "assets/images/recurrence_icons/r062.jpg", 3, 0, "2020-10-10T00:00:00.000")';      
  //Planned Transactions
  static const transferSql = 'CREATE TABLE ' +
      TransfersNames.tableName +
      '(' +
      TransfersNames.id +
      ' INTEGER PRIMARY KEY, ' +
      TransfersNames.title +
      ' TEXT, ' +
      TransfersNames.description +
      ' TEXT, ' +
     TransfersNames.fromAccountId +
      ' INTEGER, ' +
     TransfersNames.toAccountId +
      ' INTEGER, ' +
     PlannedTransactionNames.recurrenceId +
      ' INTEGER, ' +                  
      PlannedTransactionNames.plannedDate +
      ' TEXT, ' +
      PlannedTransactionNames.amount +
      ' REAL, ' +           
      PlannedTransactionNames.usedForCashFlow +
      ' INTEGER ' +
      ')';
  static Future<sql.Database> database() async {

    try{
      final dbPath = await sql.getDatabasesPath();
      return sql.openDatabase(
        path.join(dbPath, DbNames.dbName),
        onCreate: (db, version) {
          // print('Account ' + accountSql);
          // print('Category ' + categorySql);
          // print('Category Entry ' + categoryEntry);
          // print('Settings ' + settingsSql);
          // print('Settings Entry ' + settingsEntry);
          // print('Transactions ' + transactionSql); 
          // print('Recurrence Entry ' + recurrenceEntry);
          // print('Recurrence ' + recurrenceSql);    
          // print('Transfer ' + transferSql);   
          db.execute(categorySql);
          db.execute(categoryEntry);
          db.execute(settingsSql);
          db.execute(settingsEntry);
          db.execute(transactionSql);
          db.execute(recurrenceSql); 
          db.execute(recurrenceEntry);   
          db.execute(transferSql);                     
          return db.execute(accountSql);
        },
        version: 1,
      );
    } catch (error){
      throw Exception('could not open database ' + DbNames.dbName + ' : ' + error.toString());
    }
  }
  static Future<void> cleanDatabase() async {
    try{
      
      final db = await database();
      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete(AccountNames.tableName);
        batch.delete(CategoryNames.tableName);
        batch.delete(RecurrenceNames.tableName);
        batch.delete(TransfersNames.tableName);
        batch.delete(PlannedTransactionNames.tableName);
        batch.delete(SettingNames.tableName); 
        await batch.commit();       
      });
    } catch(error){
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }
}

class DbNames {
  static const dbName = 'macf.db';
}
