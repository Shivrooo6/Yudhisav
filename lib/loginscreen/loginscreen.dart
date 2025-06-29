import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yudhisav/bottomnav/bottomnavscreen.dart';
import 'package:yudhisav/repository/widgets/uihelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool isLoginMode = true;

  @override
  void initState() {
    super.initState();
    _checkIfAlreadyLoggedIn();
  }

  void _checkIfAlreadyLoggedIn() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavScreen()),
      );
    }
  }

  Future<void> _handleGoogleAuth() async {
    setState(() => _isLoading = true);

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        _showMessage("Google Sign-In cancelled.");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        _showMessage("Google authentication failed.");
        return;
      }

      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

      if (isLoginMode) {
        if (isNewUser) {
          _showMessage("User not registered. Please sign up first.");
          await FirebaseAuth.instance.signOut();
        } else {
          _navigateToHome();
        }
      } else {
        if (isNewUser) {
          _navigateToHome();
        } else {
          _showMessage("User already exists. Try logging in.");
          await FirebaseAuth.instance.signOut();
        }
      }
    } catch (e) {
      _showMessage("Sign-In failed. Make sure SHA-1 is added in Firebase.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const BottomNavScreen()),
    );
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              UiHelper.CustomText(
                text: "Yudhisav",
                color: const Color(0xFFFE600E),
                fontweight: FontWeight.bold,
                fontsize: 44,
                fontfamily: "bold",
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => isLoginMode = true),
                    child: const Text("Sign In"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isLoginMode ? const Color(0xFFFE600E) : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => setState(() => isLoginMode = false),
                    child: const Text("Sign Up"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !isLoginMode ? const Color(0xFFFE600E) : Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 400,
                height: 350,
                child: Image.asset("assets/images/loginimage.png"),
              ),
              const SizedBox(height: 30),

              _isLoading
    ? const CircularProgressIndicator()
    : ElevatedButton(
        onPressed: _handleGoogleAuth,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Colors.grey),
          ),
          elevation: 3,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/google_icon.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 12),
            Text(
              isLoginMode ? "Login with Google" : "Register with Google",
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),


              const SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  text: 'By continuing, you agree to our ',
                  style: const TextStyle(fontSize: 12),
                  children: [
                    const TextSpan(
                      text: 'T&C',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const TextSpan(text: ' and '),
                    const TextSpan(
                      text: 'Privacy',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const TextSpan(text: ' policy.'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
