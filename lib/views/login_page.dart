import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warehouse_app/blocs/user_login_bloc/user_login_bloc.dart';
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

  bool autoValidate = true;

  FirebaseAuthProvider provider = FirebaseAuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => UserLoginBloc(firebaseAuth: provider),
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
                  loginForm(),
                  signUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return BlocListener<UserLoginBloc, UserLoginState>(
      listener: (context, state) {
        if (state is UserLoginFailed) {
          print('Login Failed');
        }
      },
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            emailField(),
            passwordField(),
            buttonLogin(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return BlocBuilder<UserLoginBloc, UserLoginState>(
        builder: (context, state) {
      return Padding(
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
              // focusedBorder: InputBorder.none,
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'Your Email is Invalid')
            ]),
          ),
        ),
      );
    });
  }

  Widget passwordField() {
    return BlocBuilder<UserLoginBloc, UserLoginState>(
        builder: (context, state) {
      return Padding(
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
              // focusedBorder: InputBorder.none,
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'Your Password is Invalid')
            ]),
          ),
        ),
      );
    });
  }

  Widget buttonLogin() {
    return BlocBuilder<UserLoginBloc, UserLoginState>(
        builder: (context, state) {
      return Padding(
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
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pushReplacementNamed('/dashboard');
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
      );
    });
  }

  Widget signUpButton() {
    return BlocBuilder<UserLoginBloc, UserLoginState>(
        builder: (context, state) {
      return Row(
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
      );
    });
  }
}
