class ItrState {
  final bool? submitClicked;
  final Map<String, dynamic>? dataMap;
  final bool? obscureText;

  ItrState({
    this.submitClicked,
    this.dataMap,
    this.obscureText,
  });

  ItrState copyWith({
    bool? submitClicked,
    Map<String, dynamic>? dataMap,
    bool? obscureText,
  }) {
    return ItrState(
      submitClicked: submitClicked ?? this.submitClicked,
      dataMap: dataMap ?? this.dataMap,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}
