import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TasksView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Tasks")
                }
                .tag(0)

            CreateTaskOrGoalView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Create")
                }
                .tag(1)

            GoalsView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Goals")
                }
                .tag(2)
        }
    }
}

struct TasksView: View {
    // FetchRequest for today's tasks
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.dueDate, ascending: true)],
        predicate: NSPredicate(format: "dueDate >= %@", Date() as NSDate) // example predicate for today's tasks
    ) var todaysTasks: FetchedResults<Task>

    // FetchRequest for all tasks
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.dueDate, ascending: true)]
    ) var allTasks: FetchedResults<Task>

    var body: some View {
        VStack{
            if !todaysTasks.isEmpty {
                            NavigationView {
                                List(todaysTasks, id: \.self) { task in
                                    Text(task.name ?? "Unknown Task")
                                }
                                .navigationTitle("Today's Tasks")
                            }
                        } else {
                            Text("No Tasks Today").padding()
                        }

                        Spacer()

                        // All Tasks Section
                        NavigationView {
                            List(allTasks, id: \.self) { task in
                                Text(task.name ?? "Unknown Task")
                            }
                            .navigationTitle("All Tasks")
                        }
        }
    }
}

struct CreateTaskOrGoalView: View {
    var body: some View {
        Text("Create a New Task or Goal")
    }
}

struct GoalsView: View {
    var body: some View {
        Text("View All Goals")
    }
}


struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}
