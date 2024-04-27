import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_closet/Screens/login-design.dart';


//SignUp Component
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> createUserWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide any existing Snackbars
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Signing up...'),
        duration: Duration(seconds: 2), // Show a loading message for 2 seconds
      ));

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Clear the email and password fields after successful sign-up
      // _emailController.clear();
      // _passwordController.clear();

      ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide the signing up Snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully signed up!'),
        duration: Duration(seconds: 2),
      ));


    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'An error occurred.';
      }

      ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide any existing Snackbars
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    }
  }

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

            //SignUP Form
            Container(
              width: 400, // Adjust the width of the container
              height: 500, // Adjust the height of the container
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
                                'Sign Up',
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



                            const SizedBox(height: 20),

                            //SignUp Button
                            ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                 createUserWithEmailAndPassword(
                                   context,
                                   _email.text,
                                   _password.text,
                                 );
                                }
                              },

                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.brown.shade400), // Change the button's background color here
                              ),
                              child: isLoading
                                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                                  : Text(
                                      "Sign Up",
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
                              'or sign in with?',
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
                                    text: "Already have an account? ",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Login",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.indigoAccent,
                                      decoration: TextDecoration.underline, // Add underline decoration to simulate link
                                    ),
                                    // Sign up routing
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const LogIn()
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
