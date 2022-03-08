class FilterData {
  //
  final int filterId, groupId;
  final String name;
  bool isChecked;

  FilterData({
    this.filterId,
    this.groupId,
    this.name,
    this.isChecked = false,
  });

  factory FilterData.fromJson(Map<String, dynamic> json) {
    return FilterData(
      filterId: json['filter_id'],
      groupId: json['filter_group_id'],
      name: json['name'],
    );
  }
}
