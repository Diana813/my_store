class OfferPhoto{
  /*data, kiedy usuniemy grafikę z
  serwera. Nie usuniemy jej, jeśli
  wykorzystasz grafikę w ofercie*/
  String expiresAt;
  /*link do zdjęcia, które przesłałeś*/
  String location;

  OfferPhoto.fromJson(Map<String, dynamic> json) : location = json['location'] as String;
}