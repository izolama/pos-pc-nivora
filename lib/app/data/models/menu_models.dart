class PosMenuCategory {
  const PosMenuCategory({
    required this.key,
    required this.label,
    required this.items,
  });

  final String key;
  final String label;
  final List<PosMenuItem> items;
}

class PosMenuItem {
  const PosMenuItem({
    required this.key,
    required this.label,
    required this.description,
  });

  final String key;
  final String label;
  final String description;
}
