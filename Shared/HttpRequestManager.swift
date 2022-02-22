//
//  HttpRequestManager.swift
//  Shared
//
//  Created by MD Ehteshamul Haque Tamvir on 21/2/22.
//

import Foundation

protocol HttpRequestProvider {
    func getOrPostData(endPoint : String)
}

class HttpRequestManager : ObservableObject, HttpRequestProvider {
    @Published var users: [User] = []
    var count = 1
    func getOrPostData(endPoint : String) {
        let url = URL(string: endPoint)!

        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
            
            DispatchQueue.main.async {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let results = json["results"] as? [[String:Any]] {
                            for result in results {
                                
                                let names = result["name"] as! Dictionary<String, AnyObject>
                                let name = User.Names(title: names["title"] as! String, first: names["first"] as! String, last: names["last"] as! String)
                                
                                let locations = result["location"] as! Dictionary<String, AnyObject>
                                let addresses = locations["street"] as! Dictionary<String, AnyObject>
                                let address = User.Address(number: addresses["number"] as! Int64, name: addresses["name"] as! String)
                                
                                let location = User.Location(address: address, city: locations["city"] as! String, state: locations["state"] as! String, country: locations["country"] as! String)
                                
                                let pictures = result["picture"] as! Dictionary<String, AnyObject>
                                let picture = User.Picture(large: pictures["large"] as! String, medium: pictures["medium"] as! String, thumbnail: pictures["thumbnail"] as! String)
                                let user = User(id: Int64(self.count), name: name, email: result["email"] as! String, location: location, cell: result["cell"] as! String, picture: picture)
                                self.users.append(user)
                                self.count += 1
                                print("\(user.name.title) \(user.name.first) \(user.name.last)")
                            }
                        }
                    }
                        
                } catch let error {
                    print("Error decoding: ", error)
                }
            }
            
        }.resume()
    }
}
