import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'store_address.dart';
import 'store_money.dart';

class WooStoreImage {
  const WooStoreImage({
    this.id = 0,
    this.src = '',
    this.thumbnail = '',
    this.srcset = '',
    this.sizes = '',
    this.name = '',
    this.alt = '',
  });

  factory WooStoreImage.fromJson(Map<String, dynamic> json) => WooStoreImage(
        id: WooJson.readInt(json, 'id') ?? 0,
        src: WooJson.readString(json, 'src') ?? '',
        thumbnail: WooJson.readString(json, 'thumbnail') ?? '',
        srcset: WooJson.readString(json, 'srcset') ?? '',
        sizes: WooJson.readString(json, 'sizes') ?? '',
        name: WooJson.readString(json, 'name') ?? '',
        alt: WooJson.readString(json, 'alt') ?? '',
      );

  factory WooStoreImage.fake() => WooStoreImage(
        id: FakeHelper.integer(),
        src: FakeHelper.image(),
        thumbnail: FakeHelper.image(),
        srcset: FakeHelper.image(),
        sizes: '450px',
        name: FakeHelper.word(),
        alt: FakeHelper.word(),
      );

  final int id;

  final String src;

  final String thumbnail;

  final String srcset;

  final String sizes;

  final String name;

  final String alt;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'src': src,
        'thumbnail': thumbnail,
        'srcset': srcset,
        'sizes': sizes,
        'name': name,
        'alt': alt,
      };

  WooStoreImage copyWith({
    int? id,
    String? src,
    String? thumbnail,
    String? srcset,
    String? sizes,
    String? name,
    String? alt,
  }) =>
      WooStoreImage(
        id: id ?? this.id,
        src: src ?? this.src,
        thumbnail: thumbnail ?? this.thumbnail,
        srcset: srcset ?? this.srcset,
        sizes: sizes ?? this.sizes,
        name: name ?? this.name,
        alt: alt ?? this.alt,
      );
}

class WooStoreQuantityLimits {
  const WooStoreQuantityLimits({
    this.minimum = 1,
    this.maximum = 9999,
    this.multipleOf = 1,
    this.editable = true,
  });

  factory WooStoreQuantityLimits.fromJson(Map<String, dynamic> json) =>
      WooStoreQuantityLimits(
        minimum: WooJson.readInt(json, 'minimum') ?? 1,
        maximum: WooJson.readInt(json, 'maximum') ?? 9999,
        multipleOf: WooJson.readInt(json, 'multiple_of') ?? 1,
        editable: WooJson.readBool(json, 'editable') ?? true,
      );

  factory WooStoreQuantityLimits.fake() => WooStoreQuantityLimits(
        maximum: FakeHelper.integer(min: 10, max: 100),
      );

  final int minimum;

  final int maximum;

  final int multipleOf;

  final bool editable;

  int clamp(int wanted) {
    final stepped =
        multipleOf <= 1 ? wanted : (wanted / multipleOf).round() * multipleOf;
    return stepped.clamp(minimum, maximum);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'minimum': minimum,
        'maximum': maximum,
        'multiple_of': multipleOf,
        'editable': editable,
      };

  WooStoreQuantityLimits copyWith({
    int? minimum,
    int? maximum,
    int? multipleOf,
    bool? editable,
  }) =>
      WooStoreQuantityLimits(
        minimum: minimum ?? this.minimum,
        maximum: maximum ?? this.maximum,
        multipleOf: multipleOf ?? this.multipleOf,
        editable: editable ?? this.editable,
      );
}

class WooStoreCartItem {
  const WooStoreCartItem({
    required this.key,
    required this.id,
    required this.quantity,
    required this.name,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.lineSubtotal,
    required this.lineTotal,
    this.sku = '',
    this.permalink = '',
    this.shortDescription = '',
    this.images = const <WooStoreImage>[],
    this.limits = const WooStoreQuantityLimits(),
    this.variation = const <String, String>{},
    this.lowStockRemaining,
    this.backordersAllowed = false,
    this.soldIndividually = false,
  });

