import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter/material.dart';

import './register.dart';

class AdminHome extends StatelessWidget {
  var bg = 'assets/images/bg.jpeg';
  Widget build(BuildContext context) {
    return Material(
        child: AdminScaffold(
      appBar: AppBar(
        title: Text('Admin HomePage'),
      ),
      // body: Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage(bg),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // )

      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: '/',
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'User Management',
            icon: Icons.file_copy,
            children: [
              AdminMenuItem(
                title: 'New Users',
                // route: 'User Logs',
              ),
              AdminMenuItem(
                title: 'Existing Users',
                // route: 'User Logs',
              ),
            ],
          ),
          AdminMenuItem(
            title: 'Patient Management',
            icon: Icons.file_copy,
            // route: '/secondLevelItem2',
          ),
          AdminMenuItem(
            title: 'Reports',
            icon: Icons.file_copy,
          //   children: [
          //     AdminMenuItem(
          //       title: 'Third Level Item 1',
          //       // route: '/thirdLevelItem1',
          //     ),
          //     AdminMenuItem(
          //       title: 'Third Level Item 2',
          //       // route: '/thirdLevelItem2',
          //     ),
          //   ],
           ),
        ],
        selectedRoute: '/',
        onSelected: (item) {
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },
        // header: Container(
        //   height: 50,
        //   width: double.infinity,
        //   color: const Color(0xff444444),
        //   // child: const Center(
        //   //   child: Text(
        //   //     'header',
        //   //     style: TextStyle(
        //   //       color: Colors.white,
        //   //     ),
        //   //   ),
        //   // ),
        // ),
        // footer: Container(
        //   height: 50,
        //   width: double.infinity,
        //   color: const Color(0xff444444),
        //   child: const Center(
        //     child: Text(
        //       'footer',
        //       style: TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Dashboard',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    ));
  }
}
 // child: Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage(bg),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   child: Container(
      //     child: Stack(
      //       alignment: Alignment.center,
      //       children: [
      //         Positioned(
      //           // alignment: Alignment.center,
      //           top: 90,
      //           height: 300,
      //           width: 300,
      //           child: Container(
      //             decoration: BoxDecoration(
                    
      //               // image: DecorationImage(
      //               //   // image: AssetImage('assets/images/logo.jpeg'),
      //               //   fit: BoxFit.scaleDown ,
      //               // ),
      //             ),
      //           ),
      //         ),
            
      //       ],
      //     ),
      //   ),
      // ),