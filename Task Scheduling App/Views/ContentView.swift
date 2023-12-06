import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedTab: Int = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            TasksView(viewModel: TasksViewModel(context: viewContext))
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext

        // Sample data setup
        let sampleTask = Task(context: context)
        sampleTask.task_name = "Sample Task" // Correctly set the task_name here

        // If you have a Schedule entity linked to Task, set it up as well
        let sampleSchedule = Schedule(context: context)
        sampleSchedule.interval_pattern = "daily" // Replace with your attribute names
        //sampleSchedule.task_name = sampleTask.task_name
        
        sampleTask.schedule = sampleSchedule
        //sampleSchedule.task = sampleTask
        
        let sampleTask1 = Task(context: context)
        sampleTask1.task_name = "Sample Task 1" // Correctly set the task_name here

    
        // If you have a Schedule entity linked to Task, set it up as well
        let sampleSchedule1 = Schedule(context: context)
        sampleSchedule1.interval_pattern = "weekly" // Replace with your attribute names
        sampleSchedule1.days_of_week = "3,6"
        sampleTask1.schedule = sampleSchedule1
        //sampleSchedule1.task = sampleTask1
        let sampleGoal = Goal(context: context)
        sampleGoal.goal_name = "Sample goal"
        sampleGoal.color = "red"
        sampleTask.goal = sampleGoal
        do {
            try context.save()
        } catch {
            
            let nsError = error as NSError
                print("Unresolved error? \(nsError), \(nsError.userInfo)")
        }

        return ContentView()
            .environment(\.managedObjectContext, context)
    }
}

