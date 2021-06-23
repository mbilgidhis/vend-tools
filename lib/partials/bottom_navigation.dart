import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:vend_tools_v2/pages/home.dart';
import 'package:vend_tools_v2/pages/product.dart';
import 'package:easy_localization/easy_localization.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {

  void _onItemTapped(int index) {
    switch(index) {
      case 0 :
        Navigator.push(
            context,
            PageTransition(
              child: StoreList(),
              type: PageTransitionType.fade,
            )
        );
        break;
      case 1:
        Navigator.push(
            context,
            PageTransition(
              child: Product(),
              type: PageTransitionType.fade,
            )
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build (BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: tr('home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: tr('product'),
        ),
      ],
      currentIndex: widget.index,
      onTap: _onItemTapped,
      selectedItemColor: Colors.green,
    );
  }
}
