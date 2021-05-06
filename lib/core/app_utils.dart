import 'package:setel/features/restaurant/domain/entities/time_range.dart';
import 'package:setel/features/restaurant/domain/entities/working_days.dart';
import 'package:intl/intl.dart';

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

List<WorkingDay> fillWirkingDaysWithHours({String operatingHours}) {
  //   // String operatingHours =
  // String operatingHours =
  //     "Mon-Thu, Sun 11:30 am - 9:00 pm  / Fri-Sat 11:30 am - 9:30 pm";
  List<String> operatingHoursArray = operatingHours.split('/').toList();
  List<WorkingDay> wirkingDays = List<WorkingDay>();
  // int hFrom, mTo, mFrom, hTo;
  Map<String, String> resultList = {
    "Mon": "",
    "Tue": "",
    "Wed": "",
    "Thu": "",
    "Fri": "",
    "Sat": "",
    "Sun": "",
  };
  for (var i = 0; i < operatingHoursArray.length; i++) {
    var item = operatingHoursArray[i].trim();
    List<String> spaceList = item.split(' ');
    var timeFlag = false;
    String toDay;
    List<String> day = List<String>();
    for (int j = 0; j < spaceList.length; j++) {
      if (timeFlag)
        break;
      else if (isNumeric(spaceList[j][0])) {
        timeFlag = true;
        int hFrom = int.parse(spaceList[j].split(":")[0]);
        int mFrom = int.parse(spaceList[j].split(":")[1]);
        int hTo = int.parse(spaceList[j + 3].split(":")[0]);
        int mTo = int.parse(spaceList[j + 3].split(":")[1]);
        day.forEach(
          (it) => wirkingDays.add(
            WorkingDay(
              day: it,
              hours: TimeRange(hFrom: hFrom, hTo: hTo, mFrom: mFrom, mTo: mTo),
            ),
          ),
        );
        break;
      } else {
        List fromToDays = spaceList[j].split('-');
        String fromDay = fromToDays[0];
        if (fromToDays.length > 1) {
          toDay = fromToDays[1];
          bool flag = false;
          for (var s in resultList.keys) {
            if (s == fromDay || flag) {
              day.add(s);
              // when you reach the first day of the days givin
              flag = true;
            }
            if (s == toDay) {
              flag = false;
            }
          }
        }
        // day.add(spaceList[j]);
      }
    }
  }

  return wirkingDays;
}

Map<String, String> fillWirkingDaysWithHours2({String operatingHours}) {
  Map<String, String> resultList = {
    "Mon": "",
    "Tue": "",
    "Wed": "",
    "Thu": "",
    "Fri": "",
    "Sat": "",
    "Sun": "",
  };

  // String operatingHours =
  //     "Mon-Thu, Sun 11:30 am - 9:00 pm  / Fri-Sat 11:30 am - 9:30 pm";

  //operatingHoursArray list of days depend on time
  //every new time will come after slash
  List operatingHoursArray = operatingHours.split('/').toList();
  //devided by slash
  for (var item in operatingHoursArray) {
    String days = "", time = "", toDay;
    // cut spaces after end of 9:00 pm
    // cut spaces befor start of next time  Fri-Sat
    item = item.trim();
    List spaceList = item.split(' ');
    var timeFlag = false;
    for (var j = 0; j < spaceList.length; j++) {
      // start with number like 11:30 am - 9:00 pm
      // it will take untill the end
      // if it's number set it in the working hours
      //spaceList[j][0] will see frim
      if (isNumeric(spaceList[j][0]) || timeFlag) {
        //3- time= 11:30
        // space is for space after each hours 11:30" "am" "-" "9:00 pm
        time += spaceList[j] + " ";
        // we set this flag so that we will take the rest as time
        timeFlag = true;
      } else {
        // 1- Mon-Thu,
        // 2- Sun
        //days = Mon-Thu,Sun
        days += spaceList[j];
      }
    }
    //delete last space after 9:00 pm" "
    time = time.trim();

    List daysList = days.split(',');
    for (var part in daysList) {
      List fromToDays = part.split('-');
      String fromDay = fromToDays[0];
      // this is if there is no to day like nothin came after Mon
      if (fromToDays.length > 1) {
        toDay = fromToDays[1];
        bool flag = false;
        for (var day in resultList.keys) {
          if (day == fromDay || flag) {
            resultList[day] = (day + " " + time);
            // when you reach the first day of the days givin
            flag = true;
          }
          if (day == toDay) {
            flag = false;
          }
        }
      } else
        resultList[fromDay] = (fromDay + " " + time);
    }
  }

  return resultList;
}

bool isRestaurantNowOppend({List<WorkingDay> workingDays}) {
  var isOpened = false;
  var day = DateFormat.yMMMd().format(DateTime.now());
  var time = DateTime.now().toLocal();
  workingDays.forEach(
    (it) => {
      if (it.day.contains(day))
        {
          // you are after 12 mid night
          if (time.hour < 6)
            isOpened = false
          else if (time.hour > it.hours.hFrom && time.hour < it.hours.hTo)
            {
              if (time.minute > it.hours.mFrom && time.minute < it.hours.mTo)
                isOpened = true
              else
                isOpened = false,
            }
        }
    },
  );
  return isOpened;
}
