import 'package:flutter/material.dart';

class ContenuPrecedantSuivant extends StatelessWidget {
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  const ContenuPrecedantSuivant({
    super.key,
    required this.onPreviousPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF7A5C),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: onPreviousPressed,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                            
                                Text(
                                  "Contenu précédent",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: onNextPressed,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Contenu suivant",
                                  style: TextStyle(color: Colors.black),
                                ),
                            
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
  }
}