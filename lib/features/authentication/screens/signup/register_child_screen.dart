// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:kids_learning_app/common/widgets/text_fields/custom_text_field.dart';
// import 'package:kids_learning_app/utils/constants/assets_manager.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class RegisterChildScreen extends StatefulWidget {
//   const RegisterChildScreen({super.key});

//   @override
//   State<RegisterChildScreen> createState() => _RegisterChildScreenState();
// }

// class _RegisterChildScreenState extends State<RegisterChildScreen> {
//   int selectedAvatar = 0;
//   int selectedGrade = 1;

//   final usernameController = TextEditingController();
//   final pinController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final avatars = List.generate(
//       8,
//       (index) => 'assets/images/avatars/Avatar-$index.png',
//     );
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Header
//         const Gap( 20),

//         // Username field
//         CustomTextField(
//           controller: usernameController,
//           hintText: "Nom et prénom",
//           icon: SvgPicture.asset(SvgAssets.solar_user_linear),
//         ),
//         const Gap( 24),

//         const Text(
//           "Choisissez votre avatar",
//           style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
//         ),

//         const Gap( 12),

//         Wrap(
//           spacing: 12,
//           runSpacing: 12,
//           children: List.generate(avatars.length, (index) {
//             return GestureDetector(
//               onTap: () => setState(() => selectedAvatar = index),
//               child: Container(
//                 width: screenWidth * 0.18,
//                 height: screenWidth * 0.18,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color:
//                         selectedAvatar == index
//                             ? Colors.deepPurple
//                             : Colors.transparent,
//                     width: 2,
//                   ),
//                 ),
//                 child: ClipOval(
//                   child: Image.asset(avatars[index], fit: BoxFit.cover),
//                 ),
//               ),
//             );
//           }),
//         ),

//         const Gap( 24),

//         const Text(
//           "Définissez votre code PIN",
//           style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
//         ),

//         const Gap( 8),

//         PinCodeTextField(
//           appContext: context,
//           length: 4,
//           onChanged: (value) {},
//           pinTheme: PinTheme(
//             shape: PinCodeFieldShape.box,
//             borderRadius: BorderRadius.circular(8),
//             fieldHeight: 55,
//             fieldWidth: 55,
//             activeFillColor: Colors.grey[100]!,
//             inactiveFillColor: Colors.grey[100]!,
//             selectedFillColor: Colors.white,
//             activeColor: Colors.deepPurple,
//             selectedColor: Colors.deepPurple,
//             inactiveColor: Color(0XffF9FAFB),
//           ),
//           enableActiveFill: true,
//         ),

//         const Gap( 24),

//         const Text(
//           "Sélectionnez le niveau scolaire",
//           style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
//         ),
//         const Gap( 12),

//         Row(
//           children: [
//             _buildGradeOption(1, "1ere année"),
//             const Gap( 10),
//             _buildGradeOption(2, "2eme année"),
//           ],
//         ),

//         const Gap( 40),

//         // Submit button
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF9281FF),
//               padding: EdgeInsets.symmetric(vertical: 8),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(40),
//               ),
//             ),
//             child: const Text("S’inscrire", style: TextStyle(fontSize: 12)),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildGradeOption(int value, String label) {
//     final isSelected = selectedGrade == value;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () => setState(() => selectedGrade = value),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           decoration: BoxDecoration(
//             color: isSelected ? const Color(0xFFF5F2FF) : Colors.white,
//             border: Border.all(
//               color: isSelected ? const Color(0xFF9281FF) : Colors.grey,
//             ),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? const Color(0xFF9281FF) : Colors.black,
//               fontWeight: FontWeight.w500,
//               fontSize: 12,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
