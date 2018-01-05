import UIKit

class User {
    let calendar = Calendar.current
    var categories: [Category] = [
        Category(name: "Amazing", color: UIColor(red: 0.95, green:0.76, blue:0.20, alpha:1.0)),
        Category(name: "Good", color: UIColor(red:0.45, green:0.69, blue:0.29, alpha:1.0)),
        Category(name: "Meh", color: UIColor(red:0.40, green:0.31, blue:0.65, alpha:1.0)),
        Category(name: "Not good", color: UIColor(red:0.24, green:0.52, blue:0.78, alpha:1.0)),
        Category(name: "Horrible", color: UIColor(red:0.91, green:0.28, blue:0.28, alpha:1.0))
        ]
    
    var activities: [Activity] = [
        Activity(name: "Working", icon: "💼"),
        Activity(name: "Eating", icon: "🍽"),
        Activity(name: "Sleeping in", icon: "🛌"),
        Activity(name: "Swimming", icon: "🏊🏻‍♀️"),
        Activity(name: "Gaming", icon: "🎮"),
        Activity(name: "Ice skating", icon: "⛸"),
        Activity(name: "Date night", icon: "💑"),
        Activity(name: "Baking", icon: "🍰"),
        Activity(name: "Listening to music", icon: "🎧"),
        Activity(name: "Writing", icon: "🖌"),
        Activity(name: "Shopping", icon: "🛍"),
        Activity(name: "Singing", icon: "🎤")
    ]
    
    var moods: [Mood]
    
    init() {
        moods = [
            Mood(date: Date(timeIntervalSinceNow: -5000000),category: categories[1], activities: activities.prefix(upTo: 4).map{$0}),
            Mood(date: Date(timeIntervalSinceNow: -9000000),category: categories[2], activities: activities.suffix(from: 8).map{$0}),
            Mood(date: Date(timeIntervalSinceNow: -5005789),category: categories[1], activities: activities.prefix(upTo: 5).map{$0}),
            Mood(date: Date(timeIntervalSinceNow: -1000000),category: categories[0], activities: activities.suffix(from: 6).map{$0}),
            Mood(date: Date(timeIntervalSinceNow: -3543274),category: categories[1], activities: activities.prefix(upTo: 1).map{$0}),
            Mood(date: Date(timeIntervalSinceNow: -7000000),category: categories[0], activities: activities.suffix(from: 9).map{$0}),
            Mood(date: Date(timeIntervalSinceNow: -400),category: categories[1], activities: activities.prefix(upTo: 3).map{$0}),
            Mood(date: Date(timeIntervalSinceNow: -3904387),category: categories[2], activities: activities.suffix(from: 5).map{$0}),
            Mood(date: Date(timeIntervalSinceNow: -3000000),category: categories[3], activities: activities.prefix(upTo: 4).map{$0}),
            Mood(date: Date(timeIntervalSinceNow: -2642845),category: categories[1], activities: activities.suffix(from: 10).map{$0})
        ]
    }
    
    func numberOfMoods(in month: Int, year: Int) -> Int{
        return moods.filter{calendar.component(.month, from: $0.date) == month+1 && calendar.component(.year, from: $0.date) == year}.count
    }
    
    func moods(in month: Int, year: Int) -> [Mood]{
        return moods.filter{calendar.component(.month, from: $0.date) == month+1 && calendar.component(.year, from: $0.date) == year}
    }
    
    func numberOfMoods(in category: Category, year: Int) -> Int {
        return moods.filter{$0.category.name == category.name && calendar.component(.year, from: $0.date) == year}.count
    }
    
    func numberOfMoods(in category: Category, for activity: Activity, year: Int) -> Int {
        return moods.filter{$0.category.name == category.name && $0.activities.contains(where: {$0.name == activity.name}) && calendar.component(.year, from: $0.date) == year}.count
    }
    
    func numberOfYears() -> Int {
        return uniq(source: moods.map{calendar.component(.year, from: $0.date)}).count
    }
    
    func years() -> [Int] {
        return uniq(source: moods.map{calendar.component(.year, from: $0.date)})
    }
    
    func categoryName(at index: Int) -> String {
        return categories.map{$0.name}[index]
    }
    
    func categoryIndex(_ category: Category) -> Int {
        return categories.index{$0.name == category.name}!
    }
    
    func activitiesText(_ activities: [Activity]) -> String {
        var text = ""
        for actvitity in activities {
            text.append(actvitity.icon+" "+actvitity.name+"\n")
        }
        return text
    }
}

//Source: https://stackoverflow.com/questions/27624331/unique-values-of-array-in-swift
func uniq<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
    var buffer = [T]()
    var added = Set<T>()
    for elem in source {
        if !added.contains(elem) {
            buffer.append(elem)
            added.insert(elem)
        }
    }
    return buffer
}
