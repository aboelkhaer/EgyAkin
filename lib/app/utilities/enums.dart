enum QuestionType {
  multiple,
  string,
  select,
  date,
}

enum GroupInviteStatus {
  invited,
  accepted,
  declined,
  joined,
}

enum GroupStatus {
  private,
  public,
}

enum PostPosition {
  community,
  groupTab,
  groupDetails,
}

enum GroupPosition {
  groupTab,
  myGroups,
  allGroups,
}

enum GroupPrivacy {
  public,
  private,
}
// // Assuming `questionJson` is the JSON object representing a question from the API
// String typeString = questionJson['type']; // Assuming 'type' is a string field in the JSON

// // Parse the type string and convert it into the corresponding QuestionType enum value
// QuestionType type = _parseQuestionType(typeString);

// // Function to parse the type string and convert it into the QuestionType enum value
// QuestionType _parseQuestionType(String typeString) {
//   switch (typeString) {
//     case 'multiple':
//       return QuestionType.multiple;
//     case 'string':
//       return QuestionType.string;
//     case 'select':
//       return QuestionType.select;
//     case 'date':
//       return QuestionType.date;
//     // Add more cases as needed based on your API response
//     default:
//       throw ArgumentError('Invalid question type: $typeString');
//   }
// }
