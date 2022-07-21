class FaviconResponse {
  String url;
  String icon;

  FaviconResponse({
    this.url = '',
    this.icon = '',
  });

  factory FaviconResponse.fromJson(Map<String, dynamic> json) {
    return FaviconResponse(
      url: json['url'] as String,
      icon: json['icons'] != null ? (json['icons'] as List<String>)[0] : '',
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['icon'] = icon;
    return data;
  }
}