  factory WooStoreCartItem.fromJson(Map<String, dynamic> json) {
    final prices = WooJson.readMap(json, 'prices') ?? <String, dynamic>{};
    final totals = WooJson.readMap(json, 'totals') ?? <String, dynamic>{};
    final currency = WooStoreCurrency.fromJson(prices);
    return WooStoreCartItem(
      key: WooJson.readString(json, 'key') ?? '',
      id: WooJson.readInt(json, 'id') ?? 0,
      quantity: WooJson.readInt(json, 'quantity') ?? 0,
      name: WooJson.readString(json, 'name') ?? '',
      sku: WooJson.readString(json, 'sku') ?? '',
      permalink: WooJson.readString(json, 'permalink') ?? '',
      shortDescription: WooJson.readString(json, 'short_description') ?? '',
      price: WooStoreMoney.read(prices, 'price', currency),
      regularPrice: WooStoreMoney.read(prices, 'regular_price', currency),
      salePrice: WooStoreMoney.read(prices, 'sale_price', currency),
      lineSubtotal: WooStoreMoney.read(totals, 'line_subtotal'),
      lineTotal: WooStoreMoney.read(totals, 'line_total'),
      images: WooJson.readListOrEmpty(json, 'images', WooStoreImage.fromJson),
      limits: WooStoreQuantityLimits.fromJson(
        WooJson.readMap(json, 'quantity_limits') ?? <String, dynamic>{},
      ),
      variation: <String, String>{
        for (final value in (json['variation'] as List?) ?? const [])
          if (value is Map)
            '${value['attribute'] ?? ''}': '${value['value'] ?? ''}',
      },
      lowStockRemaining: WooJson.readInt(json, 'low_stock_remaining'),
      backordersAllowed: WooJson.readBool(json, 'backorders_allowed') ?? false,
      soldIndividually: WooJson.readBool(json, 'sold_individually') ?? false,
    );
  }

  factory WooStoreCartItem.fake() => WooStoreCartItem(
        key: FakeHelper.word(),
        id: FakeHelper.integer(),
        quantity: FakeHelper.integer(min: 1, max: 5),
        name: FakeHelper.word(),
        sku: FakeHelper.word(),
        permalink: FakeHelper.url(),
        shortDescription: FakeHelper.sentence(),
        price: WooStoreMoney.fake(),
        regularPrice: WooStoreMoney.fake(),
        salePrice: WooStoreMoney.fake(),
        lineSubtotal: WooStoreMoney.fake(),
        lineTotal: WooStoreMoney.fake(),
        images: FakeHelper.list(() => WooStoreImage.fake()),
      );

  final String key;

  final int id;

  final int quantity;

  final String name;

  final String sku;

  final String permalink;

  final String shortDescription;

  final WooStoreMoney price;

  final WooStoreMoney regularPrice;

  final WooStoreMoney salePrice;

  final WooStoreMoney lineSubtotal;

  final WooStoreMoney lineTotal;

  final List<WooStoreImage> images;

  final WooStoreQuantityLimits limits;

  final Map<String, String> variation;

  final int? lowStockRemaining;

  final bool backordersAllowed;

  final bool soldIndividually;

  bool get onSale => salePrice < regularPrice;

