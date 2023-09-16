import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/router/app_routes.dart';
import '../../../../core/common/custom_textformfield.dart';
import '../viewmodel/auth_viewmodel.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _gap = const SizedBox(height: 30);

  final _formKey = GlobalKey<FormState>();

  final _contactController = TextEditingController(text: '1234567890');
  final _passwordController = TextEditingController(text: 'sanjiv123');

  bool _hidePassword = true;

  IconData _hideIcon = Icons.remove_red_eye;

  // @override
  // void initState() {
  //   super.initState();
  //   Dio dio = Dio();
  //   print('message from server');
  //   print(dio.get('http://10.0.2.2:3000/'));
  // }

  void _submitLogin() {
    final contact = _contactController.text.trim();
    final password = _passwordController.text.trim();

    print('Contact : $contact Password : $password');

    ref
        .watch(authViewModelProvider.notifier)
        .loginUser(context, contact, password);
  }

  @override
  void dispose() {
    super.dispose();

    _contactController.dispose();

    _passwordController.dispose();
  }

  void _resetControllers() {
    _contactController.clear();
    _passwordController.clear();
  }

  void _togglePasswordIcon() {
    if (_hidePassword) {
      setState(() {
        _hidePassword = false;
        _hideIcon = FontAwesomeIcons.eyeSlash;
      });
    } else {
      setState(() {
        _hidePassword = true;
        _hideIcon = Icons.remove_red_eye;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/images/showJalLogo.png'),
                  _gap,
                  CustomTextFormWidget(
                    fullNameController: _contactController,
                    frontIcon: Icons.phone,
                    name: 'Contact',
                    keyboardType: TextInputType.number,
                  ),
                  _gap,
                  TextFormField(
                    obscureText: _hidePassword,
                    controller: _passwordController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please, enter password'
                        : null,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _togglePasswordIcon();
                          },
                          icon: Icon(_hideIcon)),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                  _gap,
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('login');
                        _submitLogin();
                      }
                    },
                    child: const Text('Login'),
                  ),
                  _gap,
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(
                          context, AppRoutes.registerRoute);
                    },
                    child: const Text('Don\'t have an account ? Register Here'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(
                          context, AppRoutes.dashboardRoute);
                    },
                    child: const Text('Dashboard'),
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
