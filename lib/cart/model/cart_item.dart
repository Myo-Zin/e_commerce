class CartItem {
  CartItem({
    this.key,
    this.id,
    this.quantity,
    this.name,
    this.shortDescription,
    this.description,
    this.sku,
    this.images,
    this.variation,
    this.prices,
    this.totals,
    this.isSelected = false,
  });

  CartItem.fromJson(dynamic json) {
    key = json['key'];
    id = json['id'];
    quantity = json['quantity'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    sku = json['sku'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      variation = [];
      json['variation'].forEach((v) {
        variation?.add(Variation.fromJson(v));
      });
    }
    prices = json['prices'] != null ? Prices.fromJson(json['prices']) : null;
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
    isSelected = false;
  }

  String? key;
  int? id;
  int? quantity;
  String? name;
  String? shortDescription;
  String? description;
  String? sku;
  List<Images>? images;
  List<Variation>? variation;
  Prices? prices;
  Totals? totals;
  bool? isSelected;

  CartItem copyWith({
    String? key,
    int? id,
    int? quantity,
    String? name,
    String? shortDescription,
    String? description,
    String? sku,
    List<Images>? images,
    List<Variation>? variation,
    Prices? prices,
    Totals? totals,
    bool? isSelected,
  }) =>
      CartItem(
        key: key ?? this.key,
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        name: name ?? this.name,
        shortDescription: shortDescription ?? this.shortDescription,
        description: description ?? this.description,
        sku: sku ?? this.sku,
        images: images ?? this.images,
        variation: variation ?? this.variation,
        prices: prices ?? this.prices,
        totals: totals ?? this.totals,
        isSelected: isSelected ?? this.isSelected,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['id'] = id;
    map['quantity'] = quantity;
    map['name'] = name;
    map['short_description'] = shortDescription;
    map['description'] = description;
    map['sku'] = sku;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    if (variation != null) {
      map['variation'] = variation?.map((v) => v.toJson()).toList();
    }
    if (prices != null) {
      map['prices'] = prices?.toJson();
    }
    if (totals != null) {
      map['totals'] = totals?.toJson();
    }

    return map;
  }
}

class Totals {
  Totals({
    this.lineSubtotal,
    this.lineSubtotalTax,
    this.lineTotal,
    this.lineTotalTax,
  });

  Totals.fromJson(dynamic json) {
    lineSubtotal = json['line_subtotal'];
    lineSubtotalTax = json['line_subtotal_tax'];
    lineTotal = json['line_total'];
    lineTotalTax = json['line_total_tax'];
  }

  String? lineSubtotal;
  String? lineSubtotalTax;
  String? lineTotal;
  String? lineTotalTax;

  Totals copyWith({
    String? lineSubtotal,
    String? lineSubtotalTax,
    String? lineTotal,
    String? lineTotalTax,
  }) =>
      Totals(
        lineSubtotal: lineSubtotal ?? this.lineSubtotal,
        lineSubtotalTax: lineSubtotalTax ?? this.lineSubtotalTax,
        lineTotal: lineTotal ?? this.lineTotal,
        lineTotalTax: lineTotalTax ?? this.lineTotalTax,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['line_subtotal'] = lineSubtotal;
    map['line_subtotal_tax'] = lineSubtotalTax;
    map['line_total'] = lineTotal;
    map['line_total_tax'] = lineTotalTax;
    return map;
  }
}

class Prices {
  Prices({
    this.price,
    this.regularPrice,
    this.salePrice,
    this.currencyCode,
    this.currencySymbol,
  });

  Prices.fromJson(dynamic json) {
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
  }

  String? price;
  String? regularPrice;
  String? salePrice;
  String? currencyCode;
  String? currencySymbol;

  Prices copyWith({
    String? price,
    String? regularPrice,
    String? salePrice,
    String? currencyCode,
    String? currencySymbol,
  }) =>
      Prices(
        price: price ?? this.price,
        regularPrice: regularPrice ?? this.regularPrice,
        salePrice: salePrice ?? this.salePrice,
        currencyCode: currencyCode ?? this.currencyCode,
        currencySymbol: currencySymbol ?? this.currencySymbol,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = price;
    map['regular_price'] = regularPrice;
    map['sale_price'] = salePrice;
    map['currency_code'] = currencyCode;
    map['currency_symbol'] = currencySymbol;
    return map;
  }
}

class Variation {
  Variation({
    this.attribute,
    this.value,
  });

  Variation.fromJson(dynamic json) {
    attribute = json['attribute'];
    value = json['value'];
  }

  String? attribute;
  String? value;

  Variation copyWith({
    String? attribute,
    String? value,
  }) =>
      Variation(
        attribute: attribute ?? this.attribute,
        value: value ?? this.value,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attribute'] = attribute;
    map['value'] = value;
    return map;
  }
}

class Images {
  Images({
    this.id,
    this.src,
  });

  Images.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
  }

  int? id;
  String? src;

  Images copyWith({
    int? id,
    String? src,
  }) =>
      Images(
        id: id ?? this.id,
        src: src ?? this.src,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    return map;
  }
}
