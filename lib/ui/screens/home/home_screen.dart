import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sun_c9/ui/screens/bottom_sheets/add_bottom_sheet.dart';
import 'package:todo_sun_c9/ui/screens/home/tabs/list/list_tab.dart';
import 'package:todo_sun_c9/ui/screens/home/tabs/settings/settings_tab.dart';

import '../../providers/list_provider.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedTabIndex = 0;
  late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNav(),
      body: currentSelectedTabIndex == 0 ? ListTab() : SettingsTab(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildFab() =>
      FloatingActionButton(onPressed: (){
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddBottomSheet(),
            ));
      },
        child: const Icon(Icons.add),);

  Widget buildBottomNav() =>
       BottomAppBar(
         notchMargin: 8,
         shape: const CircularNotchedRectangle(),
         clipBehavior: Clip.hardEdge,
         child: BottomNavigationBar(
             onTap: (index){
               currentSelectedTabIndex = index;
               setState(() {});
             },
             currentIndex: currentSelectedTabIndex,
             items: const [
           BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
           BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
         ]),
       );

  PreferredSizeWidget buildAppBar() => AppBar(
    title: const Text("To Do List"),
    toolbarHeight: MediaQuery.of(context).size.height * .1,
  );
}