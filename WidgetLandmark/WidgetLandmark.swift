//
//  WidgetLandmark.swift
//  WidgetLandmark
//
//  Created by luqrri on 13.09.22.
//

import WidgetKit
import SwiftUI
import Intents

struct SimpleEntry: TimelineEntry {
    let date: Date
    let hike: Hike
}

private let color = CGColor(red: 0, green: 204, blue: 0, alpha: 1)
private let modelData = ModelData()
private let defaultHike = modelData.hikes[modelData.hikes.count - 1]

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), hike: defaultHike)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), hike: defaultHike)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), hike: defaultHike)]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

@main
struct WidgetStruct: Widget {
    let kind: String = "LastHikeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetView(entry: entry)
        }
        .configurationDisplayName("LastHikeDetail")
        .description("Keep track of the last hike")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct WidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    @ViewBuilder
    var body: some View {
        switch widgetFamily {
            case .systemSmall:
                SmallWidget(hike: entry.hike, color: color)
            case .systemMedium:
                MediumWidget(hike: entry.hike, color: color)
            default:
                LargeWidget(hike: entry.hike, color: color)
        }
    }
}

struct WidgetLandmark_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WidgetView(entry: SimpleEntry(date: Date(), hike: defaultHike))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}

