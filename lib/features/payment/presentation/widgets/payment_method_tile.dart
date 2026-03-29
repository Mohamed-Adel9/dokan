import 'package:flutter/material.dart';

class PaymentMethodTile extends StatelessWidget {
  final IconData     icon;
  final String       label;
  final String       subtitle;
  final bool         selected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? color : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
          color: selected
              ? color.withValues(alpha: 0.04)
              : Colors.transparent,
        ),
        child: Row(children: [
          Icon(icon,
              color: selected ? color : Colors.grey, size: 24),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: selected ? color : null)),
              const SizedBox(height: 2),
              Text(subtitle,
                  style: const TextStyle(
                      fontSize: 12, color: Colors.grey)),
            ],
          )),
          if (selected)
            Icon(Icons.check_circle_rounded,
                color: color, size: 20),
        ]),
      ),
    );
  }
}