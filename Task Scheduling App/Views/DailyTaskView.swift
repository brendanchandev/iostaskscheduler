import CoreData


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
            print("tasks  \(allTasks)")
        }
        
        private func filterTodaysTasks() {
            //print(allTasks)
            print("filtering")
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

