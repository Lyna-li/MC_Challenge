

import 'dart:io';

import 'ParkingLot.dart';
import 'Logger.dart';
void main() async { 
   
    ParkingLot lot = ParkingLot();
     Logger logger = Logger(); 
 bool find = true;
  await logger.logTransaction("Smart Parking System started ");
    while(find){
   print("""🚗 Welcome to Smart Parking System! 🚗

         \x1B[38;2;255;165;0m===  SMART PARKING SYSTEM MENU  ===\x1B[0m
          1. Park a vehicle
          2. Check available slots
          3. Retrieve a parked vehicle
          4. View transaction log
          5. Exit
          Select an Option: 
          """
           );
    
    String? choice = stdin.readLineSync()!;
    switch (choice){

      case "1" : await lot.parkVehicule();
      break;
      case "2" :await  lot.checkavailableslot();
      break;
      case "3" : await lot.retrieveVehicle();
      break;
      case "4" :await lot.logger.showAllLogs();
      break;
      case "5" : find = false;
      print('''\x1B[32mThank you for using Smart Parking System! Goodbye! 👋
      Parking system shutting down \x1B[0m''');
      break;
      default:
      print('\x1B[31mThere is not this choice \x1B[0m');
      break;
    }

}}

