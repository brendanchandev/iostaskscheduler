import CoreData
import SwiftUI

struct TasksView: View {

    // FetchRequest for all tasks
    @ObservedObject var viewModel: TasksViewModel

        var body: some View {
            VStack {
                // Today's Tasks Section
                if !viewModel.todaysTasks.isEmpty {
                    NavigationView {
                        List(viewModel.todaysTasks, id: \.self) { task in
                            let colorName = task.goal?.color ?? "white"
                            let displayColor = GoalColor(rawValue: colorName)?.color ?? GoalColor(rawValue: "white")?.color
                            TaskView(task: task)
                                .frame(height: 40.0)
                                .listRowBackground(displayColor)
                            
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .navigationTitle("Today's Tasks")
                    }
                } else {
                    Text("No Tasks Today").padding()
                }

                Spacer()
                    

                // All Tasks Section
                NavigationView {
                    List(viewModel.allTasks, id: \.self) { task in
                        let colorName = task.goal?.color ?? "white"
                        let displayColor = GoalColor(rawValue: colorName)?.color ?? GoalColor(rawValue: "white")?.color
                        TaskView(task: task)
                            .frame(height: 40.0)
                            .listRowBackground(displayColor)
                    }
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .navigationTitle("All Tasks")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
}

class TasksViewModel: ObservableObject {
    @Published var todaysTasks: [Task] = []
    @Published var allTasks: [Task] = []
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchAllTasks()
        filterTodaysTasks()
    }
    
    private func fetchAllTasks() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
       request.sortDescriptors = [NSSortDescriptor(keyPath: \Task.task_name, ascending: true)]
        
        do {
            allTasks = try context.fetch(request)
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }
    
    private func filterTodaysTasks() {
        // Use Date() to get today's date and filter tasks based on their schedule
        // This is a simplified example, you'll need to implement the logic based on your Schedule entity
        todaysTasks = allTasks.filter { task in
            guard let schedule = task.schedule else {
                return false
                
            }
            // Implement your schedule checking logic here
            return isTaskDueToday(schedule)
        }
    }
    
    
    private func isTaskDueToday(_ schedule: Schedule) -> Bool {
        let calendar = Calendar.current
        let today = Date()
        let dayOfWeek = calendar.component(.weekday, from: today)
        let dayOfMonth = calendar.component(.day, from: today)
        
        switch schedule.interval_pattern {
        case "daily":
            return true
        case "weekly":
            let scheduledDaysOfWeek = schedule.days_of_week?.split(separator: ",").compactMap { Int($0) }
            return scheduledDaysOfWeek?.contains(dayOfWeek) ?? false
        case "monthly":
            let scheduledDaysOfMonth = schedule.days_of_month?.split(separator: ",").compactMap { Int($0) }
            return scheduledDaysOfMonth?.contains(dayOfMonth) ?? false
        default:
            return false
        }
    }
}

