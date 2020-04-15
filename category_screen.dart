import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Screens
import '../screens/icons_screen.dart';
//Provider
import 'package:provider/provider.dart';
import '../providers/categories_provider.dart';
import '../providers/cash_flow_provider.dart';
//Models
import '../models/list_tile_base.dart';
import '../models/category.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = 'CategoryScreen';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var result;  
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var _editCategory = Category(
      id: -1,
      categoryName: '',
      description: '',
      iconPath: '',
      useForCashFlow: true);

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final ListTileBase args = ModalRoute.of(context).settings.arguments;
      if (args != null) {
        _editCategory = Provider.of<CategoriesProvider>(context, listen: false).findById(args.id);
      }

    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    try{
      if(_editCategory.iconPath.length == 0){
        showDialog(context: context, builder: (context) => AlertDialog(title: Text('Category Icon'), content: Text('Please select an icon for the Category'),actions: <Widget>[FlatButton(child: Text('OK'),onPressed: (){Navigator.of(context).pop();},),],),);
        return;     
      }          
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if (_editCategory.id >= 0) {
        await Provider.of<CategoriesProvider>(context, listen: false).updateCategory(_editCategory);         
      } else {
        await Provider.of<CategoriesProvider>(context, listen: false).addCategory(_editCategory);          
      }     
      setState(() {
        _isLoading = false;
      });
      Provider.of<CashFlowProvider>(context).cashFlowDirty = true;
      Navigator.of(context).pop();
    } catch (error){
      var outError = 'Saving Category ' + error.toString();
      Clipboard.setData(new ClipboardData(text: outError));
      showDialog(
        context: context, 
        child: AlertDialog(
          title: Text('Trying to save Category Error'), 
          content: Text('Error Data has been copied to the clipboard: ' + outError),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: (){
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  void _navigateAndDisplayCategoryIcons(BuildContext context) async {
    try{
      result = await Navigator.push(context,MaterialPageRoute(builder: (context) => IconsScreen(catOrRef: true, givenIconPath: _editCategory.iconPath)),);
      if(result != null){
        setState(() {
          _editCategory.iconPath = result;
        });
      }
    } catch (error){
      throw Exception('CategoryScreen._navigateAndDisplayCategoryIcons: ' + error.toString());
    }  
  }
  @override
 Widget build(BuildContext context) {
    try{
      return Scaffold(
        appBar: AppBar(
          title: Text('A Category'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveForm();
              },
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      //Category Name
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          maxLength: 30,
                          decoration: InputDecoration(
                            labelText: 'Category Name',
                          ),
                          initialValue: _editCategory.categoryName,
                          textInputAction: TextInputAction.none,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a valid Category Name';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => _editCategory.categoryName = value,
                        ),
                      ),
                      //Category Description
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          maxLength: 80,
                          decoration: InputDecoration(
                            labelText: 'Category Description',
                          ),
                          initialValue: _editCategory.description,
                          textInputAction: TextInputAction.none,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a valid Account Description';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => _editCategory.description = value,
                        ),
                      ),
                      //Icon Image
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Row(children: <Widget>[
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage(_editCategory.iconPath),
                              fit: BoxFit.fitHeight,
                              ),                          
                            ),
                          ),
                          FlatButton(
                            highlightColor: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).disabledColor,
                            child: Text(
                              'Icon Select',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              _navigateAndDisplayCategoryIcons(context);
                            }
                          ),
                        ],),                     
                      ),  
                      //Used in Cash Flow                   
                      SwitchListTile(
                        title: Text('Use in Financial Facts'),
                        value: _editCategory.useForCashFlow,
                        subtitle:
                            Text('Include or Exclude from the Facts run'),
                        onChanged: (bool val) {
                          setState(() => _editCategory.useForCashFlow = val);
                        },
                      ),
                      Divider(thickness: 2.0,),
                    ],
                  ),
                ),
              ),
      );
    } catch(error){
      throw Exception('CategoryScreen.build: ' + error.toString());
    }
  }
}