import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CheatSheetCard extends StatefulWidget {
  final String title;
  final Color color;
  final Color alternateRowColor;
  final List<String> columns;
  final List<List<String>> rows;
  final IconData icon;

  const CheatSheetCard({
    super.key,
    required this.title,
    required this.color,
    required this.columns,
    required this.rows,
    required this.alternateRowColor,
    required this.icon,
  });

  @override
  State<CheatSheetCard> createState() => _CheatSheetCardState();
}

class _CheatSheetCardState extends State<CheatSheetCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: widget.color.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Interactive title bar
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: _isExpanded ? Radius.zero : Radius.circular(20),
                  bottomRight: _isExpanded ? Radius.zero : Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    size: 20,
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BricolageGrotesque',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isExpanded ? Icons.visibility : Icons.visibility_off,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          size: 16,
                        ),
                        const Gap(4),
                        Text(
                          _isExpanded ? 'Masquer' : 'Voir',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          AnimatedCrossFade(
            firstChild: Container(height: 0),
            secondChild: Column(
              children: [
                // Table headers (if present)
                if (widget.columns.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: 0.7),
                    ),
                    child: Row(
                      children: List.generate(
                        widget.columns.length,
                        (index) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.columns[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Table rows with enhanced styling
                Column(
                  children: List.generate(
                    widget.rows.length,
                    (rowIndex) => Container(
                      decoration: BoxDecoration(
                        color:
                            rowIndex % 2 == 0
                                ? widget.alternateRowColor
                                : Colors.white,
                        borderRadius:
                            rowIndex == widget.rows.length - 1
                                ? const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )
                                : null,
                      ),
                      child: Row(
                        children: List.generate(
                          widget.rows[rowIndex].length,
                          (colIndex) => Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  right:
                                      colIndex <
                                              widget.rows[rowIndex].length - 1
                                          ? BorderSide(
                                            color: Colors.grey.withValues(
                                              alpha: 0.2,
                                            ),
                                            width: 1,
                                          )
                                          : BorderSide.none,
                                  bottom:
                                      rowIndex < widget.rows.length - 1
                                          ? BorderSide(
                                            color: Colors.grey.withValues(
                                              alpha: 0.2,
                                            ),
                                            width: 1,
                                          )
                                          : BorderSide.none,
                                ),
                              ),
                              child: Text(
                                widget.rows[rowIndex][colIndex],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                      colIndex == 0
                                          ? FontWeight.w500
                                          : FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Interactive footer
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.1),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          // Add sound functionality here
                        },
                        icon: Icon(
                          Icons.volume_up,
                          color: widget.color,
                          size: 20,
                        ),
                        label: Text(
                          'Écouter',
                          style: TextStyle(
                            color: widget.color,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            crossFadeState:
                _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
