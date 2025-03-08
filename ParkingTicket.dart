

import 'Vehicule.dart';


class Parkingticket {


  Vehicule vehicule;
  DateTime exittime;

  Parkingticket(this.vehicule)
  :exittime = DateTime.now();

    double getDuration() {
    return exittime.difference(vehicule.entryTime).inMinutes / 60.0;
  }
  double calculateFee() {
    double duration = getDuration();
    return (duration <= 1) ? 10.0 : duration * 10.0;
  }
  
  void printReceipt() {
    print("    ======== PARKING RECEIPT ========");
    print("    Ticket ID: ${vehicule.ticketID}");
    print("    Vehicle: ${vehicule.runtimeType} - ${vehicule.ID}");
    print("    Entry Time: ${vehicule.entryTime}");
    print("    Exit Time: ${exittime}");
    print("    Duration: ${exittime.difference(vehicule.entryTime).inMinutes} minutes");
    print("    Total Fee: \$${calculateFee().toStringAsFixed(2)}");
    print("    =================================");
  }

}