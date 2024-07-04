import 'package:flutter/material.dart';
import 'package:geo_test_riverpod/screens/homepage.dart';
import 'package:geo_test_riverpod/utils/validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _emailTextFormFieldController = TextEditingController();
  final _emailTextFormFieldKey = const Key('emailTextFormField');
  final _passwordTextFormFieldKey = const Key('passwordTextFormField');
  final _loginFormButtonKey = const Key('loginFormButton');

  final _formKey = GlobalKey<FormState>();

  void formSaveOnTap() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data'),
        ),
      );
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomepageWidget(email: _emailTextFormFieldController.text,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Geolocator TDD'),
          leading: const Icon(Icons.accessible_forward),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    key: _emailTextFormFieldKey,
                    controller: _emailTextFormFieldController,
                    validator: isValidEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Email'),
                      icon: Icon(Icons.person),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: 4,
                    ),
                  ),
                  TextFormField(
                    key: _passwordTextFormFieldKey,
                    validator: isValidPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Password'),
                      icon: Icon(Icons.key),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: 4,
                    ),
                  ),
                  ElevatedButton.icon(
                    key: _loginFormButtonKey,
                    onPressed: formSaveOnTap,
                    label: const Text('Login'),
                    icon: const Icon(Icons.login),
                  ),
                ],
              ),
            )));
  }
}
