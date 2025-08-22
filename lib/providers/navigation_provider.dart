import 'package:flutter/material.dart';

import '../data/bottomnav_menus.dart';
import '../models/menu_model.dart';

class NavigationProvider with ChangeNotifier {
  Menu _selectedNav = bottomNavItems.first;
  int _selectedIndex = 0;

  Menu get selectedNav => _selectedNav;
  int get selectedIndex => _selectedIndex;

  void updateSelectedNav(Menu menu, int index) {
    // Deactivate all other menus
    for (Menu item in bottomNavItems) {
      if (item.rive.status != null) {
        item.rive.status!.value = false;
      }
    }
    // Activate the selected menu
    if (menu.rive.status != null) {
      menu.rive.status!.value = true;
    }
    // Update the selectedNav state
    _selectedNav = menu;
    _selectedIndex = index;
    notifyListeners();
  }
}
