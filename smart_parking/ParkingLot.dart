import 'dart:io';

import 'Logger.dart';
import 'Vehicule.dart';
import 'ParkingTicket.dart';

 
class ParkingLot {

 List<Vehicule> vehicles;
 List<Parkingticket> tickets = [];
  Logger logger = Logger(); 
 int slot = 10;

  ParkingLot()
      : vehicles = [];
    
    Future<void> addVehicule(Vehicule vehicule) async {
       if(slot>=int.parse(vehicule.number)){
           vehicles.add(vehicule);
           print("Vehicle parked successfully ✅");
          slot = slot - int.parse(vehicule.number);
           print("Availability updated: ${slot}/10 slots available\n");
           print("plate Number:${vehicule.ID}\nSlot Number:${vehicule.number}\nEntry Time:${vehicule.entryTime}\n");
            await logger.logTransaction("${vehicule.type} selected: ${vehicule.ID}");
       }
       else{
        print("there is no available slot");
       }
    }

   
    Future<void> parkVehicule() async {
      
      print("Enter vehicle plate number:");
      String? plateNumber = stdin.readLineSync()!;
      if (plateNumber == null || plateNumber.isEmpty) {
        print("Invalid plate number!");
        return;
      }
      print("Vehicle plate number is: $plateNumber");
        print("Select vehicle type:");
        print("1. Car");
        print("2. Motorcycle");
        print("3. Truck");
            String? input = stdin.readLineSync();
            Vehicule? vehicule;
            if(input != ""){
            switch (input) {
           case "1":
            vehicule = Car(plateNumber, "1"); 
            break;
          case "2":
            vehicule = Motorcycle(plateNumber, "1"); 
            break;
          case "3":
            vehicule = Truck(plateNumber, "1");
            break;
          default:
            print("Invalid choice!");
            return;
        }
            print("Processing... Please wait.\n");
            await Future.delayed(Duration(seconds: 2));
            print("Vehicle ${plateNumber} parked at slot ${10 - slot}\n");
            addVehicule(vehicule);

      
      }}
      Future<void> retrieveVehicle() async {
        print("=== VEHICLE EXIT ===");
    print("Enter vehicle plate number:\n");
    String? plateNumber = stdin.readLineSync();
    print("Processing... Please wait.\n");
     await Future.delayed(Duration(seconds: 2));
    if (plateNumber == null || plateNumber.isEmpty) {
      print("Invalid plate number!\n");
      return;
    }
    Vehicule? foundVehicle;
    for (Vehicule v in vehicles) {
        if (v.ID == plateNumber) { 
            foundVehicle = v;
        }
    }
    if (foundVehicle == null) {
        print("Vehicle with plate number $plateNumber not found!\n");
        return;
    }
    Parkingticket? tiket = Parkingticket(foundVehicle);
    await logger.logTransaction("Ticket issued:${foundVehicle.ticketID} for vehicle ${foundVehicle.ID}\n");
    double fee = tiket.calculateFee();
    print("Vehicle plat1 exited. Fee:\$ ${fee}\n");
    slot = slot +1;
    vehicles.remove(foundVehicle);
     await logger.logTransaction("Vehicle exit process initiated\n");
      print("Availability updated: ${slot}/10 slots available\n");
      print("✅ Vehicle retrieved successfully!\n");
    tiket.printReceipt();

    logger.logCompletedTicket(foundVehicle.ticketID, "CAR",foundVehicle.ID,foundVehicle.entryTime,tiket.exittime,fee);

}
      Future<void> checkavailableslot()
      async {

        if(slot!= 0){
          print("Parking status checked: ${slot}/10 slots available\n");
          await logger.logTransaction("Availability check requested\n");
          int k = 10 - slot;
          for(int i=1;i<k+1;i++){
            print("slot ${i} : not available\n");
          }
          for(int i=k+1;i<11;i++){
            if(i ==10){
          print('\x1B[38;2;255;165;0mSlot 10: Available\x1B[0m');
          return;}
           print("slot ${i} :available\n");
           

           
          }
        }
        else{
          print("there is no available slot\n");
        }
    }
    



}
