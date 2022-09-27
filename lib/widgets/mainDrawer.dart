import 'package:city_navigation/pages/bus_stops.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/home.dart';

Drawer mainDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    child: ListView(
      children: [
        //Drawer Header
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blueGrey[50],
                child: const Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 60,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Owira",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text("254769728089"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),

        //Drawer Body
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: const ListTile(
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.indigo,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BusStopsPage(),
              ),
            );
          },
          child: const ListTile(
            leading: Icon(
              CupertinoIcons.cube_box,
              color: Colors.indigo,
            ),
            title: Text(
              "Bus stops",
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const AccountPage(),
            //   ),
            // );
          },
          child: const ListTile(
            leading: Icon(Icons.person_outline, color: Colors.indigo),
            title: Text(
              "Account",
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const SupportPage(),
            //   ),
            // );
          },
          child: const ListTile(
            leading: Icon(Icons.help_outline, color: Colors.indigo),
            title: Text(
              "Support",
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const SettingsPage(),
            //   ),
            // );
          },
          child: const ListTile(
            leading: Icon(
              Icons.share,
              color: Colors.indigo,
            ),
            title: Text(
              "Share",
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
          ),
        ),
        GestureDetector(
          child: const ListTile(
            leading: Icon(Icons.logout, color: Colors.indigo),
            title: Text(
              "Logout",
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    ),
  );
}
