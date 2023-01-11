class TakeActionIdProofRes {
  String? tag;
  bool? status;
  List<Data>? data;

  TakeActionIdProofRes({this.tag, this.status, this.data});

  TakeActionIdProofRes.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}
class Data {
  String? name;
  String? id;

  Data({this.name, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
