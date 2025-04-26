import 'package:eductionapp/views/register/register_child_screen.dart';
import 'package:eductionapp/views/subjects/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RegisterParentScreen extends StatefulWidget {
  const RegisterParentScreen({super.key});

  @override
  State<RegisterParentScreen> createState() => _RegisterParentScreenState();
}

class _RegisterParentScreenState extends State<RegisterParentScreen> {
  String selectedRole = 'parent';
  bool obscurePassword = true;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChildSelected = true;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              SvgPicture.asset(
                'assets/icons/Logo.svg',
                width: 158,
                height: 35,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 16),

              const Text(
                'Inscrivez-vous dès maintenant au Petit Davinci !',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),
              Row(
                children: const [
                  Text("Vous avez déjà un compte ? "),
                  Text(
                    "Se connecter",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Role toggle
              _buildRoleButton(),

              SizedBox(
                child:
                    !isChildSelected
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),

                            // Name field
                            const SizedBox(height: 24),
                            CustomTextField(
                              controller: emailController,
                              hintText: "Nom et prénom",
                              icon: SvgPicture.asset(
                                "assets/icons/solar_user-linear.svg",
                              ),
                            ),
                            const SizedBox(height: 16),
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

                            const SizedBox(height: 24),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Ajouter un compte enfant",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff272727),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Handle child account logic
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/icons/solar_add-circle-linear.svg",
                                  ),
                                  label: const Text("Ajouter"),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.grey[100],
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 40),

                            // Sign up button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.push('/home');
                                  // Submit logic
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF9281FF),
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                child: const Text(
                                  "S’inscrire",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        )
                        : RegisterChildScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Enfant Button
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isChildSelected = true;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color:
                      isChildSelected ? Colors.deepPurpleAccent : Colors.grey,
                  width: 1.5,
                ),
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enfant",
                    style: TextStyle(
                      color:
                          isChildSelected
                              ? Colors.deepPurpleAccent
                              : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        // Parent Button
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isChildSelected = false;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color:
                      !isChildSelected ? Colors.deepPurpleAccent : Colors.grey,
                  width: 1.2,
                ),
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Parent",
                    style: TextStyle(
                      color:
                          !isChildSelected
                              ? Colors.deepPurpleAccent
                              : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
