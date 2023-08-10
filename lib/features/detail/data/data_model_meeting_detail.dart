/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myJsonDataNode = Root.fromJson(map);
*/
class Datum {
  int? postid;
  String? title;
  String? content;
  String? authornickname;
  int? authornation;
  String? authorpicture;
  int? usertype;
  int? meetingcapacity;
  String? meetingpic;
  String? meetinglocation;
  String? meetingstarttime;
  int? category;
  int? likecount;
  int? likecheck;
  int? participationstatus;

  Datum(
      {this.postid,
      this.title,
      this.content,
      this.authornickname,
      this.authornation,
      this.authorpicture,
      this.usertype,
      this.meetingcapacity,
      this.meetingpic,
      this.meetinglocation,
      this.meetingstarttime,
      this.category,
      this.likecount,
      this.likecheck,
      this.participationstatus});

  Datum.fromJson(Map<String, dynamic> json) {
    postid = json['post_id'];
    title = json['title'];
    content = json['content'];
    authornickname = json['author_nickname'];
    authornation = json['author_nation'];
    authorpicture = json['author_picture'];
    usertype = json['user_type'];
    meetingcapacity = json['meeting_capacity'];
    meetingpic = json['meeting_pic'];
    meetinglocation = json['meeting_location'];
    meetingstarttime = json['meeting_start_time'];
    category = json['category'];
    likecount = json['like_count'];
    likecheck = json['like_check'];
    participationstatus = json['participation_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postid;
    data['title'] = title;
    data['content'] = content;
    data['author_nickname'] = authornickname;
    data['author_nation'] = authornation;
    data['author_picture'] = authorpicture;
    data['user_type'] = usertype;
    data['meeting_capacity'] = meetingcapacity;
    data['meeting_pic'] = meetingpic;
    data['meeting_location'] = meetinglocation;
    data['meeting_start_time'] = meetingstarttime;
    data['category'] = category;
    data['like_count'] = likecount;
    data['like_check'] = likecheck;
    data['participation_status'] = participationstatus;
    return data;
  }
}

class JsonData {
  int? status;
  List<Datum?>? data;

  JsonData({this.status, this.data});

  JsonData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Datum>[];
      json['data'].forEach((v) {
        data!.add(Datum.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['status'] = status;
  //   data['data'] = data != null ? data.map((v) => v?.toJson()).toList() : null;
  //   return data;
  // }
}