  WooStoreImage? get image => images.isEmpty ? null : images.first;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'key': key,
        'id': id,
        'quantity': quantity,
        'name': name,
        'sku': sku,
        'permalink': permalink,
        'short_description': shortDescription,
        'prices': price.currency.toJson()
          ..addAll(<String, dynamic>{
            'price': '${price.minorUnits}',
            'regular_price': '${regularPrice.minorUnits}',
            'sale_price': '${salePrice.minorUnits}',
          }),
        'totals': <String, dynamic>{
          'line_subtotal': '${lineSubtotal.minorUnits}',
          'line_total': '${lineTotal.minorUnits}',
        },
        'images': images.map((image) => image.toJson()).toList(),
        'quantity_limits': limits.toJson(),
        'variation': <Object?>[
          for (final entry in variation.entries)
            <String, dynamic>{'attribute': entry.key, 'value': entry.value},
        ],
        'low_stock_remaining': lowStockRemaining,
        'backorders_allowed': backordersAllowed,
        'sold_individually': soldIndividually,
      };

  WooStoreCartItem copyWith({
    String? key,
    int? id,
    int? quantity,
    String? name,
    String? sku,
    String? permalink,
    String? shortDescription,
    WooStoreMoney? price,
    WooStoreMoney? regularPrice,
    WooStoreMoney? salePrice,
    WooStoreMoney? lineSubtotal,
    WooStoreMoney? lineTotal,
    List<WooStoreImage>? images,
    WooStoreQuantityLimits? limits,
    Map<String, String>? variation,
    int? lowStockRemaining,
    bool? backordersAllowed,
    bool? soldIndividually,
  }) =>
      WooStoreCartItem(
        key: key ?? this.key,
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        name: name ?? this.name,
        sku: sku ?? this.sku,
        permalink: permalink ?? this.permalink,
        shortDescription: shortDescription ?? this.shortDescription,
        price: price ?? this.price,
        regularPrice: regularPrice ?? this.regularPrice,
        salePrice: salePrice ?? this.salePrice,
        lineSubtotal: lineSubtotal ?? this.lineSubtotal,
        lineTotal: lineTotal ?? this.lineTotal,
        images: images ?? this.images,
        limits: limits ?? this.limits,
        variation: variation ?? this.variation,
        lowStockRemaining: lowStockRemaining ?? this.lowStockRemaining,
        backordersAllowed: backordersAllowed ?? this.backordersAllowed,
        soldIndividually: soldIndividually ?? this.soldIndividually,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooStoreCartItem &&
          other.key == key &&
          other.id == id &&
          other.quantity == quantity &&
          other.name == name &&
          other.sku == sku &&
          other.permalink == permalink &&
          other.shortDescription == shortDescription &&
          other.price == price &&
          other.regularPrice == regularPrice &&
          other.salePrice == salePrice &&
          other.lineSubtotal == lineSubtotal &&
          other.lineTotal == lineTotal &&
          WooJson.listEquals(other.images, images) &&
          other.limits == limits &&
          WooJson.mapEquals(other.variation, variation) &&
          other.lowStockRemaining == lowStockRemaining &&
          other.backordersAllowed == backordersAllowed &&
          other.soldIndividually == soldIndividually;

  @override
  int get hashCode => Object.hashAll([
        key,
        id,
        quantity,
        name,
        sku,
        permalink,
        shortDescription,
        price,
        regularPrice,
        salePrice,
        lineSubtotal,
        lineTotal,
        ...images,
        limits,
        ...variation.entries,
        lowStockRemaining,
        backordersAllowed,
        soldIndividually,
      ]);

  @override
  String toString() =>
      'WooStoreCartItem(key: $key, id: $id, quantity: $quantity, price: $price)';
}

class WooStoreCartCoupon {
  const WooStoreCartCoupon({
    required this.code,
    required this.discountType,
    required this.totalDiscount,
    required this.totalDiscountTax,
  });

  factory WooStoreCartCoupon.fromJson(Map<String, dynamic> json) {
    final totals = WooJson.readMap(json, 'totals') ?? <String, dynamic>{};
    return WooStoreCartCoupon(
      code: WooJson.readString(json, 'code') ?? '',
      discountType: WooJson.readString(json, 'discount_type') ?? '',
      totalDiscount: WooStoreMoney.read(totals, 'total_discount'),
      totalDiscountTax: WooStoreMoney.read(totals, 'total_discount_tax'),
    );
  }

  factory WooStoreCartCoupon.fake() => WooStoreCartCoupon(
        code: FakeHelper.code(),
        discountType: 'percent',
        totalDiscount: WooStoreMoney.fake(),
        totalDiscountTax: WooStoreMoney.fake(),
      );

  final String code;

  final String discountType;

  final WooStoreMoney totalDiscount;

  final WooStoreMoney totalDiscountTax;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'discount_type': discountType,
        'totals': <String, dynamic>{
          'total_discount': '${totalDiscount.minorUnits}',
          'total_discount_tax': '${totalDiscountTax.minorUnits}',
        },
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooStoreCartCoupon &&
          other.code == code &&
          other.discountType == discountType &&
          other.totalDiscount == totalDiscount &&
          other.totalDiscountTax == totalDiscountTax;

