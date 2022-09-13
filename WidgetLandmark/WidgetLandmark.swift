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

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), hike: modelData.hikes[modelData.hikes.count - 1])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), hike: modelData.hikes[modelData.hikes.count - 1])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), hike: modelData.hikes[modelData.hikes.count - 1])]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

@main
struct SmallWidgetStruct: Widget {
    let kind: String = "LastHikeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetView(hike: entry.hike)
        }
        .configurationDisplayName("LastHikeDetail")
        .description("Keep track of the last hike")
        .supportedFamilies([.systemSmall])
    }
}

struct WidgetView : View {
    let hike: Hike

    var body: some View {
        ZStack {
            Color(color)
            
            HStack {
                VStack {
                    LastHikeName(hike: hike)
                
                    Spacer()
                    
                    HikeInfo(hike: hike)
                }.padding(.all)
            }
        }
    }
}

struct Small : View {
    var entry: Provider.Entry
    
    var body: some View {
        WidgetView(hike: entry.hike)
    }
}

struct LastHikeName: View {
    @State var backgroundColor = CGColor(red: 0, green: 100, blue: 50, alpha: 1)
    let hike: Hike

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Last Hike")
                    .font(.footnote)
                
                Spacer(minLength: 1)
                
                Text(hike.name)
                    .font(.body)
                    .bold()
            }
            
            Spacer(minLength: 0)
        }
        .padding(.all, 8.0)
        .background(
            ContainerRelativeShape().fill(
                Color(backgroundColor)))
    }
}

struct HikeInfo: View {
    @State var date = Date().advanced(by: (-60 * 29 + 5))
    let hike: Hike
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(hike.distanceText)
                .font(.title2)
                .bold()
            
            Text("\(date, style: .relative) ago")
                .font(.caption)
        }
    }
}

struct WidgetLandmark_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WidgetView(hike: modelData.hikes[modelData.hikes.count - 1])
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}

/*
struct MediumWidget : View {
    let hike: Hike

    var body: some View {
        ZStack {
            Color(color)
            
            HStack {
                SmallPart(hike: hike)
                
                Divider()
                
                VStack {
                    Text("Heart Rate")
                
                    HikeGraph(hike: hike, path: \.heartRate)
                }.padding(.all)
            }
        }
    }
}
*/
