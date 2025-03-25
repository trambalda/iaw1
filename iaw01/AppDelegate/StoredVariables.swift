enum StoredVariables {
    case isOnboardingCompleted
    
    var name: String {
        switch self {
        case .isOnboardingCompleted: return "isOnboardingCompleted"
        }
    }
} 