import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_starter/models/student_model.dart';
import 'package:riverpod_starter/view_models/student_viewmodel.dart';

class NotifierProviderScreen extends ConsumerStatefulWidget {
  const NotifierProviderScreen({super.key});

  @override
  ConsumerState<NotifierProviderScreen> createState() =>
      _NotifierProviderScreenState();
}

class _NotifierProviderScreenState
    extends ConsumerState<NotifierProviderScreen> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final dobController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final studentViewmodel = ref.watch(studentViewmodelProvider);

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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Notifier Provider',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: fNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white70,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: lNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.white70,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dobController,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          labelStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Icons.calendar_today,
                            color: Colors.white70,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final student = StudentModel(
                                fName: fNameController.text,
                                lName: lNameController.text,
                                dob: dobController.text,
                              );
                              ref
                                  .read(studentViewmodelProvider.notifier)
                                  .addStudent(student);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Add Student',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      studentViewmodel.isLoading
                          ? const CircularProgressIndicator()
                          : Expanded(
                              child: ListView.builder(
                                itemCount: studentViewmodel.lstStudents.length,
                                itemBuilder: (context, index) {
                                  final student =
                                      studentViewmodel.lstStudents[index];
                                  return ListTile(title: Text(student.fName));
                                },
                              ),
                            ),
                    ],
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
