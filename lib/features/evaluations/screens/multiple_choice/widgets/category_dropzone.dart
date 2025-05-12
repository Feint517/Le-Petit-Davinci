import 'package:flutter/material.dart';

class CategoryDropzone extends StatelessWidget {
  final String category;
  final List<String> items;
  final Function(String) onItemAdded;
  final Color metadataColor;

  const CategoryDropzone({
    super.key,
    required this.category,
    required this.items,
    required this.onItemAdded,
    required this.metadataColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: metadataColor.withOpacity(0.7),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          
          // Dropzone area
          DragTarget<String>(
            onAccept: (data) {
              onItemAdded(data);
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: metadataColor.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  border: Border.all(
                    color: candidateData.isNotEmpty
                        ? metadataColor.withOpacity(0.8)
                        : metadataColor.withOpacity(0.5),
                    width: candidateData.isNotEmpty ? 2 : 1,
                  ),
                ),
                child: items.isEmpty
                    ? Center(
                        child: Text(
                          candidateData.isNotEmpty
                              ? 'Dépose ici'
                              : 'Glisse les éléments ici',
                          style: TextStyle(
                            color: Colors.black54,
                            fontStyle: candidateData.isNotEmpty ? FontStyle.normal : FontStyle.italic,
                            fontWeight: candidateData.isNotEmpty ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: items.map((item) => _buildCategoryItem(item)).toList(),
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: metadataColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: metadataColor.withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        item,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}