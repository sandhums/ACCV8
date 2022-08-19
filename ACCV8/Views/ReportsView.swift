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
    @State var showCons = false
    @State var showProcByCentre = false
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            content
                .background(Image("Blob 1").offset(x: -100, y: -400))
//                .background(Image("Blob 1").offset(x: -10, y: 420))
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
            .padding(.top, 150)
            .padding(.horizontal, 20)
            HStack(alignment: .top, spacing: 16) {
               
                VStack(alignment: .leading, spacing: 8) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black.opacity(0.2))
                        .blendMode(.overlay)
                        .frame(height: 90)
                        .overlay(
                            Image("Illustration 3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 100)
                        )
                    Text("Consumption Report")
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                        .layoutPriority(1)
                    Text("Major Consumables")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)
                    Text("Only Stents, Wires, Balloons, contrast etc.")
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
                        .fill(LinearGradient(colors: [.indigo, .blue], startPoint: .top, endPoint: .bottomTrailing))
                        .rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0), anchor: .bottomTrailing)
                        .rotationEffect(.degrees(180))
                        .padding(.trailing, 40)
                )
                .shadow(color: .clear, radius: 0, x: 0, y: 0)
                .onTapGesture {
                    showCons = true
                }
                VStack(alignment: .leading, spacing: 8) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black.opacity(0.2))
                        .blendMode(.overlay)
                        .frame(height: 90)
                        .overlay(
                            Image("Illustration 4")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 100)
                        )
                    Text("View Reports")
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                        .layoutPriority(1)
                    Text("Restricted Access!")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)
                    Text("Only persons with authorization")
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
                        .fill(LinearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottomTrailing))
                        .rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0), anchor: .bottomTrailing)
                        .rotationEffect(.degrees(180))
                        .padding(.trailing, 40)
                )
                .shadow(color: .clear, radius: 0, x: 0, y: 0)
                .onTapGesture {
                    showProcByCentre = true
                }
            }
            .offset(y: -50)
            .padding(.top, 40)
            .padding(.horizontal, 20)
        }
        .sheet(isPresented: $showProc) {
            ProcedureRepView()
        }
        .sheet(isPresented: $showRev) {
            RevenueRepView()
        }
        .sheet(isPresented: $showCons) {
           ConsumptionRepView()
        }
        .sheet(isPresented: $showProcByCentre) {
          ViewReportsView()
        }
        .coordinateSpace(name: "scroll")
        .overlay(NavigationBar(title: "Reports", contentHasScrolled: $contentHasScrolled))
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
