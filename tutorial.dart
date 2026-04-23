void main(){
  // Aprenderemos a usar Maps
  Map<String, int> video = {
    "CPU": 10,
    "GPU": 20,
    "RAM": 15
  };
  List videos = [
 {"titulo":"CPU"},
 {"titulo":"RAM"}
];
  videos.forEach((f) {
    print(f["titulo"]);
  });

  print(video["CPU"]); // Imprime 10
  video.forEach((video, duracion) {
    print("$video : $duracion");
  });


}