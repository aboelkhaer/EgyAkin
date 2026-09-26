// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_inbox_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetInboxModelResponse _$GetInboxModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetInboxModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetInboxModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  InboxDataModel? get data => throw _privateConstructorUsedError;

  /// Serializes this GetInboxModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetInboxModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetInboxModelResponseCopyWith<GetInboxModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetInboxModelResponseCopyWith<$Res> {
  factory $GetInboxModelResponseCopyWith(GetInboxModelResponse value,
          $Res Function(GetInboxModelResponse) then) =
      _$GetInboxModelResponseCopyWithImpl<$Res, GetInboxModelResponse>;
  @useResult
  $Res call({bool? value, String? message, InboxDataModel? data});

  $InboxDataModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetInboxModelResponseCopyWithImpl<$Res,
        $Val extends GetInboxModelResponse>
    implements $GetInboxModelResponseCopyWith<$Res> {
  _$GetInboxModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetInboxModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as InboxDataModel?,
    ) as $Val);
  }

  /// Create a copy of GetInboxModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InboxDataModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $InboxDataModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetInboxModelResponseImplCopyWith<$Res>
    implements $GetInboxModelResponseCopyWith<$Res> {
  factory _$$GetInboxModelResponseImplCopyWith(
          _$GetInboxModelResponseImpl value,
          $Res Function(_$GetInboxModelResponseImpl) then) =
      __$$GetInboxModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message, InboxDataModel? data});

  @override
  $InboxDataModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetInboxModelResponseImplCopyWithImpl<$Res>
    extends _$GetInboxModelResponseCopyWithImpl<$Res,
        _$GetInboxModelResponseImpl>
    implements _$$GetInboxModelResponseImplCopyWith<$Res> {
  __$$GetInboxModelResponseImplCopyWithImpl(_$GetInboxModelResponseImpl _value,
      $Res Function(_$GetInboxModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetInboxModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetInboxModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as InboxDataModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetInboxModelResponseImpl implements _GetInboxModelResponse {
  const _$GetInboxModelResponseImpl({this.value, this.message, this.data});

  factory _$GetInboxModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetInboxModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;
  @override
  final InboxDataModel? data;

  @override
  String toString() {
    return 'GetInboxModelResponse(value: $value, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetInboxModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, message, data);

  /// Create a copy of GetInboxModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetInboxModelResponseImplCopyWith<_$GetInboxModelResponseImpl>
      get copyWith => __$$GetInboxModelResponseImplCopyWithImpl<
          _$GetInboxModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetInboxModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetInboxModelResponse implements GetInboxModelResponse {
  const factory _GetInboxModelResponse(
      {final bool? value,
      final String? message,
      final InboxDataModel? data}) = _$GetInboxModelResponseImpl;

  factory _GetInboxModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetInboxModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  InboxDataModel? get data;

  /// Create a copy of GetInboxModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetInboxModelResponseImplCopyWith<_$GetInboxModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InboxDataModel _$InboxDataModelFromJson(Map<String, dynamic> json) {
  return _InboxDataModel.fromJson(json);
}

/// @nodoc
mixin _$InboxDataModel {
  String? get filter => throw _privateConstructorUsedError;
  InboxCountsModel? get counts => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_counts')
  InboxSectionCountsModel? get sectionCounts =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'total_unread', fromJson: _flexibleIntFromJson)
  int? get totalUnread => throw _privateConstructorUsedError;

  /// Optional localized chip titles from API, e.g. `{"all":"All","doctors":"Doctors"}`.
  @JsonKey(name: 'filter_titles')
  Map<String, String>? get filterTitles => throw _privateConstructorUsedError;

  /// Optional section headers, e.g. `{"priority":"PRIORITY","earlier":"EARLIER"}`.
  @JsonKey(name: 'section_titles')
  Map<String, String>? get sectionTitles => throw _privateConstructorUsedError;
  List<InboxItemModel>? get items => throw _privateConstructorUsedError;
  InboxPaginatorMetaModel? get meta => throw _privateConstructorUsedError;

  /// Serializes this InboxDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InboxDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InboxDataModelCopyWith<InboxDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InboxDataModelCopyWith<$Res> {
  factory $InboxDataModelCopyWith(
          InboxDataModel value, $Res Function(InboxDataModel) then) =
      _$InboxDataModelCopyWithImpl<$Res, InboxDataModel>;
  @useResult
  $Res call(
      {String? filter,
      InboxCountsModel? counts,
      @JsonKey(name: 'section_counts') InboxSectionCountsModel? sectionCounts,
      @JsonKey(name: 'total_unread', fromJson: _flexibleIntFromJson)
      int? totalUnread,
      @JsonKey(name: 'filter_titles') Map<String, String>? filterTitles,
      @JsonKey(name: 'section_titles') Map<String, String>? sectionTitles,
      List<InboxItemModel>? items,
      InboxPaginatorMetaModel? meta});

  $InboxCountsModelCopyWith<$Res>? get counts;
  $InboxSectionCountsModelCopyWith<$Res>? get sectionCounts;
  $InboxPaginatorMetaModelCopyWith<$Res>? get meta;
}

/// @nodoc
class _$InboxDataModelCopyWithImpl<$Res, $Val extends InboxDataModel>
    implements $InboxDataModelCopyWith<$Res> {
  _$InboxDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InboxDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = freezed,
    Object? counts = freezed,
    Object? sectionCounts = freezed,
    Object? totalUnread = freezed,
    Object? filterTitles = freezed,
    Object? sectionTitles = freezed,
    Object? items = freezed,
    Object? meta = freezed,
  }) {
    return _then(_value.copyWith(
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String?,
      counts: freezed == counts
          ? _value.counts
          : counts // ignore: cast_nullable_to_non_nullable
              as InboxCountsModel?,
      sectionCounts: freezed == sectionCounts
          ? _value.sectionCounts
          : sectionCounts // ignore: cast_nullable_to_non_nullable
              as InboxSectionCountsModel?,
      totalUnread: freezed == totalUnread
          ? _value.totalUnread
          : totalUnread // ignore: cast_nullable_to_non_nullable
              as int?,
      filterTitles: freezed == filterTitles
          ? _value.filterTitles
          : filterTitles // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      sectionTitles: freezed == sectionTitles
          ? _value.sectionTitles
          : sectionTitles // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<InboxItemModel>?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as InboxPaginatorMetaModel?,
    ) as $Val);
  }

  /// Create a copy of InboxDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InboxCountsModelCopyWith<$Res>? get counts {
    if (_value.counts == null) {
      return null;
    }

    return $InboxCountsModelCopyWith<$Res>(_value.counts!, (value) {
      return _then(_value.copyWith(counts: value) as $Val);
    });
  }

  /// Create a copy of InboxDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InboxSectionCountsModelCopyWith<$Res>? get sectionCounts {
    if (_value.sectionCounts == null) {
      return null;
    }

    return $InboxSectionCountsModelCopyWith<$Res>(_value.sectionCounts!,
        (value) {
      return _then(_value.copyWith(sectionCounts: value) as $Val);
    });
  }

  /// Create a copy of InboxDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InboxPaginatorMetaModelCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $InboxPaginatorMetaModelCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InboxDataModelImplCopyWith<$Res>
    implements $InboxDataModelCopyWith<$Res> {
  factory _$$InboxDataModelImplCopyWith(_$InboxDataModelImpl value,
          $Res Function(_$InboxDataModelImpl) then) =
      __$$InboxDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? filter,
      InboxCountsModel? counts,
      @JsonKey(name: 'section_counts') InboxSectionCountsModel? sectionCounts,
      @JsonKey(name: 'total_unread', fromJson: _flexibleIntFromJson)
      int? totalUnread,
      @JsonKey(name: 'filter_titles') Map<String, String>? filterTitles,
      @JsonKey(name: 'section_titles') Map<String, String>? sectionTitles,
      List<InboxItemModel>? items,
      InboxPaginatorMetaModel? meta});

  @override
  $InboxCountsModelCopyWith<$Res>? get counts;
  @override
  $InboxSectionCountsModelCopyWith<$Res>? get sectionCounts;
  @override
  $InboxPaginatorMetaModelCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$InboxDataModelImplCopyWithImpl<$Res>
    extends _$InboxDataModelCopyWithImpl<$Res, _$InboxDataModelImpl>
    implements _$$InboxDataModelImplCopyWith<$Res> {
  __$$InboxDataModelImplCopyWithImpl(
      _$InboxDataModelImpl _value, $Res Function(_$InboxDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of InboxDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = freezed,
    Object? counts = freezed,
    Object? sectionCounts = freezed,
    Object? totalUnread = freezed,
    Object? filterTitles = freezed,
    Object? sectionTitles = freezed,
    Object? items = freezed,
    Object? meta = freezed,
  }) {
    return _then(_$InboxDataModelImpl(
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String?,
      counts: freezed == counts
          ? _value.counts
          : counts // ignore: cast_nullable_to_non_nullable
              as InboxCountsModel?,
      sectionCounts: freezed == sectionCounts
          ? _value.sectionCounts
          : sectionCounts // ignore: cast_nullable_to_non_nullable
              as InboxSectionCountsModel?,
      totalUnread: freezed == totalUnread
          ? _value.totalUnread
          : totalUnread // ignore: cast_nullable_to_non_nullable
              as int?,
      filterTitles: freezed == filterTitles
          ? _value._filterTitles
          : filterTitles // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      sectionTitles: freezed == sectionTitles
          ? _value._sectionTitles
          : sectionTitles // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<InboxItemModel>?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as InboxPaginatorMetaModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InboxDataModelImpl implements _InboxDataModel {
  const _$InboxDataModelImpl(
      {this.filter,
      this.counts,
      @JsonKey(name: 'section_counts') this.sectionCounts,
      @JsonKey(name: 'total_unread', fromJson: _flexibleIntFromJson)
      this.totalUnread,
      @JsonKey(name: 'filter_titles') final Map<String, String>? filterTitles,
      @JsonKey(name: 'section_titles') final Map<String, String>? sectionTitles,
      final List<InboxItemModel>? items,
      this.meta})
      : _filterTitles = filterTitles,
        _sectionTitles = sectionTitles,
        _items = items;

  factory _$InboxDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InboxDataModelImplFromJson(json);

  @override
  final String? filter;
  @override
  final InboxCountsModel? counts;
  @override
  @JsonKey(name: 'section_counts')
  final InboxSectionCountsModel? sectionCounts;
  @override
  @JsonKey(name: 'total_unread', fromJson: _flexibleIntFromJson)
  final int? totalUnread;

  /// Optional localized chip titles from API, e.g. `{"all":"All","doctors":"Doctors"}`.
  final Map<String, String>? _filterTitles;

  /// Optional localized chip titles from API, e.g. `{"all":"All","doctors":"Doctors"}`.
  @override
  @JsonKey(name: 'filter_titles')
  Map<String, String>? get filterTitles {
    final value = _filterTitles;
    if (value == null) return null;
    if (_filterTitles is EqualUnmodifiableMapView) return _filterTitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Optional section headers, e.g. `{"priority":"PRIORITY","earlier":"EARLIER"}`.
  final Map<String, String>? _sectionTitles;

  /// Optional section headers, e.g. `{"priority":"PRIORITY","earlier":"EARLIER"}`.
  @override
  @JsonKey(name: 'section_titles')
  Map<String, String>? get sectionTitles {
    final value = _sectionTitles;
    if (value == null) return null;
    if (_sectionTitles is EqualUnmodifiableMapView) return _sectionTitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<InboxItemModel>? _items;
  @override
  List<InboxItemModel>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final InboxPaginatorMetaModel? meta;

  @override
  String toString() {
    return 'InboxDataModel(filter: $filter, counts: $counts, sectionCounts: $sectionCounts, totalUnread: $totalUnread, filterTitles: $filterTitles, sectionTitles: $sectionTitles, items: $items, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InboxDataModelImpl &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.counts, counts) || other.counts == counts) &&
            (identical(other.sectionCounts, sectionCounts) ||
                other.sectionCounts == sectionCounts) &&
            (identical(other.totalUnread, totalUnread) ||
                other.totalUnread == totalUnread) &&
            const DeepCollectionEquality()
                .equals(other._filterTitles, _filterTitles) &&
            const DeepCollectionEquality()
                .equals(other._sectionTitles, _sectionTitles) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      filter,
      counts,
      sectionCounts,
      totalUnread,
      const DeepCollectionEquality().hash(_filterTitles),
      const DeepCollectionEquality().hash(_sectionTitles),
      const DeepCollectionEquality().hash(_items),
      meta);

  /// Create a copy of InboxDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InboxDataModelImplCopyWith<_$InboxDataModelImpl> get copyWith =>
      __$$InboxDataModelImplCopyWithImpl<_$InboxDataModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InboxDataModelImplToJson(
      this,
    );
  }
}

abstract class _InboxDataModel implements InboxDataModel {
  const factory _InboxDataModel(
      {final String? filter,
      final InboxCountsModel? counts,
      @JsonKey(name: 'section_counts')
      final InboxSectionCountsModel? sectionCounts,
      @JsonKey(name: 'total_unread', fromJson: _flexibleIntFromJson)
      final int? totalUnread,
      @JsonKey(name: 'filter_titles') final Map<String, String>? filterTitles,
      @JsonKey(name: 'section_titles') final Map<String, String>? sectionTitles,
      final List<InboxItemModel>? items,
      final InboxPaginatorMetaModel? meta}) = _$InboxDataModelImpl;

  factory _InboxDataModel.fromJson(Map<String, dynamic> json) =
      _$InboxDataModelImpl.fromJson;

  @override
  String? get filter;
  @override
  InboxCountsModel? get counts;
  @override
  @JsonKey(name: 'section_counts')
  InboxSectionCountsModel? get sectionCounts;
  @override
  @JsonKey(name: 'total_unread', fromJson: _flexibleIntFromJson)
  int? get totalUnread;

  /// Optional localized chip titles from API, e.g. `{"all":"All","doctors":"Doctors"}`.
  @override
  @JsonKey(name: 'filter_titles')
  Map<String, String>? get filterTitles;

  /// Optional section headers, e.g. `{"priority":"PRIORITY","earlier":"EARLIER"}`.
  @override
  @JsonKey(name: 'section_titles')
  Map<String, String>? get sectionTitles;
  @override
  List<InboxItemModel>? get items;
  @override
  InboxPaginatorMetaModel? get meta;

  /// Create a copy of InboxDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InboxDataModelImplCopyWith<_$InboxDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InboxCountsModel _$InboxCountsModelFromJson(Map<String, dynamic> json) {
  return _InboxCountsModel.fromJson(json);
}

/// @nodoc
mixin _$InboxCountsModel {
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get all => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get doctors => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get people => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get patients => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get groups => throw _privateConstructorUsedError;
  @JsonKey(name: 'social_groups', fromJson: _flexibleIntFromJson)
  int? get socialGroups => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get consults => throw _privateConstructorUsedError;

  /// Serializes this InboxCountsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InboxCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InboxCountsModelCopyWith<InboxCountsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InboxCountsModelCopyWith<$Res> {
  factory $InboxCountsModelCopyWith(
          InboxCountsModel value, $Res Function(InboxCountsModel) then) =
      _$InboxCountsModelCopyWithImpl<$Res, InboxCountsModel>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _flexibleIntFromJson) int? all,
      @JsonKey(fromJson: _flexibleIntFromJson) int? doctors,
      @JsonKey(fromJson: _flexibleIntFromJson) int? people,
      @JsonKey(fromJson: _flexibleIntFromJson) int? patients,
      @JsonKey(fromJson: _flexibleIntFromJson) int? groups,
      @JsonKey(name: 'social_groups', fromJson: _flexibleIntFromJson)
      int? socialGroups,
      @JsonKey(fromJson: _flexibleIntFromJson) int? consults});
}

/// @nodoc
class _$InboxCountsModelCopyWithImpl<$Res, $Val extends InboxCountsModel>
    implements $InboxCountsModelCopyWith<$Res> {
  _$InboxCountsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InboxCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = freezed,
    Object? doctors = freezed,
    Object? people = freezed,
    Object? patients = freezed,
    Object? groups = freezed,
    Object? socialGroups = freezed,
    Object? consults = freezed,
  }) {
    return _then(_value.copyWith(
      all: freezed == all
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as int?,
      doctors: freezed == doctors
          ? _value.doctors
          : doctors // ignore: cast_nullable_to_non_nullable
              as int?,
      people: freezed == people
          ? _value.people
          : people // ignore: cast_nullable_to_non_nullable
              as int?,
      patients: freezed == patients
          ? _value.patients
          : patients // ignore: cast_nullable_to_non_nullable
              as int?,
      groups: freezed == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as int?,
      socialGroups: freezed == socialGroups
          ? _value.socialGroups
          : socialGroups // ignore: cast_nullable_to_non_nullable
              as int?,
      consults: freezed == consults
          ? _value.consults
          : consults // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InboxCountsModelImplCopyWith<$Res>
    implements $InboxCountsModelCopyWith<$Res> {
  factory _$$InboxCountsModelImplCopyWith(_$InboxCountsModelImpl value,
          $Res Function(_$InboxCountsModelImpl) then) =
      __$$InboxCountsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _flexibleIntFromJson) int? all,
      @JsonKey(fromJson: _flexibleIntFromJson) int? doctors,
      @JsonKey(fromJson: _flexibleIntFromJson) int? people,
      @JsonKey(fromJson: _flexibleIntFromJson) int? patients,
      @JsonKey(fromJson: _flexibleIntFromJson) int? groups,
      @JsonKey(name: 'social_groups', fromJson: _flexibleIntFromJson)
      int? socialGroups,
      @JsonKey(fromJson: _flexibleIntFromJson) int? consults});
}

