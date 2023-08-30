// class UserModel {
//   UserModel({
//     required this.value,
//     required this.data,
//     required this.token,
//   });
//   late final bool value;
//   late final UserDataModel data;
//   late final String token;

//   UserModel.fromJson(Map<String, dynamic> json) {
//     value = json['value'];
//     data = UserDataModel.fromJson(json['data']);
//     token = json['token'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['value'] = value;
//     data['data'] = data;
//     data['token'] = token;
//     return data;
//   }
// }

// class UserDataModel {
//   UserDataModel({
//     required this.id,
//     required this.fname,
//     required this.lname,
//     required this.email,
//     required this.emailVerifiedAt,
//     required this.age,
//     required this.specialty,
//     required this.workingplace,
//     required this.phone,
//     required this.job,
//     required this.highestdegree,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//   late final int id;
//   late final String fname;
//   late final String lname;
//   late final String email;
//   late final String emailVerifiedAt;
//   late final int age;
//   late final String specialty;
//   late final String workingplace;
//   late final String phone;
//   late final String job;
//   late final String highestdegree;
//   late final String createdAt;
//   late final String updatedAt;

//   UserDataModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'] ?? 0;
//     fname = json['fname'] ?? '';
//     lname = json['lname'] ?? '';
//     email = json['email'] ?? '';
//     emailVerifiedAt = json['emailVerifiedAt'] ?? '';
//     age = json['age'] ?? 0;
//     specialty = json['specialty'] ?? '';
//     workingplace = json['workingplace'] ?? '';
//     phone = json['phone'] ?? '';
//     job = json['job'] ?? '';
//     highestdegree = json['highestdegree'] ?? '';
//     createdAt = json['created_at'] ?? '';
//     updatedAt = json['updated_at'] ?? '';
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['fname'] = fname;
//     data['lname'] = lname;
//     data['email'] = email;
//     data['email_verified_at'] = emailVerifiedAt;
//     data['age'] = age;
//     data['specialty'] = specialty;
//     data['workingplace'] = workingplace;
//     data['phone'] = phone;
//     data['job'] = job;
//     data['highestdegree'] = highestdegree;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
