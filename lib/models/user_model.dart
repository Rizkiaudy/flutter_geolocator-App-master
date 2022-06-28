class UserModel {
  String? status;
  String? msg;
  String? errors;
  Content? content;

  UserModel({this.status, this.msg, this.errors, this.content});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    errors = json['errors'];
    content = json['content'] != "kosong"
        ? new Content.fromJson(json['content'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['errors'] = this.errors;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class Content {
  int? statusCode;
  String? accessToken;
  String? tokenType;
  String? name;
  String? user;
  String? role;

  Content(
      {this.statusCode,
      this.accessToken,
      this.tokenType,
      this.name,
      this.user,
      this.role});

  Content.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    name = json['name'];
    user = json['user'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['name'] = this.name;
    data['user'] = this.user;
    data['role'] = this.role;
    return data;
  }
}
