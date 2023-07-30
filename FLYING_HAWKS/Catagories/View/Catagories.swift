
import SwiftUI
import UserNotifications


class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert,.sound,.badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error on Notification Permission\(error)")
            } else {
                print("Success✅")
            }
        }
    }
    func scheduleNotification(subtitle: String, title: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

struct Catagories: View {
    var body: some View {
        NavigationView {
            catagories()
                .navigationTitle("Flying Hawks")
                .toolbarBackground(Color("Color1"), for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .preferredColorScheme(.dark)
        }
    }
}

struct Catagories_Previews: PreviewProvider {
    static var previews: some View {
        Catagories()
    }
}

struct catagories :View {
    @State private var title = "Flying Hawks"
    @State var isAlarmBeginner: Bool = true
    @State var isAlarmAmateur: Bool = true
    
    var body: some View {
        ZStack {
            Color("Color1")
                .ignoresSafeArea()
            VStack {
                VStack {
                    VStack(spacing: 10) {
                        Image("begginer")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(30)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.50), radius: 0, x: 8, y: 10)
                            .frame(width: 270, height: 215)
                        Text("FOR BEGINNER")
                            .foregroundColor(.white)
                            .font(.title3.bold())
                        
                        HStack {
                            NavigationLink {
                                VideoFetching()
                            } label: {
                                Text("Let's Enroll")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: 275, height: 36)
                                    .background(Color("Color2"))
                                    .clipShape(Capsule())
                            }
                            Button {
                                NotificationManager.instance.requestAuthorization()
                                // Check if the bell icon is in the unfilled state (isAlarmBeginner is true)
                                if isAlarmBeginner {
                                    // If the bell icon is unfilled, schedule the notification. If true case than the we scheduleNotificaton !
                                    NotificationManager.instance.scheduleNotification(subtitle: "Today's tip: master your positioning. Watch now! ⚽️", title: "🏅 Get better every day!")
                                }
                                isAlarmBeginner.toggle()
                            } label: {
                                Image(systemName: isAlarmBeginner ? "bell.and.waveform" : "bell.and.waveform.fill")
                                    .foregroundColor(Color("Color2"))
                            }
                        }
                    }
                }
                .padding(.bottom)
                
                ZStack {
                    VStack(spacing: 10) {
                        Image("David")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(30)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.50), radius: 0, x: 8, y: 10)
                            .frame(width: 270, height: 215)
                        
                        Text("AMATEUR")
                            .foregroundColor(.white)
                            .font(.title3.bold())
                        
                        HStack {
                            NavigationLink {
                                VideoFetchingAmerteur()
                            } label: {
                                Text("Let's Enroll")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: 275, height: 36)
                                    .background(Color("Color2"))
                                    .clipShape(Capsule())
                            }
                            Button {
                                NotificationManager.instance.requestAuthorization()
                                // Schedule the notification only if the bell icon changes to fill state
                                if isAlarmAmateur {
                                    NotificationManager.instance.scheduleNotification(subtitle: "Discover a game-changing tip for reflex training. Don't miss it! 🎬 ", title: "🎯 Focus on precision!")
                                }
                                isAlarmAmateur.toggle()
                            } label: {
                                Image(systemName: isAlarmAmateur ? "bell.and.waveform" : "bell.and.waveform.fill")
                                    .foregroundColor(Color("Color2"))
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
            .padding(.top,150)
        }
        .ignoresSafeArea(.all)
    }
}

