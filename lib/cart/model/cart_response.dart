class CartResponse {
  CartResponse({
      this.billingAddress, 
      this.items, 
      this.itemsCount, 
      this.itemsWeight, 
      this.crossSells, 
      this.needsPayment, 
      this.needsShipping, 
      this.hasCalculatedShipping,
      this.totals,});

  CartResponse.fromJson(dynamic json) {
    billingAddress = json['billing_address'] != null ? BillingAddress.fromJson(json['billing_address']) : null;
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    itemsCount = json['items_count'];
    itemsWeight = json['items_weight'];

    needsPayment = json['needs_payment'];
    needsShipping = json['needs_shipping'];
    hasCalculatedShipping = json['has_calculated_shipping'];
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
  }
  BillingAddress? billingAddress;
  List<Items>? items;
  int? itemsCount;
  int? itemsWeight;
  List<dynamic>? crossSells;
  bool? needsPayment;
  bool? needsShipping;
  bool? hasCalculatedShipping;
  Totals? totals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (billingAddress != null) {
      map['billing_address'] = billingAddress?.toJson();
    }
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['items_count'] = itemsCount;
    map['items_weight'] = itemsWeight;
    if (crossSells != null) {
      map['cross_sells'] = crossSells?.map((v) => v.toJson()).toList();
    }
    map['needs_payment'] = needsPayment;
    map['needs_shipping'] = needsShipping;
    map['has_calculated_shipping'] = hasCalculatedShipping;
    if (totals != null) {
      map['totals'] = totals?.toJson();
    }
    return map;
  }

}

class Totals {
  Totals({
      this.totalItems, 
      this.totalItemsTax, 
      this.totalFees, 
      this.totalFeesTax, 
      this.totalDiscount, 
      this.totalDiscountTax, 
      this.totalShipping, 
      this.totalShippingTax, 
      this.totalPrice, 
      this.totalTax, 
      this.currencyCode, 
      this.currencySymbol, 
      this.currencyMinorUnit, 
      this.currencyDecimalSeparator, 
      this.currencyThousandSeparator, 
      this.currencyPrefix, 
      this.currencySuffix,});

  Totals.fromJson(dynamic json) {
    totalItems = json['total_items'];
    totalItemsTax = json['total_items_tax'];
    totalFees = json['total_fees'];
    totalFeesTax = json['total_fees_tax'];
    totalDiscount = json['total_discount'];
    totalDiscountTax = json['total_discount_tax'];
    totalShipping = json['total_shipping'];
    totalShippingTax = json['total_shipping_tax'];
    totalPrice = json['total_price'];
    totalTax = json['total_tax'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }
  String? totalItems;
  String? totalItemsTax;
  String? totalFees;
  String? totalFeesTax;
  String? totalDiscount;
  String? totalDiscountTax;
  String? totalShipping;
  String? totalShippingTax;
  String? totalPrice;
  String? totalTax;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_items'] = totalItems;
    map['total_items_tax'] = totalItemsTax;
    map['total_fees'] = totalFees;
    map['total_fees_tax'] = totalFeesTax;
    map['total_discount'] = totalDiscount;
    map['total_discount_tax'] = totalDiscountTax;
    map['total_shipping'] = totalShipping;
    map['total_shipping_tax'] = totalShippingTax;
    map['total_price'] = totalPrice;
    map['total_tax'] = totalTax;
    map['currency_code'] = currencyCode;
    map['currency_symbol'] = currencySymbol;
    map['currency_minor_unit'] = currencyMinorUnit;
    map['currency_decimal_separator'] = currencyDecimalSeparator;
    map['currency_thousand_separator'] = currencyThousandSeparator;
    map['currency_prefix'] = currencyPrefix;
    map['currency_suffix'] = currencySuffix;
    return map;
  }

}

class Items {
  Items({
      this.key, 
      this.id, 
      this.quantity, 
      this.quantityLimits, 
      this.name, 
      this.shortDescription, 
      this.description, 
      this.backordersAllowed, 
      this.showBackorderBadge, 
      this.soldIndividually, 
      this.permalink, 
      this.images, 
      this.prices, 
      this.totals, 
      this.catalogVisibility, 
      this.extensions,});

