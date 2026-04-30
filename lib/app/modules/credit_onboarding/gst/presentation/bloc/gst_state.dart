class GstState {
  final bool? submitClicked;
  final Map<String, dynamic>? dataMap;

  GstState({
    this.submitClicked,
    this.dataMap,
  });

  GstState copyWith({
    bool? submitClicked,
    Map<String, dynamic>? dataMap,
  }) {
    return GstState(
      submitClicked: submitClicked ?? this.submitClicked,
      dataMap: dataMap ?? this.dataMap,
    );
  }
}
