class Image {
  Image({
      this.id, 
      this.src,});

  Image.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
  }
  int? id;
  String? src;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    return map;
  }

}