  Items.fromJson(dynamic json) {
    key = json['key'];
    id = json['id'];
    quantity = json['quantity'];
    quantityLimits = json['quantity_limits'] != null ? QuantityLimits.fromJson(json['quantity_limits']) : null;
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    backordersAllowed = json['backorders_allowed'];
    showBackorderBadge = json['show_backorder_badge'];
    soldIndividually = json['sold_individually'];
    permalink = json['permalink'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    prices = json['prices'] != null ? Prices.fromJson(json['prices']) : null;
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
    catalogVisibility = json['catalog_visibility'];
    extensions = json['extensions'];
  }
  String? key;
  int? id;
  int? quantity;
  QuantityLimits? quantityLimits;
  String? name;
  String? shortDescription;
  String? description;
  bool? backordersAllowed;
  bool? showBackorderBadge;
  bool? soldIndividually;
  String? permalink;
  List<Images>? images;
  Prices? prices;
  Totals? totals;
  String? catalogVisibility;
  dynamic extensions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['id'] = id;
    map['quantity'] = quantity;
    if (quantityLimits != null) {
      map['quantity_limits'] = quantityLimits?.toJson();
    }
    map['name'] = name;
    map['short_description'] = shortDescription;
    map['description'] = description;
    map['backorders_allowed'] = backordersAllowed;
    map['show_backorder_badge'] = showBackorderBadge;
    map['sold_individually'] = soldIndividually;
    map['permalink'] = permalink;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    if (prices != null) {
      map['prices'] = prices?.toJson();
    }
    if (totals != null) {
      map['totals'] = totals?.toJson();
    }
    map['catalog_visibility'] = catalogVisibility;
    map['extensions'] = extensions;
    return map;
  }

}


class Prices {
  Prices({
      this.price, 
      this.regularPrice, 
      this.salePrice, 
      this.priceRange, 
      this.currencyCode, 
      this.currencySymbol, 
      this.currencyMinorUnit, 
      this.currencyDecimalSeparator, 
      this.currencyThousandSeparator, 
      this.currencySuffix, 
      this.rawPrices,});

  Prices.fromJson(dynamic json) {
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    priceRange = json['price_range'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencySuffix = json['currency_suffix'];
    rawPrices = json['raw_prices'] != null ? RawPrices.fromJson(json['raw_prices']) : null;
  }
  String? price;
  String? regularPrice;
  String? salePrice;
  dynamic priceRange;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencySuffix;
  RawPrices? rawPrices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = price;
    map['regular_price'] = regularPrice;
    map['sale_price'] = salePrice;
    map['price_range'] = priceRange;
    map['currency_code'] = currencyCode;
    map['currency_symbol'] = currencySymbol;
    map['currency_minor_unit'] = currencyMinorUnit;
    map['currency_decimal_separator'] = currencyDecimalSeparator;
    map['currency_thousand_separator'] = currencyThousandSeparator;
    map['currency_suffix'] = currencySuffix;
    if (rawPrices != null) {
      map['raw_prices'] = rawPrices?.toJson();
    }
    return map;
  }

}

class RawPrices {
  RawPrices({
      this.precision, 
      this.price, 
      this.regularPrice, 
      this.salePrice,});

  RawPrices.fromJson(dynamic json) {
    precision = json['precision'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
  }
  int? precision;
  String? price;
  String? regularPrice;
  String? salePrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['precision'] = precision;
    map['price'] = price;
    map['regular_price'] = regularPrice;
    map['sale_price'] = salePrice;
    return map;
  }

}

class Images {
  Images({
      this.id, 
      this.src, 
      this.thumbnail, 
      this.srcset, 
      this.sizes, 
      this.name,});

  Images.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    thumbnail = json['thumbnail'];
    srcset = json['srcset'];
    sizes = json['sizes'];
    name = json['name'];
  }
  int? id;
  String? src;
  String? thumbnail;
  String? srcset;
  String? sizes;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['thumbnail'] = thumbnail;
    map['srcset'] = srcset;
    map['sizes'] = sizes;
    map['name'] = name;
    return map;
  }

}

class QuantityLimits {
  QuantityLimits({
      this.minimum, 
      this.maximum, 
      this.multipleOf, 
      this.editable,});

  QuantityLimits.fromJson(dynamic json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
    multipleOf = json['multiple_of'];
    editable = json['editable'];
  }
  int? minimum;
  int? maximum;
  int? multipleOf;
  bool? editable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['minimum'] = minimum;
    map['maximum'] = maximum;
    map['multiple_of'] = multipleOf;
    map['editable'] = editable;
    return map;
  }

}

class BillingAddress {
  BillingAddress({
      this.firstName, 
      this.lastName, 
      this.company, 
      this.address1, 
      this.address2, 
      this.city, 
      this.state, 
      this.postcode, 
      this.country, 
      this.email, 
      this.phone,});

  BillingAddress.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    email = json['email'];
    phone = json['phone'];
  }
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['company'] = company;
    map['address_1'] = address1;
    map['address_2'] = address2;
    map['city'] = city;
    map['state'] = state;
    map['postcode'] = postcode;
    map['country'] = country;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }

}