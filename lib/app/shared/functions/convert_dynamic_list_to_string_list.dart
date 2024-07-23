List<String> convertDynamicListToStringList(List<dynamic> dynamicList) {
  List<String> stringList = [];
  for (var item in dynamicList) {
    stringList.add(item.toString());
  }
  return stringList;
}
