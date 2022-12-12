/// id : 59
/// quantity : 2
/// price : 20
/// discount : null
/// VAT : null
/// order_date_and_time : "2022-06-15T08:50:03.000000Z"
/// user : {"id":113,"name":"Abir"}
/// payment : {"payment_status":0}
/// order_status : {"order_status_category":{"id":1,"name":"Ongoing"}}

class OrderModel {
  OrderModel({
      num? id, 
      num? quantity, 
      num? price, 
      dynamic discount, 
      dynamic vat, 
      String? orderDateAndTime, 
      User? user, 
      Payment? payment, 
      OrderStatus? orderStatus,}){
    _id = id;
    _quantity = quantity;
    _price = price;
    _discount = discount;
    _vat = vat;
    _orderDateAndTime = orderDateAndTime;
    _user = user;
    _payment = payment;
    _orderStatus = orderStatus;
}

  OrderModel.fromJson(dynamic json) {
    _id = json['id'];
    _quantity = json['quantity'];
    _price = json['price'];
    _discount = json['discount'];
    _vat = json['VAT'];
    _orderDateAndTime = json['order_date_and_time'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _payment = json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    _orderStatus = json['order_status'] != null ? OrderStatus.fromJson(json['order_status']) : null;
  }
  num? _id;
  num? _quantity;
  num? _price;
  dynamic _discount;
  dynamic _vat;
  String? _orderDateAndTime;
  User? _user;
  Payment? _payment;
  OrderStatus? _orderStatus;
OrderModel copyWith({  num? id,
  num? quantity,
  num? price,
  dynamic discount,
  dynamic vat,
  String? orderDateAndTime,
  User? user,
  Payment? payment,
  OrderStatus? orderStatus,
}) => OrderModel(  id: id ?? _id,
  quantity: quantity ?? _quantity,
  price: price ?? _price,
  discount: discount ?? _discount,
  vat: vat ?? _vat,
  orderDateAndTime: orderDateAndTime ?? _orderDateAndTime,
  user: user ?? _user,
  payment: payment ?? _payment,
  orderStatus: orderStatus ?? _orderStatus,
);
  num? get id => _id;
  num? get quantity => _quantity;
  num? get price => _price;
  dynamic get discount => _discount;
  dynamic get vat => _vat;
  String? get orderDateAndTime => _orderDateAndTime;
  User? get user => _user;
  Payment? get payment => _payment;
  OrderStatus? get orderStatus => _orderStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['discount'] = _discount;
    map['VAT'] = _vat;
    map['order_date_and_time'] = _orderDateAndTime;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_payment != null) {
      map['payment'] = _payment?.toJson();
    }
    if (_orderStatus != null) {
      map['order_status'] = _orderStatus?.toJson();
    }
    return map;
  }

}

/// order_status_category : {"id":1,"name":"Ongoing"}

class OrderStatus {
  OrderStatus({
      OrderStatusCategory? orderStatusCategory,}){
    _orderStatusCategory = orderStatusCategory;
}

  OrderStatus.fromJson(dynamic json) {
    _orderStatusCategory = json['order_status_category'] != null ? OrderStatusCategory.fromJson(json['order_status_category']) : null;
  }
  OrderStatusCategory? _orderStatusCategory;
OrderStatus copyWith({  OrderStatusCategory? orderStatusCategory,
}) => OrderStatus(  orderStatusCategory: orderStatusCategory ?? _orderStatusCategory,
);
  OrderStatusCategory? get orderStatusCategory => _orderStatusCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_orderStatusCategory != null) {
      map['order_status_category'] = _orderStatusCategory?.toJson();
    }
    return map;
  }

}

/// id : 1
/// name : "Ongoing"

class OrderStatusCategory {
  OrderStatusCategory({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  OrderStatusCategory.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
OrderStatusCategory copyWith({  num? id,
  String? name,
}) => OrderStatusCategory(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// payment_status : 0

class Payment {
  Payment({
      num? paymentStatus,}){
    _paymentStatus = paymentStatus;
}

  Payment.fromJson(dynamic json) {
    _paymentStatus = json['payment_status'];
  }
  num? _paymentStatus;
Payment copyWith({  num? paymentStatus,
}) => Payment(  paymentStatus: paymentStatus ?? _paymentStatus,
);
  num? get paymentStatus => _paymentStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_status'] = _paymentStatus;
    return map;
  }

}

/// id : 113
/// name : "Abir"

class User {
  User({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
User copyWith({  num? id,
  String? name,
}) => User(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}