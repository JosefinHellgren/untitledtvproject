//
//  ShowEntryView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

struct ShowEntryView : View {
    @StateObject private var viewModel: ShowEntryViewModel = ShowEntryViewModel()
    
    @State var show2 : ApiShows.Returned
    @State var name : String = ""
    @State var language : String = ""
    @State var summary: String = ""
    
    @State var image: ApiShows.Image?
    @State var type: String = ""
    @State var network: ApiShows.Network?
    @State var status: String = ""
    @State var premiered: String = ""
    
    @State var scale = 0.1
    
    @State var showPopUp = false
    
    @State var listChoice = ""
    
    @State var showingAlertPopUp = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image?.medium ?? "https://i.imgur.com/e3AEk4W.png")) //gets an imgur image as default if no image exists
                .padding(.top, 100)
                .padding(.bottom, -90)
                .ignoresSafeArea()
            Text("\(name)")
                .font(.largeTitle)
            Text("Summary: \(summary)")
                .padding(.top, -10)
                .padding(10)
                NavigationLink {
                    ShowEntryMoreView(show2: show2, name: show2.show.name, language: show2.show.language, summary: show2.show.summary, image: show2.show.image, type: show2.show.type, network: show2.show.network, status: show2.show.status, premiered: show2.show.premiered, rating: show2.show.rating!)
                } label: {
                    Text("Show more information")
                }
            Spacer()
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
                        Button(action: {
                            showPopUp = true
                        }) {
                            Image("plus.app.fill 1")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                .scaleEffect(scale)
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
            .confirmationDialog("Add to what list?", isPresented: $showPopUp, actions: {
                VStack {
                    HStack {
                        Button("Want to watch") {
                            listChoice = "wantToWatch"
                            viewModel.saveToFireStore(show2: show2, listChoice: "wantToWatch")
                        }
                        Button("Watching") {
                            listChoice = "watching"
                            viewModel.saveToFireStore(show2: show2, listChoice: "watching")
                        }
                    }
                    HStack {
                        Button("Completed") {
                            listChoice = "completed"
                            viewModel.saveToFireStore(show2: show2, listChoice: "completed")
                        }
                        Button("Dropped") {
                            listChoice = "dropped"
                            viewModel.saveToFireStore(show2: show2, listChoice: "dropped")
                        }
                    }
                }
            })
            .alert("Show added!", isPresented: $showingAlertPopUp) {
                Button("Go it!", role: .cancel) { }
            }
            .navigationBarBackButtonHidden(false)
        }
        .background(Color(.systemGray6))
        .onAppear() {
            viewModel.setContent()
            _ = Animation.easeInOut(duration: 1)

            withAnimation {
                scale = 1
            }
        }
    }



}
