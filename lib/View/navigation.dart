/* import 'package:flutter/material.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/View/Dashboard.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Welcome to',
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                  Text(
                    'Greater Hyderabad Municipal',
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                  Text(
                    'Corporation',
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                  Text(
                    'Version 2.8',
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ],
              ),
            ),
            createDrawerItem(maintext: 'Profile'),
            ListTile(
              leading: const Icon(
                Icons.inbox,
              ),
              title: const Text(
                'Inbox',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.black),
            createDrawerItem(maintext: 'Services'),
            ListTile(
              leading: const Icon(
                Icons.inbox,
              ),
              title: const Text(
                'Grievances',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.navigation);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.inbox,
              ),
              title: const Text(
                'Abstract Report',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.black),
            createDrawerItem(maintext: 'Advertisement'),
            ListTile(
              leading: const Icon(
                Icons.inbox,
              ),
              title: const Text(
                'Hoardings Info',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.black),
            createDrawerItem(maintext: 'Others'),
            ListTile(
              leading: const Icon(
                Icons.inbox,
              ),
              title: const Text(
                'Themes',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.inbox,
              ),
              title: const Text(
                'Exit',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.inbox,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const GhmcDashboard(),
    );
  }

  Widget createDrawerItem({required String maintext}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Text(
            maintext,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
 */