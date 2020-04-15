import 'package:flutter/services.dart';
import '../models/list_tile_base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recurrences_provider.dart';
import '../providers/cash_flow_provider.dart';
import '../models/recurrence.dart';
import '../widgets/date_choose.dart';
import '../screens/icons_screen.dart';

class RecurrenceScreen extends StatefulWidget {
  static const routeName = 'RecurrenceScreen';

  @override
  _RecurrenceScreenState createState() => _RecurrenceScreenState();
}

class _RecurrenceScreenState extends State<RecurrenceScreen> {
  var result;   
 DateTime _selectedDate;
 int _selectedType;  
 String _selectedTypeName;
 final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var _editRecurrence = Recurrence(
      id: -1,
      title: '',
      type: -1,
      description: '',
      iconPath: '',
      noOccurences: 0,
      endDate: null,
  );
  var _haveChosenDate = false;
  var _haveChosenOccurrences = false; 

  @override
  void didChangeDependencies() {
    try{
      if (_isInit) {
        final ListTileBase args = ModalRoute.of(context).settings.arguments;
        if (args != null) {
          _editRecurrence = Provider.of<RecurrencesProvider>(context, listen: false).findById(args.id);
          if(_editRecurrence.endDate != null && _editRecurrence.endDate.length != 0){
            if(DateTime.tryParse(_editRecurrence.endDate) != null){
              _selectedDate = DateTime.parse(_editRecurrence.endDate);
              _haveChosenDate = true;
            } else {
              _selectedDate = null;
            }            
          }
          _haveChosenOccurrences = (_editRecurrence.noOccurences != null && 0 != _editRecurrence.noOccurences  );
          _selectedType = _editRecurrence.type;
          _selectedTypeName = RecurrenceOptions.getTypeName(_editRecurrence.type);  
        }
      }
      _isInit = false;
      super.didChangeDependencies();
    } catch (error){
      throw Exception('RecurrenceScreen.didChangeDependencies: ' + error.toString());
    }
  }

