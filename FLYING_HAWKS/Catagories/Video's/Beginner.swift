//
//  Beginner.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//



import SwiftUI
import AVKit


struct VideoFetching: View {
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "B-1", withExtension: "mov")!))
                        .frame(height: 500)
                    
                    VStack {
                        Text("🔘. Use your legs to generate power. When you dive, don't just use your arms. Use your legs to generate power and help you to reach the ball.\n 🔘. Keep your eyes on the ball. Don't take your eyes off the ball until you have made the save. This will help you to track the ball's flight and make sure that you dive in the right direction.\n🔘. Don't be afraid to dive. If you are afraid to dive, you will not be able to make saves. So get over your fear and start diving!")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
            .navigationTitle("TIP OF THE DAY.")
        }
    }
}

struct VedioFetching_Previews: PreviewProvider {
    static var previews: some View {
        VideoFetching()
            .preferredColorScheme(.dark)
    }
}



//import AVKit
//import FirebaseStorage
//
//struct VideoPlayerView: UIViewControllerRepresentable {
//    let videoURL: URL
//
//    func makeUIViewController(context: Context) -> AVPlayerViewController {
//        let player = AVPlayer(url: videoURL)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        return playerViewController
//    }
//
//    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
//         //Update the player if needed
//    }
//}
//
//class VideoURLsViewModel: ObservableObject {
//    @Published var videoURLs: [URL] = []
//
//    func fetchVideoURLs() {
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//
//        let videoNames = ["B-1.mov"]
//
//        let dispatchGroup = DispatchGroup()
//
//        for name in videoNames {
//            dispatchGroup.enter()
//
//            let videoRef = storageRef.child("Video/\(name)")
//
//            videoRef.downloadURL { url, error in
//                if let url = url {
//                    self.videoURLs.append(url)
//                } else {
//                    print("Failed to fetch download URL for video \(name):", error?.localizedDescription ?? "")
//                }
//
//                dispatchGroup.leave()
//            }
//        }
//
//        dispatchGroup.notify(queue: .main) {
//            print("Video URLs fetched:", self.videoURLs)
//        }
//    }
//}
//
//struct VideoFetching: View {
//    @StateObject var viewModel = VideoURLsViewModel()
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color("Color")
//                    .ignoresSafeArea(.all)
//            ScrollView {
//                    VStack {
//                        if viewModel.videoURLs.isEmpty {
//                            Text("Loading videos...")
//                        } else {
//                            ForEach(viewModel.videoURLs, id: \.self) { url in
//                                VideoPlayerView(videoURL: url)
//                                    .frame(height: 300)
//                            }
//                        }
//                    }
//                    .onAppear {
//                        viewModel.fetchVideoURLs()
//                    }
//                }
//            .navigationTitle("Beginner Level")
//            }
//        }
//    }
//}
//
//struct VideoFetching_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoFetching()
//    }
//}
//
//
