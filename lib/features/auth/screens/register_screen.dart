import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/core/themes/color_palette.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;
  String _passwordStrengthLabel = '';
  Color _strengthColor = Colors.grey;

  //init state
  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      _checkPasswordStrength(passwordController.text);
    });
  }

  //dispose state
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //submit form method
  void _submit() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final pass = passwordController.text.trim();

      final authController = ref.read(authControllerProvider.notifier);
      authController.emailRegistration(
        email,
        pass,
        context,
        onSuccess: () => {
          Navigator.of(context).pushReplacementNamed('/dashboard'),
        },
      );
    }
  }

  //password strength check method
  void _checkPasswordStrength(String password) {
    if (password.isEmpty) {
      _passwordStrengthLabel = '';
      _strengthColor = Colors.grey;
    } else if (password.length < 3) {
      _passwordStrengthLabel = 'Too short';
      _strengthColor = Colors.red;
    } else if (password.length < 5) {
      _passwordStrengthLabel = 'Weak';
      _strengthColor = Colors.orange;
    } else if (!RegExp(r'[A-Z]').hasMatch(password) ||
        !RegExp(r'[0-9]').hasMatch(password) ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      _passwordStrengthLabel = 'Medium';
      _strengthColor = Colors.yellow[800]!;
    } else {
      _passwordStrengthLabel = 'Strong';
      _strengthColor = Colors.green;
    }

    setState(() {}); // update UI
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Create Account", style: TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              if (passwordController.text.isNotEmpty)
                Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: _passwordStrengthLabel == 'Strong'
                                ? 1.0
                                : _passwordStrengthLabel == 'Medium'
                                ? 0.66
                                : _passwordStrengthLabel == 'Weak'
                                ? 0.33
                                : 0.1,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _strengthColor,
                            ),
                            minHeight: 5,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _passwordStrengthLabel,
                          style: TextStyle(
                            color: _strengthColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              if (authState.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    authState.error!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: authState.isLoading ? null : _submit,
                child: authState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
