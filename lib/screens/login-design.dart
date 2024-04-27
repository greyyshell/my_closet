import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_closet/screens/sign_up.dart';

//Authentication
class AuthService {
  static Future<void> signInWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide any existing Snackbars
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Signing in...'),
        duration: Duration(seconds: 2), // Show a loading message for 2 seconds
      ));

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide any existing Snackbars
      String errorMessage = '';

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Invalid credentials. Please check your email and password.';
      } else {
        errorMessage = 'An error occurred.';
      }


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    }
  }
}

//Login Component
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //header
            Text(
              "My Closet",
              style: GoogleFonts.gluten(
                fontSize: 60,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: const Offset(-3, -3),
                    blurRadius: 5,
                    color: Colors.white60.withOpacity(1.0),
                  ),
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Shadow(
                    offset: const Offset(2, 5),
                    blurRadius: 2,
                    color: Colors.black26.withOpacity(0.5),
                  ),
                  Shadow(
                    offset: const Offset(5, 12),
                    blurRadius: 3,
                    color: Colors.black12.withOpacity(0.1),
                  ),
                ],
              ),
            ),

            //Login Form
            Container(
              width: 400, // Adjust the width of the container
              height: 600, // Adjust the height of the container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              margin: const EdgeInsets.all(10),
              child: Card(
                elevation: 0,
                shadowColor: Colors.transparent,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            //const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(top: 0), // Adjust the top padding here
                              child: Text(
                                'Login',
                                style: GoogleFonts.angkor(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 2.5,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: const Offset(-3, -3),
                                      blurRadius: 5,
                                      color: Colors.white60.withOpacity(1.0),
                                    ),
                                    Shadow(
                                      offset: const Offset(1, 1),
                                      blurRadius: 2,
                                      color: Colors.black.withOpacity(1.0),
                                    ),
                                    Shadow(
                                      offset: const Offset(2, 3),
                                      blurRadius: 2,
                                      color: Colors.brown.withOpacity(1.0),
                                    ),
                                    Shadow(
                                      offset: const Offset(7, 7),
                                      blurRadius: 3,
                                      color: Colors.black12.withOpacity(0.1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            //Email Text field
                            TextFormField(
                              controller: _email,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Email is Empty!';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(labelText: 'Email'),
                            ),
                            const SizedBox(height: 20),

                            //Password Text field
                            TextFormField(
                              obscureText: true,
                              controller: _password,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Password is Empty!';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(labelText: 'Password'),
                            ),
                            const SizedBox(height: 20),

                            //Forgot Password Function
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'forgot password?',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            //Login Button
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  AuthService.signInWithEmailAndPassword(
                                    context,
                                    _email.text,
                                    _password.text,
                                  );
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.brown.shade400), // Change the button's background color here
                              ),
                              child: isLoading
                                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                                  : Text(
                                "Login",
                                style: GoogleFonts.angkor(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  letterSpacing: 2.5,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: const Offset(5, 5),
                                      blurRadius: 3,
                                      color: Colors.black12.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),

                            Divider(
                              color: Colors.brown.withOpacity(0.8), // Customize the color of the divider
                              thickness: 3, // Customize the thickness of the divider
                              height: 20, // Adjust the height of the divider
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'or log in with?',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.facebook, // Add your Facebook icon here
                                  size: 30,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.g_translate, // Add your Google icon here
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Sign Up
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Don't have an account yet? ",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Sign up",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.indigoAccent,
                                      decoration: TextDecoration.underline, // Add underline decoration to simulate link
                                    ),
                                    // Sign up routing
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigate to SignUpScreen
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                            builder: (context) => const SignUp()
                                        ));
                                      },
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
