import 'package:ecommerce_mobile_app/routes/app_routes.dart';
import 'package:ecommerce_mobile_app/widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../consts/firebase_consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  String? _email;
  String? _name;
  String? address;
  final User? user = authInstance.currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    if (user == null) {
      print("User is null");
      return;
    }
    try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          _email = userDoc.get('email');
          _name = userDoc.get('name');
          address = userDoc.get('shipping-address');
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                RichText(
                  text: TextSpan(
                    text: 'Hi,  ',
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'user: $_name',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('My $_name is pressed');
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  text: _email == null ? 'Email' : _email!,
                  color: Colors.white,
                  textSize: 18,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 30,
                ),
                _listTiles(
                  title: 'Address',
                  subtitle: address,
                  icon: IconlyLight.profile,
                  onPressed: () async {
                    await _showAddressDialog();
                  },
                  color: Colors.white,
                ),
                _listTiles(
                  title: 'Orders',
                  icon: IconlyLight.bag,
                  onPressed: () {},
                  color: Colors.white,
                ),
                _listTiles(
                  title: 'Logout',
                  icon: IconlyLight.logout,
                  onPressed: () async {
                    await _showLogoutDialog();
                  },
                  color: Colors.white,
                ),
                _listTiles(
                  title:"" 
                ),
                _listTiles(
                  title:"" 
                ),
                _listTiles(
                  title:"" 
                ),
                _listTiles(
                  title:"" 
                ),
                _listTiles(
                  title:"" 
                ),
                _listTiles(
                  title:"" 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              // onChanged: (value) {
              //   print('_addressTextController.text ${_addressTextController.text}');
              // },
              controller: _addressTextController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: "Your address"),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String _uid = user!.uid;
                  try {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(_uid)
                        .update({
                      'shipping-address': _addressTextController.text,
                    });
                    setState(() {
                      address = _addressTextController.text;
                    });
                    Navigator.pop(context);
                  } catch (err) {
                    print('Error: $err');
                  }
                },
                child: const Text('Update'),
              ),
            ],
          );
        });
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppRoutes.routes['LoginScreen']!(context),
        ),
      );
    } catch (error) {
      print("Error signing out: $error");
    }
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              const Text('Sign out'),
            ]),
            content: const Text('Do you want to sign out?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Cancel',
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: _logout,
                child: TextWidget(
                  color: Colors.red,
                  text: 'OK',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

  Widget _listTiles({
    required String title,
    IconData? icon,
    String? subtitle,
    Function()? onPressed,
    Color? color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: Colors.white,
        textSize: 18,
      ),
      subtitle: subtitle != null
          ? TextWidget(
              text: subtitle,
              color: color!.withOpacity(0.5),
              textSize: 14,
            )
          : null,
      leading: Icon(
        icon,
        color: color,
      ),
      onTap: onPressed,
    );
  }
}


