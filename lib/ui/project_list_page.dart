import 'package:flutter/material.dart';
import 'package:eslister/model/project.dart';

/// The list of Projects that the user can work on.
class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  ProjectListPageState createState() => ProjectListPageState();
}

class ProjectListPageState extends State<ProjectListPage> {
  int _selectedProjectId = -1;

  Future<List<Project>> _getProjects() async {
    // Temporary list of projects
    return [
      Project(id: 1, name: "Default Project", description: "A Sample Project"),
      Project(id: 2, name: "Estate Stuff", description: "Another Sample Project"),
      Project(id: 3, name: "Cheaper Stuff"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Project"),
      ),
      body: FutureBuilder<List<Project>>(
        future: _getProjects(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final project = snapshot.data![index];
                return ListTile(
                  title: Text(project.name),
                  subtitle: project.description != null ? Text(project.description!) : null,
                  onTap: () {
                    setState(() {
                      _selectedProjectId = project.id!;
                    });
                  },
                  selected: project.id == _selectedProjectId,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: _selectedProjectId >= 0
          ? FloatingActionButton(
              onPressed: () {
                // Replace this with your own code to handle the selected project
                print("Selected project with id $_selectedProjectId");
              },
              child: Icon(Icons.check),
            )
          : null,
    );
  }
}
