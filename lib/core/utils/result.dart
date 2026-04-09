/// 统一结果类型
/// 对应 Kotlin: Result<T> / sealed class Resource<T>
///
/// 用法:
/// ```dart
/// final result = await repository.getAlerts();
/// switch (result) {
///   case Success(:final data): showAlerts(data);
///   case Failure(:final error): showError(error);
/// }
/// ```
sealed class Result<T> {
  const Result();

  factory Result.success(T data) = Success<T>;

  factory Result.failure(String error, {Object? exception}) =
      Failure<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => switch (this) {
        Success(:final data) => data,
        Failure() => null,
      };

  R when<R>({
    required R Function(T data) success,
    required R Function(String error, Object? exception) failure,
  }) =>
      switch (this) {
        Success(:final data) => success(data),
        Failure(:final error, :final exception) => failure(error, exception),
      };
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String error;
  final Object? exception;
  const Failure(this.error, {this.exception});
}
