// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:kids_learning_app/common/widgets/buttons/svg_button.dart';
// import 'package:kids_learning_app/features/exercises/screens/writing/widgets/control_buttons.dart';
// import 'package:kids_learning_app/features/personalization/screens/profile/widgets/profile_header.dart';
// import 'package:kids_learning_app/common/widgets/content_dropdown_list.dart';
// import 'package:kids_learning_app/utils/constants/assets_manager.dart';
// import 'package:kids_learning_app/utils/constants/colors.dart';
// import 'package:kids_learning_app/utils/constants/sizes.dart';

// class WritingPracticeScreen extends StatelessWidget {
//   const WritingPracticeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
//             child: Column(
//               children: [
//                 ProfileHeader(activeIcon: false),
//                 const Gap(AppSizes.defaultSpace),

//                 SingleChildScrollView(
//                   primary: false,
//                   child: Column(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomDropdownButton(
//                             optionsList: [
//                               "Contenu 1 - Les Bases de l’Alphabet Français",
//                               "Contenu 2 - Les Chiffres en Français",
//                               "Contenu 3 - Les Jours de la Semaine",
//                             ],
//                           ),
//                           const Gap(AppSizes.spaceBtwItems),

//                           LevelSelector(),
//                           const Gap(AppSizes.spaceBtwSections),

//                           _buildExerciseBoxSection(),
//                           const Gap(AppSizes.spaceBtwSections),

//                           ControlButtons(),
//                           const Gap(AppSizes.spaceBtwItems),

//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 9,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFFFD6F4),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: const Text(
//                               "Obtenez 5 points",
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Color(0xFFFF725E),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           const Gap(AppSizes.spaceBtwSections),
                          
//                           const Text(
//                             "Perfectionne ton écriture et ta lecture",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           const Text(
//                             "La lecture et l’écriture sont essentielles pour maîtriser la langue française. Cet exercice interactif t’aide à enrichir ton vocabulaire et à améliorer ta compréhension des phrases.",
//                             style: TextStyle(fontSize: 11),
//                           ),
//                           const SizedBox(height: 28),
//                           Center(
//                             child: SizedBox(
//                               width: MediaQuery.of(context).size.width - 20,
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(vertical: 18),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xffFC715A),
//                                   borderRadius: BorderRadius.circular(40),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                     left: 15.0,
//                                     right: 15,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       InkWell(
//                                         onTap: () {},
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Icon(
//                                               Icons.arrow_back_ios,
//                                               color: Colors.black,
//                                               size: 15,
//                                             ),

//                                             Text(
//                                               "Contenu précédent",
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {},
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               "Contenu suivant",
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),

//                                             Icon(
//                                               Icons.arrow_forward_ios,
//                                               color: Colors.black,
//                                               size: 15,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildExerciseBoxSection() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Compléter des phrases avec des mots manquants.",
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 20),

//           _buildExerciseBox("Je vais y aller et...", [
//             "revenir",
//             "maison",
//             "retour",
//           ]),
//           const SizedBox(height: 16),

//           _buildExerciseBox("Que ... manger", [
//             "donne-moi",
//             "veux-tu",
//             "puis-je",
//           ]),
//           const SizedBox(height: 16),

//           _buildExerciseBox("Qu’est-ce que tu fais pour...", [
//             "habites-tu",
//             "arrives-tu",
//             "t'amuser",
//           ]),
//         ],
//       ),
//     );
//   }

//   Widget _levelChip({required String label, required bool isSelected}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: isSelected ? const Color(0xFF9281FF) : Colors.black26,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         color: isSelected ? const Color(0xFFEFEAFF) : Colors.transparent,
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//           color: isSelected ? const Color(0xFF9281FF) : Colors.black87,
//         ),
//       ),
//     );
//   }

//   Widget _buildExerciseBox(String phrase, List<String> options) {
//     return Container(
//       width: double.infinity,
//       height: 90,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFFEFD8FF)),
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.white,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(phrase, style: const TextStyle(fontSize: 16)),
//           const SizedBox(height: 12),
//           Wrap(
//             spacing: 16,
//             runSpacing: 6,
//             children:
//                 options.map((option) {
//                   Color color = Colors.green;
//                   if (option.contains('tu')) {
//                     color = Colors.red;
//                   } else if (option.contains('donne') ||
//                       option.contains('je')) {
//                     color = Colors.purple;
//                   }
//                   return Text(
//                     option,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: color,
//                       decoration: TextDecoration.underline,
//                     ),
//                   );
//                 }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _navButton(String label, IconData icon) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFFFF725E),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//         padding: const EdgeInsets.symmetric(vertical: 16),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (icon == Icons.arrow_back_ios)
//             Icon(icon, size: 16, color: Colors.white),
//           const SizedBox(width: 8),
//           Text(label, style: const TextStyle(color: Colors.white)),
//           if (icon == Icons.arrow_forward_ios) const SizedBox(width: 8),
//           if (icon == Icons.arrow_forward_ios)
//             Icon(icon, size: 16, color: Colors.white),
//         ],
//       ),
//     );
//   }
// }



// class LevelSelector extends StatefulWidget {
//   const LevelSelector({super.key});

//   @override
//   State<LevelSelector> createState() => _LevelSelectorState();
// }

// class _LevelSelectorState extends State<LevelSelector> {
//   String selectedLevel = 'Intermédiaire';

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children:
//           ['Débutant', 'Intermédiaire', 'Avancé'].map((label) {
//             final isSelected = label == selectedLevel;
//             return GestureDetector(
//               onTap: () => setState(() => selectedLevel = label),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   border: Border.all(
//                     color: isSelected ? AppColors.primaryDeep : Colors.black87,
//                     width: 1.5,
//                   ),
//                   color:
//                       isSelected ? const Color(0xFFEFE3FF) : Colors.transparent,
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 14,
//                       height: 14,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color:
//                               isSelected
//                                   ? AppColors.primaryDeep
//                                   : AppColors.black,
//                           width: 2,
//                         ),
//                       ),
//                       child:
//                           isSelected
//                               ? Center(
//                                 child: Container(
//                                   width: 5,
//                                   height: 5,
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Color(0xFF9281FF),
//                                   ),
//                                 ),
//                               )
//                               : null,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       label,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 12,
//                         color:
//                             isSelected ? AppColors.primaryDeep : Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//     );
//   }
// }
