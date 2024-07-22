part of '../widget.dart';

class _BoardGroupCategorySelection extends StatelessWidget {
  final List<BoardGroupCategory> categories;
  final BoardGroupCategory? selectedCategory;
  final Function(BoardGroupCategory) onChange;

  const _BoardGroupCategorySelection({
    required this.categories,
    required this.onChange,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return Container(width: 6);
        },
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final BoardGroupCategory boardGroupCategory = categories[index];
          final bool isSelected = boardGroupCategory == selectedCategory;
          return ElevatedButton(
            onPressed: () => onChange(boardGroupCategory),
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? AppTheme.primaryColor.shade500 : Colors.white,
              elevation: 0,
              side: isSelected
                  ? BorderSide(
                      color: AppTheme.primaryColor.shade500,
                    )
                  : BorderSide(
                      color: Colors.grey.shade500,
                    ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              boardGroupCategory.displayName,
              style: context.textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
            ),
          );
        },
      ),
    );
  }
}
