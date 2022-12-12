/// id : 4
/// name : "test sd"
/// image : "foods/1698303690017174.png"
/// is_visible : 1
/// is_available : 0
/// food_item_category : []
/// price : [{"original_price":100,"discounted_price":80,"discount_type":"fixed","fixed_value":20,"percent_of":null}]
/// stock_items : [{"quantity":200}]

class ProdactModel {
  ProdactModel({
      num? id, 
      String? name, 
      String? image, 
      num? isVisible, 
      num? isAvailable, 
      List<dynamic>? foodItemCategory, 
      List<Price>? price, 
      List<StockItems>? stockItems,}){
    _id = id;
    _name = name;
    _image = image;
    _isVisible = isVisible;
    _isAvailable = isAvailable;
    _foodItemCategory = foodItemCategory;
    _price = price;
    _stockItems = stockItems;
}

  ProdactModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _isVisible = json['is_visible'];
    _isAvailable = json['is_available'];
    if (json['food_item_category'] != null) {
      _foodItemCategory = [];
      json['food_item_category'].forEach((v) {
       // _foodItemCategory?.add(Dynamic.fromJson(v));
      });
    }
    if (json['price'] != null) {
      _price = [];
      json['price'].forEach((v) {
        _price?.add(Price.fromJson(v));
      });
    }
    if (json['stock_items'] != null) {
      _stockItems = [];
      json['stock_items'].forEach((v) {
        _stockItems?.add(StockItems.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  String? _image;
  num? _isVisible;
  num? _isAvailable;
  List<dynamic>? _foodItemCategory;
  List<Price>? _price;
  List<StockItems>? _stockItems;
ProdactModel copyWith({  num? id,
  String? name,
  String? image,
  num? isVisible,
  num? isAvailable,
  List<dynamic>? foodItemCategory,
  List<Price>? price,
  List<StockItems>? stockItems,
}) => ProdactModel(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  isVisible: isVisible ?? _isVisible,
  isAvailable: isAvailable ?? _isAvailable,
  //foodItemCategory: foodItemCategory ?? _foodItemCategory,
  price: price ?? _price,
  stockItems: stockItems ?? _stockItems,
);
  num? get id => _id;
  String? get name => _name;
  String? get image => _image;
  num? get isVisible => _isVisible;
  num? get isAvailable => _isAvailable;
  List<dynamic>? get foodItemCategory => _foodItemCategory;
  List<Price>? get price => _price;
  List<StockItems>? get stockItems => _stockItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['is_visible'] = _isVisible;
    map['is_available'] = _isAvailable;
    if (_foodItemCategory != null) {
      map['food_item_category'] = _foodItemCategory?.map((v) => v.toJson()).toList();
    }
    if (_price != null) {
      map['price'] = _price?.map((v) => v.toJson()).toList();
    }
    if (_stockItems != null) {
      map['stock_items'] = _stockItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// quantity : 200

class StockItems {
  StockItems({
      num? quantity,}){
    _quantity = quantity;
}

  StockItems.fromJson(dynamic json) {
    _quantity = json['quantity'];
  }
  num? _quantity;
StockItems copyWith({  num? quantity,
}) => StockItems(  quantity: quantity ?? _quantity,
);
  num? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = _quantity;
    return map;
  }

}

/// original_price : 100
/// discounted_price : 80
/// discount_type : "fixed"
/// fixed_value : 20
/// percent_of : null

class Price {
  Price({
      num? originalPrice, 
      num? discountedPrice, 
      String? discountType, 
      num? fixedValue, 
      dynamic percentOf,}){
    _originalPrice = originalPrice;
    _discountedPrice = discountedPrice;
    _discountType = discountType;
    _fixedValue = fixedValue;
    _percentOf = percentOf;
}

  Price.fromJson(dynamic json) {
    _originalPrice = json['original_price'];
    _discountedPrice = json['discounted_price'];
    _discountType = json['discount_type'];
    _fixedValue = json['fixed_value'];
    _percentOf = json['percent_of'];
  }
  num? _originalPrice;
  num? _discountedPrice;
  String? _discountType;
  num? _fixedValue;
  dynamic _percentOf;
Price copyWith({  num? originalPrice,
  num? discountedPrice,
  String? discountType,
  num? fixedValue,
  dynamic percentOf,
}) => Price(  originalPrice: originalPrice ?? _originalPrice,
  discountedPrice: discountedPrice ?? _discountedPrice,
  discountType: discountType ?? _discountType,
  fixedValue: fixedValue ?? _fixedValue,
  percentOf: percentOf ?? _percentOf,
);
  num? get originalPrice => _originalPrice;
  num? get discountedPrice => _discountedPrice;
  String? get discountType => _discountType;
  num? get fixedValue => _fixedValue;
  dynamic get percentOf => _percentOf;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['original_price'] = _originalPrice;
    map['discounted_price'] = _discountedPrice;
    map['discount_type'] = _discountType;
    map['fixed_value'] = _fixedValue;
    map['percent_of'] = _percentOf;
    return map;
  }

}