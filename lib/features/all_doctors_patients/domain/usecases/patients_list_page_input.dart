
class PatientsListPageInput {
  final int page;
  final String? sort;
  final String? direction;

  const PatientsListPageInput({
    required this.page,
    this.sort,
    this.direction,
  });
}
