import 'package:provider/provider.dart';
import '../providers/planned_transactions_provider.dart';
import '../models/category.dart';
import 'package:flutter/material.dart';
import '../helpers/DbHelper.dart';
import '../screens/category_screen.dart';

class CategoriesProvider with ChangeNotifier {

  String categoryRouteName = CategoryScreen.routeName;
  List<Category> _items = [];
  List<Category> get items => dirty ?  null : _items; 
  bool dirty = true;

  Future<void> addCategory(Category aC) async {
    try{
      await DBHelper.insert(CategoryNames.tableName, {     
        CategoryNames.categoryName: aC.categoryName,
        CategoryNames.description: aC.description,
        CategoryNames.iconPath: aC.iconPath,
        CategoryNames.usedForCashFlow: aC.useForCashFlow,
      });
      dirty = true;
    } catch(error){
      throw Exception('CategoriesProvider.addCategory: ' + error.toString());
    }
  }

  Future<void> updateCategory(Category aC) async {
    try{
      await DBHelper.update(CategoryNames.tableName, aC.id, {     
        CategoryNames.categoryName: aC.categoryName,
        CategoryNames.description: aC.description,
        CategoryNames.iconPath: aC.iconPath,
        CategoryNames.usedForCashFlow: aC.useForCashFlow,
      }); 
      dirty = true;   
    } catch(error){
      throw Exception('CategoriesProvider.updateCategory: ' + error.toString());
    }
  }

  Future<void> fetchAndSetCategories() async {
    try{
      final dataList = await DBHelper.getData(CategoryNames.tableName);
      if(_items != null && _items.length != 0 && dirty == false) return;
      _items = dataList.map(
        (item) => Category(
          id: item[CategoryNames.id],
          categoryName: item[CategoryNames.categoryName],
          description: item[CategoryNames.description],
          iconPath: item[CategoryNames.iconPath],
          useForCashFlow: item[CategoryNames.usedForCashFlow] == 1 ? true : false,
        ), 
      ).toList();
      dirty = false;
    } catch(error){
      throw Exception('CategoriesProvider.fetchAndSetCategories: ' + error.toString());
    }
  }

