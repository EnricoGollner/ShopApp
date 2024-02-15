import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/authentication/viewModels/auth_view_model.dart';
import 'package:shop/core/components/custom_snack_bar.dart';
import 'package:shop/core/components/custom_text_field.dart';
import 'package:shop/core/enums/auth_mode.dart';
import 'package:shop/core/exceptions/auth_exception.dart';
import 'package:shop/core/utils/validator.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({super.key});

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm>
    with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.login;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final Map<String, String> _authData = {'email': '', 'password': ''};

  bool _isLoading = false;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    ); //Animation that works in an interval between 2 points - Point A to B - In the case, the size of the form card

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: _authMode == AuthMode.login ? 300 : 390,
        child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    label: 'E-mail',
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (emailText) => _authData['email'] = emailText ?? '',
                    validatorFunction: Validator.isEmail,
                  ),
                  CustomTextField(
                    controller: _passwordTextController,
                    label: 'Password',
                    isPassword: true,
                    onSaved: (passwordText) => _authData['password'] = passwordText ?? '',
                  ),
                  AnimatedContainer(
                    constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.login ? 0 : 60,
                      maxHeight: _authMode == AuthMode.login ? 0 : 120,
                    ),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: CustomTextField(
                          label: 'Confirm Password',
                          isPassword: true,
                          validatorFunction: _authMode == AuthMode.login
                              ? null
                              : (passwordToConfirm) => Validator.confirmPassword(
                                  password: _passwordTextController.text,
                                  confirmPassword: passwordToConfirm),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: !_isLoading,
                    replacement: const CircularProgressIndicator(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 30,
                        ),
                      ),
                      onPressed: _submit,
                      child: Text(
                          _authMode == AuthMode.login ? 'LOGIN' : 'SIGNUP'),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                      _authMode == AuthMode.login
                          ? 'REGISTER'
                          : 'ALREADY REGISTERED?',
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }

  void _switchAuthMode() {
    setState(() {
      if (_authMode == AuthMode.login) {
        _authMode = AuthMode.signup;
        _controller.forward(); // Starts the animation from begin to the end
      } else {
        _authMode = AuthMode.login;
        _controller.reverse(); // return of the animation
      }
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      _formKey.currentState!.save();
      AuthViewModel authProvider = Provider.of<AuthViewModel>(context, listen: false);

      if (_authMode == AuthMode.login) {
        final AuthException? response = await authProvider.login(email: _authData['email']!, password: _authData['password']!);
        if (response != null && mounted) showSnackBar(context, BoxSnackBar.error(message: response.toString()));
      } else {
        await authProvider.signup(email: _authData['email']!, password: _authData['password']!);
      }

      setState(() => _isLoading = false);
    }
  }
}
