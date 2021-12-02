import 'package:hulp/modules/entities/Volunteer.dart';
import 'package:hulp/modules/entities/teams.dart';
import 'package:hulp/modules/interactor/teams.dart';
import 'package:hulp/modules/interactor/volunteer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TeamPresenter {
  VolunteerInteractor volunteerInteractor = new VolunteerInteractor();
  TeamInteractor teamInteractor = new TeamInteractor();




  Future listTeams() async {
    return await teamInteractor.list();



  }

  Future listTeamByLeader() async {
    var req = await teamInteractor.getTeamByIdLeader();
    var meq = await teamInteractor.listMembers();
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var userId = prefs.get("user");


    final Map<String, dynamic> teams = new Map<String, dynamic>();
    teams['name']= req[0]['name'];
    teams['members'] = [];

    for(var element in meq)  {
      if(element['volunteer_id']!=userId){
        final vol = await volunteerInteractor.getVolunteer(element['volunteer_id']);

        teams['members'].add(vol);
      }

    };

  return teams;

  }




  
  Future createTeam(Team t, List<Volunteer> lv) async{
    var req = await teamInteractor.create(t);


      final members= [];
      lv.forEach((element) {
        var aux = {"team_id": req['id'],"volunteer_id": element.id };
        members.add(aux);
      });


    
    return await teamInteractor.insertMember(members);
    

    
  }


}
