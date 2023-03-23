class RequestSession {
  String? username;
  String? password;
  String? requestToken;

  RequestSession(this.username, this.password, this.requestToken);

  RequestSession.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    requestToken = json['request_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['request_token'] = requestToken;
    return data;
  }
}