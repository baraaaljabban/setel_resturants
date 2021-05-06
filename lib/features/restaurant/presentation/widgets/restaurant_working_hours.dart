import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel/features/restaurant/domain/entities/working_days.dart';
import 'package:setel/features/restaurant/presentation/bloc/restaurant_bloc.dart';

class RestaurantWorkingHoursDialog extends StatelessWidget {
  final List<WorkingDay> workingDays;
  const RestaurantWorkingHoursDialog({
    Key key,
    @required this.workingDays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => goBack(context),
      child: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
                leading: Text(workingDays[index].day),
                trailing: Text(workingDays[index].hours.toString())
                //  Text(workingDays[index].day),
                //   Text(workingDays[index].hours.toString()),
                );
          },
          itemCount: workingDays.length,
        ),
      ),
    );
  }

  Future<bool> goBack(BuildContext context) {
    BlocProvider.of<RestaurantBloc>(context).add(
      GoToRasturanetsListEvent(),
    );
    return Future.value(false);
  }
}
