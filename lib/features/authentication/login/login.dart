import 'package:eductionapp/views/subjects/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Giraffe/Illustration on the right
            Positioned(
              top: 50,
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/giraffe.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
              ),
            ),

            // Main login content
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/Logo.svg',
                      width: 158,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Connectez-vous\nau Petit Davinci",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text("Nouveau ici ? "),
                        GestureDetector(
                          onTap: () {
                            context.push('/register-parent');
                          },
                          child: Text(
                            "S’inscrire",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: emailController,
                      hintText: "E-mail",
                      icon: SvgPicture.asset(
                        "assets/icons/solar_letter-linear.svg",
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Mot de passe",
                      icon: SvgPicture.asset(
                        "assets/icons/solar_lock-password-linear.svg",
                      ),
                      obscureText: true,
                      right_icon: SvgPicture.asset(
                        "assets/icons/solar_eye-linear.svg",
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go('/home');
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              "Se connecter",
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Mot de passe oublié?",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Ou connectez vous avec\nvotre ",
                              children: [
                                TextSpan(
                                  text: "code PIN",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),

                          PinCodeTextField(
                            keyboardType: TextInputType.number,
                            appContext: context,
                            length: 4,
                            onChanged: (value) {},
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(8),
                              fieldHeight: 55,
                              fieldWidth: 55,
                              activeFillColor: Colors.grey[100]!,
                              inactiveFillColor: Colors.grey[100]!,
                              selectedFillColor: Colors.white,
                              activeColor: Colors.deepPurple,
                              selectedColor: Colors.deepPurple,
                              inactiveColor: Color(0xffC3C3C3),
                            ),
                            enableActiveFill: true,
                          ),

                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.push('/register-parent');
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Color(0xffFC715A),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text("Connexion avec code PIN"),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Vous avez oublié votre code PIN?",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
