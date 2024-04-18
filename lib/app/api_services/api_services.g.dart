// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_services.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiServices implements ApiServices {
  _ApiServices(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://egyakin.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SignOutModelResponse> signOut() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SignOutModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/logout',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SignOutModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthenticationModelResponse> signIn(
    String email,
    String password,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AuthenticationModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthenticationModelResponse> register(
      Map<String, dynamic> doctorModel) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(doctorModel);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AuthenticationModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllBasPatientstModelResponse> getAllPatients(String token) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllBasPatientstModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/allPatients',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetAllBasPatientstModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCurrentPatientstModelResponse> getCurrentPatients(
      String token) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCurrentPatientstModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/currentPatients',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetCurrentPatientstModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllBasPatientstModelResponse> searchHome(
      String searchContent) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllBasPatientstModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/patient/search/${searchContent}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetAllBasPatientstModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetDoctorModelResponse> updateProfile(
    int doctorID,
    String firstName,
    String lastName,
    String email,
    String age,
    String specialty,
    String workingPlace,
    String phone,
    String job,
    String highestDegree,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'name': firstName,
      'lname': lastName,
      'email': email,
      'age': age,
      'specialty': specialty,
      'workingplace': workingPlace,
      'phone': phone,
      'job': job,
      'highestdegree': highestDegree,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetDoctorModelResponse>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/users/${doctorID}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetDoctorModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetBaseSectionsModelResponse> getPatientSections(
      String patientId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetBaseSectionsModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/section/${patientId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetBaseSectionsModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetQuestionsModelResponse> getSectionDetails(
    String sectionId,
    String patientId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetQuestionsModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/questions/${sectionId}/${patientId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetQuestionsModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeletePatientModelResponse> deletePatient(String patientId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeletePatientModelResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/patientHistory/${patientId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DeletePatientModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateSectionDetailsModelResponse> updateSectionDetails(
    String sectionId,
    String patientId,
    Map<String, dynamic> map,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateSectionDetailsModelResponse>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/section/${sectionId}/${patientId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UpdateSectionDetailsModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetPatientHistoryForAddPatientModelResponse>
      getPatientHistoryForAddPatient(String sectionId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPatientHistoryForAddPatientModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/questions/${sectionId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        GetPatientHistoryForAddPatientModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SemiPatientModel> addPatientForFirstTime(
      Map<String, dynamic> map) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SemiPatientModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/patientHistory',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SemiPatientModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddOutcometModelResponse> submitOutcome(
    String patientId,
    String outcomeOfThePatient,
    String creatinineOnDischarge,
    String durationField,
    String finalStatus,
    String other,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'patient_id': patientId,
      'outcome_of_the_patient': outcomeOfThePatient,
      'creatinine_on_discharge': creatinineOnDischarge,
      'duration_of_admission': durationField,
      'final_status': finalStatus,
      'other': other,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddOutcometModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/outcome',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AddOutcometModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetOutcomeModelResponse> getOutcome(String patientId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetOutcomeModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/outcome/${patientId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetOutcomeModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateSectionDetailsModelResponse> finalSubmit(
      String patientId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateSectionDetailsModelResponse>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/section/${patientId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UpdateSectionDetailsModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCommentstModelResponse> getComments(String patientId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCommentstModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/comment/${patientId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetCommentstModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddCommentModelResponse> addComment(
    String patientId,
    String content,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'patient_id': patientId,
      'content': content,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddCommentModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/comment',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AddCommentModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteCommentModelResponse> deleteComment(String commentId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteCommentModelResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/comment/${commentId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DeleteCommentModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddContactUsModelResponse> addContactUs(String message) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'message': message};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddContactUsModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/contact',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AddContactUsModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetPostsModelResponse> getHomePosts() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPostsModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/post',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetPostsModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostCommentsModelResponse> getPostComments(String postId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostCommentsModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/Postcomments/${postId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PostCommentsModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeletePostCommentModelResponse> deletePostComment(
      String commentId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeletePostCommentModelResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/Postcomments/${commentId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DeletePostCommentModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllNotificationsModelResponse> getAllNotifications(
      int pageNumber) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': pageNumber};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllNotificationsModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/shownotification',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetAllNotificationsModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateNotificationModelResponse> updateNotifications() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateNotificationModelResponse>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/notification',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UpdateNotificationModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddCommentOnPostModelResponse> addCommentOnPost(
    String postId,
    String content,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'post_id': postId,
      'content': content,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddCommentOnPostModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/Postcomments',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AddCommentOnPostModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResetPasswordModelResponse> sendEmailForForgetPassword(
      String email) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResetPasswordModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/forgotpassword',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResetPasswordModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResetPasswordModelResponse> verifyOTP(
    String email,
    String otp,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'otp': otp,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResetPasswordModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/resetpasswordverification',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResetPasswordModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResetPasswordModelResponse> changePassword(
    String email,
    String newPassword,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': newPassword,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResetPasswordModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/resetpassword',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResetPasswordModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SendEmailForVerificationModelResponse> sendEmailVerification() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SendEmailForVerificationModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/sendverificationmail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SendEmailForVerificationModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SendOTPForEmailVerificationModelResponse> sendOTPForEmailVerification(
      String otp) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'otp': otp};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SendOTPForEmailVerificationModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/emailverification',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        SendOTPForEmailVerificationModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HomeModelResponse> getHome() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<HomeModelResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/home',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = HomeModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UploadProfileImageModelResponse> uploadProfileImage(File image) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(MapEntry(
      'image',
      MultipartFile.fromFileSync(
        image.path,
        filename: image.path.split(Platform.pathSeparator).last,
      ),
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UploadProfileImageModelResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'https://egyakin.com/api/upload-profile-image',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UploadProfileImageModelResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
