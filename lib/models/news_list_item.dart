class NewsListItem {
  final int newsid;
  final String title;
  final DateTime postdate;
  final String image;
  final int commentcount;
  final String url;
  final String postDateStr;
  final List<NewsTip> newsTips;

  NewsListItem({
    required this.newsid,
    required this.title,
    required this.postdate,
    required this.image,
    required this.commentcount,
    required this.url,
    required this.postDateStr,
    required this.newsTips,
  });

  factory NewsListItem.fromJson(Map<String, dynamic> json) => NewsListItem(
        newsid: json["newsid"],
        title: json["title"],
        postdate: DateTime.parse(json["postdate"]),
        image: json["image"],
        commentcount: json["commentcount"],
        url: json["url"],
        postDateStr: json["PostDateStr"],
        newsTips: List<NewsTip>.from(
            json["NewsTips"].map((x) => NewsTip.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "newsid": newsid,
        "title": title,
        "postdate": postdate.toIso8601String(),
        "image": image,
        "url": url,
        "PostDateStr": postDateStr,
        "NewsTips": List<dynamic>.from(newsTips.map((x) => x.toJson())),
      };
}

class NewsTip {
  final String tipClass;
  final String tipName;

  NewsTip({
    required this.tipClass,
    required this.tipName,
  });

  factory NewsTip.fromJson(Map<String, dynamic> json) => NewsTip(
        tipClass: json["TipClass"],
        tipName: json["TipName"],
      );

  Map<String, dynamic> toJson() => {
        "TipClass": tipClass,
        "TipName": tipName,
      };
}
