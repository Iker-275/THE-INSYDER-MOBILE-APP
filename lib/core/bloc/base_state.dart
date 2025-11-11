class BaseState<T> {
  final bool isLoading;
  final T? data;
  final String? error;

  const BaseState({this.isLoading = false, this.data, this.error});

  factory BaseState.initial() => const BaseState();
  factory BaseState.loading() => const BaseState(isLoading: true);
  factory BaseState.success(T data) => BaseState(data: data);
  factory BaseState.error(String error) => BaseState(error: error);
}
