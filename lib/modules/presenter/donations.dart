import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/donations.dart';
import 'package:hulp/modules/entities/reports.dart';
import 'package:hulp/modules/interactor/donations.dart';



class DonationPresenter {
  DonationInteractor donationInteractor = new DonationInteractor();

  Future createEvent(Donation donation) async {
    return await donationInteractor.create(donation);
  }

  Future editEvent(Donation donation) async {
    return await donationInteractor.update(donation);
  }

  Future<List<Report>> listDonationByEvent(eventId) async {
    final response = await donationInteractor.list(eventId);

    print('response');
    final donations = response['doacoes'];


    List<Report> reports = [];

    for(final i in donations){
      var rep = Report.fromJson(i);
      rep.city = response['cidade'];
      reports.add(rep);

    }
    print(reports);
    return reports;


  }


}
