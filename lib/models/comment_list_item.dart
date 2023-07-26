class CommentListItem {
  final int id;
  final DateTime postTime;
  final int support;
  final int against;
  final UserInfo userInfo;
  final int replyCommentId;
  final UserInfo? replyUserInfo;
  final String floorStr;
  final dynamic replyFloorStr;
  final int parentCommentId;
  final int checkStatus;
  final dynamic paragraphId;
  final dynamic referText;
  final List<CommentElement> elements;
  final List<CommentListItem> children;
  final int voteStatus;
  final int editStatus;
  final dynamic editStatusStr;
  final DateTime editTime;
  final dynamic editRole;
  final int expandCount;

  CommentListItem({
    required this.id,
    required this.postTime,
    required this.support,
    required this.against,
    required this.userInfo,
    required this.replyCommentId,
    this.replyUserInfo,
    required this.floorStr,
    this.replyFloorStr,
    required this.parentCommentId,
    required this.checkStatus,
    this.paragraphId,
    this.referText,
    required this.elements,
    required this.children,
    required this.voteStatus,
    required this.editStatus,
    this.editStatusStr,
    required this.editTime,
    this.editRole,
    required this.expandCount,
  });

  factory CommentListItem.fromJson(Map<String, dynamic> json) =>
      CommentListItem(
        id: json["id"],
        postTime: DateTime.parse(json["postTime"]),
        support: json["support"],
        against: json["against"],
        userInfo: UserInfo.fromJson(json["userInfo"]),
        replyCommentId: json["replyCommentId"],
        replyUserInfo: json["replyUserInfo"] == null
            ? null
            : UserInfo.fromJson(json["replyUserInfo"]),
        floorStr: json["floorStr"],
        replyFloorStr: json["replyFloorStr"],
        parentCommentId: json["parentCommentId"],
        checkStatus: json["checkStatus"],
        paragraphId: json["paragraphId"],
        referText: json["referText"],
        elements: List<CommentElement>.from(
            json["elements"].map((x) => CommentElement.fromJson(x))),
        children: List<CommentListItem>.from(
            json["children"].map((x) => CommentListItem.fromJson(x))),
        voteStatus: json["voteStatus"],
        editStatus: json["editStatus"],
        editStatusStr: json["editStatusStr"],
        editTime: DateTime.parse(json["editTime"]),
        editRole: json["editRole"],
        expandCount: json["expandCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "postTime": postTime.toIso8601String(),
        "support": support,
        "against": against,
        "userInfo": userInfo.toJson(),
        "replyCommentId": replyCommentId,
        "replyUserInfo": replyUserInfo?.toJson(),
        "floorStr": floorStr,
        "replyFloorStr": replyFloorStr,
        "parentCommentId": parentCommentId,
        "checkStatus": checkStatus,
        "paragraphId": paragraphId,
        "referText": referText,
        "elements": List<dynamic>.from(elements.map((x) => x.toJson())),
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "voteStatus": voteStatus,
        "editStatus": editStatus,
        "editStatusStr": editStatusStr,
        "editTime": editTime.toIso8601String(),
        "editRole": editRole,
        "expandCount": expandCount,
      };
}

class CommentElement {
  final int type;
  final String content;
  final dynamic link;
  final int topicId;
  final int atUserId;
  final bool isAutoReply;
  final dynamic src;
  final int width;
  final int height;

  CommentElement({
    required this.type,
    required this.content,
    this.link,
    required this.topicId,
    required this.atUserId,
    required this.isAutoReply,
    this.src,
    required this.width,
    required this.height,
  });

  factory CommentElement.fromJson(Map<String, dynamic> json) => CommentElement(
        type: json["type"],
        content: json["content"],
        link: json["link"],
        topicId: json["topicId"],
        atUserId: json["atUserId"],
        isAutoReply: json["isAutoReply"],
        src: json["src"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "content": content,
        "link": link,
        "topicId": topicId,
        "atUserId": atUserId,
        "isAutoReply": isAutoReply,
        "src": src,
        "width": width,
        "height": height,
      };
}

class UserInfo {
  final int id;
  final String userNick;
  final String userAvatar;
  final int level;
  final int m;
  final int vip;
  final String link;

  UserInfo({
    required this.id,
    required this.userNick,
    required this.userAvatar,
    required this.level,
    required this.m,
    required this.vip,
    required this.link,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        userNick: json["userNick"],
        userAvatar: json["userAvatar"],
        level: json["level"],
        m: json["m"],
        vip: json["vip"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userNick": userNick,
        "userAvatar": userAvatar,
        "level": level,
        "m": m,
        "vip": vip,
        "link": link,
      };
}
