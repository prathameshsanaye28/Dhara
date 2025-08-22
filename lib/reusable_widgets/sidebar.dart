import 'package:dhara_sih/models/shiftIncharge.dart';
import 'package:dhara_sih/resources/user_provider.dart';
import 'package:dhara_sih/screens/main_layout_screen.dart';
import 'package:dhara_sih/screens/pdf_summarizer/ocr_to_summary.dart';
import 'package:dhara_sih/screens/task_screen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../data/sidebar_menus.dart';
import '../models/menu_model.dart';
import '../utils/rive_utils.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Menu selectedSideMenu = sidebarMenus.first;

  @override
  Widget build(BuildContext context) {
    final ShiftIncharge? user = Provider.of<UserProvider>(context).getUser;
    return SafeArea(
      child: Material(
        // Wrap the entire Sidebar in a Material widget
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Container(
            width: 288,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(16, 38, 4, 1),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(user?.name??'',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 32),
                  ...sidebarMenus.map((menu) => SideMenu(
                        menu: menu,
                        selectedMenu: selectedSideMenu,
                        press: () {
                          RiveUtils.changeSMIBoolState(menu.rive.status!);
                          setState(() {
                            selectedSideMenu = menu;
                          });
                          switch (menu.title) {
                            case 'Home':
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MainLayoutScreen(
                                        initialIndex: 0,
                                      ),
                                    ),
                                  );
                                },
                              );
                              break;
                            case 'IoT':
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MainLayoutScreen(
                                        initialIndex: 1,
                                      ),
                                    ),
                                  );
                                },
                              );
                              break;

                              case 'Summarizer':
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      SummarizerScreen()
                                    ),
                                  );
                                },
                              );
                              break;

                              case 'Weather':
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      MainLayoutScreen(initialIndex: 3)
                                    ),
                                  );
                                },
                              );
                              break;

                              case 'Task':
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>TasksScreen()));
                                },
                              );
                              break;

                            // Add more cases for other menu items
                            default:
                              debugPrint("No action defined for ${menu.title}");
                              break;
                          }
                        },
                        riveOnInit: (artboard) {
                          menu.rive.status = RiveUtils.getRiveInput(artboard,
                              stateMachineName: menu.rive.stateMachineName);
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
    required this.menu,
    required this.press,
    required this.riveOnInit,
    required this.selectedMenu,
  });

  final Menu menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final Menu selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(color: Colors.white24, height: 1),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              width: selectedMenu == menu ? 288 : 0,
              height: 56,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 36,
                width: 36,
                child: RiveAnimation.asset(
                  menu.rive.src,
                  artboard: menu.rive.artboard,
                  onInit: riveOnInit,
                ),
              ),
              title: Text(
                menu.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
