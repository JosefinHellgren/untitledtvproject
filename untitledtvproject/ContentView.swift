//
//  ContentView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase

struct ContentView: View {
    
    @State var signedIn = false
    
    @State var wantToSignUp = false
    
    @State var createdAccount = false
    
    var body: some View {
        if !wantToSignUp && !createdAccount {
            LoginView(signedIn: $signedIn, wantToSignUp: $wantToSignUp)
        }
        if wantToSignUp {
            SignUpView(wantToSignUp: $wantToSignUp, createdAccount: $createdAccount)
        }
        if createdAccount || signedIn {
            OverView()
        }
    }
}
struct LoginView: View {
    
    @Binding var signedIn : Bool
    @Binding var wantToSignUp : Bool
    
    @State var userInput : String = ""
    @State var pwInput : String = ""
    
    var newColor = Color(red: 243 / 255, green: 246 / 255, blue: 255 / 255)
    
    var body: some View {
        VStack {
            Text("Sign in")
            TextField("Username", text: $userInput)
                .padding()
                .background(newColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $pwInput)
                .padding()
                .background(newColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            Button(action: { signIn() }) {
                Text("Sign in")}
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
            Button(action: { wantToSignUp = true }) {
                Text("No account? Create account here")}
        }
    }
    func signIn() {
        Auth.auth().signIn(withEmail: userInput, password: pwInput) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                signedIn = true
                print("success")
            }
        }
    }
}
struct SignUpView: View {
    
    @Binding var wantToSignUp : Bool
    
    @Binding var createdAccount : Bool
    
    @State var userInput : String = ""
    @State var pwInput : String = ""
    
    var newColor = Color(red: 243 / 255, green: 246 / 255, blue: 255 / 255)
    
    var body: some View {
        VStack {
            Text("Create account")
            TextField("Username", text: $userInput)
                .padding()
                .background(newColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $pwInput)
                .padding()
                .background(newColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            Button(action: { signUp() }) {
                Text("Create account")}
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
            Button(action: { wantToSignUp = false }) {
                Text("Already got an account? Log in here!")}
        }
    }
    func signUp() {
        Auth.auth().createUser(withEmail: userInput, password: pwInput) { result, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
                return
            }
            if (result?.user.uid != nil) { createdAccount = true ; wantToSignUp = false }
        }
    }
}
struct OverView : View {
    
    @State var searchScope = ApiShows.SearchScope.name
        
    @StateObject var showList = ShowList()
    @StateObject var apiShows = ApiShows()
    
    @State var searchText = ""
        
    @State var singleItemList : [ApiShows.Returned] = []

    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section {
                        ForEach(filteredMessages) { returned in
                            NavigationLink(destination: ShowEntryView(show2: returned, name: returned.show.name, language: returned.show.language, summary: returned.show.summary, image: returned.show.image)) {
                                RowTest(showTest: returned)
                            }
                        }
                    }
                   .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                   .searchScopes($searchScope) {
                       ForEach(ApiShows.SearchScope.allCases, id: \.self) { scope in
                           Text(scope.rawValue.capitalized)
                       }
                   }
                   .onSubmit(of: .search, getData)
                   .onChange(of: searchScope) { _ in getData()}
                   .disableAutocorrection(true)
                    /*
                    Section(header: Text("Want to watch")) {
                        ForEach(showList.lists[.wantToWatch]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language, summary: show.summary)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .wantToWatch)
                        }
                    }
                    Section(header: Text("Watching")) {
                        ForEach(showList.lists[.watching]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language, summary: show.summary)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .watching)
                        }
                    }
                    Section(header: Text("Completed")) {
                        ForEach(showList.lists[.completed]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language, summary: show.summary)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .completed)
                        }
                    }
                    Section(header: Text("Dropped")) {
                        ForEach(showList.lists[.dropped]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language, summary: show.summary)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .dropped)
                        }
                    }
                    .onAppear() {
                        apiShows.getData {}
                    }
                    Section(header: Text("Recently deleted")) {
                        ForEach(showList.lists[.recentlyDeleted]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language, summary: show.summary)) {
                                RowView(show: show)
                            }
                        }
                    }*/
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            HStack {
                                Button(action: {
                                    //do nothing
                                }) {
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
                                NavigationLink(destination: ProfileView()) {
                                    Image("person.crop.circle.fill")
                                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    var filteredMessages: [ApiShows.Returned] {
        if searchText.isEmpty {
            return singleItemList
        } else {
            if singleItemList.isEmpty {
                return singleItemList
            }
            return singleItemList.filter { $0.show.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    func getData() {
        
        searchText = searchText.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://api.tvmaze.com/search/shows?q=\(searchText)"
        
        print("trying to access the url \(urlString)")
        
        //Create url
        guard let url = URL(string: urlString) else {
            print("Error could not create url from \(urlString)")
            return
        }
        searchText = searchText.replacingOccurrences(of: "%20", with: " ") //problem med house of the dragon "-" "-" something
        
        //create urlsession
        let session = URLSession.shared
        //get data with .dataTask method
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error \(error.localizedDescription)")
            }
            //deal with the data
            do {
                apiShows.searchArray = try JSONDecoder().decode([ApiShows.Returned].self, from: data!)
                singleItemList.removeAll()
                singleItemList.append(apiShows.searchArray[0])
                
            } catch {
                print("catch: json error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
struct RowTest : View {
    var showTest : ApiShows.Returned
    
    var body: some View {
        HStack {
            Text(showTest.show.name)
        }
    }
}
struct RowView : View {
    var show : ShowEntry
    
    var body: some View {
        HStack {
            Text(show.name)
        }
    }
}
/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */
