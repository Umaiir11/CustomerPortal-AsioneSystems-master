class Person {
  final String name;
  final int age;

  Person({required this.name, required this.age});

  @override
  String toString() {
    return '$name ($age)';
  }
}
