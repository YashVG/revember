String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}
//generates a timestamp of when topic is created, thus unique id
//to be used for querying in user created questions, not revision notes