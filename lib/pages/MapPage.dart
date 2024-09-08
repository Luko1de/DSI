import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
//navbar
import 'package:testes/pages/FavoritePage.dart';
import 'package:testes/pages/ProfilePage.dart';
import 'package:testes/pages/SignUpCinemas.dart';
import 'package:testes/pages/catalogPage.dart';
import 'package:testes/pages/homePage.dart';
import '../components/bottom_nav_bar.dart';

class MapPage extends StatefulWidget {
 @override
  State<MapPage> createState() => _MapPageState();
}
class _MapPageState extends State<MapPage> {
  
  int _currentIndex = 4; // Índice da barra de navegação inferior

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CatalogPage()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  FavoritePage()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  MapPage()));
        break;
    }
  }

  //Lista dos cinemas
  List<Map> cinemas = [
  {
    'id': '0',
    'name': 'Kinoplex Boa Vista',
    'address': 'R. do Giriquiti, 48 - Boa Vista, Recife - PE, 50070-010',
    'coordinates': {
      'latitude': '-8.059578180439983',
      'longitude': '-34.88765672067769',
    },
  },
  {
    'id': '0',
    'name': 'Cinema São Luiz',
    'address': 'R. da Aurora, 175 - Boa Vista, Recife - PE, 50050-000',
    'coordinates': {
      'latitude': '-8.06207320441164',
      'longitude': '-34.881901918825335',
    },
  },
  {
    'id': '0',
    'name': 'Cinema do Porto Digital',
    'address': 'Cais do Apolo, 222 - 16º andar - Recife, PE, 50030-230',
    'coordinates': {
      'latitude': '-8.062905113692164',
      'longitude': '-34.87391297649749',
    },
  },
  {
    'id': '0',
    'name': 'Cinema da Fundação Joaquim Nabuco',
    'address': 'R. Henrique Dias, 609 - Derby, Recife - PE, 52010-100',
    'coordinates': {
      'latitude': '-8.059131603101392',
      'longitude': '-34.9000289495138',
    },
  },
  {
    'id': '0',
    'name': 'Moviemax Rosa e Silva',
    'address': 'Av. Rosa e Silva, 1280 - Torre, Recife - PE, 52071-000',
    'coordinates': {
      'latitude': '-8.038179400099285',
      'longitude': '-34.899429305333854',
    },
  },
  {
    'id': '0',
    'name': 'Moviemax Camará Shopping',
    'address': 'Av. Camaragibe, 1121 - Camaragibe, Recife - PE, 54740-370',
    'coordinates': {
      'latitude': '-8.01603667996577',
      'longitude': '-34.977114549514425',
    },
  },
  {
    'id': '0',
    'name': 'UCI Kinoplex Recife',
    'address': 'Shopping Recife, Av. Padre Carapuceiro, 777 Loja BV174 - Boa Viagem, Recife - PE, 51020-900',
    'coordinates': {
      'latitude': '-8.118722444530238',
      'longitude': '-34.904827405332796',
    },
  },
  {
    'id': '0',
    'name': 'Cinemark - Rio Mar',
    'address': 'Av. República do Líbano, 251 - Pina, Recife - PE, 51110-160',
    'coordinates': {
      'latitude': '-8.086491171000917',
      'longitude': '-34.89442490348085',
    },
  },
  ];

  //Localização do usuário
  Future<Position> determinePosition() async{
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        return Future.error('Permissão negada');
      }
    }
    
   return await Geolocator.getCurrentPosition();
  }

  LatLng? UserPosition; 
  
  void getCurrentLocation() async{
    Position position = await determinePosition();
    setState(() {
      UserPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState(){
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(     
      backgroundColor: Colors.black,
      body: UserPosition == null? CircularProgressIndicator() :
      Column(
        children: [
          // Mapa
          Expanded(
            flex: 3,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: UserPosition!,
                initialZoom: 16.0,
                minZoom: 5.0,
                maxZoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYWxpbmVtdmNvbGl2ZWlyYSIsImEiOiJjbTBkd25vNWQwa2ZpMmlvaDNxYnV6bTZnIn0.RDeMz7KKOsvxycaO5kvSNg",
                  additionalOptions: {
                    'accessToken': 'pk.eyJ1IjoiYWxpbmVtdmNvbGl2ZWlyYSIsImEiOiJjbTBkd25vNWQwa2ZpMmlvaDNxYnV6bTZnIn0.RDeMz7KKOsvxycaO5kvSNg',
                    'id': 'mapbox/streets-v12', // Mapbox style

                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: UserPosition!, // LatLng do cinema, ajuste conforme necessário
                      child: 
                      Builder(builder: (context) => Icon(Icons.location_on, color: Colors.red, size: 40.0)),
                    ),
                    // Adicione outros marcadores aqui
                  ],
                ),
              ],
            ),
          ),
          // Lista de cinemas
          Container(
            color: Colors.black,
            height: 400, // Altura da lista de cinemas
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Cinemas próximos a você',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                // Lista de cinemas
                Expanded(
                  child: ListView.builder(
                    itemCount: cinemas.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          color: Colors.white,
                          borderOnForeground: true,
                          child: ListTile(
                            title: Text(cinemas[index]['name']),
                            subtitle: Text(cinemas[index]['address']),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // Navegação para a página do cinema
                              // Implemente conforme necessário
                            },
                          ),
                        ), 
                        );
                    },
                  ),
                ),
                
                SizedBox(height: 20),

                Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpCinemas()));
                      },
                      child: const Text(
                        "Adicionar Cinema",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                )
              ],
            ),
          ),
        ],
      ),
    
    bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
  }
}