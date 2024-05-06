class Locality {
  String locality = '';

  Locality({required this.locality});

  Locality.fromJson(Map<String, dynamic> json) {
    locality = json['locality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locality'] = locality;
    return data;
  }
}
