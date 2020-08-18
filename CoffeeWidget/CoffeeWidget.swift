//
//  CoffeeWidget.swift
//  CoffeeWidget
//
//  Created by Balaji Sundaram on 18/08/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct CoffeeWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var entry: Provider.Entry

    @ViewBuilder
    var body: some View {
        switch  family {
            case .systemSmall: coffeeSmallView()
            case .systemMedium: coffeeMediumView()
            case .systemLarge: coffeeLargeView()

            default:
                coffeeSmallView()
        }
    }
}

struct coffeeSmallView : View {
    var body: some View {
        ZStack {
            Text("Small Coffee Bytes").font(.title3).bold().foregroundColor(.white)
        }.background(Image("coffeeMedium"))
    }
}

struct coffeeMediumView : View {
    var body: some View {
        ZStack {
            Text("Medium Coffee Bytes").font(.title).bold().foregroundColor(.white)
        }.background(Image("new"))
    }
}

struct coffeeLargeView : View {
    var body: some View {
        ZStack {
            Text("Large Coffee Bytes").font(.title).bold().foregroundColor(.white)
        }.background(Image("coffeeLarge"))
    }
}

@main
struct CoffeeWidget: Widget {
    let kind: String = "CoffeeWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CoffeeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Clock Time Widget")
        .description("This is an example widget to showcase the usage and the way to design a Widget by using SwiftUI.")
    }
}

struct CoffeeWidget_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        CoffeeWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        CoffeeWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
