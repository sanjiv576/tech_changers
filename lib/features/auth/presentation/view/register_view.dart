import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_project/features/auth/domain/entity/user_entity.dart';

import '../../../../config/router/app_routes.dart';
import '../../../../core/common/custom_textformfield.dart';
import '../viewmodel/auth_viewmodel.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _gap = const SizedBox(height: 30);

  final _formKey = GlobalKey<FormState>();
  final _role = ['User', 'Supplier'];

  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _userRole;

  bool _hidePassword = true;

  IconData _hideIcon = Icons.remove_red_eye;

  @override
  void dispose() {
    super.dispose();

    _addressController.dispose();
    _usernameController.dispose();
    _contactController.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void _resetControllers() {
    _addressController.clear();
    _usernameController.clear();
    _contactController.clear();
    _fullNameController.clear();
    _usernameController.clear();
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

  void _submitRegister(BuildContext context, WidgetRef ref) {
    UserEntity newUser = UserEntity(
      fullName: _fullNameController.text.trim(),
      contactNumber: _contactController.text.trim(),
      address: _addressController.text.trim(),
      password: _passwordController.text.trim(),
    );

    print('New user details : $newUser');

    ref.watch(authViewModelProvider.notifier).registerUser(newUser, context);
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
                      fullNameController: _fullNameController,
                      frontIcon: Icons.person,
                      name: 'Full Name'),
                  _gap,
                  // DropdownButtonFormField(
                  //   items: _role
                  //       .map((e) => DropdownMenuItem(
                  //             value: e,
                  //             child: Text(e.toString()),
                  //           ))
                  //       .toList(),
                  //   onChanged: (value) {
                  //     _userRole = value;
                  //     print('User role : $_userRole');
                  //   },
                  //   value: _userRole,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Select Role',
                  //   ),
                  //   validator: ((value) {
                  //     if (value == null) {
                  //       return 'Please select role';
                  //     }
                  //     return null;
                  //   }),
                  // ),
                  // _gap,
                  CustomTextFormWidget(
                      fullNameController: _addressController,
                      frontIcon: Icons.location_on,
                      name: 'address'),
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
                        print('Register');
                        _submitRegister(context, ref);
                      }
                    },
                    child: const Text('Login'),
                  ),
                  _gap,
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, AppRoutes.loginRoute);
                    },
                    child: const Text('Have an already account ? Login Here'),
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
