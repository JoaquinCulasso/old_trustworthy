class DatabaseState {
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _lastError;
  String get lastError => this._lastError;

  void loading() {
    _isLoading = true;
    _isLoaded = false;
    _hasError = false;
  }

  void loaded() {
    _isLoaded = true;
    _isLoading = false;
    _hasError = false;
  }

  void error(lastError) {
    _hasError = true;
    _isLoading = false;
    _isLoaded = false;
    _lastError = lastError;
  }

  @override
  String toString() {
    return '''DatabaseState{
      _isLoaded: $_isLoaded,
      _isLoading: $_isLoading,
      _hasError: $_hasError,
    }''';
  }
}
