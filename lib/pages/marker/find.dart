Map<String, String> getType(String where, List markers) {
  String type = "poi";
  String to = where;
  for (var item in markers) {
    if (item['name'] == where) {
      type = "mark";
      String lat_x = item['lat_x'];
      String lng_y = item['lng_y'];
      to = lat_x + ',' + lng_y;
      break;
    }
  }
  return {"type": type, "to": to};
}

Map getClickedMarker(List markers, id) {
  for (Map item in markers) {
    if (item["marker"].getId() == id) {
      return item;
    }
  }
  return null;
}

int getUpdateMarker(List markers, _id) {
  for (int i = 0; i < markers.length; i++) {
    Map item = markers[i];
    if (item["_id"] == _id) {
      return i;
    }
  }
  return -1;
}
