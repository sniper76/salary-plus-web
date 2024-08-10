part of '../screen.dart';

class _RadioItem extends StatelessWidget {
  const _RadioItem({super.key, required this.title, required this.isChecked, this.icon, this.onTap});

  final String title;
  final bool isChecked;
  final IconData? icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  icon,
                  size: 22,
                  color: isChecked ? context.colorScheme.primary : Colors.grey.shade300,
                ),
              ),
            Text(
              title,
              style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}
