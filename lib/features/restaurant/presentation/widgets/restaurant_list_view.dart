import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel/features/restaurant/domain/entities/restaurant.dart';
import 'package:setel/features/restaurant/presentation/bloc/restaurant_bloc.dart';

class RestaurantListView extends StatefulWidget {
  final List<Restaurant> restaurants;
  RestaurantListView({
    Key key,
    @required this.restaurants,
  }) : super(key: key);

  @override
  _RestaurantListViewState createState() => _RestaurantListViewState();
}

class _RestaurantListViewState extends State<RestaurantListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (_, index) => GestureDetector(
          onTap: () {
            BlocProvider.of<RestaurantBloc>(context).add(
              ShowOpperatingHoursEvent(
                restaurant: widget.restaurants[index],
              ),
            );
          },
          child: Card(
            child: ListTile(
              leading: Icon(
                Icons.restaurant,
                color: Colors.blueAccent,
              ),
              title: Text(widget.restaurants[index].restaurantName),
              subtitle: widget.restaurants[index].isOpen
                  ? Text(
                      'Open',
                      style: TextStyle(color: Colors.green),
                    )
                  : Text(
                      'Close',
                      style: TextStyle(color: Colors.red),
                    ),
              trailing: Icon(Icons.more_vert),
            ),
          ),
        ),
        itemCount: widget.restaurants.length,
      ),
    );
  }
}
