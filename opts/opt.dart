add(List<double> args) {
  double x = 0;
  for (double number in args) {
    x += number;
  }
  print(x);
  return x;
}

void main() {
  add([5, 6, 7]);
}