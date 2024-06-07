// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'download_patient_report_model_response.freezed.dart';
part 'download_patient_report_model_response.g.dart';

@freezed
class DownloadPatientReportModelResponse
    with _$DownloadPatientReportModelResponse {
  const factory DownloadPatientReportModelResponse({
    @JsonKey(name: 'pdf_url') String? pdfUrl,
  }) = _DownloadPatientReportModelResponse;
  factory DownloadPatientReportModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DownloadPatientReportModelResponseFromJson(json);
}
