String? isNotEmpty(String? value) {
  return value!.isNotEmpty ? null : "This is required";
}
