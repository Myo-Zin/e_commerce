import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';

part 'order.g.dart';

@Freezed()
class Order with _$Order {
  const factory Order({
    String? paymentMethod,
    String? paymentMethodTitle,
    String? customerNote,
    bool? setPaid,
    Billing? billing,
    Shipping? shipping,
    List<LineItems>? lineItems,
  }) = _Order;

  factory Order.fromJson(Map<String, Object?> json) => _$OrderFromJson(json);
// Order.fromJson(Map<String, dynamic> json) {
//   id = json['id'];
//   billing =
//       json['billing'] != null ? Billing.fromJson(json['billing']) : null;
//   shipping =
//       json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
//   paymentMethod = json['payment_method'];
//   paymentMethodTitle = json['payment_method_title'];
//
//   if (json['line_items'] != null) {
//     lineItems = <LineItems>[];
//     json['line_items'].forEach((v) {
//       lineItems!.add(LineItems.fromJson(v));
//     });
//   }
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   if (this.billing != null) {
//     data['billing'] = this.billing!.toJson();
//   }
//   if (this.shipping != null) {
//     data['shipping'] = this.shipping!.toJson();
//   }
//   data['payment_method'] = this.paymentMethod;
//   data['payment_method_title'] = this.paymentMethodTitle;
//   if (this.lineItems != null) {
//     data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
//   }
//
//   return data;
// }
}

@Freezed()
class Billing with _$Billing {
  const factory Billing({
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? email,
    String? phone,
  }) = _Billing;

  factory Billing.fromJson(Map<String, Object?> json) =>
      _$BillingFromJson(json);

// Billing.fromJson(Map<String, dynamic> json) {
//   firstName = json['first_name'];
//   lastName = json['last_name'];
//   company = json['company'];
//   address1 = json['address_1'];
//   address2 = json['address_2'];
//   city = json['city'];
//   state = json['state'];
//   postcode = json['postcode'];
//   country = json['country'];
//   email = json['email'];
//   phone = json['phone'];
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['first_name'] = this.firstName;
//   data['last_name'] = this.lastName;
//   data['company'] = this.company;
//   data['address_1'] = this.address1;
//   data['address_2'] = this.address2;
//   data['city'] = this.city;
//   data['state'] = this.state;
//   data['postcode'] = this.postcode;
//   data['country'] = this.country;
//   data['email'] = this.email;
//   data['phone'] = this.phone;
//   return data;
// }
}

@Freezed()
class Shipping with _$Shipping {
  const factory Shipping({
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? phone,
  }) = _Shipping;

  factory Shipping.fromJson(Map<String, Object?> json) =>
      _$ShippingFromJson(json);

// Shipping.fromJson(Map<String, dynamic> json) {
//   firstName = json['first_name'];
//   lastName = json['last_name'];
//   company = json['company'];
//   address1 = json['address_1'];
//   address2 = json['address_2'];
//   city = json['city'];
//   state = json['state'];
//   postcode = json['postcode'];
//   country = json['country'];
//   phone = json['phone'];
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['first_name'] = this.firstName;
//   data['last_name'] = this.lastName;
//   data['company'] = this.company;
//   data['address_1'] = this.address1;
//   data['address_2'] = this.address2;
//   data['city'] = this.city;
//   data['state'] = this.state;
//   data['postcode'] = this.postcode;
//   data['country'] = this.country;
//   data['phone'] = this.phone;
//   return data;
// }
}

@Freezed()
class LineItems with _$LineItems {
  const factory LineItems({
    int? productId,
    int? quantity,
  }) = _LineItems;

  factory LineItems.fromJson(Map<String, Object?> json) =>
      _$LineItemsFromJson(json);

}
