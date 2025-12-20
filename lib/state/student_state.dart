import 'package:riverpod_starter/models/student_model.dart';

class StudentState {
  final bool isLoading;
  final List<StudentModel> lstStudents;

  StudentState({this.isLoading = false, this.lstStudents = const []});

  StudentState copyWith({bool? isLoading, List<StudentModel>? lstStudents}) {
    return StudentState(
      isLoading: isLoading ?? this.isLoading,
      lstStudents: lstStudents ?? this.lstStudents,
    );
  }
}
