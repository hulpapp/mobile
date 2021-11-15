import 'package:hulp/modules/entities/Volunteer.dart';
import 'package:hulp/modules/entities/teams.dart';
import 'package:hulp/modules/interactor/teams.dart';
import 'package:hulp/modules/interactor/volunteer.dart';


class TeamPresenter {
  VolunteerInteractor volunteerInteractor = new VolunteerInteractor();
  TeamInteractor teamInteractor = new TeamInteractor();




  Future listTeams() async {
    return await teamInteractor.list();



  }
  
  Future createTeam(Team t, List<Volunteer> lv) async{
    var req = await teamInteractor.create(t);
    print('qweqw');
    print(req['id']);

      final members= [];
      lv.forEach((element) {
        var aux = {"team_id": req['id'],"volunteer_id": element.id };
        members.add(aux);
      });
    
    
      print('meb');
      print(members.toString());

    
    return await teamInteractor.insertMember(members);
    

    
  }


}