  Future<void> _saveForm() async {
    try{
      if(_editRecurrence.iconPath.length == 0){
        showDialog(context: context, builder: (context) => AlertDialog(title: Text('Recurrence Icon'), content: Text('Please select an icon for the Recurrence'),actions: <Widget>[FlatButton(child: Text('OK'),onPressed: (){Navigator.of(context).pop();},),],),);
        return;     
      } 
      if(_editRecurrence.type == -1){
        showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select Type of Recurrence'), content: Text('e.g. Monthly'), actions: <Widget>[FlatButton(child: Text('OK'), onPressed: (){Navigator.of(context).pop();},),],),);
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
      if(_selectedDate != null){
        _editRecurrence.endDate = _selectedDate.toIso8601String();
      }    
      if (_editRecurrence.id >= 0) {
        await Provider.of<RecurrencesProvider>(context, listen: false).updateRecurrence(_editRecurrence);         
      } else {
        await Provider.of<RecurrencesProvider>(context, listen: false).addRecurrence(_editRecurrence);          
      }
      Navigator.of(context).pop();
      setState(() {
        _isLoading = false;
      });
      Provider.of<CashFlowProvider>(context).cashFlowDirty = true;
    } catch (error){
      var outError = 'Saving Recurrence ' + error.toString();
      Clipboard.setData(new ClipboardData(text: outError));
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text('Trying to save Recurrence Error'), 
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
  void _presentDatePicker() {
    try{
      showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2050),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _haveChosenDate = true;
          _selectedDate = pickedDate;
        });
      });
    } catch (error){
      throw Exception('RecurrenceScreen._presentDatePicker: ' + error.toString());
    }
  }
  void _navigateAndDisplayRecurrenceIcons(BuildContext context) async {
    try{
      result = await Navigator.push(context,MaterialPageRoute(builder: (context) => IconsScreen(catOrRef: false, givenIconPath: _editRecurrence.iconPath)),);
      if(result != null){
        setState(() {
          _editRecurrence.iconPath = result;
        });
      }
    } catch (error){
      throw Exception('RecurrenceScreen._navigateAndDisplayRecurrenceIcons: ' + error.toString());
    }
  }
  @override
  Widget build(BuildContext context) { 
    try{
      return Scaffold(
        appBar: AppBar(
          title: Text('A Recurrence'),
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
                      //Title
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          maxLength: 30,
                          decoration: InputDecoration(
                            labelText: 'Recurrence Title',
                          ),
                          initialValue: _editRecurrence.title,
                          textInputAction: TextInputAction.none,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a valid Account Name';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => _editRecurrence.title = value,
                        ),
                      ),
                      //Description
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          maxLength: 80,
                          decoration: InputDecoration(
                            labelText: 'Recurrence Description',
                          ),
                          initialValue: _editRecurrence.description,
                          textInputAction: TextInputAction.none,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a valid Recurrence Description';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => _editRecurrence.description = value,
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
                              image: AssetImage(_editRecurrence.iconPath),
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
                              _navigateAndDisplayRecurrenceIcons(context);
                            }
                          ),
                        ],),                     
                      ),                     
                      //Type
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Text(_selectedType == null || _selectedTypeName == null ? 'No type chosen' : _selectedTypeName),
                          ),
                          PopupMenuButton(
                            itemBuilder: (_) => [
                                PopupMenuItem(
                                  child: Text(RecurrenceOptions.weeklyT),
                                  value: RecurrenceOptions.weekly,
                                ),
                                PopupMenuItem(
                                  child: Text(RecurrenceOptions.monthlyT),
                                  value: RecurrenceOptions.monthly,
                                ),
                                PopupMenuItem(
                                  child: Text(RecurrenceOptions.quarterlyT),
                                  value: RecurrenceOptions.quarterly,
                                ),                              
                                PopupMenuItem(
                                  child: Text(RecurrenceOptions.yearlyT),
                                  value: RecurrenceOptions.yearly,
                                ),                                                        
                            ],
                            onSelected: (value){
                              setState(() {
                                _selectedType = value;
                                switch (value){
                                case RecurrenceOptions.weekly:
                                  _editRecurrence.type = RecurrenceOptions.weekly;
                                  _selectedTypeName = RecurrenceOptions.weeklyT;
                                  break; 
                                case RecurrenceOptions.monthly:
                                  _editRecurrence.type = RecurrenceOptions.monthly;
                                  _selectedTypeName = RecurrenceOptions.monthlyT; 
                                  break;
                                case RecurrenceOptions.yearly:
                                  _editRecurrence.type = RecurrenceOptions.yearly;
                                  _selectedTypeName = RecurrenceOptions.yearlyT; 
                                  break; 
                                  break;
                                case RecurrenceOptions.quarterly:
                                  _editRecurrence.type = RecurrenceOptions.quarterly;
                                  _selectedTypeName = RecurrenceOptions.quarterlyT; 
                                  break;                                                                      
                                }
                              });  
                            },
                          ),
                        ],),                     
                      ),  
                      Divider(thickness: 1,),                 
                      //No of Occurences
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          maxLength: 10,
                          enabled: !_haveChosenDate,
                          style: TextStyle(fontSize: 16,),
                          textAlign: TextAlign.right,
                          onChanged: (text){
                            setState(() {
                               _haveChosenOccurrences = (null != int.tryParse(text) && 0 != int.parse(text));
                            });                          
                          },
                          decoration: InputDecoration(
                            labelText: 'Number of Occurences, if applicable',

                          ),
                          //If the inital value != null or 0 must set _haveChosenOccurrences to true
                          initialValue: _editRecurrence.noOccurences == null ? 0.toString() : _editRecurrence.noOccurences.toString(),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.none,
                          onFieldSubmitted: (_) => _saveForm(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'please enter number of occurences';
                            }
                            if (int.tryParse(value) == null) {
                              return 'please enter a valid whole number for the number of occurences';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _editRecurrence.noOccurences = int.parse(value),
                        ),
                      ), 
                      //Date
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Text('End Date, select if the recurrance ends')
                        ),
                      DateChoose(selectedDate: _selectedDate, datePicker: _presentDatePicker, disabled: _haveChosenOccurrences,), 
                                    
                      Divider(thickness: 2.0,),
                    ],
                  ),
                ),
              ),
      );
    } catch (error){
      throw Exception('RecurrenceScreen.build: ' + error.toString());
    }
  }
}
