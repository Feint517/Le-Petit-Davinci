import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class CheatSheetCard extends StatelessWidget {
  final String title;
  final Color color;
  final Color alternateRowColor;
  final List<String> columns;
  final List<List<String>> rows;
  
  const CheatSheetCard({
    super.key,
    required this.title,
    required this.color,
    required this.columns,
    required this.rows,
    required this.alternateRowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Table headers (if present)
          if (columns.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.8),
              ),
              child: Row(
                children: List.generate(
                  columns.length, 
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        columns[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          
          // Table rows
          Column(
            children: List.generate(
              rows.length,
              (rowIndex) => Container(
                color: rowIndex % 2 == 0 ? alternateRowColor : Colors.white,
                child: Row(
                  children: List.generate(
                    rows[rowIndex].length,
                    (colIndex) => Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border(
                            right: colIndex < rows[rowIndex].length - 1
                                ? BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  )
                                : BorderSide.none,
                            bottom: rowIndex < rows.length - 1
                                ? BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  )
                                : BorderSide.none,
                          ),
                        ),
                        child: Text(
                          rows[rowIndex][colIndex],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: colIndex == 0 ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}