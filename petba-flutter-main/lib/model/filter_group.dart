class FilterGroupData {
  //
  final int groupId;
  final String name;

  bool selected;

  FilterGroupData({
    this.groupId,
    this.name,
    this.selected = false,
  });

  factory FilterGroupData.fromJson(Map<String, dynamic> json) {
    return FilterGroupData(
      groupId: json['filter_group_id'],
      name: json['name'],
    );
  }
}
