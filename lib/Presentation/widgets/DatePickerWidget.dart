import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Providers/date_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DatePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('I built myself');
    return Consumer<DateProvider>(
      builder: (context, dateProvider, child) {
        String hintText = dateProvider.selectedDate != null
            ? DateFormat('dd MMM yyyy').format(dateProvider.selectedDate!)
            : 'Date of Birth';

        return Expanded(
          child: Container(
            width: double.infinity,
            child: TextField(
              controller: TextEditingController(text: hintText),
              readOnly: true,
              style: GoogleFonts.redHatDisplay(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              onTap: () {
                _showDatePicker(context, dateProvider);
              },
              decoration: InputDecoration(
                hintText: 'Date of Birth',
                prefixIcon: Icon(Icons.calendar_today_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: whiteColor,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDatePicker(
      BuildContext context, DateProvider dateProvider) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateProvider.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      dateProvider.setDate(pickedDate);
    }
  }
}
