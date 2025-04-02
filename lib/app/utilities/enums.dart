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
  pending,
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

enum AcceptOrDeclineMemberInGroup {
  accepted,
  declined,
}

enum VerificationBySyndicateCard {
  Required,
  Pending,
  Verified,
}
