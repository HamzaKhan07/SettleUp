import 'package:flutter/material.dart';

class LegendCard extends StatelessWidget {
  final Color color;
  final String name;

  const LegendCard({Key? key, required this.color, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 8.0,
            backgroundColor: color,
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: Text(
              name.trim(),
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
