import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtualcard/pages/scan_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact List'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.goNamed(ScanPage.routeName);
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(

          padding: EdgeInsets.zero,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
              backgroundColor: Colors.blue.shade100,
              onTap: (index){
                setState(() {
                  selectedIndex = index;
                });
              },
              currentIndex: selectedIndex,
              items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'ALL'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'FAVORITES'),
          ]),

        ));
  }
}
