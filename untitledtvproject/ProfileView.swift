//
//  ProfileView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-30.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase

struct ProfileView: View {
    @StateObject var showList = ShowList()
    let db = Firestore.firestore()
    
    //language lists
    @State var englishList : [ApiShows.Returned] = []
    @State var swedishList : [ApiShows.Returned] = []
    @State var koreanList : [ApiShows.Returned] = []
    @State var thaiList : [ApiShows.Returned] = []
    @State var chineseList : [ApiShows.Returned] = []
    @State var japaneseList : [ApiShows.Returned] = []
    @State var danishList : [ApiShows.Returned] = []
    @State var norwegianList : [ApiShows.Returned] = []
    @State var germanList : [ApiShows.Returned] = []
    @State var frenchList : [ApiShows.Returned] = []
    @State var dutchList : [ApiShows.Returned] = []
    @State var polishList : [ApiShows.Returned] = []
    @State var spanishList : [ApiShows.Returned] = []
    @State var turkishList : [ApiShows.Returned] = []
    @State var greekList : [ApiShows.Returned] = []
    @State var allLanguages : [ApiShows.Returned] = []
    //genre lists
    @State var dramaList : [ApiShows.Returned] = []
    @State var comedyList : [ApiShows.Returned] = []
    @State var scifiList : [ApiShows.Returned] = []
    @State var horrorList : [ApiShows.Returned] = []


        
    var newColor = Color(red: 243 / 255, green: 246 / 255, blue: 255 / 255)
    
    var user = Auth.auth().currentUser
    
    @State var signedIn = true
    @State var wantToSignUp = false
    @State var createdAccount = false
    
    @State var showingLangWindow = false
    @State var showingGenreWindow = false
        
