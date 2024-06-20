import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'team.dart';
import 'team_form.dart';
import 'team_detail.dart';

class TeamList extends StatefulWidget {
  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  List<Team> teams = [];

  void _navigateToAddTeam() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamForm()),
    );

    if (result != null) {
      setState(() {
        teams.add(result);
      });
    }
  }

  void _navigateToTeamDetail(Team team) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetail(
          team: team,
          onUpdate: (updatedTeam) {
            setState(() {
              int index = teams.indexOf(team);
              teams[index] = updatedTeam;
            });
          },
          onDelete: (deletedTeam) {
            setState(() {
              teams.remove(deletedTeam);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Teams'),
      ),
      body: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                teams[index].name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Year: ${teams[index].year}\nDate Champ: ${DateFormat('yyyy-MM-dd').format(teams[index].dateChamp)}',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              isThreeLine: true,
              onTap: () {
                _navigateToTeamDetail(teams[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTeam,
        child: Icon(Icons.add),
      ),
    );
  }
}
