import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class CommonHeader extends StatelessWidget {
  const CommonHeader({super.key, required this.title});
  final String title ;
  @override
  Widget build(BuildContext context) {
    return Row(
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row( 
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios, color: AppColors.textSecondary, size: 18,),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ), 
                                Text(
                                  'Retour',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'BricolageGrotesque',
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(title,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'BricolageGrotesque',
                                  color: AppColors.buttonSecondary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        const CircleAvatar(
                          backgroundImage: AssetImage(IconAssets.avatar),
                          radius: 24,
                        ),
                      ], 
                    );
  }
}