  @override
  int get hashCode =>
      Object.hash(code, discountType, totalDiscount, totalDiscountTax);

  @override
  String toString() => 'WooStoreCartCoupon($code)';
}

class WooStoreShippingRate {
  const WooStoreShippingRate({
    required this.rateId,
    required this.name,
    required this.price,
    required this.taxes,
    required this.selected,
    this.description = '',
    this.deliveryTime = '',
    this.methodId = '',
    this.instanceId = 0,
  });

  factory WooStoreShippingRate.fromJson(Map<String, dynamic> json) =>
      WooStoreShippingRate(
        rateId: WooJson.readString(json, 'rate_id') ?? '',
        name: WooJson.readString(json, 'name') ?? '',
        description: WooJson.readString(json, 'description') ?? '',
        deliveryTime: WooJson.readString(json, 'delivery_time') ?? '',
        price: WooStoreMoney.read(json, 'price'),
        taxes: WooStoreMoney.read(json, 'taxes'),
        methodId: WooJson.readString(json, 'method_id') ?? '',
        instanceId: WooJson.readInt(json, 'instance_id') ?? 0,
        selected: WooJson.readBool(json, 'selected') ?? false,
      );

  factory WooStoreShippingRate.fake() => WooStoreShippingRate(
        rateId: 'flat_rate:${FakeHelper.integer()}',
        name: FakeHelper.word(),
        description: FakeHelper.sentence(),
        deliveryTime: '3-5 days',
        price: WooStoreMoney.fake(),
        taxes: WooStoreMoney.fake(),
        methodId: 'flat_rate',
        instanceId: FakeHelper.integer(),
        selected: false,
      );

  final String rateId;

  final String name;

  final String description;

  final String deliveryTime;

  final WooStoreMoney price;

  final WooStoreMoney taxes;

  final String methodId;

  final int instanceId;

  final bool selected;

  bool get isFree => price.isZero;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rate_id': rateId,
        'name': name,
        'description': description,
        'delivery_time': deliveryTime,
        'price': '${price.minorUnits}',
        'taxes': '${taxes.minorUnits}',
        'method_id': methodId,
        'instance_id': instanceId,
        'selected': selected,
      };

  WooStoreShippingRate copyWith({
    String? rateId,
    String? name,
    String? description,
    String? deliveryTime,
    WooStoreMoney? price,
    WooStoreMoney? taxes,
    String? methodId,
    int? instanceId,
    bool? selected,
  }) =>
      WooStoreShippingRate(
        rateId: rateId ?? this.rateId,
        name: name ?? this.name,
        description: description ?? this.description,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        price: price ?? this.price,
        taxes: taxes ?? this.taxes,
        methodId: methodId ?? this.methodId,
        instanceId: instanceId ?? this.instanceId,
        selected: selected ?? this.selected,
      );
}

class WooStoreShippingPackage {
  const WooStoreShippingPackage({
    required this.packageId,
    required this.name,
    required this.rates,
    this.destination,
    this.itemNames = const <String>[],
  });

  factory WooStoreShippingPackage.fromJson(Map<String, dynamic> json) {
    final destination = WooJson.readMap(json, 'destination');
    return WooStoreShippingPackage(
      packageId: WooJson.readInt(json, 'package_id') ?? 0,
      name: WooJson.readString(json, 'name') ?? '',
      destination:
          destination == null ? null : WooStoreAddress.fromJson(destination),
      itemNames: <String>[
        for (final item in WooJson.readListOrEmpty(
          json,
          'items',
          (value) => value,
        ))
          WooJson.readString(item, 'name') ?? '',
      ],
      rates: WooJson.readListOrEmpty(
        json,
        'shipping_rates',
        WooStoreShippingRate.fromJson,
      ),
    );
  }

  factory WooStoreShippingPackage.fake() => WooStoreShippingPackage(
        packageId: FakeHelper.integer(),
        name: 'Shipment 1',
        destination: WooStoreAddress.fake(),
        itemNames: FakeHelper.list(() => FakeHelper.word()),
        rates: FakeHelper.list(() => WooStoreShippingRate.fake()),
      );

  final int packageId;

  final String name;

  final WooStoreAddress? destination;

  final List<String> itemNames;