/// @nodoc
class __$$InboxCountsModelImplCopyWithImpl<$Res>
    extends _$InboxCountsModelCopyWithImpl<$Res, _$InboxCountsModelImpl>
    implements _$$InboxCountsModelImplCopyWith<$Res> {
  __$$InboxCountsModelImplCopyWithImpl(_$InboxCountsModelImpl _value,
      $Res Function(_$InboxCountsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of InboxCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = freezed,
    Object? doctors = freezed,
    Object? people = freezed,
    Object? patients = freezed,
    Object? groups = freezed,
    Object? socialGroups = freezed,
    Object? consults = freezed,
  }) {
    return _then(_$InboxCountsModelImpl(
      all: freezed == all
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as int?,
      doctors: freezed == doctors
          ? _value.doctors
          : doctors // ignore: cast_nullable_to_non_nullable
              as int?,
      people: freezed == people
          ? _value.people
          : people // ignore: cast_nullable_to_non_nullable
              as int?,
      patients: freezed == patients
          ? _value.patients
          : patients // ignore: cast_nullable_to_non_nullable
              as int?,
      groups: freezed == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as int?,
      socialGroups: freezed == socialGroups
          ? _value.socialGroups
          : socialGroups // ignore: cast_nullable_to_non_nullable
              as int?,
      consults: freezed == consults
          ? _value.consults
          : consults // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InboxCountsModelImpl implements _InboxCountsModel {
  const _$InboxCountsModelImpl(
      {@JsonKey(fromJson: _flexibleIntFromJson) this.all,
      @JsonKey(fromJson: _flexibleIntFromJson) this.doctors,
      @JsonKey(fromJson: _flexibleIntFromJson) this.people,
      @JsonKey(fromJson: _flexibleIntFromJson) this.patients,
      @JsonKey(fromJson: _flexibleIntFromJson) this.groups,
      @JsonKey(name: 'social_groups', fromJson: _flexibleIntFromJson)
      this.socialGroups,
      @JsonKey(fromJson: _flexibleIntFromJson) this.consults});

  factory _$InboxCountsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InboxCountsModelImplFromJson(json);

  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? all;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? doctors;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? people;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? patients;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? groups;
  @override
  @JsonKey(name: 'social_groups', fromJson: _flexibleIntFromJson)
  final int? socialGroups;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? consults;

  @override
  String toString() {
    return 'InboxCountsModel(all: $all, doctors: $doctors, people: $people, patients: $patients, groups: $groups, socialGroups: $socialGroups, consults: $consults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InboxCountsModelImpl &&
            (identical(other.all, all) || other.all == all) &&
            (identical(other.doctors, doctors) || other.doctors == doctors) &&
            (identical(other.people, people) || other.people == people) &&
            (identical(other.patients, patients) ||
                other.patients == patients) &&
            (identical(other.groups, groups) || other.groups == groups) &&
            (identical(other.socialGroups, socialGroups) ||
                other.socialGroups == socialGroups) &&
            (identical(other.consults, consults) ||
                other.consults == consults));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, all, doctors, people, patients,
      groups, socialGroups, consults);

  /// Create a copy of InboxCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InboxCountsModelImplCopyWith<_$InboxCountsModelImpl> get copyWith =>
      __$$InboxCountsModelImplCopyWithImpl<_$InboxCountsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InboxCountsModelImplToJson(
      this,
    );
  }
}

abstract class _InboxCountsModel implements InboxCountsModel {
  const factory _InboxCountsModel(
          {@JsonKey(fromJson: _flexibleIntFromJson) final int? all,
          @JsonKey(fromJson: _flexibleIntFromJson) final int? doctors,
          @JsonKey(fromJson: _flexibleIntFromJson) final int? people,
          @JsonKey(fromJson: _flexibleIntFromJson) final int? patients,
          @JsonKey(fromJson: _flexibleIntFromJson) final int? groups,
          @JsonKey(name: 'social_groups', fromJson: _flexibleIntFromJson)
          final int? socialGroups,
          @JsonKey(fromJson: _flexibleIntFromJson) final int? consults}) =
      _$InboxCountsModelImpl;

  factory _InboxCountsModel.fromJson(Map<String, dynamic> json) =
      _$InboxCountsModelImpl.fromJson;

  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get all;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get doctors;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get people;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get patients;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get groups;
  @override
  @JsonKey(name: 'social_groups', fromJson: _flexibleIntFromJson)
  int? get socialGroups;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get consults;

  /// Create a copy of InboxCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InboxCountsModelImplCopyWith<_$InboxCountsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InboxSectionCountsModel _$InboxSectionCountsModelFromJson(
    Map<String, dynamic> json) {
  return _InboxSectionCountsModel.fromJson(json);
}

/// @nodoc
mixin _$InboxSectionCountsModel {
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get priority => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get earlier => throw _privateConstructorUsedError;

  /// Serializes this InboxSectionCountsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InboxSectionCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InboxSectionCountsModelCopyWith<InboxSectionCountsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InboxSectionCountsModelCopyWith<$Res> {
  factory $InboxSectionCountsModelCopyWith(InboxSectionCountsModel value,
          $Res Function(InboxSectionCountsModel) then) =
      _$InboxSectionCountsModelCopyWithImpl<$Res, InboxSectionCountsModel>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _flexibleIntFromJson) int? priority,
      @JsonKey(fromJson: _flexibleIntFromJson) int? earlier});
}

