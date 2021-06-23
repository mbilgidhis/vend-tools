import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' show jsonDecode;
import 'dart:io';
import 'package:vend_tools_v2/model/product_vend.dart';
import 'package:vend_tools_v2/model/dbhandler.dart';
import 'package:vend_tools_v2/model/product_price_book.dart';
import 'package:vend_tools_v2/partials/bottom_navigation.dart';
import 'package:vend_tools_v2/model/pricebook_detail_vend.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final String title = tr('productDetail');
    final String id = '304114180051424';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ProductDetailsPage(title: title, id: id,),
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key? key, required this.title, required this.id }) : super(key: key);
  final String title;
  final String id;

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late DatabaseHandler handler;
  var uri;
  var key;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
  }

  Future<ProductVend> _getData() async {
    final credentials = await this.handler.getActives();
    var uri = credentials.first.uri;
    this.uri = uri;
    var key = credentials.first.key;
    this.key = key;

    final response = await http.get(
      Uri.parse('https://' + uri.toString() + '.vendhq.com/api/2.0/products/' + widget.id.toString()),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + key.toString(),
      },
    );
    var data = jsonDecode(response.body);
    var product = ProductVend.fromJson(data);
    return product;
  }

  Future<ProductPriceBook> _getPriceBookProduct() async {
    final response = await http.get(
      Uri.parse('https://' + this.uri.toString() + '.vendhq.com/api/2.0/products/' + widget.id.toString() + '/price_book_products'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + this.key.toString(),
      },
    );
    if ( response.statusCode == 200 )
      return ProductPriceBook.fromJson(jsonDecode(response.body));
    else
      throw Exception(tr('failedHttp'));
  }

  Future<PriceBookDetailsVend> _getPriceBookDetail(String id) async {
    final response = await http.get(
      Uri.parse('https://' + this.uri.toString() + '.vendhq.com/api/2.0/price_books/' + id),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + this.key.toString(),
      },
    );
    if ( response.statusCode == 200 ) {
      final priceBookDetails = PriceBookDetailsVend.fromJson(jsonDecode(response.body));
      return priceBookDetails;
    } else
      throw Exception(tr('failedHttp'));
  }

  _createInfoName(data) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(
            data.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  _createImageProduct(data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top:10.0, bottom: 10.0),
          child: Image.network(data.imageUrl),
        )
      ],
    );
  }

  _createId(data) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: SelectableText(
            tr('id') + ": " + data.id,
          ),
        )
      ],
    );
  }

  _createSku(data) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: SelectableText(
            tr('sku') + ": " + data.sku,
          ),
        )
      ],
    );
  }

  _createInfoVariantName(data) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(
            tr('variant') + ": " + data.variantName,
          ),
        )
      ],
    );
  }

  _createDescription(data) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(
            data.description,
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  _createPriceIncludingTax(data) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(
            tr('priceWTax') + ": " + data.priceIncludingTax.toString(),
          ),
        )
      ],
    );
  }

  _createPriceExcludingTax(data) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(
            tr('priceWoTax') + ": " + data.priceExcludingTax.toString(),
          ),
        )
      ],
    );
  }

  _createPriceBookLabel() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            tr('priceBook'),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  _createPriceBookData() {
    return FutureBuilder(
      future: _getPriceBookProduct(),
      builder: (BuildContext context, AsyncSnapshot<ProductPriceBook> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.data!.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: Icon(Icons.add),
                key: ValueKey<String>(snapshot.data!.data![index].priceBookId.toString()),
                title: Text(
                    tr('price') + ": " + snapshot.data!.data![index].price.toString()
                ),
                hoverColor: Colors.grey,
                // onTap: () => _getPriceBookDetailPage(snapshot.data!.data![index].priceBookId.toString()),
                onTap: () => _popPriceBookDetail(snapshot.data!.data![index].priceBookId.toString()),
              );
            },
          );
        } else {
          return Container(child: Center(child: CircularProgressIndicator()),);
        }
      },
    );
  }

  _createPriceBookName(data) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          padding: EdgeInsets.only(bottom: 10.0,),
          child: Text(
            data.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  _createPriceBookTo(data) {
    return Row(
      children: [
        Container(
          // padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(
            tr('to') + ": " + data.validTo.toString(),
          ),
        )
      ],
    );
  }

  _createPriceBookFrom(data) {
    return Row(
      children: [
        Container(
          // padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(
            tr('from') + ": " + data.validFrom.toString(),
          ),
        )
      ],
    );
  }

  _popPriceBookDetail(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('priceBookDetail').tr(),
          content: FutureBuilder(
            future: _getPriceBookDetail(id),
            builder: (BuildContext context, AsyncSnapshot<PriceBookDetailsVend> snapshot) {
              if( snapshot.hasData ) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _createPriceBookName(snapshot.data!.data),
                      _createPriceBookFrom(snapshot.data!.data),
                      _createPriceBookTo(snapshot.data!.data),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot<ProductVend> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _createInfoName(snapshot.data!.data),
                  _createImageProduct(snapshot.data!.data),
                  _createId(snapshot.data!.data),
                  _createSku(snapshot.data!.data),
                  _createInfoVariantName(snapshot.data!.data),
                  _createDescription(snapshot.data!.data),
                  _createPriceExcludingTax(snapshot.data!.data),
                  _createPriceIncludingTax(snapshot.data!.data),
                  _createPriceBookLabel(),
                  _createPriceBookData(),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: NavigationBar(index: 1,),
    );
  }
}