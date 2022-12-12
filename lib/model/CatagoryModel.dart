/// id : 123
/// name : "Dell"
/// image : "category/1746586533894662.jpg"
/// icon : "icons/1746586533977787.jpg"

class CatagoryModel {
  CatagoryModel({
      num? id, 
      String? name, 
      String? image, 
      String? icon,}){
    _id = id;
    _name = name;
    _image = image;
    _icon = icon;
}

  CatagoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _icon = json['icon'];
  }
  num? _id;
  String? _name;
  String? _image;
  String? _icon;
CatagoryModel copyWith({  num? id,
  String? name,
  String? image,
  String? icon,
}) => CatagoryModel(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  icon: icon ?? _icon,
);
  num? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['icon'] = _icon;
    return map;
  }

}