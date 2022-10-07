import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_text_extractor_flutter/app/modules/home/views/about_us_view.dart';
import 'package:ml_text_extractor_flutter/app/modules/home/views/contact_us_view.dart';
import 'package:ml_text_extractor_flutter/app/modules/home/views/home_view.dart';
import 'package:ml_text_extractor_flutter/constants.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:kDrawerBodyBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // DrawerHeader(child: Text('Ahmer')),
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: kPrimaryColor
              //gradient: LinearGradient(colors: [Colors.blue, Colors.green,Colors.purple]),
            ),
            accountName: Text('TEXTO'),
            accountEmail: Text('inzimamb5@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('I'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined,color: kIconColor,),
            title: const Text('Home'),
            onTap: () {
             Get.to(HomeView());
            },
            selected: true,
            selectedColor: kPrimaryColor,

          ),
          ListTile(
            leading: Icon(Icons.contact_page,color: kIconColor,),
            title: const Text('Help Center'),
            onTap: () {
            Get.to(HelpCenterView());
            },
            // enabled: false,
            // selected: true,
          ),
          ListTile(
            leading: Icon(Icons.info,color: kIconColor,),
            title: const Text('About Us'),
            onTap: () {
            Get.to(AboutUsView());
            },
            // enabled: false,
            // selected: true,
          ),
        ListTile(
              leading: const Icon(Icons.close,color: kIconColor,),
              title: const Text('Close'),
              onTap: () {
               Get.back();
              },
              //enabled: false,
              //selected: true,
            ),
        ],
      ),
    );
  }
}