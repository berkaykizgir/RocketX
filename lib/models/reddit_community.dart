class RedditCommunityModel {
  String? _title;
  String? _iconImage;
  String? _description;
  String? _headerImage;
  int? _subs;
  int? _online;
  String? get title => _title;
  String? get iconImage => _iconImage;
  String? get description => _description;
  String? get bannerImage => _headerImage;
  int? get subs => _subs;
  int? get online => _online;
  RedditCommunityModel(Map<String, dynamic> json) {
    _title = json['data']['display_name_prefixed'];
    _iconImage = json['data']['icon_img'] == 'self' ? '' : json['data']['icon_img'];
    _description = json['data']['public_description'];
    _headerImage = json['data']['header_img'];
    _subs = json['data']['subscribers'];
    _online = json['data']['active_user_count'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_title != null) {
      data['title'] = _title;
    }
    if (_iconImage != null) {
      data['thumbnail'] = _iconImage;
    }
    if (_description != null) {
      data['public_description'] = _description;
    }
    if (_headerImage != null) {
      data['header_img'] = _headerImage;
    }
    if (_subs != null) {
      data['subscribers'] = _subs;
    }
    if (_online != null) {
      data['active_user_count'] = _online;
    }
    return data;
  }
}
