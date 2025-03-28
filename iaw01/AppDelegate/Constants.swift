import UIKit

struct Screen {
    static let isIPhoneSE = UIScreen.main.bounds.height == 667
}

struct UserDefaultsKeys {
    static let isOnboardingCompletedKey = "isOnboardingCompleted"
} 