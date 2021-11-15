import 'package:flutter/material.dart';
import 'package:hulp/modules/interactor/event.dart';
import 'package:hulp/modules/entities/event.dart';


class EventPresenter {
  EventInteractor eventInteractor = new EventInteractor();

  Future createEvent(Event event) async {
    return await eventInteractor.create(event);
  }

  Future editEvent(Event event) async {
    return await eventInteractor.update(event);
  }

  Future listEvent() async {
    return await eventInteractor.list();
  }


}
