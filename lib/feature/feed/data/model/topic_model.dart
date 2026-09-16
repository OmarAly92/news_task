import 'package:equatable/equatable.dart';

class TopicModel extends Equatable {
  final String? id;
  final String? name;
  final String? icon;

  const TopicModel({this.id, this.name, this.icon});

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
    id: json['id'] as String?,
    name: json['name'] as String?,
    icon: json['icon'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'icon': icon};

  @override
  List<Object?> get props => [id, name, icon];
}
