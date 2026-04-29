import 'product_category_ref.dart';
import 'product_item.dart';

class ProductDetail extends ProductItem {
  const ProductDetail({
    required super.id,
    required super.merchantId,
    required super.merchantName,
    required super.name,
    required super.sku,
    required super.upc,
    required super.imageUrl,
    required super.imageThumbUrl,
    required super.description,
    required super.basePrice,
    required super.finalPrice,
    required super.qty,
    required super.productType,
    required super.isActive,
    required super.isStock,
    required super.categories,
    required this.variantGroups,
    required this.modifierGroups,
  });

  final List<VariantGroup> variantGroups;
  final List<ModifierGroup> modifierGroups;

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: (json['id'] as num?)?.toInt() ?? 0,
      merchantId: (json['merchantId'] as num?)?.toInt() ?? 0,
      merchantName: json['merchantName']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      sku: json['sku']?.toString() ?? '',
      upc: json['upc']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      imageThumbUrl: json['imageThumbUrl']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0,
      finalPrice: (json['finalPrice'] as num?)?.toDouble() ?? 0,
      qty: (json['qty'] as num?)?.toInt() ?? 0,
      productType: json['productType']?.toString() ?? '',
      isActive: json['isActive'] as bool? ?? true,
      isStock: json['isStock'] as bool? ?? false,
      categories:
          ((json['categories'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(ProductCategoryRef.fromJson)
              .toList(),
      variantGroups:
          ((json['variantGroups'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(VariantGroup.fromJson)
              .toList(),
      modifierGroups:
          ((json['modifierGroups'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(ModifierGroup.fromJson)
              .toList(),
    );
  }
}

class VariantGroup {
  const VariantGroup({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.displayOrder,
    required this.isActive,
    required this.variants,
  });

  final int id;
  final String name;
  final bool isRequired;
  final int displayOrder;
  final bool isActive;
  final List<VariantItem> variants;

  factory VariantGroup.fromJson(Map<String, dynamic> json) {
    return VariantGroup(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      isRequired: json['isRequired'] as bool? ?? false,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      variants:
          ((json['variants'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(VariantItem.fromJson)
              .toList(),
    );
  }
}

class VariantItem {
  const VariantItem({
    required this.id,
    required this.name,
    required this.additionalPrice,
    required this.sku,
    required this.isStock,
    required this.isDefault,
    required this.qty,
    required this.isActive,
  });

  final int id;
  final String name;
  final double additionalPrice;
  final String sku;
  final bool isStock;
  final bool isDefault;
  final int qty;
  final bool isActive;

  factory VariantItem.fromJson(Map<String, dynamic> json) {
    return VariantItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      additionalPrice: (json['additionalPrice'] as num?)?.toDouble() ?? 0,
      sku: json['sku']?.toString() ?? '',
      isStock: json['isStock'] as bool? ?? false,
      isDefault: json['isDefault'] as bool? ?? false,
      qty: (json['qty'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}

class ModifierGroup {
  const ModifierGroup({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.minSelect,
    required this.maxSelect,
    required this.displayOrder,
    required this.isActive,
    required this.modifiers,
  });

  final int id;
  final String name;
  final bool isRequired;
  final int minSelect;
  final int maxSelect;
  final int displayOrder;
  final bool isActive;
  final List<ModifierItem> modifiers;

  factory ModifierGroup.fromJson(Map<String, dynamic> json) {
    return ModifierGroup(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      isRequired: json['isRequired'] as bool? ?? false,
      minSelect: (json['minSelect'] as num?)?.toInt() ?? 0,
      maxSelect: (json['maxSelect'] as num?)?.toInt() ?? 0,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      modifiers:
          ((json['modifiers'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(ModifierItem.fromJson)
              .toList(),
    );
  }
}

class ModifierItem {
  const ModifierItem({
    required this.id,
    required this.name,
    required this.additionalPrice,
    required this.isStock,
    required this.isDefault,
    required this.isActive,
  });

  final int id;
  final String name;
  final double additionalPrice;
  final bool isStock;
  final bool isDefault;
  final bool isActive;

  factory ModifierItem.fromJson(Map<String, dynamic> json) {
    return ModifierItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      additionalPrice: (json['additionalPrice'] as num?)?.toDouble() ?? 0,
      isStock: json['isStock'] as bool? ?? false,
      isDefault: json['isDefault'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}