    var body: some View {
        if !signedIn {
            LoginView(signedIn: $signedIn, wantToSignUp: $wantToSignUp, createdAccount: $createdAccount)
        } else {
            VStack {
                HStack {
                    Image("defaultprofilepic") //will be user image + (if no profile pic, then use this default one) --- >>>user.photoURL<<<
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(10)
                        .padding(.top, 10)
                    Text(user?.email ?? "") //maybe change to username
                    Spacer()
                    Button(action: {
                        logOut()
                    }) {
                        Image("info.circle")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    }
                    .padding(10)
                    .padding(.top, 10)
                }
                Spacer()
                Text("Another way of seeing your data")
                Spacer()
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(newColor)
                            .aspectRatio(1.0, contentMode: .fit)
                        Canvas { context, size in
                            var slices: [(Double, Color, String)] = [(Double(englishList.count), .red, "English"),
                                                             (Double(swedishList.count), .blue, "Swedish"),
                                                             (Double(koreanList.count), .green, "Korean"),
                                                             (Double(thaiList.count), .purple, "Thai"),
                                                             (Double(chineseList.count), .yellow, "Chinese"),
                                                             (Double(japaneseList.count), .black, "Japanese"),
                                                             (Double(danishList.count), .pink, "Danish"),
                                                             (Double(norwegianList.count), .cyan, "Norwegian"),
                                                             (Double(germanList.count), .orange, "German"),
                                                             (Double(frenchList.count), .teal, "French"),
                                                             (Double(dutchList.count), .white, "Dutch"),
                                                             (Double(polishList.count), .mint, "Polish"),
                                                             (Double(spanishList.count), .indigo, "Spanish"),
                                                             (Double(turkishList.count), .gray, "Turkish"),
                                                             (Double(greekList.count), .brown, "Greek")]
                            let total = slices.reduce(0) { $0 + $1.0 }
                            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
                            var pieContext = context
                            pieContext.rotate(by: .degrees(-90))
                            let radius = min(size.width, size.height) * 0.48
                            var startAngle = Angle.zero
                            for (value, color, text) in slices {
                                let angle = Angle(degrees: 360 * (value / total))
                                let endAngle = startAngle + angle
                                let path = Path { p in
                                    p.move(to: .zero)
                                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                                    p.closeSubpath()
                                }
                                pieContext.fill(path, with: .color(color))

                                startAngle = endAngle
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                        Button("Languages") {
                            showingLangWindow = true
                        }
                        .foregroundColor(.white)
                        .alert("Percentage split", isPresented: $showingLangWindow) { //change so it doesnt show empty language lists
                            VStack {
                                Button("English: \(Double(englishList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Swedish: \(Double(swedishList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Korean: \(Double(koreanList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Thai: \(Double(thaiList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Chinese: \(Double(chineseList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Cancel", role: .cancel) { }
                            }
                        }
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(newColor)
                            .aspectRatio(1.0, contentMode: .fit)
                        Canvas { context, size in
                            var slices: [(Double, Color)] = [(Double(comedyList.count), .red),
                                                             (Double(dramaList.count), .blue),
                                                             (Double(horrorList.count), .green),
                                                             (Double(scifiList.count), .purple)]
                            let total = slices.reduce(0) { $0 + $1.0 }
                            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
                            var pieContext = context
                            pieContext.rotate(by: .degrees(-90))
                            let radius = min(size.width, size.height) * 0.48
                            var startAngle = Angle.zero
                            for (value, color) in slices {
                                let angle = Angle(degrees: 360 * (value / total))
                                let endAngle = startAngle + angle
                                let path = Path { p in
                                    p.move(to: .zero)
                                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                                    p.closeSubpath()
                                }
                                pieContext.fill(path, with: .color(color))

                                startAngle = endAngle
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                        Button("Genres") {
                            showingGenreWindow = true
                        }
                        .foregroundColor(.white)
                        .alert("Percentage split", isPresented: $showingGenreWindow) { //not correct for genres
                            VStack {
                                Button("Comedy: \(Double(comedyList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Drama: \(Double(dramaList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Horror: \(Double(horrorList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Science-Fiction: \(Double(scifiList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Cancel", role: .cancel) { }
                            }
                        }
                    }
                }
                .padding(10)
                .padding(.bottom, -20)
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(newColor)
                        .aspectRatio(1.0, contentMode: .fit)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(newColor)
                        .aspectRatio(1.0, contentMode: .fit)
                }
                .padding(10)
                .padding(.bottom, -20)
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(newColor)
                        .aspectRatio(1.0, contentMode: .fit)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(newColor)
                        .aspectRatio(1.0, contentMode: .fit)
                }
                .padding(10)
                Spacer()
            }
            .task {
                DispatchQueue.main.async {
                    listenToFireStore()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        NavigationLink(destination: OverView()) {
                            Image("house.fill")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image("redstats")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image("plus.app")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image("square.and.pencil.circle.fill")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image("person.crop.circle.fill")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    func listenToFireStore() {
        guard let user = Auth.auth().currentUser else {return}
        
        db.collection("users").document(user.uid).collection("Completed").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                allLanguages.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        allLanguages.append(show)
                        clearLists()
                        for show in allLanguages {
                            if show.show.language == "English" {
                                englishList.append(show)
                            }
                            if show.show.language == "Swedish" {
                                swedishList.append(show)
                            }
                            if show.show.language == "Korean" {
                                koreanList.append(show)
                            }
                            if show.show.language == "Thai" {
                                thaiList.append(show)
                            }
                            if show.show.language == "Chinese" {
                                chineseList.append(show)
                            }
                            if show.show.language == "Japanese" {
                                japaneseList.append(show)
                            }
                            if show.show.language == "Danish" {
                                danishList.append(show)
                            }
                            if show.show.language == "Norwegian" {
                                norwegianList.append(show)
                            }
                            if show.show.language == "German" {
                                germanList.append(show)
                            }
                            if show.show.language == "French" {
                                frenchList.append(show)
                            }
                            if show.show.language == "Dutch" {
                                dutchList.append(show)
                            }
                            if show.show.language == "Polish" {
                                polishList.append(show)
                            }
                            if show.show.language == "Spanish" {
                                spanishList.append(show)
                            }
                            if show.show.language == "Turkish" {
                                turkishList.append(show)
                            }
                            if show.show.language == "Greek" {
                                greekList.append(show)
                            }
                            if ((show.show.genres?.contains("Comedy")) != nil) {
                                comedyList.append(show)
                            }
                            if ((show.show.genres?.contains("Drama")) != nil) {
                                dramaList.append(show)
                            }
                            if ((show.show.genres?.contains("Horror")) != nil) {
                                horrorList.append(show)
                            }
                            if ((show.show.genres?.contains("Science-Fiction")) != nil) {
                                scifiList.append(show)
                            }
                        }
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
    }
    func clearLists() {
        englishList.removeAll()
        swedishList.removeAll()
        koreanList.removeAll()
        thaiList.removeAll()
        chineseList.removeAll()
        japaneseList.removeAll()
        danishList.removeAll()
        norwegianList.removeAll()
        germanList.removeAll()
        frenchList.removeAll()
        dutchList.removeAll()
        polishList.removeAll()
        spanishList.removeAll()
        turkishList.removeAll()
        greekList.removeAll()
        
        dramaList.removeAll()
        comedyList.removeAll()
        horrorList.removeAll()
        scifiList.removeAll()
    }
    func logOut() {
        do {
            try Auth.auth().signOut()
            //Auth.auth().currentUser == nil
            signedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }/*
    func getUserData() {
        let user = Auth.auth().currentUser
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
          let uid = user.uid
          let email = user.email
          let photoURL = user.photoURL
          var multiFactorString = "MultiFactor: "
          for info in user.multiFactor.enrolledFactors {
            multiFactorString += info.displayName ?? "[DispayName]"
            multiFactorString += " "
          }
          // ...
        }
    }*/
}
/*
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}*/
