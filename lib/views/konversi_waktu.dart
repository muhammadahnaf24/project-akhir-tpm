import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/controllers/konversi_waktu_controller.dart';

class TimeConversionView extends StatefulWidget {
  @override
  _TimeConversionViewState createState() => _TimeConversionViewState();
}

class _TimeConversionViewState extends State<TimeConversionView> {
  final TimeConversionController _controller = TimeConversionController();
  TimeOfDay? _selectedTime;
  String _selectedStartZone = 'WIB';
  String _selectedEndZone = 'WIB';

  String _formatTimeOfDay24Hour(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Time Conversion',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[800],
        elevation: 0, // remove shadow
        centerTitle: true,
        actions: [
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Text('Select Start Time Zone:'),
            DropdownButton<String>(
              value: _selectedStartZone,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStartZone = newValue!;
                  if (_selectedTime != null) {
                    _controller.convertTime(_selectedTime!, _selectedStartZone, _selectedEndZone);
                  }
                });
              },
              items: _controller.timeZones
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                );
                if (time != null) {
                  setState(() {
                    _selectedTime = time;
                  });
                  _controller.convertTime(time, _selectedStartZone, _selectedEndZone);
                }
              },
              child: Text('Select Time'),
            ),
            if (_selectedTime != null)
              Card(
                color: Colors.blueGrey,
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text(
                    '${_formatTimeOfDay24Hour(_selectedTime!)} ($_selectedStartZone)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            SizedBox(height: 16.0),
            Text('Select End Time Zone:'),
            DropdownButton<String>(
              value: _selectedEndZone,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedEndZone = newValue!;
                  if (_selectedTime != null) {
                    _controller.convertTime(_selectedTime!, _selectedStartZone, _selectedEndZone);
                  }
                });
              },
              items: _controller.timeZones
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            if (_selectedTime != null && _controller.convertedTime != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.blueGrey,
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      leading: Icon(Icons.access_time),
                      title: Text(
                        '${_controller.formatTimeOfDay(_controller.convertedTime!.convertedDuration)} (${_controller.convertedTime!.endZone})',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
