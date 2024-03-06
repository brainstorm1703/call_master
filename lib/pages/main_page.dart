import 'dart:io';

import 'package:call_master/theme/theme.dart';
import 'package:call_master/utils/geolocation_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.userName});

  final String userName;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GeolocationService _geolocationService = GeolocationService();
  LocationData? _userLocation;
  bool _isLocationEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    var service = Location();
    PermissionStatus hasPermission = await service.hasPermission();
    if (hasPermission == PermissionStatus.granted) {
      _initGeolocation();
      _isLocationEnabled = true;
    } else {
      setState(() {
        _isLocationEnabled = false;
      });
    }
  }

  Future<void> _initGeolocation() async {
    _userLocation = await _geolocationService.getCurrentLocation();
    if (_userLocation != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('logo'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: const [Icon(Icons.phone_outlined)],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Color.fromARGB(251, 12, 186, 112),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color: Color.fromARGB(251, 12, 186, 112),
                  color: const Color.fromARGB(255, 31, 31, 31),
                ),
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Привіт, ${widget.userName}',
                          style: theme.textTheme.titleMedium,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Додавання авто',
                          style: theme.textTheme.labelSmall,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Завантажте дані про ваше авто для\nкращого використання сервісу.',
                          style: theme.textTheme.titleSmall,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Додати авто >',
                            style: theme.textTheme.headlineSmall,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/background.png',
                        scale: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _isLocationEnabled
              ? _userLocation != null
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(36.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(_userLocation!.latitude!,
                                  _userLocation!.longitude!),
                              zoom: 14.0,
                            ),
                            onMapCreated: (GoogleMapController controller) {},
                            markers: {
                              Marker(
                                markerId: const MarkerId('user_location'),
                                position: LatLng(_userLocation!.latitude!,
                                    _userLocation!.longitude!),
                              ),
                            },
                          ),
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
              : Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Stack(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/map-background.jpg',
                          //scale: 2,
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Відсутній зв\'язок',
                              style: theme.textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Відсутність доступу до геолокації. Переконайтеся, що у додатку увімкнено геолокацію та перевірте з\'єднання з Інтернетом.',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                openAppLocationSettings();
                              },
                              child: Text('Налаштування геолокації >',
                                  style: theme.textTheme.titleLarge),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(251, 12, 186, 112),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Викликати майстра',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openAppLocationSettings() async {
    final isAndroid = Platform.isAndroid;
    final appSettingsUrl =
        isAndroid ? 'app-settings:' : 'App-Prefs:root=LOCATION/';

    final Uri url = Uri.parse(appSettingsUrl);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint('Could not launch $appSettingsUrl');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Не вдалося відкрити налаштування'),
          content: const Text(
              'Будь ласка, перейдіть в налаштування вручну та надайте дозвіл на доступ до розташування.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ок'),
            ),
          ],
        ),
      );
    }
  }
}
