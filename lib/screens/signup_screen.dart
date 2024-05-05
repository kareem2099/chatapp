import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chatapp/localization/app_localization.dart';
import 'package:chatapp/widgets/language_switch_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  String? usernameError;
  String? emailError;
  String? passwordError;
  String? passwordConfirmationError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          var localizations = AppLocalizations.of(context);
          if (localizations != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Text(
                  localizations.translate('signup') ?? 'Signup',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset("images/giphy.gif"),
                ),
                const Spacer(flex: 1),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText:
                        localizations.translate('username') ?? 'Username',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                    ),
                    errorText: usernameError,
                  ),
                ),
                const Spacer(flex: 1),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: localizations.translate('email') ?? 'Email',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                    ),
                    errorText: emailError,
                  ),
                ),
                const Spacer(flex: 1),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText:
                        localizations.translate('password') ?? 'Password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                    ),
                    errorText: passwordError,
                  ),
                ),
                const Spacer(flex: 1),
                TextField(
                  controller: passwordConfirmationController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: localizations.translate('confirm_password') ??
                        'Confirm Password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                    ),
                    errorText: passwordConfirmationError,
                  ),
                ),
                const Spacer(flex: 1),
                ElevatedButton(
                  onPressed: () {
                    // Validate username and password
                    if (usernameController.text.isEmpty) {
                      setState(() {
                        usernameError = 'Please enter a username';
                      });
                    } else {
                      setState(() {
                        usernameError = null;
                      });
                    }
                    if (emailController.text.isEmpty) {
                      setState(() {
                        emailError = 'Please enter an email';
                      });
                    } else {
                      setState(() {
                        emailError = null;
                      });
                    }
                    if (passwordController.text.isEmpty) {
                      setState(() {
                        passwordError = 'Please enter a password';
                      });
                    } else {
                      setState(() {
                        passwordError = null;
                      });
                    }
                    if (passwordConfirmationController.text !=
                        passwordController.text) {
                      setState(() {
                        passwordConfirmationError = 'Passwords do not match';
                      });
                    } else {
                      setState(() {
                        passwordConfirmationError = null;
                      });
                    }

                    // If all fields are filled and passwords match, proceed with sign-up
                    if (usernameError == null &&
                        passwordError == null &&
                        passwordConfirmationError == null &&
                        emailError == null) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  LoginScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    localizations.translate('signUp') ?? 'Sign up',
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const Spacer(flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      onPressed: () {
                        // Handle Facebook signup
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.twitter),
                      onPressed: () {
                        // Handle Twitter signup
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.google),
                      onPressed: () {
                        // Handle Google signup
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.envelope),
                      onPressed: () {
                        // Handle email signup
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: localizations.translate('already_have_account') ??
                            '',
                      ),
                      TextSpan(
                        text: localizations.translate('logIn') ?? '',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
                const LanguageSwitch(),
              ],
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
