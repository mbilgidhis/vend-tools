import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:vend_tools_v2/partials/bottom_navigation.dart';
import 'package:vend_tools_v2/model/dbhandler.dart';
import 'package:vend_tools_v2/model/store.dart';
import 'package:vend_tools_v2/model/search_product.dart';
import 'package:vend_tools_v2/pages/product_details.dart';
import 'package:easy_localization/easy_localization.dart';

class Product extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String title = tr('product');
    return MaterialApp(
      title: title,
      theme: ThemeData(
          primarySwatch: Colors.green
      ),
      home: ProductPage(title: title),
    );
  }
}

class ProductPage extends StatefulWidget{
  ProductPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late DatabaseHandler handler;
  final _formSearch = GlobalKey<FormState>();
  final skuController = TextEditingController();
  var searchProduct = SearchProduct();
  var url;
  var key;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
  }

  @override
  void dispose() {
    skuController.dispose();
    super.dispose();
  }

  _createTableRowInfo(String label, String value) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      padding: EdgeInsets.only(top: 10.0,left: 10.0),
      child: Table(
          children: [
            TableRow(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(label),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(value),
                      ),
                    ],
                  )
                ]
            )
          ]
      ),
    );
  }

  _createSearchInput() {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      padding: EdgeInsets.only(top:20.0, left: 10.0, right: 10.0),
      child: Form(
        key: _formSearch,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: tr('sku'),
              ),
              controller: skuController,
              // autofocus: true,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if ( value == null || value.isEmpty)
                  return tr('requiredSku');
                return null;
              },
            ),
            ElevatedButton(
              onPressed: _searchProduct,
              child: Text('search').tr(),
            ),
          ],
        ),
      ),

    );
  }

  _createSearchResult() {
    if( this.searchProduct.totalCount != null ) {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: this.searchProduct.totalCount,
          itemBuilder: (context, index){
            return ListTile(
              leading: Image.network(this.searchProduct.data![index].imageUrl.toString()),
              title: Text(this.searchProduct.data![index].name.toString()),
              subtitle: Text(
                    tr('sku') +
                    ": " +
                    this.searchProduct.data![index].sku.toString() +
                    '\n' +
                    tr('price') +
                    ": " +
                    this.searchProduct.data![index].priceExcludingTax.toString(),),
              contentPadding: EdgeInsets.only(left: 20,),
              onTap: () {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(this.searchProduct.data![index].id.toString()),));
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(id: this.searchProduct.data![index].id.toString(), title: tr('productDetail'),)));
              },
              isThreeLine: true,
              key: ValueKey<String>(this.searchProduct.data![index].id.toString()),
            );
          },
        )
      );
    } else {
        return Container();
    }
  }

  _searchProduct() async {
    if( _formSearch.currentState!.validate() ) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hore')));
      final response = await http.get(
        Uri.parse(this.url + 'api/2.0/search?type=products&sku=' + skuController.text.trim()),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + this.key.toString(),
        },
      );
      if ( response.statusCode == 200 ) {
        var data = jsonDecode(response.body);
        var searchProduct = SearchProduct.fromJson(data);
        setState(() {
          this.searchProduct = searchProduct;
        });
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: this.handler.getActives(),
        builder: (BuildContext context, AsyncSnapshot<List<Store>> snapshot) {
          if( snapshot.hasData ){
            if (snapshot.data!.isNotEmpty) {
              var data = snapshot.data![0];
              var url = 'https://' + data.uri! + '.vendhq.com/';
              var key = data.key!;
              this.url = url;
              this.key = key;
              return Column(
                children: [
                  _createTableRowInfo(tr('storeName'), data.name!),
                  _createTableRowInfo(tr('url'), url),
                  _createSearchInput(),
                  _createSearchResult(),
                ],
              );
            }else {
              return Center(
                child: Text('noStore').tr(),
              );
            }
          } else {
            return Center(
              child: Text('noStore').tr(),
            );
          }
        },
      ),
      bottomNavigationBar: NavigationBar(index: 1,),
    );
  }
}