class UpsertVariantGroupRequest {
  const UpsertVariantGroupRequest({
    required this.name,
    required this.isRequired,
    required this.displayOrder,
  });

  final String name;
  final bool isRequired;
  final int displayOrder;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isRequired': isRequired,
      'displayOrder': displayOrder,
    };
  }
}

class UpsertVariantRequest {
  const UpsertVariantRequest({
    required this.variantGroupId,
    required this.name,
    required this.additionalPrice,
    required this.sku,
    required this.isStock,
    required this.isDefault,
    required this.qty,
  });

  final int variantGroupId;
  final String name;
  final double additionalPrice;
  final String sku;
  final bool isStock;
  final bool isDefault;
  final int qty;

  Map<String, dynamic> toJson() {
    return {
      'variantGroupId': variantGroupId,
      'name': name,
      'additionalPrice': additionalPrice,
      'sku': sku,
      'isStock': isStock,
      'isDefault': isDefault,
      'qty': qty,
    };
  }
}

class UpsertModifierGroupRequest {
  const UpsertModifierGroupRequest({
    required this.name,
    required this.isRequired,
    required this.minSelect,
    required this.maxSelect,
    required this.displayOrder,
  });

  final String name;
  final bool isRequired;
  final int minSelect;
  final int maxSelect;
  final int displayOrder;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isRequired': isRequired,
      'minSelect': minSelect,
      'maxSelect': maxSelect,
      'displayOrder': displayOrder,
    };
  }
}

class UpsertModifierRequest {
  const UpsertModifierRequest({
    required this.modifierGroupId,
    required this.name,
    required this.additionalPrice,
    required this.isStock,
    required this.isDefault,
  });

  final int modifierGroupId;
  final String name;
  final double additionalPrice;
  final bool isStock;
  final bool isDefault;

  Map<String, dynamic> toJson() {
    return {
      'modifierGroupId': modifierGroupId,
      'name': name,
      'additionalPrice': additionalPrice,
      'isStock': isStock,
      'isDefault': isDefault,
    };
  }
}