/// @nodoc
class _$InboxSectionCountsModelCopyWithImpl<$Res,
        $Val extends InboxSectionCountsModel>
    implements $InboxSectionCountsModelCopyWith<$Res> {
  _$InboxSectionCountsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InboxSectionCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = freezed,
    Object? earlier = freezed,
  }) {
    return _then(_value.copyWith(
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      earlier: freezed == earlier
          ? _value.earlier
          : earlier // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InboxSectionCountsModelImplCopyWith<$Res>
    implements $InboxSectionCountsModelCopyWith<$Res> {
  factory _$$InboxSectionCountsModelImplCopyWith(
          _$InboxSectionCountsModelImpl value,
          $Res Function(_$InboxSectionCountsModelImpl) then) =
      __$$InboxSectionCountsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _flexibleIntFromJson) int? priority,
      @JsonKey(fromJson: _flexibleIntFromJson) int? earlier});
}

/// @nodoc
class __$$InboxSectionCountsModelImplCopyWithImpl<$Res>
    extends _$InboxSectionCountsModelCopyWithImpl<$Res,
        _$InboxSectionCountsModelImpl>
    implements _$$InboxSectionCountsModelImplCopyWith<$Res> {
  __$$InboxSectionCountsModelImplCopyWithImpl(
      _$InboxSectionCountsModelImpl _value,
      $Res Function(_$InboxSectionCountsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of InboxSectionCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = freezed,
    Object? earlier = freezed,
  }) {
    return _then(_$InboxSectionCountsModelImpl(
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      earlier: freezed == earlier
          ? _value.earlier
          : earlier // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InboxSectionCountsModelImpl implements _InboxSectionCountsModel {
  const _$InboxSectionCountsModelImpl(
      {@JsonKey(fromJson: _flexibleIntFromJson) this.priority,
      @JsonKey(fromJson: _flexibleIntFromJson) this.earlier});

  factory _$InboxSectionCountsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InboxSectionCountsModelImplFromJson(json);

  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? priority;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? earlier;

  @override
  String toString() {
    return 'InboxSectionCountsModel(priority: $priority, earlier: $earlier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InboxSectionCountsModelImpl &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.earlier, earlier) || other.earlier == earlier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, priority, earlier);

  /// Create a copy of InboxSectionCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InboxSectionCountsModelImplCopyWith<_$InboxSectionCountsModelImpl>
      get copyWith => __$$InboxSectionCountsModelImplCopyWithImpl<
          _$InboxSectionCountsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InboxSectionCountsModelImplToJson(
      this,
    );
  }
}

abstract class _InboxSectionCountsModel implements InboxSectionCountsModel {
  const factory _InboxSectionCountsModel(
          {@JsonKey(fromJson: _flexibleIntFromJson) final int? priority,
          @JsonKey(fromJson: _flexibleIntFromJson) final int? earlier}) =
      _$InboxSectionCountsModelImpl;

  factory _InboxSectionCountsModel.fromJson(Map<String, dynamic> json) =
      _$InboxSectionCountsModelImpl.fromJson;

  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get priority;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get earlier;

  /// Create a copy of InboxSectionCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InboxSectionCountsModelImplCopyWith<_$InboxSectionCountsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InboxItemModel _$InboxItemModelFromJson(Map<String, dynamic> json) {
  return _InboxItemModel.fromJson(json);
}

/// @nodoc
mixin _$InboxItemModel {
  String? get source => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_type')
  String? get chatType => throw _privateConstructorUsedError;
  @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
  int? get contextId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  ChatUserModel? get counterpart => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_urgent', fromJson: _flexibleBoolFromJson)
  bool? get isUrgent => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count', fromJson: _flexibleIntFromJson)
  int? get unreadCount => throw _privateConstructorUsedError;
  String? get section => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message')
  InboxLastMessageModel? get lastMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_open', fromJson: _flexibleBoolFromJson)
  bool? get isOpen => throw _privateConstructorUsedError;
  String? get direction => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_activity_at')
  String? get lastActivityAt => throw _privateConstructorUsedError;

  /// Serializes this InboxItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InboxItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InboxItemModelCopyWith<InboxItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InboxItemModelCopyWith<$Res> {
  factory $InboxItemModelCopyWith(
          InboxItemModel value, $Res Function(InboxItemModel) then) =
      _$InboxItemModelCopyWithImpl<$Res, InboxItemModel>;
  @useResult
  $Res call(
      {String? source,
      int? id,
      @JsonKey(name: 'chat_type') String? chatType,
      @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
      int? contextId,
      String? title,
      String? subtitle,
      ChatUserModel? counterpart,
      String? image,
      @JsonKey(name: 'is_urgent', fromJson: _flexibleBoolFromJson)
      bool? isUrgent,
      @JsonKey(name: 'unread_count', fromJson: _flexibleIntFromJson)
      int? unreadCount,
      String? section,
      @JsonKey(name: 'last_message') InboxLastMessageModel? lastMessage,
      @JsonKey(name: 'is_open', fromJson: _flexibleBoolFromJson) bool? isOpen,
      String? direction,
      @JsonKey(name: 'last_activity_at') String? lastActivityAt});

  $ChatUserModelCopyWith<$Res>? get counterpart;
  $InboxLastMessageModelCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$InboxItemModelCopyWithImpl<$Res, $Val extends InboxItemModel>
    implements $InboxItemModelCopyWith<$Res> {
  _$InboxItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InboxItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? id = freezed,
    Object? chatType = freezed,
    Object? contextId = freezed,
    Object? title = freezed,
    Object? subtitle = freezed,
    Object? counterpart = freezed,
    Object? image = freezed,
    Object? isUrgent = freezed,
    Object? unreadCount = freezed,
    Object? section = freezed,
    Object? lastMessage = freezed,
    Object? isOpen = freezed,
    Object? direction = freezed,
    Object? lastActivityAt = freezed,
  }) {
    return _then(_value.copyWith(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      chatType: freezed == chatType
          ? _value.chatType
          : chatType // ignore: cast_nullable_to_non_nullable
              as String?,
      contextId: freezed == contextId
          ? _value.contextId
          : contextId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      counterpart: freezed == counterpart
          ? _value.counterpart
          : counterpart // ignore: cast_nullable_to_non_nullable
              as ChatUserModel?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isUrgent: freezed == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as InboxLastMessageModel?,
      isOpen: freezed == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String?,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of InboxItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatUserModelCopyWith<$Res>? get counterpart {
    if (_value.counterpart == null) {
      return null;
    }

    return $ChatUserModelCopyWith<$Res>(_value.counterpart!, (value) {
      return _then(_value.copyWith(counterpart: value) as $Val);
    });
  }

  /// Create a copy of InboxItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InboxLastMessageModelCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $InboxLastMessageModelCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InboxItemModelImplCopyWith<$Res>
    implements $InboxItemModelCopyWith<$Res> {
  factory _$$InboxItemModelImplCopyWith(_$InboxItemModelImpl value,
          $Res Function(_$InboxItemModelImpl) then) =
      __$$InboxItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? source,
      int? id,
      @JsonKey(name: 'chat_type') String? chatType,
      @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
      int? contextId,
      String? title,
      String? subtitle,
      ChatUserModel? counterpart,
      String? image,
      @JsonKey(name: 'is_urgent', fromJson: _flexibleBoolFromJson)
      bool? isUrgent,
      @JsonKey(name: 'unread_count', fromJson: _flexibleIntFromJson)
      int? unreadCount,
      String? section,
      @JsonKey(name: 'last_message') InboxLastMessageModel? lastMessage,
      @JsonKey(name: 'is_open', fromJson: _flexibleBoolFromJson) bool? isOpen,
      String? direction,
      @JsonKey(name: 'last_activity_at') String? lastActivityAt});

  @override
  $ChatUserModelCopyWith<$Res>? get counterpart;
  @override
  $InboxLastMessageModelCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$InboxItemModelImplCopyWithImpl<$Res>
    extends _$InboxItemModelCopyWithImpl<$Res, _$InboxItemModelImpl>
    implements _$$InboxItemModelImplCopyWith<$Res> {
  __$$InboxItemModelImplCopyWithImpl(
      _$InboxItemModelImpl _value, $Res Function(_$InboxItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of InboxItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? id = freezed,
    Object? chatType = freezed,
    Object? contextId = freezed,
    Object? title = freezed,
    Object? subtitle = freezed,
    Object? counterpart = freezed,
    Object? image = freezed,
    Object? isUrgent = freezed,
    Object? unreadCount = freezed,
    Object? section = freezed,
    Object? lastMessage = freezed,
    Object? isOpen = freezed,
    Object? direction = freezed,
    Object? lastActivityAt = freezed,
  }) {
    return _then(_$InboxItemModelImpl(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      chatType: freezed == chatType
          ? _value.chatType
          : chatType // ignore: cast_nullable_to_non_nullable
              as String?,
      contextId: freezed == contextId
          ? _value.contextId
          : contextId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      counterpart: freezed == counterpart
          ? _value.counterpart
          : counterpart // ignore: cast_nullable_to_non_nullable
              as ChatUserModel?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isUrgent: freezed == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as InboxLastMessageModel?,
      isOpen: freezed == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String?,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InboxItemModelImpl implements _InboxItemModel {
  const _$InboxItemModelImpl(
      {this.source,
      this.id,
      @JsonKey(name: 'chat_type') this.chatType,
      @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
      this.contextId,
      this.title,
      this.subtitle,
      this.counterpart,
      this.image,
      @JsonKey(name: 'is_urgent', fromJson: _flexibleBoolFromJson)
      this.isUrgent,
      @JsonKey(name: 'unread_count', fromJson: _flexibleIntFromJson)
      this.unreadCount,
      this.section,
      @JsonKey(name: 'last_message') this.lastMessage,
      @JsonKey(name: 'is_open', fromJson: _flexibleBoolFromJson) this.isOpen,
      this.direction,
      @JsonKey(name: 'last_activity_at') this.lastActivityAt});

  factory _$InboxItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InboxItemModelImplFromJson(json);

  @override
  final String? source;
  @override
  final int? id;
  @override
  @JsonKey(name: 'chat_type')
  final String? chatType;
  @override
  @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
  final int? contextId;
  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final ChatUserModel? counterpart;
  @override
  final String? image;
  @override
  @JsonKey(name: 'is_urgent', fromJson: _flexibleBoolFromJson)
  final bool? isUrgent;
  @override
  @JsonKey(name: 'unread_count', fromJson: _flexibleIntFromJson)
  final int? unreadCount;
  @override
  final String? section;
  @override
  @JsonKey(name: 'last_message')
  final InboxLastMessageModel? lastMessage;
  @override
  @JsonKey(name: 'is_open', fromJson: _flexibleBoolFromJson)
  final bool? isOpen;
  @override
  final String? direction;
  @override
  @JsonKey(name: 'last_activity_at')
  final String? lastActivityAt;

  @override
  String toString() {
    return 'InboxItemModel(source: $source, id: $id, chatType: $chatType, contextId: $contextId, title: $title, subtitle: $subtitle, counterpart: $counterpart, image: $image, isUrgent: $isUrgent, unreadCount: $unreadCount, section: $section, lastMessage: $lastMessage, isOpen: $isOpen, direction: $direction, lastActivityAt: $lastActivityAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InboxItemModelImpl &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatType, chatType) ||
                other.chatType == chatType) &&
            (identical(other.contextId, contextId) ||
                other.contextId == contextId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.counterpart, counterpart) ||
                other.counterpart == counterpart) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      source,
      id,
      chatType,
      contextId,
      title,
      subtitle,
      counterpart,
      image,
      isUrgent,
      unreadCount,
      section,
      lastMessage,
      isOpen,
      direction,
      lastActivityAt);

  /// Create a copy of InboxItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InboxItemModelImplCopyWith<_$InboxItemModelImpl> get copyWith =>
      __$$InboxItemModelImplCopyWithImpl<_$InboxItemModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InboxItemModelImplToJson(
      this,
    );
  }
}

abstract class _InboxItemModel implements InboxItemModel {
  const factory _InboxItemModel(
      {final String? source,
      final int? id,
      @JsonKey(name: 'chat_type') final String? chatType,
      @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
      final int? contextId,
      final String? title,
      final String? subtitle,
      final ChatUserModel? counterpart,
      final String? image,
      @JsonKey(name: 'is_urgent', fromJson: _flexibleBoolFromJson)
      final bool? isUrgent,
      @JsonKey(name: 'unread_count', fromJson: _flexibleIntFromJson)
      final int? unreadCount,
      final String? section,
      @JsonKey(name: 'last_message') final InboxLastMessageModel? lastMessage,
      @JsonKey(name: 'is_open', fromJson: _flexibleBoolFromJson)
      final bool? isOpen,
      final String? direction,
      @JsonKey(name: 'last_activity_at')
      final String? lastActivityAt}) = _$InboxItemModelImpl;

  factory _InboxItemModel.fromJson(Map<String, dynamic> json) =
      _$InboxItemModelImpl.fromJson;

  @override
  String? get source;
  @override
  int? get id;
  @override
  @JsonKey(name: 'chat_type')
  String? get chatType;
  @override
  @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
  int? get contextId;
  @override
  String? get title;
  @override
  String? get subtitle;
  @override
  ChatUserModel? get counterpart;
  @override
  String? get image;
  @override
  @JsonKey(name: 'is_urgent', fromJson: _flexibleBoolFromJson)
  bool? get isUrgent;
  @override
  @JsonKey(name: 'unread_count', fromJson: _flexibleIntFromJson)
  int? get unreadCount;
  @override
  String? get section;
  @override
  @JsonKey(name: 'last_message')
  InboxLastMessageModel? get lastMessage;
  @override
  @JsonKey(name: 'is_open', fromJson: _flexibleBoolFromJson)
  bool? get isOpen;
  @override
  String? get direction;
  @override
  @JsonKey(name: 'last_activity_at')
  String? get lastActivityAt;

  /// Create a copy of InboxItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InboxItemModelImplCopyWith<_$InboxItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InboxLastMessageModel _$InboxLastMessageModelFromJson(
    Map<String, dynamic> json) {
  return _InboxLastMessageModel.fromJson(json);
}

/// @nodoc
mixin _$InboxLastMessageModel {
  int? get id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson)
  int? get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_mine', fromJson: _flexibleBoolFromJson)
  bool? get isMine => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  List<ChatAttachmentModel>? get attachments =>
      throw _privateConstructorUsedError;

  /// Serializes this InboxLastMessageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InboxLastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InboxLastMessageModelCopyWith<InboxLastMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InboxLastMessageModelCopyWith<$Res> {
  factory $InboxLastMessageModelCopyWith(InboxLastMessageModel value,
          $Res Function(InboxLastMessageModel) then) =
      _$InboxLastMessageModelCopyWithImpl<$Res, InboxLastMessageModel>;
  @useResult
  $Res call(
      {int? id,
      String? type,
      String? content,
      @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson) int? senderId,
      @JsonKey(name: 'is_mine', fromJson: _flexibleBoolFromJson) bool? isMine,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt,
      List<ChatAttachmentModel>? attachments});
}

/// @nodoc
class _$InboxLastMessageModelCopyWithImpl<$Res,
        $Val extends InboxLastMessageModel>
    implements $InboxLastMessageModelCopyWith<$Res> {
  _$InboxLastMessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InboxLastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? content = freezed,
    Object? senderId = freezed,
    Object? isMine = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? attachments = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      isMine: freezed == isMine
          ? _value.isMine
          : isMine // ignore: cast_nullable_to_non_nullable
              as bool?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<ChatAttachmentModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InboxLastMessageModelImplCopyWith<$Res>
    implements $InboxLastMessageModelCopyWith<$Res> {
  factory _$$InboxLastMessageModelImplCopyWith(
          _$InboxLastMessageModelImpl value,
          $Res Function(_$InboxLastMessageModelImpl) then) =
      __$$InboxLastMessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? type,
      String? content,
      @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson) int? senderId,
      @JsonKey(name: 'is_mine', fromJson: _flexibleBoolFromJson) bool? isMine,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt,
      List<ChatAttachmentModel>? attachments});
}

/// @nodoc
class __$$InboxLastMessageModelImplCopyWithImpl<$Res>
    extends _$InboxLastMessageModelCopyWithImpl<$Res,
        _$InboxLastMessageModelImpl>
    implements _$$InboxLastMessageModelImplCopyWith<$Res> {
  __$$InboxLastMessageModelImplCopyWithImpl(_$InboxLastMessageModelImpl _value,
      $Res Function(_$InboxLastMessageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of InboxLastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? content = freezed,
    Object? senderId = freezed,
    Object? isMine = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? attachments = freezed,
  }) {
    return _then(_$InboxLastMessageModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      isMine: freezed == isMine
          ? _value.isMine
          : isMine // ignore: cast_nullable_to_non_nullable
              as bool?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<ChatAttachmentModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InboxLastMessageModelImpl implements _InboxLastMessageModel {
  const _$InboxLastMessageModelImpl(
      {this.id,
      this.type,
      this.content,
      @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson) this.senderId,
      @JsonKey(name: 'is_mine', fromJson: _flexibleBoolFromJson) this.isMine,
      this.status,
      @JsonKey(name: 'created_at') this.createdAt,
      final List<ChatAttachmentModel>? attachments})
      : _attachments = attachments;

  factory _$InboxLastMessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InboxLastMessageModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? type;
  @override
  final String? content;
  @override
  @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson)
  final int? senderId;
  @override
  @JsonKey(name: 'is_mine', fromJson: _flexibleBoolFromJson)
  final bool? isMine;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final List<ChatAttachmentModel>? _attachments;
  @override
  List<ChatAttachmentModel>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'InboxLastMessageModel(id: $id, type: $type, content: $content, senderId: $senderId, isMine: $isMine, status: $status, createdAt: $createdAt, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InboxLastMessageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.isMine, isMine) || other.isMine == isMine) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      content,
      senderId,
      isMine,
      status,
      createdAt,
      const DeepCollectionEquality().hash(_attachments));

  /// Create a copy of InboxLastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InboxLastMessageModelImplCopyWith<_$InboxLastMessageModelImpl>
      get copyWith => __$$InboxLastMessageModelImplCopyWithImpl<
          _$InboxLastMessageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InboxLastMessageModelImplToJson(
      this,
    );
  }
}

abstract class _InboxLastMessageModel implements InboxLastMessageModel {
  const factory _InboxLastMessageModel(
          {final int? id,
          final String? type,
          final String? content,
          @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson)
          final int? senderId,
          @JsonKey(name: 'is_mine', fromJson: _flexibleBoolFromJson)
          final bool? isMine,
          final String? status,
          @JsonKey(name: 'created_at') final String? createdAt,
          final List<ChatAttachmentModel>? attachments}) =
      _$InboxLastMessageModelImpl;

  factory _InboxLastMessageModel.fromJson(Map<String, dynamic> json) =
      _$InboxLastMessageModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get type;
  @override
  String? get content;
  @override
  @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson)
  int? get senderId;
  @override
  @JsonKey(name: 'is_mine', fromJson: _flexibleBoolFromJson)
  bool? get isMine;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  List<ChatAttachmentModel>? get attachments;

  /// Create a copy of InboxLastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InboxLastMessageModelImplCopyWith<_$InboxLastMessageModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InboxPaginatorMetaModel _$InboxPaginatorMetaModelFromJson(
    Map<String, dynamic> json) {
  return _InboxPaginatorMetaModel.fromJson(json);
}