  final List<WooStoreShippingRate> rates;

  WooStoreShippingRate? get selected {
    for (final rate in rates) {
      if (rate.selected) return rate;
    }
    return null;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'package_id': packageId,
        'name': name,
        'destination': destination?.toJson(),
        'items': <Object?>[
          for (final itemName in itemNames) <String, dynamic>{'name': itemName},
        ],
        'shipping_rates': rates.map((rate) => rate.toJson()).toList(),
      };
}

class WooStoreCartTotals {
  const WooStoreCartTotals({
    required this.currency,
    required this.totalItems,
    required this.totalItemsTax,
    required this.totalFees,
    required this.totalDiscount,
    required this.totalShipping,
    required this.totalShippingTax,
    required this.totalTax,
    required this.totalPrice,
  });

  factory WooStoreCartTotals.fromJson(Map<String, dynamic> json) {
    final currency = WooStoreCurrency.fromJson(json);
    return WooStoreCartTotals(
      currency: currency,
      totalItems: WooStoreMoney.read(json, 'total_items', currency),
      totalItemsTax: WooStoreMoney.read(json, 'total_items_tax', currency),
      totalFees: WooStoreMoney.read(json, 'total_fees', currency),
      totalDiscount: WooStoreMoney.read(json, 'total_discount', currency),
      totalShipping: WooStoreMoney.read(json, 'total_shipping', currency),
      totalShippingTax:
          WooStoreMoney.read(json, 'total_shipping_tax', currency),
      totalTax: WooStoreMoney.read(json, 'total_tax', currency),
      totalPrice: WooStoreMoney.read(json, 'total_price', currency),
    );
  }

  factory WooStoreCartTotals.fake() {
    final currency = WooStoreCurrency.fake();
    return WooStoreCartTotals(
      currency: currency,
      totalItems: WooStoreMoney.fake(),
      totalItemsTax: WooStoreMoney.fake(),
      totalFees: WooStoreMoney.fake(),
      totalDiscount: WooStoreMoney.fake(),
      totalShipping: WooStoreMoney.fake(),
      totalShippingTax: WooStoreMoney.fake(),
      totalTax: WooStoreMoney.fake(),
      totalPrice: WooStoreMoney.fake(),
    );
  }

  final WooStoreCurrency currency;

  final WooStoreMoney totalItems;

  final WooStoreMoney totalItemsTax;

  final WooStoreMoney totalFees;

  final WooStoreMoney totalDiscount;

  final WooStoreMoney totalShipping;

  final WooStoreMoney totalShippingTax;

  final WooStoreMoney totalTax;

  final WooStoreMoney totalPrice;

  Map<String, dynamic> toJson() => <String, dynamic>{
        ...currency.toJson(),
        'total_items': '${totalItems.minorUnits}',
        'total_items_tax': '${totalItemsTax.minorUnits}',
        'total_fees': '${totalFees.minorUnits}',
        'total_discount': '${totalDiscount.minorUnits}',
        'total_shipping': '${totalShipping.minorUnits}',
        'total_shipping_tax': '${totalShippingTax.minorUnits}',
        'total_tax': '${totalTax.minorUnits}',
        'total_price': '${totalPrice.minorUnits}',
      };
}

class WooStoreCartError {
  const WooStoreCartError({required this.code, required this.message});

  factory WooStoreCartError.fromJson(Map<String, dynamic> json) =>
      WooStoreCartError(
        code: WooJson.readString(json, 'code') ?? '',
        message: WooJson.readString(json, 'message') ?? '',
      );

  factory WooStoreCartError.fake() => WooStoreCartError(
        code: 'woocommerce_rest_product_out_of_stock',
        message: FakeHelper.sentence(),
      );

  final String code;

  final String message;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'message': message,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooStoreCartError &&
          other.code == code &&
          other.message == message;

  @override
  int get hashCode => Object.hash(code, message);

  @override
  String toString() => '$code: $message';
}

class WooStoreCart {
  const WooStoreCart({
    required this.items,
    required this.coupons,
    required this.totals,
    required this.billingAddress,
    required this.shippingAddress,
    required this.shippingPackages,
    required this.itemsCount,
    required this.itemsWeight,
    required this.needsPayment,
    required this.needsShipping,
    required this.hasCalculatedShipping,
    required this.errors,
    this.paymentMethods = const <String>[],
  });

