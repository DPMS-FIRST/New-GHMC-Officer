class AMOHCClosedTicketListReq {
  String? dEVICEID;
  String? tOKENID;
  String? aMOHEMPID;

  AMOHCClosedTicketListReq({this.dEVICEID, this.tOKENID, this.aMOHEMPID});

  AMOHCClosedTicketListReq.fromJson(Map<String, dynamic> json) {
    dEVICEID = json['DEVICEID'];
    tOKENID = json['TOKEN_ID'];
    aMOHEMPID = json['AMOH_EMP_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DEVICEID'] = this.dEVICEID;
    data['TOKEN_ID'] = this.tOKENID;
    data['AMOH_EMP_ID'] = this.aMOHEMPID;
    return data;
  }
}
