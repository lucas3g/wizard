class DatesEntity {
  String _dateStart;
  String? _dateEnd;

  String get dateStart => _dateStart;
  void setDateStart(String value) => _dateStart = value;

  String get dateEnd => _dateEnd ?? '';
  void setDateEnd(String value) => _dateEnd = value;

  DatesEntity({required dateStart, dateEnd})
      : _dateStart = dateStart,
        _dateEnd = dateEnd;
}
