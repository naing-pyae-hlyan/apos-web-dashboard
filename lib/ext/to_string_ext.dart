extension ToStringExt on dynamic {
  String dynamicToString() => (this ?? '').toString();
}

