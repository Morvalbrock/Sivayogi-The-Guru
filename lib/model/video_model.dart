class VideoItem {
  final int id;
  final String image_name;
  final String image_url;
  final String video_url;
  final String video_name;

  VideoItem(
      {required this.id,
      required this.image_name,
      required this.image_url,
      required this.video_url,
      required this.video_name});

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
        id: json['id'],
        image_name: json['name'],
        image_url: json['image'],
        video_url: json['video_url'],
        video_name: json['video_name']);
  }
}
