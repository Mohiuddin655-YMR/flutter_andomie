part of 'sources.dart';

abstract class LocalDataSource<T extends Entity> {
  Future<Response<T>> clear<R>({
    R? Function(R parent)? source,
  });

  Future<Response<T>> delete<R>(
    String id, {
    R? Function(R parent)? source,
  });

  Future<Response<T>> get<R>(
    String id, {
    R? Function(R parent)? source,
  });

  Future<Response<T>> getUpdates<R>({
    R? Function(R parent)? source,
  });

  Future<Response<T>> gets<R>({
    R? Function(R parent)? source,
  });

  Future<Response<T>> insert<R>(
    T data, {
    R? Function(R parent)? source,
  });

  Future<Response<T>> inserts<R>(
    List<T> data, {
    R? Function(R parent)? source,
  });

  Future<Response<T>> isAvailable<R>(
    String id, {
    R? Function(R parent)? source,
  });

  Stream<Response<T>> live<R>(
    String id, {
    R? Function(R parent)? source,
  });

  Stream<Response<T>> lives<R>({
    R? Function(R parent)? source,
  });

  Future<Response<T>> update<R>(
    T data, {
    R? Function(R parent)? source,
  });

  T build(dynamic source);
}
