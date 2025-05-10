import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';


class CustomDropdown<T, C extends GetxController> extends StatelessWidget {
  final List<T> items;
  final Rx<T> selectedItem;
  final Function(T) onItemSelected;
  final String title;
  final String Function(T) itemToString;
  final String? Function(T)? itemToDisplayText;
  final Color backgroundColor;
  final Color textColor;
  
  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    this.title = "Select an item",
    required this.itemToString,
    this.itemToDisplayText,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => _showSelectionModal(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primaryDeep,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  itemToDisplayText?.call(selectedItem.value) ?? 
                      _getShortDisplayText(selectedItem.value),
                  style: const TextStyle(
                    fontFamily: 'Archivo',
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _getShortDisplayText(T item) {
    final text = itemToString(item);
    final words = text.split(' ');
    return words.length > 2 ? '${words[0]} ${words[1]}' : text;
  }

  void _showSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Bricolage Grotesque',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDeep,
              ),
            ),
            const Gap(15),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _buildOption(items[index], context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(T item, BuildContext context) {
    final isSelected = selectedItem.value == item;
    
    return InkWell(
      onTap: () {
        onItemSelected(item);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          itemToString(item),
          style: TextStyle(
            fontFamily: 'Archivo',
            fontSize: 12,
            color: isSelected ? AppColors.primaryDeep : textColor,
          ),
        ),
      ),
    );
  }
}