import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WaterIntakeEntry {
        WaterIntakeEntry(date: Date(), waterIntake: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (WaterIntakeEntry) -> Void) {
        let entry = WaterIntakeEntry(date: Date(), waterIntake: 0)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WaterIntakeEntry>) -> Void) {
        var entries: [WaterIntakeEntry] = []

//        let waterDataManager = Viewmode
        let waterIntake = UserDefaults(suiteName: "group.Hydrate")?.double(forKey: "WaterIntakeValue") ?? 0
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = WaterIntakeEntry(date: entryDate, waterIntake: Int(waterIntake)) // Replace with the actual water intake value
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}



struct WaterIntakeEntry: TimelineEntry {
    let date: Date
    let waterIntake: Int
}

struct HydrateWidgetEntryView : View {
    var entry: WaterIntakeEntry

    var body: some View {
        ZStack{
            Color.blue
            
            VStack {
                Text("Water Intake")
                    .font(.headline)
                Text("\(entry.waterIntake) mL")
                    .font(.title)
            }
            .padding()
            .foregroundColor(.white)
        }
        
    }
}

struct HydrateWidget: Widget {
    private let kind: String = "WaterIntakeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HydrateWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Water Intake Widget")
        .description("Displays your daily water intake.")
        .supportedFamilies([.systemMedium])
    }
}


struct HydrateWidget_Previews: PreviewProvider {
    static var previews: some View {
        // Fetch the actual water intake value from UserDefaults
        let waterIntake = UserDefaults(suiteName: "group.Hydrate")?.double(forKey: "WaterIntakeValue") ?? 0

        // Initialize the widget with the fetched water intake value
        return HydrateWidgetEntryView(entry: WaterIntakeEntry(date: Date(), waterIntake: Int(waterIntake)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


