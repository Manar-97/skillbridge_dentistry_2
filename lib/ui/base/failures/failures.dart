// class Failures {
//   String errorMessage;
//
//   Failures(this.errorMessage);
// }
//
// class ConnectionFailures extends Failures {
//   ConnectionFailures([String? errorMessage])
//       : super(errorMessage ??
//             "Please Check Your Internet Connection And Try Again");
// }
//
// class ApiFailures extends Failures {
//   ApiFailures([String? errorMessage])
//       : super(errorMessage ?? "Something Went Wrong Please Try Again");
// }
//
// class UnAuthenticatedFailures extends Failures {
//   UnAuthenticatedFailures([String? errorMessage])
//       : super(errorMessage ?? "Session Expired Please Login Again");
// }
//
// class InvalidInputFailure extends Failures {
//   InvalidInputFailure([String? errorMessage])
//       : super(errorMessage ?? 'Please fill all required fields.');
// }
//
// class TimeoutFailure extends Failures {
//   TimeoutFailure([String? errorMessage])
//       : super(errorMessage ?? "Session Expired Please Login Again");
// }
