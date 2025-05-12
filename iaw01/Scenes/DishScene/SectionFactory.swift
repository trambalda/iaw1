import UIKit

struct SectionFactory {
    
    static func makeSections(from model: DishModel) -> [DishOptionView] {
        var sections: [DishOptionView] = []
        
        switch model.type {
        case .combo:
            if let sideItems = model.sideItems, !sideItems.isEmpty {
                let sideCategory = DrinkCategory(name: "Side Item", subcategories: nil, options: sideItems)
                let section = DishOptionView(title: sideCategory.name, isRequired: true, category: sideCategory)
                sections.append(section)
            }
            
            if let drinkCategories = model.drinks, !drinkCategories.isEmpty {
                for drinkCategory in drinkCategories {
                    let section = DishOptionView(title: drinkCategory.name, isRequired: true, category: drinkCategory)
                    sections.append(section)
                }
            }
           
            if let editableIngredients = model.editableIngredients, !editableIngredients.isEmpty {
                let section = DishOptionView(title: "Edit Ingredients", isRequired: false, category: nil)
                sections.append(section)
            }
        case .customizable:
            if let editableIngredients = model.editableIngredients, !editableIngredients.isEmpty {
                let editCategory = DrinkCategory(name: "Edit Ingredients", subcategories: nil, options: editableIngredients)
                let section = DishOptionView(title: editCategory.name, isRequired: false, category: editCategory)
                sections.append(section)
            }
        case .fixed:
            break
        }
        
        return sections
    }
}
