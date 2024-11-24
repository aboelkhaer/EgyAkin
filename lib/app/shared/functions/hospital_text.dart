hospitalText(dynamic hospital) {
  if (hospital == null) {
    return '';
  }
  if (hospital is String) {
    return hospital;
  }
  if (hospital is Map) {
    return hospital['answers'];
  }
}