/// @nodoc
mixin _$InboxPaginatorMetaModel {
  @JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
  int? get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson)
  int? get perPage => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
  int? get lastPage => throw _privateConstructorUsedError;

  /// Serializes this InboxPaginatorMetaModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InboxPaginatorMetaModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InboxPaginatorMetaModelCopyWith<InboxPaginatorMetaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InboxPaginatorMetaModelCopyWith<$Res> {
  factory $InboxPaginatorMetaModelCopyWith(InboxPaginatorMetaModel value,
          $Res Function(InboxPaginatorMetaModel) then) =
      _$InboxPaginatorMetaModelCopyWithImpl<$Res, InboxPaginatorMetaModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
      int? currentPage,
      @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson) int? perPage,
      @JsonKey(fromJson: _flexibleIntFromJson) int? total,
      @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
      int? lastPage});
}

/// @nodoc
class _$InboxPaginatorMetaModelCopyWithImpl<$Res,
        $Val extends InboxPaginatorMetaModel>
    implements $InboxPaginatorMetaModelCopyWith<$Res> {
  _$InboxPaginatorMetaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InboxPaginatorMetaModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
    Object? lastPage = freezed,
  }) {
    return _then(_value.copyWith(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InboxPaginatorMetaModelImplCopyWith<$Res>
    implements $InboxPaginatorMetaModelCopyWith<$Res> {
  factory _$$InboxPaginatorMetaModelImplCopyWith(
          _$InboxPaginatorMetaModelImpl value,
          $Res Function(_$InboxPaginatorMetaModelImpl) then) =
      __$$InboxPaginatorMetaModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
      int? currentPage,
      @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson) int? perPage,
      @JsonKey(fromJson: _flexibleIntFromJson) int? total,
      @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
      int? lastPage});
}

