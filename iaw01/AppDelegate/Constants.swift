import UIKit

enum Constants {
    enum Screen {
        static let isIPhoneSE = UIScreen.main.bounds.height == 667
    }
    
    enum UserDefaults {
        case isOnboardingCompleted
        
        var key: String {
            switch self {
            case .isOnboardingCompleted: return "isOnboardingCompleted"
            }
        }
    }
} 