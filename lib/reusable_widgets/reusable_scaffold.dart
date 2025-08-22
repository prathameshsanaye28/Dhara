import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

import 'menu_button.dart';
import 'sidebar.dart';

class ReusableScaffold extends StatefulWidget {
  final Widget body;
  final bool showBars;

  const ReusableScaffold({
    super.key,
    required this.body,
    this.showBars = true,
  });

  @override
  State<ReusableScaffold> createState() => _ReusableScaffoldState();
}

class _ReusableScaffoldState extends State<ReusableScaffold>
    with SingleTickerProviderStateMixin {
  bool isSideBarOpen = false;
  late AnimationController _animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleSidebar() {
    if (_animationController.value == 0) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      isSideBarOpen = !isSideBarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Rive animation
        const Positioned.fill(
          child: rive.RiveAnimation.asset(
            'assets/RiveAssets/bg-blur.riv',
            fit: BoxFit.cover,
          ),
        ),
        // Sidebar
        widget.showBars
            ? AnimatedPositioned(
                width: 288,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 200),
                left: isSideBarOpen ? 0 : -288,
                child: SafeArea(
                  child: const SideBar(),
                ),
              )
            : SizedBox(), // Shows an empty SizedBox if showBars is false
        // Main content with sidebar animation
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY((1 * animation.value - 30 * animation.value) * pi / 180),
          child: Transform.translate(
            offset: Offset(animation.value * 265, 0),
            child: Transform.scale(
              scale: scaleAnimation.value,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true,
                appBar: widget.showBars
                    ? AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: isSideBarOpen
                            ? GestureDetector(
                                onTap: toggleSidebar,
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            : MenuBtn(
                                press: toggleSidebar,
                                riveOnInit: (artboard) {},
                              ),
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.warning, color: Colors.red),
                            onPressed: () {},
                          ),
                        ],
                      )
                    : AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: widget.body,
                  ),
                ),
                // bottomNavigationBar:
                //     widget.showBars ? const BottomNavigation() : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
