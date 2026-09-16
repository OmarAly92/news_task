import 'package:equatable/equatable.dart';

class ContentBlockModel extends Equatable {
  final String? type;
  final String? text;
  final String? url;
  final String? caption;

  const ContentBlockModel({this.type, this.text, this.url, this.caption});

  factory ContentBlockModel.fromJson(Map<String, dynamic> json) =>
      ContentBlockModel(
        type: json['type'] as String?,
        text: json['text'] as String?,
        url: json['url'] as String?,
        caption: json['caption'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'type': type,
    'text': text,
    'url': url,
    'caption': caption,
  };

  @override
  List<Object?> get props => [type, text, url, caption];
}
