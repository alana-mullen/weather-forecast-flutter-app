import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unit_conversion/unit_conversion.dart';
import 'package:weatherforecastflutter/src/api/api_response.dart';
import 'package:weatherforecastflutter/src/api/rest_client.dart';
import 'package:weatherforecastflutter/src/bloc/forecast_bloc.dart';
import 'package:weatherforecastflutter/src/models/forecast.dart';
import 'package:weatherforecastflutter/src/extensions/string_ext.dart';
import 'error.dart';
import 'loading.dart';

class ForecastList extends StatefulWidget {
  @override
  _ForecastListState createState() => _ForecastListState();
}

class _ForecastListState extends State<ForecastList>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;
  ForecastBloc _bloc;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _bloc = ForecastBloc();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _bloc.fetchForecast(),
      child: StreamBuilder<ApiResponse<Forecast>>(
        stream: _bloc.cartListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                final List<ListElement> _items = snapshot.data.data.list;
                return _buildListView(context, _items);
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => _bloc.fetchForecast(forceRefresh: true),
                );
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  _buildListView(BuildContext context, List<ListElement> items) {
    return ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: ListView.builder(
          itemCount: items.length,
          padding: EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: ExpandablePanel(
                header: Row(
                  children: <Widget>[

                    CachedNetworkImage(
                      height: 100,
                      width: 100,
                      imageUrl: items[index].weather[0].icon.isNotEmpty
                          ? 'https://openweathermap.org/img/wn/' + items[index].weather[0].icon + '@2x.png'
                          : '',
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error_outline, size: 50),
                    ),

                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                            child: Text(
                              DateFormat('EEEE dd/MM').format(items[index].dtTxt).toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),

                          Text(
                              items[index].weather[0].description.toString().capitalize()
                          )
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '${UnitConverter.kelvinToCelsius(items[index].main.tempMax).round()}\u00B0C',
                          style: TextStyle(
                              fontSize: 18
                          ),
                        ),

                        Text(
                          '${UnitConverter.kelvinToCelsius(items[index].main.tempMin).round()}\u00B0C',
                          style: TextStyle(
                              fontSize: 18
                          ),
                        ),

                      ],
                    )

                  ],
                ),
                collapsed: null,
                expanded: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          'Humidity: ' + items[index].main.humidity.toString()
                      ),
                      Text(
                          'Pressure: ' + items[index].main.pressure.toString()
                      ),
                      Text(
                          'Sea level: ' + items[index].main.seaLevel.toString()
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
    );
  }

}
