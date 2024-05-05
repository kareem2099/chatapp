import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:chatapp/localization/app_localization.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/signup_screen.dart';
import 'package:chatapp/widgets/language_switch_widget.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    if (localizations != null) {
      return Scaffold(
        appBar: AppBar(
          actions: const [
            LanguageSwitch(),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Text(
              localizations.translate('welcome')!,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset("assets/images/giphy.gif"),
            ),
            const Spacer(flex: 1),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: localizations.translate('username'),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
            PasswordField(passwordController: passwordController),
            const Spacer(flex: 1),
            ElevatedButton(
              onPressed: () {
                if (usernameController.text == "Easy" &&
                    passwordController.text == "123") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              },
              child: Text(
                localizations.translate('login')!,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(250, 50),
                backgroundColor: Colors.white,
              ),
            ),
            const Spacer(flex: 1),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: localizations.translate('dont_have_account') ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  TextSpan(
                    text: localizations.translate('signup') ?? '',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _navigateToSignupScreen(context); // Pass context here
                      },
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      );
    } else {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }

  void _navigateToSignupScreen(BuildContext context) {
    // Define method here
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController? passwordController;

  const PasswordField({Key? key, required this.passwordController})
      : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText:
            AppLocalizations.of(context)?.translate('password') ?? 'Password',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
