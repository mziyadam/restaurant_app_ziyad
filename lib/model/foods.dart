class Foods {
  String name;

  Foods({this.name});

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
