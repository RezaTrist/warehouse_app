import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warehouse_app/repo/providers/firebase_auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  Future _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
  }

  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  FirebaseAuthProvider provider = FirebaseAuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 30,
                    ),
                    child: SizedBox(
                      width: 180,
                      height: 180,
                      child: Image.asset('assets/images/work.png'),
                    ),
                  ),

                  // TEXT FIELD EMAIL
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      bottom: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(46, 40, 40, 1),
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: FormBuilderTextField(
                        name: 'email',
                        // controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(FontAwesomeIcons.solidEnvelope),
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.contains('@')) {
                            return 'Invalid Email';
                          }
                        },
                        onSaved: (value) {
                          _authData['email'] = value!;
                        },
                      ),
                    ),
                  ),

                  // TEXT FIELD PASSWORD
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      bottom: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(46, 40, 40, 1),
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: FormBuilderTextField(
                        name: 'password',
                        // controller: passwordController,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(FontAwesomeIcons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(obscureText
                                ? FontAwesomeIcons.solidEye
                                : FontAwesomeIcons.solidEyeSlash),
                          ),
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Password is too short';
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value!;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 2,
                    ),
                    child: new Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(163, 46),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            primary: Color.fromRGBO(35, 42, 255, 1)),
                        onPressed: () {
                          _submit();
                          // provider
                          //     .loginWithEmailAndPassword(
                          //         emailController.text.trim(),
                          //         passwordController.text.trim())
                          //     .then((value)
                          //     {
                          //   if (value == 'Welcome') {
                          //     Navigator.of(context)
                          //         .pushReplacementNamed('/dashboard');
                          //   } else {
                          //     print('Email or Password is invalid!');
                          //   }
                          // });
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context)
                                .pushReplacementNamed('/dashboard');
                          } else {
                            print('Email or Password is invalid');
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/signup');
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 0, 0, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
