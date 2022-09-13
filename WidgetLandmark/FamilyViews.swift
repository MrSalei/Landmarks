//
//  FamilyViews.swift
//  Landmarks
//
//  Created by luqrri on 13.09.22.
//

import SwiftUI
import WidgetKit

struct SmallWidget : View {
    let hike: Hike, color: CGColor

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

struct MediumWidget : View {
    let hike: Hike, color: CGColor

    var body: some View {
        ZStack {
            Color(color)
            
            HStack {
                VStack {
                    LastHikeName(hike: hike)
                
                    Spacer()
                    
                    HikeInfo(hike: hike)
                }.padding(.all)
                
                Divider()
                
                VStack {
                    Text("Heart Rate")
                
                    HikeGraph(hike: hike, path: \.heartRate)
                }.padding(.all)
            }
        }
    }
}

struct LargeWidget : View {
    let hike: Hike, color: CGColor

    var body: some View {
        ZStack {
            Color(color)
            
            VStack {
                HStack {
                    VStack {
                        LastHikeName(hike: hike)
                    
                        Spacer()
                        
                        HikeInfo(hike: hike)
                    }.padding(.all)
                    
                    Divider()
                    
                    VStack {
                        Text("Heart Rate")
                    
                        Divider()
                    
                        HikeGraph(hike: hike, path: \.heartRate)
                    }.padding(.all)
                }
                
                Spacer()
                
                HStack {
                    VStack {
                        Text("Pace")
                        
                        Divider()
                    
                        HikeGraph(hike: hike, path: \.pace)
                    }.padding(.all)
                    
                    Divider()
                    
                    VStack {
                        Text("Elevation")
                        
                        Divider()
                    
                        HikeGraph(hike: hike, path: \.elevation)
                    }.padding(.all)
                }
            }
        }
    }
}


struct FamilyViews_Previews: PreviewProvider {
    static let modelData = ModelData()
    static let defaultHike = modelData.hikes[modelData.hikes.count - 1]
    static let color = CGColor(red: 0, green: 204, blue: 0, alpha: 1)

    static var previews: some View {
        Group {
            SmallWidget(hike: defaultHike, color: color)
                .previewContext((WidgetPreviewContext(family: .systemSmall)))
                
            MediumWidget(hike: defaultHike, color: color)
                .previewContext((WidgetPreviewContext(family: .systemMedium)))
                
            LargeWidget(hike: defaultHike, color: color)        .previewContext((WidgetPreviewContext(family: .systemLarge)))
        }
    }
}
