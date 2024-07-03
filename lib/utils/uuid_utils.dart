import 'package:uuid/uuid.dart';

String newUuidV4(List<dynamic> stateList) {
  const uuid = Uuid();
  String newId;

  // Generate a unique ID
  do {
    newId = uuid.v4();
  } while (stateList.any((run) => run.id == newId));

  return newId;
}
