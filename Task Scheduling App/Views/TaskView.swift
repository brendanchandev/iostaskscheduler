//
//  TaskView.swift
//  Task Scheduling App
//
//  Created by Brendan Chan on 2023-12-05.
//

import SwiftUI

struct TaskView: View {
    var task: Task
    var body: some View {
        HStack{
            GoalTabView(goal: task.goal)
            Spacer()
            let name = task.task_name ?? "No name"
            
            Text("Task - \(name)")
                .lineLimit(1)
            Spacer()

        }
        .frame(maxWidth: .infinity, alignment: .leading) // Ensure HStack fills the width of its container
    }
}

struct GoalTabView: View {
    var goal: Goal?
    var body: some View {
        HStack{
            if let goalName = goal?.goal_name {
                Text(goalName)
                    .lineLimit(1)
            } else {
                Text("Unnamed goal")
            }
        }
    }
    
}

struct TaskView_Previews: PreviewProvider {

    static var previews: some View {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        let sampleTask = Task(context: context)
        sampleTask.task_name = "Sample Task 1"
        let sampleGoal = Goal(context: context)
        sampleGoal.icon_name = "sun.min.fill"
        sampleGoal.color = "red"
        sampleTask.goal = sampleGoal
        return TaskView(task: sampleTask)
            .environment(\.managedObjectContext, context)
    }
}

