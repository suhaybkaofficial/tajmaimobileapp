import 'package:equatable/equatable.dart';

class OnBordingModel extends Equatable {
  final String title, image, paragraph;

  const OnBordingModel({
    required this.paragraph,
    required this.title,
    required this.image,
  });

  @override
  List<Object> get props => [image, title, paragraph];
}
