import 'package:flutter/material.dart';
import 'package:kgps_locator_giovanna/models/waypoint.dart';

void main() {
  runApp(const KGpsLocatorApp());
}

class KGpsLocatorApp extends StatelessWidget {
  const KGpsLocatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KGPS-Locator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    //dados ficticios para teste
  double latitude = -23.2048746;
  double longitude = -46.1559800;
  double altitude = 760.0;
  double heading = 45.0;

  Waypoint? navegandoPara;

  final List<Waypoint> waypoints = [
    const Waypoint(nome: 'WP001', latitude: -23.2048746, longitude: -46.1559800),
    const Waypoint(nome: 'WP002', latitude: -23.2058746, longitude: -46.1569800),
    const Waypoint(nome: 'WP003', latitude: -23.2068746, longitude: -46.1579800),
  ];

  void navegarPara(Waypoint waypoint) {
    print('Navegando para: ${waypoint.nome}');

    setState(() {
      navegandoPara = waypoint;
    });
  }

  void pararNavegacao() {
    if(navegandoPara != null){
      print('Parando navegação para: ${navegandoPara!.nome}');
    }

    setState(() {
      navegandoPara = null;
    });
  }

  void adicionarWaypoint(){
    print('Você clicou em adicionar waypoint');
  }

  void excluirWaypoint(Waypoint waypoint){
    print('Você clicou em excluir waypoint: ${waypoint.nome}');
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('kGPS-Locator')),
      body: SafeArea(
        child: Column(
          children:[
            const SizedBox(height: 12),

            Compass(heading: heading),

            const SizedBox(height: 8),

            Text(
              'Heading: ${heading.toStringAsFixed(1)}°',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            _buildLocationInfo(),

            const SizedBox(height: 12),

            if (navegandoPara != null) _buildNavigationInfo(),

            const SizedBox(height: 8),

            Expanded(child: _buildWaypointList()),
          ],
        ),
      ),

      floatingActionButton: navegandoPara != null
          ? FloatingActionButton.extended(
            onPressed: pararNavegacao,
            icon: const Icon(Icons.stop),
            label: const Text('STOP'),
            ) 
            : null,

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton.icon(
            onPressed: adicionarWaypoint,
            icon: const Icon(Icons.add_location_alt),
            label: const Text('Adicionar Waypoint'),
          ),
        ),
  };
}

//parou no slide 9
