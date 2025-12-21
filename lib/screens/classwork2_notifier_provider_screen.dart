import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_starter/models/person_model.dart';
import 'package:riverpod_starter/view_models/person_viewmodel.dart';

class Classwork2NotifierProviderScreen extends ConsumerStatefulWidget {
  const Classwork2NotifierProviderScreen({super.key});

  @override
  ConsumerState<Classwork2NotifierProviderScreen> createState() =>
      _Classwork2NotifierProviderScreenState();
}

class _Classwork2NotifierProviderScreenState
    extends ConsumerState<Classwork2NotifierProviderScreen> {
  final fNameController = TextEditingController();
  String? selectedGender;
  String? selectedDepartment;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final personViewmodel = ref.watch(personViewmodelProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade800,
              Colors.deepPurple.shade400,
              Colors.purple.shade300,
            ],
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Classwork 2 - Notifier',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),

                // Full Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: fNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: const TextStyle(color: Colors.white70),
                      hintText: 'Enter full name',
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white70,
                      ),
                    ),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Enter full name' : null,
                  ),
                ),

                const SizedBox(height: 16),

                // Gender Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedGender,
                    dropdownColor: Colors.deepPurple.shade700,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.wc, color: Colors.white70),
                    ),
                    hint: const Text(
                      'Select gender',
                      style: TextStyle(color: Colors.white38),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Male', child: Text('Male')),
                      DropdownMenuItem(value: 'Female', child: Text('Female')),
                      DropdownMenuItem(value: 'Other', child: Text('Other')),
                    ],
                    onChanged: (value) =>
                        setState(() => selectedGender = value),
                  ),
                ),

                const SizedBox(height: 16),

                // Department Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedDepartment,
                    dropdownColor: Colors.deepPurple.shade700,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Department',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.business,
                        color: Colors.white70,
                      ),
                    ),
                    hint: const Text(
                      'Select department',
                      style: TextStyle(color: Colors.white38),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'IT', child: Text('IT')),
                      DropdownMenuItem(value: 'CS', child: Text('CS')),
                      DropdownMenuItem(value: 'EC', child: Text('EC')),
                      DropdownMenuItem(value: 'ME', child: Text('ME')),
                      DropdownMenuItem(value: 'CE', child: Text('CE')),
                    ],
                    onChanged: (value) =>
                        setState(() => selectedDepartment = value),
                  ),
                ),

                const SizedBox(height: 32),

                // Add Student Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            selectedGender != null &&
                            selectedDepartment != null) {
                          final person = PersonModel(
                            fName: fNameController.text.trim(),
                            gender: selectedGender!,
                            department: selectedDepartment!,
                          );
                          ref
                              .read(personViewmodelProvider.notifier)
                              .addPerson(person);
                        }
                      },
                      icon: const Icon(Icons.person_add),
                      label: const Text('Add Student'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // People List
                Expanded(
                  child: personViewmodel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : personViewmodel.lstPeople.isEmpty
                      ? const Center(
                          child: Text(
                            'No Data',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: personViewmodel.lstPeople.length,
                          itemBuilder: (context, index) {
                            final person = personViewmodel.lstPeople[index];
                            return ListTile(
                              title: Text(
                                person.fName,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                '${person.gender} - ${person.department}',
                                style: const TextStyle(color: Colors.white70),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
