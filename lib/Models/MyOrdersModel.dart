// To parse this JSON data, do
//
//     final myOrdersModel = myOrdersModelFromMap(jsonString);

import 'dart:convert';

MyOrdersModel myOrdersModelFromMap(String str) =>
    MyOrdersModel.fromMap(json.decode(str));

String myOrdersModelToMap(MyOrdersModel data) => json.encode(data.toMap());

class MyOrdersModel {
  MyOrdersModel({
    this.success,
    this.orderList,
    this.message,
  });

  String success;
  List<MyOrders> orderList;
  String message;

  factory MyOrdersModel.fromMap(Map<String, dynamic> json) => MyOrdersModel(
        success: json["success"],
        orderList:
            List<MyOrders>.from(json["data"].map((x) => MyOrders.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(orderList.map((x) => x.toMap())),
        "message": message,
      };
}

class MyOrders {
  MyOrders({
    this.ordersId,
    this.totalTax,
    this.customersId,
    this.customersName,
    this.customersCompany,
    this.customersStreetAddress,
    this.customersSuburb,
    this.customersCity,
    this.customersPostcode,
    this.customersState,
    this.customersCountry,
    this.customersTelephone,
    this.email,
    this.customersAddressFormatId,
    this.deliveryName,
    this.deliveryCompany,
    this.deliveryStreetAddress,
    this.deliverySuburb,
    this.deliveryCity,
    this.deliveryPostcode,
    this.deliveryState,
    this.deliveryCountry,
    this.deliveryAddressFormatId,
    this.billingName,
    this.billingCompany,
    this.billingStreetAddress,
    this.billingSuburb,
    this.billingCity,
    this.billingPostcode,
    this.billingState,
    this.billingCountry,
    this.billingAddressFormatId,
    this.paymentMethod,
    this.ccType,
    this.ccOwner,
    this.ccNumber,
    this.ccExpires,
    this.lastModified,
    this.datePurchased,
    this.ordersDateFinished,
    this.currency,
    this.currencyValue,
    this.orderPrice,
    this.shippingCost,
    this.shippingMethod,
    this.shippingDuration,
    this.orderInformation,
    this.isSeen,
    this.couponAmount,
    this.excludeProductIds,
    this.productCategories,
    this.excludedProductCategories,
    this.freeShipping,
    this.productIds,
    this.orderedSource,
    this.deliveryPhone,
    this.billingPhone,
    this.transactionId,
    this.createdAt,
    this.updatedAt,
    this.discountType,
    this.amount,
    this.usageLimit,
    this.coupons,
    this.ordersStatusId,
    this.ordersStatus,
    this.customerComments,
    this.adminComments,
    this.itemProduct,
  });

  int ordersId;
  double totalTax;
  int customersId;
  String customersName;
  dynamic customersCompany;
  String customersStreetAddress;
  String customersSuburb;
  String customersCity;
  String customersPostcode;
  String customersState;
  String customersCountry;
  String customersTelephone;
  String email;
  dynamic customersAddressFormatId;
  String deliveryName;
  dynamic deliveryCompany;
  String deliveryStreetAddress;
  String deliverySuburb;
  String deliveryCity;
  String deliveryPostcode;
  String deliveryState;
  String deliveryCountry;
  dynamic deliveryAddressFormatId;
  String billingName;
  dynamic billingCompany;
  String billingStreetAddress;
  String billingSuburb;
  String billingCity;
  String billingPostcode;
  String billingState;
  String billingCountry;
  int billingAddressFormatId;
  String paymentMethod;
  String ccType;
  String ccOwner;
  String ccNumber;
  String ccExpires;
  DateTime lastModified;
  DateTime datePurchased;
  dynamic ordersDateFinished;
  String currency;
  String currencyValue;
  double orderPrice;
  double shippingCost;
  String shippingMethod;
  dynamic shippingDuration;
  String orderInformation;
  int isSeen;
  int couponAmount;
  List<dynamic> excludeProductIds;
  List<dynamic> productCategories;
  List<dynamic> excludedProductCategories;
  int freeShipping;
  List<dynamic> productIds;
  int orderedSource;
  String deliveryPhone;
  String billingPhone;
  dynamic transactionId;
  dynamic createdAt;
  dynamic updatedAt;
  List<dynamic> discountType;
  List<dynamic> amount;
  List<dynamic> usageLimit;
  List<dynamic> coupons;
  int ordersStatusId;
  String ordersStatus;
  String customerComments;
  String adminComments;
  List<OrderItem> itemProduct;

  factory MyOrders.fromMap(Map<String, dynamic> json) => MyOrders(
        ordersId: json["orders_id"],
        totalTax: json["total_tax"].toDouble(),
        customersId: json["customers_id"],
        customersName: json["customers_name"],
        customersCompany: json["customers_company"],
        customersStreetAddress: json["customers_street_address"],
        customersSuburb: json["customers_suburb"],
        customersCity: json["customers_city"],
        customersPostcode: json["customers_postcode"],
        customersState: json["customers_state"],
        customersCountry: json["customers_country"],
        customersTelephone: json["customers_telephone"],
        email: json["email"],
        customersAddressFormatId: json["customers_address_format_id"],
        deliveryName: json["delivery_name"],
        deliveryCompany: json["delivery_company"],
        deliveryStreetAddress: json["delivery_street_address"],
        deliverySuburb: json["delivery_suburb"],
        deliveryCity: json["delivery_city"],
        deliveryPostcode: json["delivery_postcode"],
        deliveryState: json["delivery_state"],
        deliveryCountry: json["delivery_country"],
        deliveryAddressFormatId: json["delivery_address_format_id"],
        billingName: json["billing_name"],
        billingCompany: json["billing_company"],
        billingStreetAddress: json["billing_street_address"],
        billingSuburb: json["billing_suburb"],
        billingCity: json["billing_city"],
        billingPostcode: json["billing_postcode"],
        billingState: json["billing_state"],
        billingCountry: json["billing_country"],
        billingAddressFormatId: json["billing_address_format_id"],
        paymentMethod: json["payment_method"],
        ccType: json["cc_type"],
        ccOwner: json["cc_owner"],
        ccNumber: json["cc_number"],
        ccExpires: json["cc_expires"],
        lastModified: DateTime.parse(json["last_modified"]),
        datePurchased: DateTime.parse(json["date_purchased"]),
        ordersDateFinished: json["orders_date_finished"],
        currency: json["currency"],
        currencyValue: json["currency_value"],
        orderPrice: json["order_price"].toDouble(),
        shippingCost: json["shipping_cost"].toDouble(),
        shippingMethod: json["shipping_method"],
        shippingDuration: json["shipping_duration"],
        orderInformation: json["order_information"],
        isSeen: json["is_seen"],
        couponAmount: json["coupon_amount"],
        excludeProductIds:
            List<dynamic>.from(json["exclude_product_ids"].map((x) => x)),
        productCategories:
            List<dynamic>.from(json["product_categories"].map((x) => x)),
        excludedProductCategories: List<dynamic>.from(
            json["excluded_product_categories"].map((x) => x)),
        freeShipping: json["free_shipping"],
        productIds: List<dynamic>.from(json["product_ids"].map((x) => x)),
        orderedSource: json["ordered_source"],
        deliveryPhone: json["delivery_phone"],
        billingPhone: json["billing_phone"],
        transactionId: json["transaction_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        discountType: List<dynamic>.from(json["discount_type"].map((x) => x)),
        amount: List<dynamic>.from(json["amount"].map((x) => x)),
        usageLimit: List<dynamic>.from(json["usage_limit"].map((x) => x)),
        coupons: List<dynamic>.from(json["coupons"].map((x) => x)),
        ordersStatusId: json["orders_status_id"],
        ordersStatus: json["orders_status"],
        customerComments: json["customer_comments"],
        adminComments: json["admin_comments"],
        itemProduct:
            List<OrderItem>.from(json["data"].map((x) => OrderItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "orders_id": ordersId,
        "total_tax": totalTax,
        "customers_id": customersId,
        "customers_name": customersName,
        "customers_company": customersCompany,
        "customers_street_address": customersStreetAddress,
        "customers_suburb": customersSuburb,
        "customers_city": customersCity,
        "customers_postcode": customersPostcode,
        "customers_state": customersState,
        "customers_country": customersCountry,
        "customers_telephone": customersTelephone,
        "email": email,
        "customers_address_format_id": customersAddressFormatId,
        "delivery_name": deliveryName,
        "delivery_company": deliveryCompany,
        "delivery_street_address": deliveryStreetAddress,
        "delivery_suburb": deliverySuburb,
        "delivery_city": deliveryCity,
        "delivery_postcode": deliveryPostcode,
        "delivery_state": deliveryState,
        "delivery_country": deliveryCountry,
        "delivery_address_format_id": deliveryAddressFormatId,
        "billing_name": billingName,
        "billing_company": billingCompany,
        "billing_street_address": billingStreetAddress,
        "billing_suburb": billingSuburb,
        "billing_city": billingCity,
        "billing_postcode": billingPostcode,
        "billing_state": billingState,
        "billing_country": billingCountry,
        "billing_address_format_id": billingAddressFormatId,
        "payment_method": paymentMethod,
        "cc_type": ccType,
        "cc_owner": ccOwner,
        "cc_number": ccNumber,
        "cc_expires": ccExpires,
        "last_modified": lastModified.toIso8601String(),
        "date_purchased": datePurchased.toIso8601String(),
        "orders_date_finished": ordersDateFinished,
        "currency": currency,
        "currency_value": currencyValue,
        "order_price": orderPrice,
        "shipping_cost": shippingCost,
        "shipping_method": shippingMethod,
        "shipping_duration": shippingDuration,
        "order_information": orderInformation,
        "is_seen": isSeen,
        "coupon_amount": couponAmount,
        "exclude_product_ids":
            List<dynamic>.from(excludeProductIds.map((x) => x)),
        "product_categories":
            List<dynamic>.from(productCategories.map((x) => x)),
        "excluded_product_categories":
            List<dynamic>.from(excludedProductCategories.map((x) => x)),
        "free_shipping": freeShipping,
        "product_ids": List<dynamic>.from(productIds.map((x) => x)),
        "ordered_source": orderedSource,
        "delivery_phone": deliveryPhone,
        "billing_phone": billingPhone,
        "transaction_id": transactionId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "discount_type": List<dynamic>.from(discountType.map((x) => x)),
        "amount": List<dynamic>.from(amount.map((x) => x)),
        "usage_limit": List<dynamic>.from(usageLimit.map((x) => x)),
        "coupons": List<dynamic>.from(coupons.map((x) => x)),
        "orders_status_id": ordersStatusId,
        "orders_status": ordersStatus,
        "customer_comments": customerComments,
        "admin_comments": adminComments,
        "data": List<dynamic>.from(itemProduct.map((x) => x.toMap())),
      };
}

class OrderItem {
  OrderItem({
    this.ordersProductsId,
    this.ordersId,
    this.productsId,
    this.productsModel,
    this.productsName,
    this.productsPrice,
    this.finalPrice,
    this.productsTax,
    this.productsQuantity,
    this.image,
    this.categories,
    this.attributes,
  });

  int ordersProductsId;
  int ordersId;
  int productsId;
  dynamic productsModel;
  String productsName;
  double productsPrice;
  double finalPrice;
  String productsTax;
  int productsQuantity;
  String image;
  List<dynamic> categories;
  List<Attribute> attributes;

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        ordersProductsId: json["orders_products_id"],
        ordersId: json["orders_id"],
        productsId: json["products_id"],
        productsModel: json["products_model"],
        productsName: json["products_name"],
        productsPrice: json["products_price"].toDouble(),
        finalPrice: json["final_price"].toDouble(),
        productsTax: json["products_tax"],
        productsQuantity: json["products_quantity"],
        image: json["image"],
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "orders_products_id": ordersProductsId,
        "orders_id": ordersId,
        "products_id": productsId,
        "products_model": productsModel,
        "products_name": productsName,
        "products_price": productsPrice,
        "final_price": finalPrice,
        "products_tax": productsTax,
        "products_quantity": productsQuantity,
        "image": image,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "attributes": List<dynamic>.from(attributes.map((x) => x.toMap())),
      };
}

class Attribute {
  Attribute({
    this.ordersProductsAttributesId,
    this.ordersId,
    this.ordersProductsId,
    this.productsId,
    this.productsOptions,
    this.productsOptionsValues,
    this.optionsValuesPrice,
    this.pricePrefix,
  });

  int ordersProductsAttributesId;
  int ordersId;
  int ordersProductsId;
  int productsId;
  String productsOptions;
  String productsOptionsValues;
  String optionsValuesPrice;
  String pricePrefix;

  factory Attribute.fromMap(Map<String, dynamic> json) => Attribute(
        ordersProductsAttributesId: json["orders_products_attributes_id"],
        ordersId: json["orders_id"],
        ordersProductsId: json["orders_products_id"],
        productsId: json["products_id"],
        productsOptions: json["products_options"],
        productsOptionsValues: json["products_options_values"],
        optionsValuesPrice: json["options_values_price"],
        pricePrefix: json["price_prefix"],
      );

  Map<String, dynamic> toMap() => {
        "orders_products_attributes_id": ordersProductsAttributesId,
        "orders_id": ordersId,
        "orders_products_id": ordersProductsId,
        "products_id": productsId,
        "products_options": productsOptions,
        "products_options_values": productsOptionsValues,
        "options_values_price": optionsValuesPrice,
        "price_prefix": pricePrefix,
      };
}
