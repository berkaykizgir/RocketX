import 'package:rocketx/utilities.dart';

class RedditPostsModel {
  List<RedditPostModel> _postList = [];
  List<RedditPostModel> get postList => _postList;

  RedditPostsModel(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _postList = <RedditPostModel>[];
      json['data']['children'].forEach((postJSON) {
        _postList.add(RedditPostModel(postJSON));
      });
    }
  }
}

class RedditPostModel {
  String? _title;
  String? _thumbnail;
  String? _description;
  String? _communityName;
  String? _authorName;
  String? _createdUTC;
  String? _linkFlairText;
  String? _thumbnailClickURL;
  String? _linkFlairBackgroundColor;
  int? _ups;
  int? _downs;
  int? _numOfComments;
  int? _thumbnailHeight;
  int? _thumbnailWidth;
  String? get title => _title;
  String? get thumbnail => _thumbnail;
  String? get description => _description;
  String? get communityName => _communityName;
  String? get authorName => _authorName;
  String? get createdUTC => _createdUTC;
  String? get linkFlairText => _linkFlairText;
  String? get thumbnailClickURL => _thumbnailClickURL;
  String? get linkFlairBackgroundColor => _linkFlairBackgroundColor;
  int? get ups => _ups;
  int? get downs => _downs;
  int? get numOfComments => _numOfComments;
  int? get thumbnailHeight => _thumbnailHeight;
  int? get thumbnailWidth => _thumbnailWidth;

  RedditPostModel(Map<String, dynamic> json) {
    _title = json['data']['title'];
    _thumbnail = json['data']['thumbnail'] == 'self' ? '' : json['data']['thumbnail'];
    _description = json['data']['selftext'];
    _communityName = json['data']['subreddit_name_prefixed'];
    _authorName = json['data']['author'];
    _createdUTC = Utilities().readableTimestamp((json['data']['created_utc'] * 1000 as double).toInt());
    _linkFlairText = json['data']['link_flair_text'];
    _thumbnailClickURL = json['data']['url_overridden_by_dest'];
    _ups = json['data']['ups'];
    _downs = json['data']['downs'];
    _numOfComments = json['data']['num_comments'];
    _thumbnailHeight = json['data']['thumbnail_height'];
    _thumbnailWidth = json['data']['thumbnail_width'];
    _linkFlairBackgroundColor = json['data']['link_flair_background_color'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_title != null) {
      data['title'] = _title;
    }
    if (_thumbnail != null) {
      data['thumbnail'] = _thumbnail;
    }
    if (_description != null) {
      data['description'] = _description;
    }
    if (_communityName != null) {
      data['subreddit'] = _communityName;
    }
    if (_authorName != null) {
      data['author'] = _authorName;
    }
    if (_createdUTC != null) {
      data['created_utc'] = _createdUTC;
    }
    if (_linkFlairText != null) {
      data['link_flair_text'] = _linkFlairText;
    }
    if (_ups != null) {
      data['ups'] = _ups;
    }
    if (_downs != null) {
      data['downs'] = _downs;
    }
    if (_numOfComments != null) {
      data['num_comments'] = _numOfComments;
    }
    if (_thumbnailClickURL != null) {
      data['url_overridden_by_dest'] = _thumbnailClickURL;
    }
    if (_thumbnailHeight != null) {
      data['thumbnail_height'] = _thumbnailHeight;
    }
    if (_thumbnailWidth != null) {
      data['thumbnail_width'] = _thumbnailWidth;
    }
    if (_linkFlairBackgroundColor != null) {
      data['link_flair_background_color'] = _linkFlairBackgroundColor;
    }
    return data;
  }
}
