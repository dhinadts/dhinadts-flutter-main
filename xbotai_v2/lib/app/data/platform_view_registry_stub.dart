class _FakeRegistry {
  void registerViewFactory(String id, dynamic Function(int) f) {
    // no-op on mobile
  }
}

final platformViewRegistry = _FakeRegistry();
