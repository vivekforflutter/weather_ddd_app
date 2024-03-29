import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_ddd_app/application/dashboard/weather_bloc.dart';
import 'package:weather_ddd_app/domain/core/error/api_failures.dart';
import 'package:weather_ddd_app/domain/dashboard/entities/fetched_weather.dart';
import 'package:weather_ddd_app/presentation/core/snackbar.dart';

var weatherData = {};

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<WeatherBloc, WeatherState>(
          listenWhen: (previous, current) =>
              previous.authFailureOrSuccessOption !=
              current.authFailureOrSuccessOption,
          listener: (context, state) {},
          builder: (context, state) {
            FetchedWeather data;
            state.authFailureOrSuccessOption.fold(() {
              data = const FetchedWeather(data: {});
            }, (a) {
              data = a.getOrElse(() => const FetchedWeather(data: {}));
              weatherData = data.data;
              print("vivek kr - ${data.data.toString()}");
            });
            return SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Current ",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Weather",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                      if (weatherData.containsKey("name") &&
                          weatherData["name"] != null)
                        Text(
                          "Weather at ${weatherData["name"]}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.amber),
                        ),
                      Expanded(
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8),
                              child: Card(
                                elevation: 0,
                                child: Container(
                                  key: const Key('containerValues'),
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(children: [
                                    const FittedBox(
                                        child: Text(
                                      "Current Temperature : ",
                                    )),
                                    Expanded(
                                      child: Text(
                                        weatherData.containsKey("main")
                                            ? "${weatherData["main"]["temp"]}° c"
                                            : "No Data Available",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: weatherData == {}
                                                ? Colors.blue
                                                : Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8),
                              child: Card(
                                elevation: 0,
                                child: Container(
                                  key: const Key('containerValues'),
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(children: [
                                    const FittedBox(
                                        child: Text(
                                      "Feels Like : ",
                                    )),
                                    Expanded(
                                      child: Text(
                                        weatherData.containsKey("main")
                                            ? "${weatherData["main"]["feels_like"]}° c"
                                            : "No Data Available",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: weatherData == {}
                                                ? Colors.blue
                                                : Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    elevation: 0,
                                    child: Container(
                                      key: const Key('containerValues'),
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        const FittedBox(
                                            child: Text(
                                          "Min Temp : ",
                                        )),
                                        Expanded(
                                          child: FittedBox(
                                            child: Text(
                                              weatherData.containsKey("main")
                                                  ? "${weatherData["main"]["temp_min"]}° c"
                                                  : "No Data Available",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: weatherData == {}
                                                      ? Colors.blue
                                                      : Colors.red,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    child: Container(
                                      key: const Key('containerValues'),
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        const FittedBox(
                                            child: Text(
                                          "Max Temp : ",
                                        )),
                                        Expanded(
                                          child: FittedBox(
                                            child: Text(
                                              weatherData.containsKey("main")
                                                  ? "${weatherData["main"]["temp_max"]}° c"
                                                  : "No Data Available",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: weatherData == {}
                                                      ? Colors.blue
                                                      : Colors.red,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8),
                              child: Card(
                                elevation: 0,
                                child: Container(
                                  key: const Key('containerValues'),
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(children: [
                                    const FittedBox(
                                        child: Text(
                                      "Pressure : ",
                                    )),
                                    Expanded(
                                      child: Text(
                                        weatherData.containsKey("main")
                                            ? "${weatherData["main"]["pressure"]} millibars "
                                            : "No Data Available",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: weatherData == {}
                                                ? Colors.blue
                                                : Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8),
                              child: Card(
                                elevation: 0,
                                child: Container(
                                  key: const Key('containerValues'),
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(children: [
                                    const FittedBox(
                                        child: Text(
                                      "Humidity : ",
                                    )),
                                    Expanded(
                                      child: Text(
                                        weatherData.containsKey("main")
                                            ? "${weatherData["main"]["humidity"]} g/m3 "
                                            : "No Data Available",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: weatherData == {}
                                                ? Colors.blue
                                                : Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: ChangeCity(),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChangeCity extends StatefulWidget {
  const ChangeCity({Key? key}) : super(key: key);

  @override
  State<ChangeCity> createState() => _ChangeCityState();
}

class _ChangeCityState extends State<ChangeCity> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
        listenWhen: (previous, current) =>
            previous.authFailureOrSuccessOption !=
            current.authFailureOrSuccessOption,
        listener: (context, state) {
          state.authFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                final failureMessage = failure.failureMessage;
                showSnackBar(
                  context: context,
                  message: failureMessage,
                );
              },
              (_) {
                context.read<WeatherBloc>().add(const WeatherEvent.authCheck());
              },
            ),
          );
        },
        buildWhen: (previous, current) =>
            previous.showErrorMessages != current.showErrorMessages,
        builder: (context, state) {
          return SafeArea(
              child: Container(
            key: const Key('containerValues'),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.only(right: 10, left: 10),
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              key: const Key('CityNameField'),
              onChanged: (v) {
                context
                    .read<WeatherBloc>()
                    .add(WeatherEvent.cityNameChanged(v));
              },
              validator: (_) =>
                  context.read<WeatherBloc>().state.city.value.fold(
                        (f) => f.maybeMap(
                          empty: (_) => 'City cannot be empty.',
                          orElse: () => null,
                        ),
                        (_) => null,
                      ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.red),
                label: const Text(
                  "City Name",
                  style: TextStyle(color: Colors.black),
                ),
                hintText: "City Name",
                prefixIcon: const Icon(Icons.location_city),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
                suffix: ElevatedButton(
                  key: const Key('getWeatherButton'),
                  child: const Text('Get Weather'),
                  onPressed: () {
                    weatherData = {};
                    context
                        .read<WeatherBloc>()
                        .add(const WeatherEvent.searchOnCLick());
                  },
                ),
              ),
            ),
          ));
        });
  }
}
