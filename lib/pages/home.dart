import 'package:aplikasi_kedai/models/auth_screen.dart';
import 'package:aplikasi_kedai/models/global_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.amber],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(
          sharedPreferences!.getString('name')!,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            firebaseAuth.signOut().then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const AuthScreen(),
                ),
              );
            });
          },
          // ignore: sort_child_properties_last
          child: const Text('Logout'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
        ),
      ),
    );
  }
}
