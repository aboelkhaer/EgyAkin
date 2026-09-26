// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_inbox_model_response.freezed.dart';
part 'get_inbox_model_response.g.dart';

int? _flexibleIntFromJson(Object? value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value.trim());
  return null;
}

bool? _flexibleBoolFromJson(Object? value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final n = value.trim().toLowerCase();
    if (n == 'true' || n == '1') return true;
    if (n == 'false' || n == '0') return false;
  }
  return null;
}

@freezed
class GetInboxModelResponse with _$GetInboxModelResponse {
  const factory GetInboxModelResponse({
    bool? value,
    String? message,
    InboxDataModel? data,
  }) = _GetInboxModelResponse;

  factory GetInboxModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetInboxModelResponseFromJson(json);
}

@freezed
class InboxDataModel with _$InboxDataModel {
  const factory InboxDataModel({
    String? filter,
    InboxCountsModel? counts,
    @JsonKey(name: 'section_counts') InboxSectionCountsModel? sectionCounts,
    @JsonKey(name: 'total_unread', fromJson: _flexibleIntFromJson)
    int? totalUnread,
    /// Optional localized chip titles from API, e.g. `{"all":"All","doctors":"Doctors"}`.
    @JsonKey(name: 'filter_titles') Map<String, String>? filterTitles,
    /// Optional section headers, e.g. `{"priority":"PRIORITY","earlier":"EARLIER"}`.
    @JsonKey(name: 'section_titles') Map<String, String>? sectionTitles,
    List<InboxItemModel>? items,
    InboxPaginatorMetaModel? meta,
  }) = _InboxDataModel;

  factory InboxDataModel.fromJson(Map<String, dynamic> json) =>
      _$InboxDataModelFromJson(json);
}

@freezed
class InboxCountsModel with _$InboxCountsModel {
  const factory InboxCountsModel({
    @JsonKey(fromJson: _flexibleIntFromJson) int? all,
    @JsonKey(fromJson: _flexibleIntFromJson) int? doctors,
    @JsonKey(fromJson: _flexibleIntFromJson) int? people,
    @JsonKey(fromJson: _flexibleIntFromJson) int? patients,
    @JsonKey(fromJson: _flexibleIntFromJson) int? groups,
    @JsonKey(name: 'social_groups', fromJson: _flexibleIntFromJson)
    int? socialGroups,
    @JsonKey(fromJson: _flexibleIntFromJson) int? consults,
  }) = _InboxCountsModel;

  /// Accepts API aliases: `individual`→doctors, `group`→groups,
  /// `social_group`→social_groups.
  factory InboxCountsModel.fromJson(Map<String, dynamic> json) {
    return InboxCountsModel(
      all: _flexibleIntFromJson(json['all']),
      doctors: _flexibleIntFromJson(
        json['doctors'] ?? json['individual'] ?? json['people'],
      ),
      people: _flexibleIntFromJson(json['people']),
      patients: _flexibleIntFromJson(json['patients']),
      groups: _flexibleIntFromJson(json['groups'] ?? json['group']),
      socialGroups: _flexibleIntFromJson(
        json['social_groups'] ?? json['social_group'],
      ),
      consults: _flexibleIntFromJson(json['consults']),
    );
  }
}

@freezed
class InboxSectionCountsModel with _$InboxSectionCountsModel {
  const factory InboxSectionCountsModel({
    @JsonKey(fromJson: _flexibleIntFromJson) int? priority,
    @JsonKey(fromJson: _flexibleIntFromJson) int? earlier,
  }) = _InboxSectionCountsModel;

  factory InboxSectionCountsModel.fromJson(Map<String, dynamic> json) =>
      _$InboxSectionCountsModelFromJson(json);
}

@freezed
class InboxItemModel with _$InboxItemModel {
  const factory InboxItemModel({
    String? source,
    int? id,
    @JsonKey(name: 'chat_type') String? chatType,
    @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
    int? contextId,
    String? title,
    String? subtitle,
    ChatUserModel? counterpart,
    String? image,
    @JsonKey(name: 'is_urgent', fromJson: _flexibleBoolFromJson) bool? isUrgent,
    @JsonKey(name: 'unread_count', fromJson: _flexibleIntFromJson)
    int? unreadCount,
    String? section,
    @JsonKey(name: 'last_message') InboxLastMessageModel? lastMessage,
    @JsonKey(name: 'is_open', fromJson: _flexibleBoolFromJson) bool? isOpen,
    String? direction,
    @JsonKey(name: 'last_activity_at') String? lastActivityAt,
  }) = _InboxItemModel;

  factory InboxItemModel.fromJson(Map<String, dynamic> json) =>
      _$InboxItemModelFromJson(json);
}

@freezed
class InboxLastMessageModel with _$InboxLastMessageModel {
  const factory InboxLastMessageModel({
    int? id,
    String? type,
    String? content,
    @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson) int? senderId,
    @JsonKey(name: 'is_mine', fromJson: _flexibleBoolFromJson) bool? isMine,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    List<ChatAttachmentModel>? attachments,
  }) = _InboxLastMessageModel;

  factory InboxLastMessageModel.fromJson(Map<String, dynamic> json) =>
      _$InboxLastMessageModelFromJson(json);
}

@freezed
class InboxPaginatorMetaModel with _$InboxPaginatorMetaModel {
  const factory InboxPaginatorMetaModel({
    @JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
    int? currentPage,
    @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson) int? perPage,
    @JsonKey(fromJson: _flexibleIntFromJson) int? total,
    @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson) int? lastPage,
  }) = _InboxPaginatorMetaModel;

  factory InboxPaginatorMetaModel.fromJson(Map<String, dynamic> json) =>
      _$InboxPaginatorMetaModelFromJson(json);
}
