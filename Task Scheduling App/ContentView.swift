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
    var body: some View {
        NavigationView {
            List {
                // Replace with dynamic task data
                Text("Task 1")
                Text("Task 2")
                Text("Task 3")
            }
            .navigationTitle("Today's Tasks")
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
