//
//  ReportsView.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import SwiftUI

struct ReportsView: View {
    @State var contentHasScrolled = false
    @EnvironmentObject var model: Model
    @State var showProc = false
    @State var showRev = false
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            content
                .background(Image("Blob 1").offset(x: -100, y: -400))
                .background(Image("Blob 1").offset(x: -10, y: 420))
        }
    }
    
    var content: some View {
        ScrollView {
            scrollDetection
            HStack(alignment: .top, spacing: 16) {
               
                VStack(alignment: .leading, spacing: 8) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black.opacity(0.2))
                        .blendMode(.overlay)
                        .frame(height: 90)
                        .overlay(
                            Image("Illustration 1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 100)
                        )
                    Text("Procedure Report")
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                        .layoutPriority(1)
                    Text("Daily Procedure count")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)
                    Text("Unlisted procedure in the blank space !")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)
                        .lineLimit(5)
                    Spacer()
                }
                .padding(16)
                .frame(maxWidth: 200)
                .frame(height: 260)
                .background(.ultraThinMaterial)
                .backgroundStyle(cornerRadius: 30)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(LinearGradient(colors: [.teal, .blue], startPoint: .top, endPoint: .bottomTrailing))
                        .rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0), anchor: .bottomTrailing)
                        .rotationEffect(.degrees(180))
                        .padding(.trailing, 40)
                )
                .shadow(color: .clear, radius: 0, x: 0, y: 0)
                .onTapGesture {
                    showProc = true
                }
                VStack(alignment: .leading, spacing: 8) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black.opacity(0.2))
                        .blendMode(.overlay)
                        .frame(height: 90)
                        .overlay(
                            Image("Illustration 2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 100)
                        )
                    Text("Revenue Report")
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                        .layoutPriority(1)
                    Text("Daily IPD/OPD Revenue")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)
                    Text("Add daily collection amount also !")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)
                        .lineLimit(5)
                    Spacer()
                }
                .padding(16)
                .frame(maxWidth: 200)
                .frame(height: 260)
                .background(.ultraThinMaterial)
                .backgroundStyle(cornerRadius: 30)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(LinearGradient(colors: [.purple, .pink], startPoint: .top, endPoint: .bottomTrailing))
                        .rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0), anchor: .bottomTrailing)
                        .rotationEffect(.degrees(180))
                        .padding(.trailing, 40)
                )
                .shadow(color: .clear, radius: 0, x: 0, y: 0)
                .onTapGesture {
                    showRev = true
                }
            }
            .offset(y: -50)
            .padding(.top, 270)
            .padding(.horizontal, 20)
        }
        .sheet(isPresented: $showProc) {
            ProcedureRepView(report: ProcedureReport())
        }
        .sheet(isPresented: $showRev) {
            RevenueRepView()
        }
        .coordinateSpace(name: "scroll")
        .overlay(NavigationBar(title: "Reports", contentHasScrolled: $contentHasScrolled))
    }
    
    var coursesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(courses) { item in
                    SmallCourseItem(course: item)
                }
            }
            .padding(20)
            .padding(.bottom, 40)
        }
        .padding(.top, 60)
    }
    
    var topicsSection: some View {
        VStack {
            ForEach(Array(topics.enumerated()), id: \.offset) { index, topic in
                ListRow(title: topic.title, icon: topic.icon)
                if index != topics.count - 1 {
                    Divider()
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
    
    var handbooksSection: some View {
        HStack(alignment: .top, spacing: 16) {
            ForEach(handbooks) { handbook in
                HandbookItem(handbook: handbook)
            }
        }
        .padding(.horizontal, 20)
    }
    
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
            withAnimation(.easeInOut) {
                if offset < 0 {
                    contentHasScrolled = true
                } else {
                    contentHasScrolled = false
                }
            }
        }
    }
}

struct ReportsView_Previews: PreviewProvider {
    static var previews: some View {
        ReportsView()
            .preferredColorScheme(.dark)
            .environmentObject(Model())
    }
}
