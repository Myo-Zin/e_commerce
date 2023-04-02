class OrderHistoryResponse {
  OrderHistoryResponse({
    this.id,
    this.status,
    this.discountTotal,
    this.total,
    this.customerId,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.lineItems,
    this.dateCreatedGmt,
    this.dateModifiedGmt,
    this.dateCompletedGmt,
    this.currencySymbol,
  });

  OrderHistoryResponse.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    discountTotal = json['discount_total'];
    total = json['total'];
    customerId = json['customer_id'];
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    if (json['line_items'] != null) {
      lineItems = [];
      json['line_items'].forEach((v) {
        lineItems?.add(LineItems.fromJson(v));
      });
    }
    dateCreatedGmt = json['date_created_gmt'];
    dateModifiedGmt = json['date_modified_gmt'];
    dateCompletedGmt = json['date_completed_gmt'];
    currencySymbol = json['currency_symbol'];
  }

  num? id;
  String? status;
  String? discountTotal;
  String? total;
  num? customerId;
  String? paymentMethod;
  String? paymentMethodTitle;
  List<LineItems>? lineItems;
  String? dateCreatedGmt;
  String? dateModifiedGmt;
  dynamic dateCompletedGmt;
  String? currencySymbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['discount_total'] = discountTotal;
    map['total'] = total;
    map['customer_id'] = customerId;
    map['payment_method'] = paymentMethod;
    map['payment_method_title'] = paymentMethodTitle;
    if (lineItems != null) {
      map['line_items'] = lineItems?.map((v) => v.toJson()).toList();
    }
    map['date_created_gmt'] = dateCreatedGmt;
    map['date_modified_gmt'] = dateModifiedGmt;
    map['date_completed_gmt'] = dateCompletedGmt;
    map['currency_symbol'] = currencySymbol;
    return map;
  }
}

class LineItems {
  LineItems({
    this.id,
    this.name,
    this.productId,
    this.variationId,
    this.quantity,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
    this.sku,
    this.price,
  });

  LineItems.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    sku = json['sku'];
    price = json['price'];
  }

  num? id;
  String? name;
  num? productId;
  num? variationId;
  num? quantity;
  String? subtotal;
  String? subtotalTax;
  String? total;
  String? totalTax;
  String? sku;
  num? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['product_id'] = productId;
    map['variation_id'] = variationId;
    map['quantity'] = quantity;
    map['subtotal'] = subtotal;
    map['subtotal_tax'] = subtotalTax;
    map['total'] = total;
    map['total_tax'] = totalTax;
    map['sku'] = sku;
    map['price'] = price;
    return map;
  }
}
