import 'package:dhara_sih/models/shiftIncharge.dart';
import 'package:dhara_sih/resources/user_provider.dart';
import 'package:dhara_sih/screens/iot/iot_dashboard.dart';
import 'package:dhara_sih/screens/maps_screen.dart';
import 'package:dhara_sih/screens/user_profile_screen.dart';
import 'package:dhara_sih/screens/weather_bot/weather_bot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../data/bottomnav_menus.dart';
import '../models/menu_model.dart';
import '../providers/navigation_provider.dart';
import 'home_screen/home_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  final int initialIndex;

  const MainLayoutScreen({super.key, required this.initialIndex});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Update the selected navigation state to match the initial index
      final navigationProvider =
          Provider.of<NavigationProvider>(context, listen: false);
      navigationProvider.updateSelectedNav(
          bottomNavItems[widget.initialIndex], widget.initialIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final ShiftIncharge? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                navigationProvider.updateSelectedNav(
                    bottomNavItems[index], index);
              },
              children: [
                const HomeScreen(),
                const IotDashboardScreen(), // Placeholder screens
                BlueprintScreen(),
                const WeatherBotScreen(),
                UserScreen(),
              ],
            ),
          ),
          // Bottom navigation bar positioned 16 pixels from the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: _buildBottomNavigationBar(navigationProvider),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(items: []),
    );
  }

  Widget _buildBottomNavigationBar(NavigationProvider navigationProvider) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 36),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            bottomNavItems.length,
            (index) => _buildNavItem(navigationProvider, index),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(NavigationProvider navigationProvider, int index) {
    final Menu navBar = bottomNavItems[index];
    final bool isActive = navigationProvider.selectedIndex == index;

    return GestureDetector(
      onTap: () {
        navigationProvider.updateSelectedNav(navBar, index);
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: isActive),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isActive ? 40 : 30,
            width: isActive ? 50 : 40,
            child: Opacity(
              opacity: isActive ? 1 : 0.5,
              child: RiveAnimation.asset(
                navBar.rive.src,
                artboard: navBar.rive.artboard,
                onInit: (artboard) {
                  final controller = StateMachineController.fromArtboard(
                    artboard,
                    navBar.rive.stateMachineName,
                  );
                  if (controller != null) {
                    artboard.addController(controller);
                    navBar.rive.status =
                        controller.findInput<bool>("active") as SMIBool?;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Animated Bar Widget
class AnimatedBar extends StatelessWidget {
  const AnimatedBar({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(bottom: 2),
      duration: const Duration(milliseconds: 200),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 20, 110, 8),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
