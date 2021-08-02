import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warehouse_app/blocs/user_login_bloc/user_login_bloc.dart';
import 'package:warehouse_app/repo/repositories/firebase_auth_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required FirebaseAuthRepo firebaseAuthRepo})
      : _firebaseAuthRepo = firebaseAuthRepo,
        super(key: key);

  final FirebaseAuthRepo _firebaseAuthRepo;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  late UserLoginBloc _loginBloc;

  bool obscureText = true;

  @override
  void initState() {
    _loginBloc = UserLoginBloc(firebaseAuthRepo: widget._firebaseAuthRepo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => _loginBloc,
              child: FormBuilder(
                key: _formKey,
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
                    emailField(),
                    passwordField(),
                    buttonLogin(),
                    signUpButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 20,
      ),
      child: Container(
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   border: Border.all(
        //     color: Color.fromRGBO(46, 40, 40, 1),
        //     width: 3.0,
        //   ),
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(12),
        //   ),
        // ),
        child: FormBuilderTextField(
          name: 'email',
          // controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            hintText: 'Email',
            prefixIcon: Icon(FontAwesomeIcons.solidEnvelope),
          ),
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.email(context),
            FormBuilderValidators.required(context),
          ]),
        ),
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: Container(
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   border: Border.all(
        //     color: Color.fromRGBO(46, 40, 40, 1),
        //     width: 3.0,
        //   ),
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(12),
        //   ),
        // ),
        child: FormBuilderTextField(
          name: 'password',
          // controller: passwordController,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
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
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.minLength(context, 3),
            FormBuilderValidators.required(context),
          ]),
        ),
      ),
    );
  }

  Widget buttonLogin() {
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
            if (_formKey.currentState!.saveAndValidate()) {
              _loginBloc.add(UserLogin(
                  email: _formKey.currentState!.value['email'],
                  password: _formKey.currentState!.value['password']));
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
  }

  Widget signUpButton() {
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
  }
}