  Future<void> deleteCategory(BuildContext context, int id) async {
    try{
      //Check no Planned Transactions have the categoryId
      bool ans = Provider.of<PlannedTransactionProvider>(context, listen: false).canCategoryBeDeleted(id);
      if(ans){
        DBHelper.delete(CategoryNames.tableName, id);
        dirty = true;
        notifyListeners();
      } else {
        showDialog(context: context, builder: (context) => AlertDialog(title: Text('Can not delete category'), content: Text('Transaction is linked to this category'),actions: <Widget>[FlatButton(child: Text('OK'),onPressed: (){Navigator.of(context).pop();},),],),);
      }  
      
    } catch(error){
      throw Exception('CategoriesProvider.deleteCategory: ' + error.toString());
    }  
  }
  Category findById(int id) {
    try{
    return _items.firstWhere((category) => category.id == id, orElse: () => null);
    } catch(error){
      throw Exception('CategoriesProviderfindById: ' + error.toString());
    }
  }
  List<String> imageList(){
    List<String> images = [];
    images.add('assets/images/category_icons/c001.jpg');
    images.add('assets/images/category_icons/c002.jpg');
    images.add('assets/images/category_icons/c003.jpg');
    images.add('assets/images/category_icons/c004.jpg');
    images.add('assets/images/category_icons/c005.jpg');
    images.add('assets/images/category_icons/c006.jpg');
    images.add('assets/images/category_icons/c007.jpg');
    images.add('assets/images/category_icons/c008.jpg');
    images.add('assets/images/category_icons/c009.jpg');
    images.add('assets/images/category_icons/c010.jpg');
    images.add('assets/images/category_icons/c011.jpg');
    images.add('assets/images/category_icons/c012.jpg');
    images.add('assets/images/category_icons/c013.jpg');
    images.add('assets/images/category_icons/c014.jpg');
    images.add('assets/images/category_icons/c015.jpg');
    images.add('assets/images/category_icons/c016.jpg');
    images.add('assets/images/category_icons/c017.jpg');
    images.add('assets/images/category_icons/c018.jpg');
    images.add('assets/images/category_icons/c019.jpg');
    images.add('assets/images/category_icons/c020.jpg');
    images.add('assets/images/category_icons/c021.jpg');
    images.add('assets/images/category_icons/c022.jpg');
    images.add('assets/images/category_icons/c023.jpg');
    images.add('assets/images/category_icons/c024.jpg');
    images.add('assets/images/category_icons/c025.jpg');
    images.add('assets/images/category_icons/c026.jpg');
    images.add('assets/images/category_icons/c027.jpg');
    images.add('assets/images/category_icons/c028.jpg');
    images.add('assets/images/category_icons/c029.jpg');
    images.add('assets/images/category_icons/c030.jpg');
    images.add('assets/images/category_icons/c031.jpg');
    images.add('assets/images/category_icons/c032.jpg');
    images.add('assets/images/category_icons/c033.jpg');
    images.add('assets/images/category_icons/c034.jpg');
    images.add('assets/images/category_icons/c035.jpg');
    images.add('assets/images/category_icons/c036.jpg');
    images.add('assets/images/category_icons/c037.jpg');
    images.add('assets/images/category_icons/c038.jpg');
    images.add('assets/images/category_icons/c039.jpg');
    images.add('assets/images/category_icons/c040.jpg');
    images.add('assets/images/category_icons/c041.jpg');
    images.add('assets/images/category_icons/c042.jpg');
    images.add('assets/images/category_icons/c043.jpg');
    images.add('assets/images/category_icons/c044.jpg');
    images.add('assets/images/category_icons/c045.jpg');
    images.add('assets/images/category_icons/c046.jpg');
    images.add('assets/images/category_icons/c047.jpg');
    images.add('assets/images/category_icons/c048.jpg');
    images.add('assets/images/category_icons/c049.jpg');
    images.add('assets/images/category_icons/c050.jpg');
    images.add('assets/images/category_icons/c051.jpg');
    images.add('assets/images/category_icons/c052.jpg');
    images.add('assets/images/category_icons/c053.jpg');
    images.add('assets/images/category_icons/c054.jpg');
    images.add('assets/images/category_icons/c055.jpg');
    images.add('assets/images/category_icons/c056.jpg');
    images.add('assets/images/category_icons/c057.jpg');
    images.add('assets/images/category_icons/c058.jpg');
    images.add('assets/images/category_icons/c059.jpg');
    images.add('assets/images/category_icons/c060.jpg');
    images.add('assets/images/category_icons/c061.jpg');
    images.add('assets/images/category_icons/c062.jpg');
    images.add('assets/images/category_icons/c063.jpg');
    images.add('assets/images/category_icons/c064.jpg');
    images.add('assets/images/category_icons/c065.jpg');
    images.add('assets/images/category_icons/c066.jpg');
    images.add('assets/images/category_icons/c067.jpg');
    images.add('assets/images/category_icons/c068.jpg');
    images.add('assets/images/category_icons/c069.jpg');
    images.add('assets/images/category_icons/c070.jpg');
    images.add('assets/images/category_icons/c071.jpg');
    images.add('assets/images/category_icons/c072.jpg');
    images.add('assets/images/category_icons/c073.jpg');
    images.add('assets/images/category_icons/c074.jpg');
    images.add('assets/images/category_icons/c075.jpg');
    images.add('assets/images/category_icons/c076.jpg');
    images.add('assets/images/category_icons/c077.jpg');
    images.add('assets/images/category_icons/c078.jpg');
    images.add('assets/images/category_icons/c079.jpg');
    images.add('assets/images/category_icons/c080.jpg');
    images.add('assets/images/category_icons/c081.jpg');
    images.add('assets/images/category_icons/c082.jpg');
    images.add('assets/images/category_icons/c083.jpg');
    images.add('assets/images/category_icons/c084.jpg');
    images.add('assets/images/category_icons/c085.jpg');
    images.add('assets/images/category_icons/c086.jpg');
    images.add('assets/images/category_icons/c087.jpg');
    images.add('assets/images/category_icons/c088.jpg');
    images.add('assets/images/category_icons/c089.jpg');
    images.add('assets/images/category_icons/c090.jpg');
    images.add('assets/images/category_icons/c091.jpg');
    images.add('assets/images/category_icons/c092.jpg');
    images.add('assets/images/category_icons/c093.jpg');
    images.add('assets/images/category_icons/c094.jpg');
    images.add('assets/images/category_icons/c095.jpg');
    images.add('assets/images/category_icons/c096.jpg');
    images.add('assets/images/category_icons/c097.jpg');
    images.add('assets/images/category_icons/c098.jpg');
    images.add('assets/images/category_icons/c099.jpg');
    images.add('assets/images/category_icons/c100.jpg');
    images.add('assets/images/category_icons/c101.jpg');
    images.add('assets/images/category_icons/c102.jpg');
    images.add('assets/images/category_icons/c103.jpg');
    images.add('assets/images/category_icons/c104.jpg');
    images.add('assets/images/category_icons/c105.jpg');
    images.add('assets/images/category_icons/c106.jpg');
    images.add('assets/images/category_icons/c107.jpg');
    images.add('assets/images/category_icons/c108.jpg');
    images.add('assets/images/category_icons/c109.jpg');
    images.add('assets/images/category_icons/c110.jpg');
    images.add('assets/images/category_icons/c111.jpg');
    images.add('assets/images/category_icons/c112.jpg');
    images.add('assets/images/category_icons/c113.jpg');
    images.add('assets/images/category_icons/c114.jpg');
    images.add('assets/images/category_icons/c115.jpg');
    images.add('assets/images/category_icons/c116.jpg');
    images.add('assets/images/category_icons/c117.jpg');
    images.add('assets/images/category_icons/c118.jpg');
    images.add('assets/images/category_icons/c119.jpg');
    images.add('assets/images/category_icons/c120.jpg');
    images.add('assets/images/category_icons/c121.jpg');
    images.add('assets/images/category_icons/c122.jpg');
    images.add('assets/images/category_icons/c123.jpg');
    images.add('assets/images/category_icons/c124.jpg');
    images.add('assets/images/category_icons/c125.jpg');
    images.add('assets/images/category_icons/c126.jpg');
    images.add('assets/images/category_icons/c127.jpg');
    images.add('assets/images/category_icons/c128.jpg');
    images.add('assets/images/category_icons/c129.jpg');
    images.add('assets/images/category_icons/c130.jpg');
    images.add('assets/images/category_icons/c131.jpg');
    images.add('assets/images/category_icons/c132.jpg');
    images.add('assets/images/category_icons/c133.jpg');
    images.add('assets/images/category_icons/c134.jpg');
    images.add('assets/images/category_icons/c135.jpg');
    images.add('assets/images/category_icons/c136.jpg');
    images.add('assets/images/category_icons/c137.jpg');
    images.add('assets/images/category_icons/c138.jpg');
    images.add('assets/images/category_icons/c139.jpg');
    images.add('assets/images/category_icons/c140.jpg');
    images.add('assets/images/category_icons/c141.jpg');
    images.add('assets/images/category_icons/c142.jpg');
    images.add('assets/images/category_icons/c143.jpg');
    images.add('assets/images/category_icons/c144.jpg');
    images.add('assets/images/category_icons/c145.jpg');
    images.add('assets/images/category_icons/c146.jpg');
    return images;
  }
}

class CategoryNames {
  static const id = 'id';
  static const categoryName = 'categoryName';
  static const description = 'description';
  static const iconPath = 'iconPath';
  static const usedForCashFlow = 'usedForCashFlow';
  static const tableName = 'categories';
}