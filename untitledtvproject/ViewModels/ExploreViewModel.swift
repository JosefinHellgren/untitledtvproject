//
//  ExploreViewModel.swift
//  untitledtvproject
//
//  Created by josefin hellgren on 2023-06-09.
//

import Foundation

class ExploreViewModel : ObservableObject{
    
    @Published var exploreList: [ApiShows.Show] = []
       @Published var hboList: [ApiShows.Show] = []
       @Published var foxList: [ApiShows.Show] = []
       @Published var abcList: [ApiShows.Show] = []
       @Published var cbsList: [ApiShows.Show] = []
       @Published var itv1List: [ApiShows.Show] = []
       @Published var nbcList: [ApiShows.Show] = []
       @Published var showTimeList: [ApiShows.Show] = []
    
    func getData() { //get data for all shows in the api. For some reason these objects could not look the same as everything else (eg. apishows.returned, so these are instead apishows.show. Which works to display the images I want to display but I cant make them become contextual navigationlinks that shows the show inside the showentryview. so these images are more like a library.
        
        let urlStringAll = "https://api.tvmaze.com/shows"
                
        guard let url = URL(string: urlStringAll) else {
            print("Error could not create url from \(urlStringAll)")
            return
        }
        
        exploreList.removeAll()
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [self] data, response, error in
            if let error = error {
                print("error \(error.localizedDescription)")
            }
            do {
                            if let data = data {
                                let shows = try JSONDecoder().decode([ApiShows.Show].self, from: data)
                                
                                DispatchQueue.main.async {
                                    self.exploreList = shows
                                    self.distributeData()
                                }
                            }
                        } catch {
                            print("Error: JSON decoding error: \(error.localizedDescription)")
                        }
                    }
                    
        task.resume()
    }
    
    func distributeData() {
        for item in exploreList {
            if item.network?.name! == "HBO" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                      
                        DispatchQueue.main.async {
                            self.hboList.append(item)
                                            }
                      
                    
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "FOX" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        DispatchQueue.main.async {
                            self.foxList.append(item)
                                            }
                      
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "ABC" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        DispatchQueue.main.async {
                            self.abcList.append(item)
                                            }
                      
                    
                       
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "NBC" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        DispatchQueue.main.async {
                            self.nbcList.append(item)
                                            }
                      
                    
                        
                       
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "CBS" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        
                        DispatchQueue.main.async {
                            self.cbsList.append(item)
                                            }

                    
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "Showtime" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        
                        DispatchQueue.main.async {
                            self.showTimeList.append(item)
                                            }

                       
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "ITV1" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        
                        DispatchQueue.main.async {
                            self.itv1List.append(item)
                                            }

                    }
                }
            }
        }
        
        
        
        
    }
    
}
