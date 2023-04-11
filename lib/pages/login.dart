import 'package:aplikasi_kedai/models/global_model.dart';
import 'package:aplikasi_kedai/pages/home.dart';
import 'package:aplikasi_kedai/widget/custom_text_field.dart';
import 'package:aplikasi_kedai/widget/error.dart';
import 'package:aplikasi_kedai/widget/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  formValidation() {
    if (emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty) {
      // Login
      loginNow();
    } else {
      showDialog(
        context: context,
        builder: (c) {
          return const ErrorDialog(
            message: 'Isi terlebih dahulu email & passowrd',
          );
        },
      );
    }
  }

  loginNow() async {
    showDialog(
      context: context,
      builder: (c) {
        return const LoadingDialog(
          message: 'Checking Credentials',
        );
      },
    );
    // ignore: unused_local_variable
    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: error.message.toString(),
          );
        },
      );
    });
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!).then(
        (value) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const HomeScreen(),
            ),
          );
        },
      );
    }
  }

  Future readDataAndSetDataLocally(User currentuser) async {
    await FirebaseFirestore.instance
        .collection('sellers')
        .doc(currentuser.uid)
        .get()
        .then((snapshot) async {
      await sharedPreferences!
          .setString('email', snapshot.data()!['sellerEmail']);
      await sharedPreferences!
          .setString('name', snapshot.data()!['sellerName']);
      await sharedPreferences!
          .setString('photoUrl', snapshot.data()!['sellerAvatarUrl']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.all(15),
              child: Image.asset(
                'assets/images/seller.png',
                height: 270,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailcontroller,
                  hintText: 'Email',
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordcontroller,
                  hintText: 'Passowrd',
                  isObsecre: true,
                ),
              ],
            ),
          ),
          ElevatedButton(
            // ignore: sort_child_properties_last
            child: const Text(
              'Login',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            // ignore: avoid_print
            onPressed: () {
              formValidation();
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
