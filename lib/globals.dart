
String currentIP = "192.168.4.1";

int gSortType = 3;

List gCards = [];

List idToNameTable = [
  ["1", "Paul"],
  ["2", "Liam"],
  ["3", "Aaron"],
  ["4", "Jacob"],
  ["5", "Parker"],
  ["6", "Bella"],
  ["7", "Gardy"],

];

bool useTestData = true;

String resolveIdToName(int id){
  for (var i = 0; i < idToNameTable.length; i++) {
    if(idToNameTable[i][0] == id.toString()){
      return idToNameTable[i][1];
    }
  }
  return "";
}

