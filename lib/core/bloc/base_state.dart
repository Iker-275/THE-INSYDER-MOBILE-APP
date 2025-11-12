class BaseState<T> {
  final bool isLoading;
  final T? data;
  final String? error;
  final BaseStatus status;

  const BaseState(
      {this.isLoading = false,
      this.data,
      this.error,
      this.status = BaseStatus.initial});

  factory BaseState.initial() => const BaseState(status: BaseStatus.initial);
  factory BaseState.loading() =>
      const BaseState(isLoading: true, status: BaseStatus.loading);
  factory BaseState.success(T data) =>
      BaseState(data: data, status: BaseStatus.success);
  factory BaseState.error(String error) =>
      BaseState(error: error, status: BaseStatus.error);
}

enum BaseStatus { initial, loading, success, error }
