// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:notmeet/navController.dart';
import 'package:notmeet/page/home.dart';
import 'package:notmeet/page/myactivity.dart';
import 'package:notmeet/page/orders.dart';
import 'package:notmeet/page/profile.dart';
import 'package:get/get.dart';

class Navbar extends StatelessWidget {
  Navbar({Key? key}) : super(key: key);
  NavbarController navbarController = Get.put(NavbarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: navbarController.selectedIndex.value,
          children: [
            MyHomePage(),
            MyActivity(),
            Orders(),
            MyProfile(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          backgroundColor: Color.fromARGB(255, 0, 77, 141),
          onTap: (index) {
            navbarController.changeIndex(index);
          },
          currentIndex: navbarController.selectedIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'My Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_circle),
              label: 'My Profile',
            ),
          ],
        ),
      ),
    );
  }
}
