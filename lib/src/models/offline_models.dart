import 'package:json_annotation/json_annotation.dart';

part 'offline_models.g.dart';

/// Простая модель кэша для тестирования
@JsonSerializable()
class CacheEntry {
  final String key;
  final String data;
  final DateTime? expiry;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  CacheEntry({
    required this.key,
    required this.data,
    this.expiry,
    this.tags = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory CacheEntry.fromJson(Map<String, dynamic> json) =>
      _$CacheEntryFromJson(json);

  Map<String, dynamic> toJson() => _$CacheEntryToJson(this);

  bool get isExpired {
    if (expiry == null) return false;
    return DateTime.now().isAfter(expiry!);
  }
}

/// Простая модель офлайн операции
@JsonSerializable()
class OfflineOperation {
  final String operationId;
  final String type;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final String status;

  OfflineOperation({
    required this.operationId,
    required this.type,
    required this.data,
    DateTime? createdAt,
    this.status = 'pending',
  }) : createdAt = createdAt ?? DateTime.now();

  factory OfflineOperation.fromJson(Map<String, dynamic> json) =>
      _$OfflineOperationFromJson(json);

  Map<String, dynamic> toJson() => _$OfflineOperationToJson(this);
}
