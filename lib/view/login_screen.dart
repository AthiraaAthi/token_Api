import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/mycontroller.dart';
import '../model/my_model.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SampleApi sampleApiobj = SampleApi();

  final emailcontroller = TextEditingController();

  final passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final MyControllerobj = Provider.of<MyController>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Let's Login",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: "Enter Your Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passcontroller,
              decoration: InputDecoration(
                hintText: "Enter Your Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                await Provider.of<MyController>(context, listen: false)
                    .loginApi(
                        username: emailcontroller.text,
                        password: passcontroller.text);
                ////////////////////////////////the token  will print automatically
                //TO STORE THE TOKENS,IMPLEMENT SHARED PREFERENCES
                // // Obtain shared preferences.
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                await prefs.getString("token");
                print(
                    "Successfully Stored Tokens are:  ${await prefs.getString("token")}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              child: Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
