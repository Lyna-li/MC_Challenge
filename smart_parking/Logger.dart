import 'dart:io';

class Logger {
  final String logFile = "parking_logs.txt";

  Future<void> logTransaction(String message) async {
    try {
      final logEntry = "[${DateTime.now()}] $message";
      final file = File(logFile);
      await file.writeAsString("$logEntry\n", mode: FileMode.append);
    } catch (e) {
      print("Error writing log: $e");
    }
  }

  Future<void> logCompletedTicket(String ticketID, String vehicleType, String plate, DateTime entryTime, DateTime exitTime, double fee) async {
    try {
      final ticketLog = """
      \x1B[38;2;255;165;0m=== COMPLETED TICKETS ===\x1B[0m'
      Ticket ID: $ticketID
      Vehicle: $vehicleType - $plate
      Entry: ${entryTime.toLocal()}
      Exit: ${exitTime.toLocal()}
      \x1B[38;2;255;165;0mFee:${fee.toStringAsFixed(2)}\x1B[0m'
      \x1B[38;2;255;165;0m========================\x1B[0m')
      """;
      final file = File(logFile);
      await file.writeAsString("$ticketLog\n", mode: FileMode.append);
    } catch (e) {
      print("Error logging completed ticket: $e");
    }
  }

  Future<void> showAllLogs() async {
    try {
      final file = File(logFile);
      if (await file.exists()) {
        String logs = await file.readAsString();
        print("\n=== TRANSACTION LOG ===");
        List<String> lines = logs.split("\n");
        bool hasCompletedTickets = false;

        for (String line in lines) {
          print(line);
         
          if (line.contains("=== COMPLETED TICKETS ===")) {
            hasCompletedTickets = true;
          }
        }
        if (!hasCompletedTickets) {
          print("\n=== COMPLETED TICKETS ===");
          print("No completed tickets yet.\n");
        }
      } else {
        print("No logs found.");
      }
    } catch (e) {
      print("Error reading log file: $e");
    }
  }
}
