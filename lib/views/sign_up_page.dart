import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warehouse_app/blocs/user_register_bloc/user_register_bloc.dart';
import 'package:warehouse_app/blocs/user_role_bloc/user_role_bloc.dart';
import 'package:warehouse_app/models/user_model/user_role_model.dart';
import 'package:warehouse_app/repo/repositories/user_repo/register_api_repository.dart';
import 'package:warehouse_app/repo/repositories/user_repo/role_api_repository.dart';

class SignupPage extends StatefulWidget {
  const SignupPage(
      {Key? key, required RegisterApiRepository registerApiRepository})
      : _registerApiRepository = registerApiRepository,
        super(key: key);

  final RegisterApiRepository _registerApiRepository;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  late UserRegisterBloc _registerBloc;

  bool obscureText = true;

  @override
  void initState() {
    _registerBloc =
        UserRegisterBloc(registerApiRepository: widget._registerApiRepository);
    super.initState();
  }

  RoleApiRepository roleApiRepository = RoleApiRepository();

  RegisterApiRepository provider = RegisterApiRepository();

  String? roles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: MultiBlocProvider(
              providers: [
                BlocProvider<UserRegisterBloc>(
                  create: (BuildContext context) =>
                      UserRegisterBloc(registerApiRepository: provider),
                ),
                BlocProvider<UserRoleBloc>(
                  create: (BuildContext context) =>
                      UserRoleBloc(roleApiRepository: roleApiRepository),
                ),
              ],
              child: FormBuilder(
                key: _formKey,
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
                        top: 6,
                        bottom: 6,
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
                        bottom: 25,
                      ),
                      child: SizedBox(
                        width: 160,
                        height: 160,
                        child: Image.asset('assets/images/user1.png'),
                      ),
                    ),
                    nameField(context),
                    roleDropdown(),
                    emailField(context),
                    passwordField(context),
                    signUpButton(),
                    loginButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget nameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 12,
      ),
      child: Container(
        child: FormBuilderTextField(
            name: 'name',
            decoration: InputDecoration(
              hintText: 'Name',
              prefixIcon: Icon(
                FontAwesomeIcons.solidUser,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.minLength(context, 3)
            ])),
      ),
    );
  }

  Widget roleDropdown() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 12,
      ),
      child: Container(
        child:
            BlocBuilder<UserRoleBloc, UserRoleState>(builder: (context, state) {
          // (state is UserRoleLoading)
          if (state is UserRoleFailed) {
            print('Dropdown Error');
          } else if (state is UserRoleDone) {
            return ButtonTheme(
              alignedDropdown: true,
              child: FormBuilderDropdown(
                name: 'role',
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.solidUser,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                hint: Text('Select Role'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                // value: roles,
                items: state.role.map((UserRole item) {
                  return DropdownMenuItem(
                    child: Text('${item.role}'),
                    value: item.roleId,
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    // roles = newValue;
                    newValue == 1 ? roles = 'manager' : roles = 'client';
                  });
                },
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }

  Widget emailField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 12,
      ),
      child: Container(
        child: FormBuilderTextField(
          name: 'email',
          decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(
              FontAwesomeIcons.solidEnvelope,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
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

  Widget passwordField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: Container(
        child: FormBuilderTextField(
          name: 'password',
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: Icon(
              FontAwesomeIcons.lock,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText
                    ? FontAwesomeIcons.solidEye
                    : FontAwesomeIcons.solidEyeSlash,
                color: Colors.black,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
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

  Widget signUpButton() {
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
              side: BorderSide(
                color: Color.fromRGBO(255, 0, 0, 1),
                width: 2,
              ),
            ),
            primary: Colors.white,
          ),
          onPressed: () {
            if (_formKey.currentState!.saveAndValidate()) {
              _registerBloc.add(UserRegistration(
                  email: _formKey.currentState!.value['email'],
                  password: _formKey.currentState!.value['password'],
                  name: _formKey.currentState!.value['name'],
                  roleId: _formKey.currentState!.value['role']));
              Navigator.of(context).pushReplacementNamed('/login');
            }
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
    );
  }

  Widget loginButton() {
    return Row(
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
    );
  }
}
