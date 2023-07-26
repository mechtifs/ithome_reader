class NewsContent {
  NewsContent({
    required this.success,
    required this.newsid,
    required this.title,
    required this.url,
    required this.newssource,
    required this.newsauthor,
    required this.keyword,
    required this.image,
    required this.newstags,
    required this.newsflag,
    required this.detail,
    required this.postdate,
    required this.hitcount,
    required this.btheme,
    required this.forbidcomment,
    required this.commentcount,
    required this.z,
  });
  late final bool success;
  late final int newsid;
  late final String title;
  late final String url;
  late final String newssource;
  late final String newsauthor;
  late final String keyword;
  late final String image;
  late final List<Newstags> newstags;
  late final int newsflag;
  late final String detail;
  late final String postdate;
  late final int hitcount;
  late final bool btheme;
  late final bool forbidcomment;
  late final int commentcount;
  late final String z;

  NewsContent.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    newsid = json['newsid'];
    title = json['title'];
    url = json['url'];
    newssource = json['newssource'];
    newsauthor = json['newsauthor'];
    keyword = json['keyword'];
    image = json['image'];
    newstags = List.from(json['newstags'] ?? [])
        .map((e) => Newstags.fromJson(e))
        .toList();
    newsflag = json['newsflag'];
    detail = json['detail'];
    postdate = json['postdate'];
    hitcount = json['hitcount'];
    btheme = json['btheme'];
    forbidcomment = json['forbidcomment'];
    commentcount = json['commentcount'];
    z = json['z'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['newsid'] = newsid;
    data['title'] = title;
    data['url'] = url;
    data['newssource'] = newssource;
    data['newsauthor'] = newsauthor;
    data['keyword'] = keyword;
    data['image'] = image;
    data['newstags'] = newstags.map((e) => e.toJson()).toList();
    data['newsflag'] = newsflag;
    data['detail'] = detail;
    data['postdate'] = postdate;
    data['hitcount'] = hitcount;
    data['btheme'] = btheme;
    data['forbidcomment'] = forbidcomment;
    data['commentcount'] = commentcount;
    data['z'] = z;
    return data;
  }
}

class Newstags {
  Newstags({
    required this.id,
    required this.keyword,
    required this.link,
  });
  late final int id;
  late final String keyword;
  late final String link;

  Newstags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyword = json['keyword'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['keyword'] = keyword;
    data['link'] = link;
    return data;
  }
}
