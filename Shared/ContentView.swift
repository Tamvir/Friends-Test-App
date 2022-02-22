//
//  ContentView.swift
//  Shared
//
//  Created by MD Ehteshamul Haque Tamvir on 21/2/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var httpRequestProvider: HttpRequestManager
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)], spacing: 20) {
                    ForEach (httpRequestProvider.users) { user in
                        NavigationLink(destination: DetailedContentView(user: user)) {
                            VStack {
                                Divider()
                                let imageUrl:URL = URL(string: user.picture.large)!
                                // Start background thread so that image loading does not make app unresponsive
                                let imageData:NSData = NSData(contentsOf: imageUrl)!
                                let image = UIImage(data: imageData as Data)
                                // dispatch back to the main thread to update UI
                                Image(uiImage: image!)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                    .overlay(Circle().stroke(Color.red, lineWidth: 5))
                                
                                VStack(alignment: .leading){
                                    Text("\(user.name.title) \(user.name.first) \(user.name.last)" )
                                        .font(.largeTitle)
                                        .foregroundColor(Color.white)
                                    Text("\(user.location.country)")
                                        .font(.title2)
                                        .foregroundColor(Color.white)
                                }
                            }
                        }
                        .navigationTitle("Friends")
                        .frame(width: UIScreen.main.bounds.width/2.1 - 48, height: UIScreen.main.bounds.width/2.1 - 48, alignment: .center)
                        .background(Rectangle().foregroundColor(.blue))
                            .cornerRadius(5)
                    }
                }
            }
            .onAppear {
                httpRequestProvider.getOrPostData(endPoint: Endpoint)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(HttpRequestManager())
    }
}

struct DetailedContentView: View {
    let user : User
    var body: some View {
        ScrollView {
            VStack {
                let imageUrl:URL = URL(string: user.picture.large)!
                // Start background thread so that image loading does not make app unresponsive
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                let image = UIImage(data: imageData as Data)
                // dispatch back to the main thread to update UI
                Image(uiImage: image!)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.blue, lineWidth: 5))
                
                Text("\(user.name.title) \(user.name.first) \(user.name.last)" )
                    .font(.largeTitle)
                    .foregroundColor(Color.blue)
                Text("\(user.location.address.number) \(user.location.address.name)")
                    .font(.title2)
                    .foregroundColor(Color.blue)
                Text("\(user.location.city) \(user.location.state)")
                    .font(.title3)
                    .foregroundColor(Color.blue)
                Text("\(user.location.country)")
                    .font(.title3)
                    .foregroundColor(Color.blue)
                Text("\(user.email)")
                    .font(.title3)
                    .foregroundColor(Color.blue)
                    .onTapGesture {
                        if let url = URL(string: "mailto:\(user.email)") {
                          if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url)
                          } else {
                            UIApplication.shared.openURL(url)
                          }
                        }
                    }
                Text("\(user.cell)")
                    .font(.title3)
                    .foregroundColor(Color.blue)
            }.navigationTitle("Details")
        }
    }
}
