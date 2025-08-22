import '../models/menu_model.dart';

List<Menu> bottomNavItems = [
  Menu(
    title: "Home",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
  ),
  Menu(
    title: "IoT",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "IOT",
        stateMachineName: "IOT_interactivity"),
  ),
  Menu(
    title: "Maps",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "MAPS",
        stateMachineName: "MAPS_interactivity"),
  ),
  Menu(
    title: "Weather",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "WEATHER",
        stateMachineName: "WEATHER_interactivity"),
  ),
  Menu(
    title: "Profile",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
  ),
];
