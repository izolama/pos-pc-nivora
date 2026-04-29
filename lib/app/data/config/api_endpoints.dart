class ApiEndpoints {
  const ApiEndpoints._();

  static const String login = '/pos/auth/login';

  static const String categoryList = '/pos/category/list';
  static const String categoryCreate = '/pos/category/single/add';
  static const String categoryUpdate = '/pos/category/update';

  static String categoryDetail(int categoryId) =>
      '/pos/category/detail/$categoryId';
  static String categoryDelete(int categoryId) =>
      '/pos/category/delete/$categoryId';

  static const String productList = '/pos/product/list';
  static const String productCreate = '/pos/product/add';
  static const String productUpdate = '/pos/product/update';
  static const String productRecalculatePrices =
      '/pos/product/recalculate-prices';

  static String productDetail(int productId) =>
      '/pos/product/detail/$productId';
  static String productDelete(int productId) =>
      '/pos/product/delete/$productId';

  static String addVariantGroup(int productId) =>
      '/pos/product/$productId/variant-group/add';
  static String updateVariantGroup(int productId, int variantGroupId) =>
      '/pos/product/$productId/variant-group/$variantGroupId';
  static String deleteVariantGroup(int productId, int variantGroupId) =>
      '/pos/product/$productId/variant-group/$variantGroupId';

  static String addVariant(int productId) =>
      '/pos/product/$productId/variant/add';
  static String updateVariant(int productId, int variantId) =>
      '/pos/product/$productId/variant/$variantId';
  static String setVariantActive(int productId, int variantId) =>
      '/pos/product/$productId/variant/$variantId/active';

  static String addModifierGroup(int productId) =>
      '/pos/product/$productId/modifier-group/add';
  static String updateModifierGroup(int productId, int modifierGroupId) =>
      '/pos/product/$productId/modifier-group/$modifierGroupId';
  static String deleteModifierGroup(int productId, int modifierGroupId) =>
      '/pos/product/$productId/modifier-group/$modifierGroupId';

  static String addModifier(int productId) =>
      '/pos/product/$productId/modifier/add';
  static String updateModifier(int productId, int modifierId) =>
      '/pos/product/$productId/modifier/$modifierId';
  static String setModifierActive(int productId, int modifierId) =>
      '/pos/product/$productId/modifier/$modifierId/active';

  static const String transactionList = '/pos/transaction/list';
  static const String transactionCreate = '/pos/transaction/create';
  static const String paymentMethodList = '/pos/payment-method/merchant/list';
  static const String stockUpdate = '/pos/stock/update';
  static const String stockMovementList = '/pos/stock-movement/product/list';
  static const String paymentSetting = '/pos/payment-setting';
  static const String paymentSettingCreate = '/pos/payment-setting/create';
  static const String paymentSettingUpdate = '/pos/payment-setting/update';
  static const String summaryReport = '/pos/summary-report/list';
  static const String uploadImage = '/images/upload';

  static String transactionDetail(int transactionId) =>
      '/pos/transaction/detail/$transactionId';
  static String transactionUpdate(String merchantTrxId) =>
      '/pos/transaction/update/$merchantTrxId';
  static String initiatePayment(String merchantTrxId) =>
      '/pos/transaction/initiate-payment/$merchantTrxId';
}
