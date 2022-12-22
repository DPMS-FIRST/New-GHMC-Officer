class ViewGrievancePreview {
  List<ViewGrievances>? viewGrievances;

  ViewGrievancePreview({this.viewGrievances});

  ViewGrievancePreview.fromJson(Map<String, dynamic> json) {
    if (json['viewGrievances'] != null) {
      viewGrievances = <ViewGrievances>[];
      json['viewGrievances'].forEach((v) {
        viewGrievances!.add(new ViewGrievances.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.viewGrievances != null) {
      data['viewGrievances'] =
          this.viewGrievances!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewGrievances {
  String? flag;
  String? id;
  String? type;
  String? timestamp;
  String? status;
  String? category;
  String? assignedto;
  String? statusID;

  ViewGrievances(
      {this.flag,
      this.id,
      this.type,
      this.timestamp,
      this.status,
      this.category,
      this.assignedto,
      this.statusID});

  ViewGrievances.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    id = json['id'];
    type = json['type'];
    timestamp = json['timestamp'];
    status = json['status'];
    category = json['category'];
    assignedto = json['assignedto'];
    statusID = json['status_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['id'] = this.id;
    data['type'] = this.type;
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['category'] = this.category;
    data['assignedto'] = this.assignedto;
    data['status_ID'] = this.statusID;
    return data;
  }
}