import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wasteaider/screens/user/login.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  final _form = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  validation() async {
    try {
      CollectionReference collRef =
          FirebaseFirestore.instance.collection('users');
      if (_form.currentState!.validate()) {
        UserCredential userdetails = await _auth.createUserWithEmailAndPassword(
          email: _emailcontroller.text,
          password: _passwordcontroller.text,
        );
        await collRef.add({
          'name': userdetails.user!.displayName,
          'email': userdetails.user!.email,
          'uuid': userdetails.user!.uid,
        });

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => UserLogin()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created successfully!')),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account creation failed. Please try again.')),
      );
    }
  }

  @override
  void dispose() {
    _namecontroller.text;
    _emailcontroller.text;
    _passwordcontroller.text;
    _confirmpasswordcontroller.text;
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 200, left: 20, right: 20),
                    child: Text(
                      'SIGN UP',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter valid Name';
                        }
                        return null;
                      },
                      controller: _namecontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Enter valid EmailAddress';
                        }
                        return null;
                      },
                      controller: _emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Please enter valid password!';
                        }
                        return null;
                      },
                      controller: _passwordcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            value != _passwordcontroller.text) {
                          return 'Password mismatch';
                        }
                        return null;
                      },
                      controller: _confirmpasswordcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock_outline_sharp)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        validation();
                      },
                      child: Text('Signup')),
                  SizedBox(
                    height: 50,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => (UserLogin())));
                      },
                      child: Text("Already have an account! Login?"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
