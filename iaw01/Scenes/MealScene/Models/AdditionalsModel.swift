import UIKit

struct Additionals {
    var itemImage: UIImage
    
    var itemTitle: String
    
    var price: String?
    
    var editableField: Bool?
    
    var type: AdditionalType
}

enum AdditionalType {
    case select
    
    case add
}
