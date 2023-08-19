import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_task1/bookfolder/book_list.dart';
import 'package:flutter_application_task1/loginService/sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isValid = false;
  bool _isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),

              Text(
                'Create your Username ',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Username',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _isValid = value.isNotEmpty;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _isValid ? '' : '',
                        style: TextStyle(
                          color: _isValid ? Colors.green : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _isEmailValid = RegExp(
                                    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an email';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'Invalid email format';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _isEmailValid
                            ? ''
                            : 'email like this: (example@XXXX.com)',
                        style: TextStyle(
                          color: _isEmailValid ? Colors.green : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                        onChanged: (value) {
                          RegExp passwordRegExp = RegExp(
                              r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{6,}$');
                          setState(() {
                            _isValid = passwordRegExp.hasMatch(value);
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          } else if (value.length < 6) {
                            return 'Password must contain at least 6 characters';
                          } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                            return 'Password must contain lowercase letters';
                          } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return 'Password must contain numbers';
                          } else if (!RegExp(r'[!@#\><*~]').hasMatch(value)) {
                            return 'Password must contain special characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _isValid && passwordController.text.length >= 6
                            ? ''
                            : 'Password must contain at least 6 characters',
                        style: TextStyle(
                          color: _isValid && passwordController.text.length >= 6
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _isValid &&
                                RegExp(r'[a-z]')
                                    .hasMatch(passwordController.text)
                            ? ''
                            : 'Password must contain lowercase letters',
                        style: TextStyle(
                          color: _isValid &&
                                  RegExp(r'[a-z]')
                                      .hasMatch(passwordController.text)
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _isValid &&
                                RegExp(r'[0-9]')
                                    .hasMatch(passwordController.text)
                            ? ''
                            : 'Password must contain numbers',
                        style: TextStyle(
                          color: _isValid &&
                                  RegExp(r'[0-9]')
                                      .hasMatch(passwordController.text)
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _isValid &&
                                RegExp(r'[!@#\><*~]')
                                    .hasMatch(passwordController.text)
                            ? ''
                            : 'Password must contain special characters',
                        style: TextStyle(
                          color: _isValid &&
                                  RegExp(r'[!@#\><*~]')
                                      .hasMatch(passwordController.text)
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // sign in button

              GestureDetector(
                child: TextButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      try {
                     await FirebaseAuth.instance.createUserWithEmailAndPassword(email:emailController.text , password: passwordController.text);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(context ,MaterialPageRoute(builder: (context) => MyBook(),));
                      } catch (e) {
                        print(e.toString());
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

                 Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'are you a member',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () async {
                  await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage()),
                      );

                    
                    },
                    child: const Text(
                      'login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
