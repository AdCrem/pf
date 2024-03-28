class SolverException implements Exception{
  final String message;

  const SolverException(this.message);

  @override
  String toString() => message;
}