import 'package:hulp/modules/interactor/volunteer.dart';


class EventPresenter {
  VolunteerInteractor volunteerInteractor = new VolunteerInteractor();



  Future listEvent() async {
    return await volunteerInteractor.list();
  }


}
