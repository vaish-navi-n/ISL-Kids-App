import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StreakCalendarWidget extends StatefulWidget {
  const StreakCalendarWidget({super.key});

  @override
  State<StreakCalendarWidget> createState() => _StreakCalendarWidgetState();
}

class _StreakCalendarWidgetState extends State<StreakCalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  /// Example streak dates - replace this with dynamic data (e.g., from Firestore)
  final List<DateTime> streakDates = [
    DateTime.utc(2025, 5, 17),
    DateTime.utc(2025, 5, 18),
    DateTime.utc(2025, 5, 19),
    DateTime.utc(2025, 5, 20), // Today
  ];

  /// Calculates the current streak by checking if the user used the app today or yesterday,
  /// and then iterating backwards through continuous dates.
  int get currentStreak {
    if (streakDates.isEmpty) return 0;

    // Normalize all streak dates to remove time component
    final normalizedStreaks =
        streakDates
            .map((date) => DateTime.utc(date.year, date.month, date.day))
            .toList();

    normalizedStreaks.sort((a, b) => b.compareTo(a)); // Descending order

    final today = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final yesterday = today.subtract(const Duration(days: 1));

    // Start streak if user used the app today or yesterday
    if (!(normalizedStreaks.contains(today) ||
        normalizedStreaks.contains(yesterday))) {
      return 0;
    }

    int streak = 1;
    for (int i = 1; i < normalizedStreaks.length; i++) {
      final prev = normalizedStreaks[i - 1];
      final curr = normalizedStreaks[i];
      if (prev.difference(curr).inDays == 1) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final greenColor =
        isDark ? Colors.greenAccent.shade200 : Colors.green.shade600;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔥 Streak Text
          Row(
            children: [
              const Text("🔥", style: TextStyle(fontSize: 20)),
              const SizedBox(width: 6),
              Text(
                "Current Streak: $currentStreak days",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// 📅 Calendar
          TableCalendar(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              defaultTextStyle: const TextStyle(fontSize: 13),
              weekendTextStyle: const TextStyle(fontSize: 13),
              outsideTextStyle: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
              todayDecoration: BoxDecoration(
                color: greenColor.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: greenColor,
                shape: BoxShape.circle,
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontSize: 13),
              weekendStyle: TextStyle(fontSize: 13),
            ),
            headerStyle: const HeaderStyle(
              titleTextStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                final normalizedDay = DateTime.utc(
                  day.year,
                  day.month,
                  day.day,
                );
                final isStreak = streakDates.any(
                  (d) => isSameDay(d, normalizedDay),
                );
                if (isStreak) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: greenColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
