class TimeRange {
  final int hFrom, hTo, mFrom, mTo;
  TimeRange({this.hFrom, this.hTo, this.mFrom, this.mTo});
  @override
  String toString() {
    return "$hFrom:$mFrom - $hTo:$mTo";
  }
}
