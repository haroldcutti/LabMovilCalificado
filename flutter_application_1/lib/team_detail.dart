import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'team.dart';
import 'team_form.dart';

class TeamDetail extends StatelessWidget {
  final Team team;
  final Function(Team) onUpdate;
  final Function(Team) onDelete;

  TeamDetail({required this.team, required this.onUpdate, required this.onDelete});

  void _navigateToEditTeam(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamForm(team: team),
      ),
    );

    if (result != null) {
      onUpdate(result);
    }
  }

  void _deleteTeam(BuildContext context) {
    onDelete(team);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _navigateToEditTeam(context),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteTeam(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${team.id}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Name: ${team.name}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Year: ${team.year}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Text(
                  'Date Champ: ${DateFormat('yyyy-MM-dd').format(team.dateChamp)}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
