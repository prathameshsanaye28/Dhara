import 'package:dhara_sih/models/shiftIncharge.dart';
import 'package:dhara_sih/resources/auth_methods.dart';
import 'package:dhara_sih/resources/user_provider.dart';
import 'package:dhara_sih/reusable_widgets/reusable_glassmorphic_container.dart';
import 'package:dhara_sih/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShiftIncharge? user = Provider.of<UserProvider>(context).getUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('User Profile',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () async {
              await AuthMethods().signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AnimatedLoginScreen())
              );
            },
            child: Icon(Icons.logout, color: Colors.white),
            
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: Stack(
        children: [
          const RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GlassEffectContainer(
                width: double.infinity,
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Stack(
                        //   children: [
                        //     CircleAvatar(
                        //       radius: 90,
                        //       backgroundImage: NetworkImage(user!.photoUrl),
                        //       backgroundColor: PastelColors.pastelPink,
                        //     ),
                        //     Positioned(
                        //       bottom: 20,
                        //       right: 0,
                        //       child: Icon(Icons.add_a_photo, size: 30, color: PastelColors.pastelPurple),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    SizedBox(height: 20),
                    userProfDisplay(context, 'Name', user.name),
                    SizedBox(height: 10),
                    userProfDisplay(context, 'Email', user.email),
                    SizedBox(height: 10),
                    userProfDisplay(context, 'Phone', user.phone),
                    SizedBox(height: 10),
                    userProfDisplay(context, 'Department', user.department),
                    SizedBox(height: 30),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => EditProfileScreen(
                    //           currentUser: user,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   child: circularGradientContainer("Edit Profile", context),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userProfDisplay(BuildContext context, String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)),
      SizedBox(height: 5),
      Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ),
    ],
  );
}

}