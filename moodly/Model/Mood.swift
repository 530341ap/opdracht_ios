import UIKit

class Mood {
    let calendar = Calendar.current
    var date: Date
    var category: Category
    var activities: [Activity] = []
    
    init(date: Date, category: Category, activities: [Activity] = []) {
        self.date = date
        self.category = category
        self.activities = activities
    }
    
    func year() -> Int {
        return calendar.component(.year, from: self.date)
    }
    
    func month() -> Int {
        return calendar.component(.month, from: self.date)
    }
}
