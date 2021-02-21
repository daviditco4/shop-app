import 'package:flutter/material.dart';

enum AuthMode { signup, signin }

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  var _authMode = AuthMode.signin;
  final _authData = {'email': '', 'password': ''};
  final _passwordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() => _isLoading = true);

      switch (_authMode) {
        case AuthMode.signup:
          // Sign up...
          break;
        case AuthMode.signin:
          // Sign in...
          break;
      }

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSgnin = _authMode == AuthMode.signin;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: isSgnin ? 260 : 320,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    return value.isEmpty || !value.contains('@')
                        ? 'Invalid email.'
                        : null;
                  },
                  onSaved: (value) => _authData['email'] = value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    return value.isEmpty || value.length < 5
                        ? 'Password is too short.'
                        : null;
                  },
                  onSaved: (value) => _authData['password'] = value,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    validator: (value) {
                      return value != _passwordController.text
                          ? 'Passwords do not match.'
                          : null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                  ),
                const SizedBox(height: 20.0),
                if (_isLoading)
                  const CircularProgressIndicator()
                else ...[
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(isSgnin ? 'Sign in' : 'Sign up'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _authMode = isSgnin ? AuthMode.signup : AuthMode.signin;
                      });
                    },
                    child: Text('${isSgnin ? 'Sign up' : 'Sign in'} instead'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
