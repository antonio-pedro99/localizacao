class RequestResponse {
  Object? _data;
  Object? _error;

  Object? get data => _data;
  Object? get error => _error;

  set setData(Object? data) => _data = data;
  set setError(Object? error) => _error = error;

  bool get hasData => _data != null;
  bool get hasError => _error != null;
}
