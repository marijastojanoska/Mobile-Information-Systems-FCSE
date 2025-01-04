import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/exam_provider.dart';
import 'choose_location.dart';

class CreateExam extends StatefulWidget {
  @override
  _CreateExamState createState() => _CreateExamState();
}

class _CreateExamState extends State<CreateExam> {
  final _titleController = TextEditingController();
  final _locationNameController = TextEditingController();
  LatLng? _selectedLocation;
  DateTime? _selectedDateTime;

  void _pickDateTime() async {
    final chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (chosenDate == null) return;

    final chosenTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (chosenTime == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        chosenDate.year,
        chosenDate.month,
        chosenDate.day,
        chosenTime.hour,
        chosenTime.minute,
      );
    });
  }

  void _pickLocation() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(builder: (ctx) => ChooseLocation()),
    );
    if (pickedLocation == null) return;
    setState(() {
      _selectedLocation = pickedLocation;
    });
  }

  void _saveExam() {
    if (_titleController.text.isEmpty ||
        _selectedDateTime == null ||
        _selectedLocation == null ||
        _locationNameController.text.isEmpty) {
      return;
    }
    Provider.of<ExamProvider>(context, listen: false).addExam(
      _titleController.text,
      _selectedDateTime!,
      _selectedLocation!,
      _locationNameController.text,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    const appBarColor = Colors.greenAccent;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Exam',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: appBarColor,
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _titleController,
                labelText: 'Name of the exam:',
                appBarColor: appBarColor,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _locationNameController,
                labelText: 'Location name:',
                appBarColor: appBarColor,
              ),
              const SizedBox(height: 16),
              _buildDateTimePicker(appBarColor),
              const SizedBox(height: 16),
              _buildLocationPicker(appBarColor),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveExam,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required Color appBarColor,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: appBarColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appBarColor),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appBarColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(Color appBarColor) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: _pickDateTime,
          style: ElevatedButton.styleFrom(
            backgroundColor: appBarColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          child: const Text('Choose Date & Time'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            _selectedDateTime != null
                ? '${_selectedDateTime!.toLocal()}'.split(' ')[0] +
                ' ${_selectedDateTime!.hour}:${_selectedDateTime!.minute}'
                : 'Date & Time not chosen',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationPicker(Color appBarColor) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: _pickLocation,
          style: ElevatedButton.styleFrom(
            backgroundColor: appBarColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          child: const Text('Choose Location'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            _selectedLocation != null
                ? '${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}'
                : 'Location not chosen',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