  factory WooStoreCart.fromJson(Map<String, dynamic> json) => WooStoreCart(
        items: WooJson.readListOrEmpty(
          json,
          'items',
          WooStoreCartItem.fromJson,
        ),
        coupons: WooJson.readListOrEmpty(
          json,
          'coupons',
          WooStoreCartCoupon.fromJson,
        ),
        totals: WooStoreCartTotals.fromJson(
          WooJson.readMap(json, 'totals') ?? <String, dynamic>{},
        ),
        billingAddress: WooStoreAddress.fromJson(
          WooJson.readMap(json, 'billing_address') ?? <String, dynamic>{},
        ),
        shippingAddress: WooStoreAddress.fromJson(
          WooJson.readMap(json, 'shipping_address') ?? <String, dynamic>{},
        ),
        shippingPackages: WooJson.readListOrEmpty(
          json,
          'shipping_rates',
          WooStoreShippingPackage.fromJson,
        ),
        itemsCount: WooJson.readInt(json, 'items_count') ?? 0,
        itemsWeight: WooJson.readDouble(json, 'items_weight') ?? 0,
        needsPayment: WooJson.readBool(json, 'needs_payment') ?? false,
        needsShipping: WooJson.readBool(json, 'needs_shipping') ?? false,
        hasCalculatedShipping:
            WooJson.readBool(json, 'has_calculated_shipping') ?? false,
        paymentMethods: <String>[
          for (final method in (json['payment_methods'] as List?) ?? const [])
            '$method',
        ],
        errors: WooJson.readListOrEmpty(
          json,
          'errors',
          WooStoreCartError.fromJson,
        ),
      );

  factory WooStoreCart.fake() => WooStoreCart(
        items: FakeHelper.list(() => WooStoreCartItem.fake()),
        coupons: FakeHelper.list(() => WooStoreCartCoupon.fake()),
        totals: WooStoreCartTotals.fake(),
        billingAddress: WooStoreAddress.fake(),
        shippingAddress: WooStoreAddress.fake(),
        shippingPackages: FakeHelper.list(() => WooStoreShippingPackage.fake()),
        itemsCount: FakeHelper.integer(),
        itemsWeight: FakeHelper.decimal(),
        needsPayment: FakeHelper.boolean(),
        needsShipping: FakeHelper.boolean(),
        hasCalculatedShipping: FakeHelper.boolean(),
        paymentMethods: <String>['cod', 'bacs'],
        errors: FakeHelper.list(() => WooStoreCartError.fake()),
      );

  final List<WooStoreCartItem> items;

  final List<WooStoreCartCoupon> coupons;

  final WooStoreCartTotals totals;

  final WooStoreAddress billingAddress;

  final WooStoreAddress shippingAddress;

  final List<WooStoreShippingPackage> shippingPackages;

  final int itemsCount;

  final double itemsWeight;

  final bool needsPayment;

  final bool needsShipping;

  final bool hasCalculatedShipping;

  final List<String> paymentMethods;

  final List<WooStoreCartError> errors;

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  bool get hasErrors => errors.isNotEmpty;

  WooStoreCartItem? itemFor(int productId) {
    for (final item in items) {
      if (item.id == productId) return item;
    }
    return null;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'items': items.map((item) => item.toJson()).toList(),
        'coupons': coupons.map((coupon) => coupon.toJson()).toList(),
        'totals': totals.toJson(),
        'billing_address': billingAddress.toJson(),
        'shipping_address': shippingAddress.toJson(),
        'shipping_rates':
            shippingPackages.map((package) => package.toJson()).toList(),
        'items_count': itemsCount,
        'items_weight': itemsWeight,
        'needs_payment': needsPayment,
        'needs_shipping': needsShipping,
        'has_calculated_shipping': hasCalculatedShipping,
        'payment_methods': paymentMethods,
        'errors': errors.map((error) => error.toJson()).toList(),
      };

  @override
  String toString() => 'WooStoreCart($itemsCount items, ${totals.totalPrice})';
}
