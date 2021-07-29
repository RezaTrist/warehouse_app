import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warehouse_app/blocs/user_role_bloc/user_role_bloc.dart';
import 'package:warehouse_app/models/user_role_model.dart';
import 'package:warehouse_app/repo/providers/firebase_auth_provider.dart';
import 'package:warehouse_app/repo/repositories/role_api_repository.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool obscureText = true;

  RoleApiRepository roleApiRepository = RoleApiRepository();

  String? roles;

  FirebaseAuthProvider provider = FirebaseAuthProvider();

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FormBuilder(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      'Create your account by filling up the form',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(183, 183, 183, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 20,
                    ),
                    child: SizedBox(
                      width: 180,
                      height: 180,
                      child: Image.asset('assets/images/user1.png'),
                    ),
                  ),

                  // ==================== TEXT FIELD NAME
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
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: FormBuilderTextField(
                        name: 'name',
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          prefixIcon: Icon(FontAwesomeIcons.solidUser),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  // ==================== DROPDOWN ROLE
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
                            width: 3,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: BlocProvider(
                          create: (context) => UserRoleBloc(
                              roleApiRepository: roleApiRepository),
                          child: BlocBuilder<UserRoleBloc, UserRoleState>(
                              builder: (context, state) {
                            if (state is UserRoleLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            } else if (state is UserRoleFailed) {
                              print('Dropdown Error');
                            } else if (state is UserRoleDone) {
                              return DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                    hint: Text('Select Role'),
                                    value: roles,
                                    items: state.role.map((UserRole item) {
                                      return DropdownMenuItem(
                                        child: Text('${item.role}'),
                                        value: item.role,
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        roles = newValue;
                                      });
                                    },
                                  ),
                                ),
                              );
                            }
                            return Container();
                          }),
                        )),
                  ),

                  // ==================== TEXT FIELD EMAIL
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
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(FontAwesomeIcons.solidEnvelope),
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  // ==================== TEXT FIELD PASSWORD
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
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: TextField(
                        controller: passwordController,
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
                      ),
                    ),
                  ),

                  // ==================== SIGN UP BUTTON
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
                            side: BorderSide(
                              color: Color.fromRGBO(255, 0, 0, 1),
                              width: 2,
                            ),
                          ),
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          provider
                              .registerWithEmailAndPassword(
                                  emailController.text.trim(),
                                  passwordController.text.trim())
                              .then((value) {
                            if (value == 'Success') {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            } else {
                              print('Email or password is too weak!');
                              return Container();
                            }
                          });
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(255, 0, 0, 1),
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
                      Text("Already have an account?"),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color.fromRGBO(35, 42, 255, 1),
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
