import Foundation

struct QuantityCalculator {
    
    func increaseQuantity(currentQuantity: Int) -> Int {
        var value = currentQuantity
        
        if currentQuantity > 99 {
            return currentQuantity
        } else {
            value += 1
        }
        return value
    }
    
    func decreaseQuantity(currentQuantity: Int) -> Int {
        var value = currentQuantity
        
        if currentQuantity < 0 {
            return currentQuantity
        } else {
            value -= 1
        }
        return value
    }
}
