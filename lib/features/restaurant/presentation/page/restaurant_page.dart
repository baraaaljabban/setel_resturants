import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel/features/common/common_widgets.dart';
import 'package:setel/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:setel/features/restaurant/presentation/widgets/bar.dart';
import 'package:setel/features/restaurant/presentation/widgets/restaurant_list_view.dart';
import 'package:setel/features/restaurant/presentation/widgets/restaurant_working_hours.dart';

class RestaurantPage extends StatefulWidget {
  RestaurantPage({Key key}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RestaurantBloc>(context).add(GetRestaurants());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Bar(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(24),
        child: BlocConsumer<RestaurantBloc, RestaurantState>(
          listener: (context, state) {
            if (state is Loading)
              CommonWidgets.showLoadingSnackBar(context);
            else if (state is Error)
              CommonWidgets.showErrorSnackBar(context,
                  message: state.message);
            else
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            // if (state is ShowRestaurantWorkingHours)
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => RestaurantWorkingHoursDialog(
            //         workingDays: state.workindDays,
            //       ),
            //     ),
            //   );
          },
          builder: (context, state) {
            if (state is RestaurantListLoaded)
              return RestaurantListView(
                restaurants: state.restaurant,
              );
            else if (state is ShowRestaurantWorkingHours)
              return RestaurantWorkingHoursDialog(
                workingDays: state.workindDays,
              );
            else
              return Container();
          },
        ),
      ),
    );
  }
}
