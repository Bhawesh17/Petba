import 'dart:convert';

import 'package:geocoder/geocoder.dart';

class dataa{
  final String img1 , name , breedName , dob ;
  final int gender , adopt_id;
  dataa(this.img1, this.gender, this.adopt_id , this.name , this.breedName , this.dob);
}

class show{
  final int id, gender;
  final String name, dob, breed, img1 , animal;
  final bool wishlist;
 show({this.id, this.gender, this.name, this.dob, this.breed, this.img1, this.animal, this.wishlist});
  factory show.fromJson(Map<String, dynamic> json){
    return show(
      id: json['adopt_id'],
      img1: json['img1'],
      animal: json['animal_typ']['name'],
      breed: json['breed'] != null ? json['breed']['name'] : json['breedName'],
      gender: json['gender'],
      name: json['name'],
      dob: json['dob'],
    );
  }
}



class AdoptionData {
  final int id, gender;
  final bool antiRabies;
  final String name, dob, breed, description, ownerDP, city;
  final double latitude, longitude;

  List<String> images;
  bool wishlist;
  String age;
  Address address;

  AdoptionData({
    this.city,
    this.age,
    this.address,
    this.wishlist,
    this.breed,
    this.gender,
    this.id,
    this.images,
    this.name,
    this.dob,
    this.antiRabies,
    this.latitude,
    this.longitude,
    this.description,
    this.ownerDP,
  });

  factory AdoptionData.fromJson(Map<String, dynamic> json) {
    List<String> images = [];

    // for(int i; i < 4;i++){
    //   if(json['img'[i]] != ""){
    //     images.add(json['img'[i]]);
    //   }
    // }


    images.add(json['img1']);
    images.add(json['img2']);
    images.add(json['img3']);
    images.add(json['img4']);

    return AdoptionData(
      id: json['adopt_id'],
      breed: json['breed'] != null ? json['breed']['name'] : json['breedName'],
      city: json['city'],
      gender: json['gender'],
      name: json['name'],
      dob: json['dob'],
      antiRabies: json['anti_rbs'] == 'True' ? true : false,
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['note'],
      ownerDP: json['user'] != null
          ? json['user']['display_pic']
          : "https://instagram.fgdl9-1.fna.fbcdn.net/v/t51.2885-19/44884218_345707102882519_2446069589734326272_n.jpg?_nc_ht=instagram.fgdl9-1.fna.fbcdn.net&_nc_ohc=s0l7r_rFmQYAX_GgvhZ&oh=b4dc40d5c0690b151fcd9dbd33fb57a9&oe=6028878F&ig_cache_key=YW5vbnltb3VzX3Byb2ZpbGVfcGlj.2",
      wishlist: json['wishlist'],
      images: images,
    );
  }
}
////////////////////////////////////
////new bhawesh

class Adopt{
  final int ad_id , gender;
  final double  longitude , latitude;
  final String img1 , img2 , img3 , img4 , name , dob ,breed , antiRabies , description , city , postdate , ownerdp;
  final bool wishlist;

  Adopt({
    this.ad_id, this.gender,
     this.longitude , this.latitude ,
    this.img1 , this.img2 , this.img3 , this.img4 , this.name ,
    this.dob , this.breed , this.antiRabies , this.description ,
    this.city , this.postdate , this.wishlist , this.ownerdp
  });

  factory Adopt.fromJson(Map<String, dynamic> json){
    return Adopt(
        ad_id: json['adopt_id'],
        gender: json['gender'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      img1: json['img1'],
      img2: json['img2'],
      img3: json['img3'],
      img4: json['img4'],
      name: json['name'],
      dob: json['dob'],
        breed: json['breed'] != null ? json['breed']['name'] : json['breedName'],
      ownerdp: json['user'] != null
          ? json['user']['display_pic']
          : "https://instagram.fgdl9-1.fna.fbcdn.net/v/t51.2885-19/44884218_345707102882519_2446069589734326272_n.jpg?_nc_ht=instagram.fgdl9-1.fna.fbcdn.net&_nc_ohc=s0l7r_rFmQYAX_GgvhZ&oh=b4dc40d5c0690b151fcd9dbd33fb57a9&oe=6028878F&ig_cache_key=YW5vbnltb3VzX3Byb2ZpbGVfcGlj.2",
      antiRabies: json['anti_rbs'],
      description: json['note'],
      city: json['city'],
      postdate: json['date_added'],
      wishlist: json['wishlist']

    );
  }

}

class extractdata{
 //final bool success;
  final Adopt adopt;
  extractdata({
    this.adopt,
   //this.success
  });

  factory extractdata.fromJson(Map<String, dynamic> json) {
    return extractdata(
     //success: json['success'],
        adopt: Adopt.fromJson(json['adoption']),
    ) ;
  }

}