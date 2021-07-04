import 'package:flutter/material.dart';
import 'package:vend_tools_v2/partials/bottom_navigation.dart';
import 'package:vend_tools_v2/model/dbhandler.dart';
import 'package:vend_tools_v2/model/store.dart';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';

class StoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String title = tr('storeList');
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: StoreListPage(title: title),
    );
  }
}

class StoreListPage extends StatefulWidget{
  StoreListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _StoreListPageState createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  late DatabaseHandler handler;
  final _formAdd = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final keyController = TextEditingController();
  final uriController = TextEditingController();

  Future<int> addDummyStores() async {
    Store firstStore = Store(name: "Example Store", key: "kmzwa88wav", uri: "example", active: 0);
    List<Store> listOfStores = [firstStore];
    return await this.handler.insertStore(listOfStores);
  }

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      // await this.addDummyStores();
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    keyController.dispose();
    uriController.dispose();
    super.dispose();
  }

  _clearTextInput() {
    nameController.clear();
    keyController.clear();
    uriController.clear();
  }

  _popUpAddStore() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('addStore').tr(),
          content: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: _formAdd,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: tr('storeName'),
                    ),
                    controller: nameController,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return tr('requiredStoreName');
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: tr('key'),
                    ),
                    controller: keyController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return tr('requiredKey');
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: tr('uri'),
                    ),
                    controller: uriController,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return tr('requiredUri');
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('save').tr(),
              onPressed: _saveStore,
            ),
          ],
        );
      },
    );
  }

  _saveStore() async{
    if( _formAdd.currentState!.validate() ) {
      Store newStore = Store(name: nameController.text.trim(), key: keyController.text.trim(), uri: uriController.text.trim().toLowerCase(), active: 0);
      List<Store> listStore = [newStore];
      var result = await this.handler.insertStore(listStore);
      if (!result.isNaN) {
        Navigator.of(context, rootNavigator: true).pop();
        _clearTextInput();
        setState(() {});
      }
    }
  }

  _itemChange(bool? val, int index) async{
    await this.handler.deactiveAll();
    await this.handler.setActive(index);
    setState(() {});
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text('sureTitle').tr(),
        content: Text('sureDescription').tr(),
        actions: <Widget>[
          GestureDetector(
            child: TextButton(
              child: Text('no').tr(),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            onTap: () => Navigator.of(context).pop(false),
          ),
          GestureDetector(
            child: TextButton(
              child: Text('yes').tr(),
              onPressed: () => Navigator.of(context).pop(true),
            ),
            onTap: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    )) ?? false;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.language_outlined),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem(
                  child: Text('English'),
                  value: 'en',
                ),
                PopupMenuItem(
                  child: Text('Indonesian'),
                  value: 'id',
                ),
              ],
              onSelected: (String result) {
                context.setLocale(Locale(result));
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: this.handler.retrieveStores(),
          builder: (BuildContext context, AsyncSnapshot<List<Store>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: ValueKey<int>(snapshot.data![index].id!),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(Icons.delete_forever_outlined),
                      ),
                      onDismissed: (DismissDirection direction) async{
                        await this.handler.deleteStore(snapshot.data![index].id!);
                        setState(() {
                          snapshot.data!.remove(snapshot.data![index]);
                        });
                      },
                      child: Card(
                        child: RadioListTile(
                          // dense: true,
                          title: Text(snapshot.data![index].name.toString()),
                          value: (snapshot.data![index].active == 1),
                          onChanged: (bool? value) {
                            _itemChange(value, snapshot.data![index].id!);
                          },
                          groupValue: true,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text('noStore').tr());
              }
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: tr('addStore'),
          child: Icon(Icons.add),
          onPressed: _popUpAddStore,
        ),
        bottomNavigationBar: NavigationBar(index: 0,),
      ),
      onWillPop: _onWillPop,
    );
  }
}