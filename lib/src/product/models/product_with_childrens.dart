import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'product.dart';

class WooProductWithChildren {
  WooProductWithChildren({
    required this.mainProduct,
    this.relatedProducts,
    this.upsellProducts,
    this.crossSellProducts,
    this.parentProduct,
    this.groupedProducts,
  });
  factory WooProductWithChildren.fromData(
      List<Map<String, dynamic>> data, WooProduct product) {
    final List<WooProduct> relatedProducts = [];
    final List<WooProduct> upsellProducts = [];
    final List<WooProduct> crossSellProducts = [];
    WooProduct? parentProduct;
    final List<WooProduct> groupedProducts = [];
    for (final element in data) {
      final id = WooJson.readInt(element, 'id');
      if (product.relatedIds?.contains(id) ?? false) {
        relatedProducts.add(WooProduct.fromJson(element));
      }
      if (product.upsellIds?.contains(id) ?? false) {
        upsellProducts.add(WooProduct.fromJson(element));
      }
      if (product.crossSellIds?.contains(id) ?? false) {
        crossSellProducts.add(WooProduct.fromJson(element));
      }
      if (product.parentId == id) {
        parentProduct = WooProduct.fromJson(element);
      }
      if (product.groupedProducts?.contains(id) ?? false) {
        groupedProducts.add(WooProduct.fromJson(element));
      }
    }
    return WooProductWithChildren(
      mainProduct: product,
      relatedProducts: relatedProducts.isNotEmpty ? relatedProducts : null,
      upsellProducts: upsellProducts.isNotEmpty ? upsellProducts : null,
      crossSellProducts:
          crossSellProducts.isNotEmpty ? crossSellProducts : null,
      parentProduct: parentProduct,
      groupedProducts: groupedProducts.isNotEmpty ? groupedProducts : null,
    );
  }
  factory WooProductWithChildren.fake() => WooProductWithChildren(
        mainProduct: WooProduct.fake(),
        parentProduct: WooProduct.fake(),
        relatedProducts: FakeHelper.list(() => WooProduct.fake()),
        crossSellProducts: FakeHelper.list(() => WooProduct.fake()),
        groupedProducts: FakeHelper.list(() => WooProduct.fake()),
        upsellProducts: FakeHelper.list(() => WooProduct.fake()),
      );
  final WooProduct mainProduct;
  final List<WooProduct>? relatedProducts;
  final List<WooProduct>? upsellProducts;
  final List<WooProduct>? crossSellProducts;
  final WooProduct? parentProduct;
  final List<WooProduct>? groupedProducts;
  WooProductWithChildren copyWith({
    WooProduct? mainProduct,
    List<WooProduct>? relatedProducts,
    List<WooProduct>? upsellProducts,
    List<WooProduct>? crossSellProducts,
    WooProduct? parentProduct,
    List<WooProduct>? groupedProducts,
  }) =>
      WooProductWithChildren(
        mainProduct: mainProduct ?? this.mainProduct,
        relatedProducts: relatedProducts ?? this.relatedProducts,
        upsellProducts: upsellProducts ?? this.upsellProducts,
        crossSellProducts: crossSellProducts ?? this.crossSellProducts,
        parentProduct: parentProduct ?? this.parentProduct,
        groupedProducts: groupedProducts ?? this.groupedProducts,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductWithChildren &&
          other.mainProduct == mainProduct &&
          WooJson.listEquals(other.relatedProducts, relatedProducts) &&
          WooJson.listEquals(other.upsellProducts, upsellProducts) &&
          WooJson.listEquals(other.crossSellProducts, crossSellProducts) &&
          other.parentProduct == parentProduct &&
          WooJson.listEquals(other.groupedProducts, groupedProducts);
  @override
  int get hashCode => Object.hashAll([
        mainProduct,
        ...(relatedProducts ?? const []),
        ...(upsellProducts ?? const []),
        ...(crossSellProducts ?? const []),
        parentProduct,
        ...(groupedProducts ?? const []),
      ]);
  @override
  String toString() => 'WooProductWithChildren(mainProduct: $mainProduct, '
      'relatedProducts: ${relatedProducts?.length ?? 0}, '
      'upsellProducts: ${upsellProducts?.length ?? 0}, '
      'crossSellProducts: ${crossSellProducts?.length ?? 0}, '
      'parentProduct: $parentProduct, '
      'groupedProducts: ${groupedProducts?.length ?? 0})';
}
