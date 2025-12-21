import 'package:riverpod_starter/models/person_model.dart';

class PersonState {
  final bool isLoading;
  final List<PersonModel> lstPeople;
  PersonState({this.isLoading = false, this.lstPeople = const []});

  PersonState copyWith({bool? isLoading, List<PersonModel>? lstPeople}) {
    return PersonState(
      isLoading: isLoading ?? this.isLoading,
      lstPeople: lstPeople ?? this.lstPeople,
    );
  }
}