/// @nodoc
class __$$InboxPaginatorMetaModelImplCopyWithImpl<$Res>
    extends _$InboxPaginatorMetaModelCopyWithImpl<$Res,
        _$InboxPaginatorMetaModelImpl>
    implements _$$InboxPaginatorMetaModelImplCopyWith<$Res> {
  __$$InboxPaginatorMetaModelImplCopyWithImpl(
      _$InboxPaginatorMetaModelImpl _value,
      $Res Function(_$InboxPaginatorMetaModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of InboxPaginatorMetaModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
    Object? lastPage = freezed,
  }) {
    return _then(_$InboxPaginatorMetaModelImpl(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InboxPaginatorMetaModelImpl implements _InboxPaginatorMetaModel {
  const _$InboxPaginatorMetaModelImpl(
      {@JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
      this.currentPage,
      @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson) this.perPage,
      @JsonKey(fromJson: _flexibleIntFromJson) this.total,
      @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
      this.lastPage});

  factory _$InboxPaginatorMetaModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InboxPaginatorMetaModelImplFromJson(json);

  @override
  @JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
  final int? currentPage;
  @override
  @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson)
  final int? perPage;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? total;
  @override
  @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
  final int? lastPage;

  @override
  String toString() {
    return 'InboxPaginatorMetaModel(currentPage: $currentPage, perPage: $perPage, total: $total, lastPage: $lastPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InboxPaginatorMetaModelImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentPage, perPage, total, lastPage);

  /// Create a copy of InboxPaginatorMetaModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InboxPaginatorMetaModelImplCopyWith<_$InboxPaginatorMetaModelImpl>
      get copyWith => __$$InboxPaginatorMetaModelImplCopyWithImpl<
          _$InboxPaginatorMetaModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InboxPaginatorMetaModelImplToJson(
      this,
    );
  }
}

abstract class _InboxPaginatorMetaModel implements InboxPaginatorMetaModel {
  const factory _InboxPaginatorMetaModel(
      {@JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
      final int? currentPage,
      @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson)
      final int? perPage,
      @JsonKey(fromJson: _flexibleIntFromJson) final int? total,
      @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
      final int? lastPage}) = _$InboxPaginatorMetaModelImpl;

  factory _InboxPaginatorMetaModel.fromJson(Map<String, dynamic> json) =
      _$InboxPaginatorMetaModelImpl.fromJson;

  @override
  @JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
  int? get currentPage;
  @override
  @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson)
  int? get perPage;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get total;
  @override
  @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
  int? get lastPage;

  /// Create a copy of InboxPaginatorMetaModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InboxPaginatorMetaModelImplCopyWith<_$InboxPaginatorMetaModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
