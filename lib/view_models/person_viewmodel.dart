import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_starter/models/person_model.dart';
import 'package:riverpod_starter/state/person_state.dart';

// provider
final personViewmodelProvider = NotifierProvider<PersonViewmodel, PersonState>(
  () {
    return PersonViewmodel();
  },
);

class PersonViewmodel extends Notifier<PersonState> {
  @override
  PersonState build() {
    return PersonState();
  }

  Future<void> addPerson(PersonModel person) async {
    state = state.copyWith(isLoading: true);
    final updatedPerson = [...state.lstPeople, person];
    await Future.delayed(Duration(seconds: 12));
    state = state.copyWith(isLoading: false, lstPeople: updatedPerson);
  }

  Future<void> loadPerson() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(seconds: 2));
    state = state.copyWith(isLoading: false);
  }
}
