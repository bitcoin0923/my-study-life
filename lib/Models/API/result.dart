class Result<T> {
  Result._();

  factory Result.loading(T msg) = LoadingState<T>;

  factory Result.success(T value) = SuccessState<T>;

  factory Result.error(T msg) = ErrorState<T>;
}

class LoadingState<T> extends Result<T> {
  LoadingState(this.msg) : super._();
  final T msg;
}

class ErrorState<T> extends Result<T> {
  ErrorState(this.msg) : super._();
  final T msg;
}

class SuccessState<T> extends Result<T> {
  SuccessState(this.value) : super._();
  final T value;
}