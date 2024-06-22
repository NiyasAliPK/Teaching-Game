import 'package:hive/hive.dart';
part 'premath_hive.g.dart';

@HiveType(typeId: 0)
class PreMathProgressModel {
  @HiveField(0)
  final double progress;
  @HiveField(1)
  final String id;
  PreMathProgressModel({required this.progress, required this.id});
}
