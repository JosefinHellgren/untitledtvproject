//
//  ExploreView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-02-22.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject private var viewModel: ExploreViewModel = ExploreViewModel()
    
 
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("🔥 Top Shows on HBO")
                    .font(.system(size: 20))
                    .frame(width: 380, alignment: .leading)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.hboList, id: \.id) { show in
                                AsyncImage(url: URL(string: show.image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
                                    .frame(width: 140, height: 210)
                            }
                        }
                    }
                }
                Text("📺 Top Shows on FOX")
                    .font(.system(size: 20))
                    .frame(width: 380, alignment: .leading)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.foxList, id: \.id) { show in
                                AsyncImage(url: URL(string: show.image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
                                    .frame(width: 140, height: 210)
                            }
                        }
                    }
                }
                Text("🙉 Top Shows on CBS")
                    .font(.system(size: 20))
                    .frame(width: 380, alignment: .leading)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.cbsList, id: \.id) { show in
                                AsyncImage(url: URL(string: show.image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
                                    .frame(width: 140, height: 210)
                            }
                        }
                    }
                }
                Text("😉 Top Shows on ABC")
                    .font(.system(size: 20))
                    .frame(width: 380, alignment: .leading)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.abcList, id: \.id) { show in
                                AsyncImage(url: URL(string: show.image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
                                    .frame(width: 140, height: 210)
                            }
                        }
                    }
                }
                Text("❤️ Top Shows on NBC")
                    .font(.system(size: 20))
                    .frame(width: 380, alignment: .leading)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.nbcList, id: \.id) { show in
                                AsyncImage(url: URL(string: show.image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
                                    .frame(width: 140, height: 210)
                            }
                        }
                    }
                }
            }
            .background(Color(.systemGray6))
        }
        .background(Color(.systemGray6))
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
                    NavigationLink(destination: OverView(selectedRowBgColor: "", selectedTextColor: "")) {
                        Image("house.fill")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    }
                    .isDetailLink(false)
                    Spacer()
                    NavigationLink(destination: StatsView()) {
                        
                        Image("redstats")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    }
                    Spacer()
                    NavigationLink(destination: SearchView()) {
                        
                        Image("magnifyingglass.circle.fill")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    }
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image("square.and.pencil.circle.fill_grey")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    }
                    Spacer()
                    NavigationLink(destination: ProfileView(selectedUserName: "", userName: "")) {
                        Image("person.crop.circle.fill")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    }
                    .isDetailLink(false)
                }
            }
        }
        .onAppear() {
            viewModel.getData()
        }
    }
    
    
 
       
}

