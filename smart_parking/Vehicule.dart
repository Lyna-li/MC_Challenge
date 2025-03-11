class Vehicule {
  String type;
  String ID;
  String number;
  DateTime entryTime;
  String ticketID;

  Vehicule(this.type, this.ID, this.number) :
   entryTime = DateTime.now(),
    ticketID ="T${DateTime.now().millisecondsSinceEpoch}";
}

class Car extends Vehicule {
  Car(String ID, String number) : super("Car", ID, number);
}

class Motorcycle extends Vehicule {
  Motorcycle(String ID, String number) : super("Motorcycle", ID, number);
}

class Truck extends Vehicule {
  Truck(String ID, String number) : super("Truck", ID, number);
}

