import UIKit

class MoodsViewController : UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var user: User!
    var year: Int!
    
    var months: [String] = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addMood"?:
            let addMoodViewController = segue.destination as! AddMoodViewController
            addMoodViewController.user = user
        case "editMood"?:
            let addMoodViewController = segue.destination as! AddMoodViewController
            addMoodViewController.user = user
            let selection = collectionView.indexPathsForSelectedItems!.first!
            let month = selection.section
            addMoodViewController.mood = user.moods(in: month, year: year)[selection.item]
        case "showStatistics"?:
            let statisticsViewController = segue.destination as! StatisticsViewController
            statisticsViewController.user = user
            statisticsViewController.year = year
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func unwindFromAddMood(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didAddMood"?:
            let addMoodViewController = segue.source as! AddMoodViewController
            let mood = addMoodViewController.mood!
            user.moods.append(mood)
            if mood.year() == year {
                let section = mood.month()
                let count = user.numberOfMoods(in: mood.month(), year: year)
                //Source: https://stackoverflow.com/questions/19199985/invalid-update-invalid-number-of-items-on-uicollectionview voor het oplossen van een bug in IOS
                if count == 1 {
                    collectionView.reloadItems(at: [collectionView.indexPathsForSelectedItems!.first!])
                } else {
                    collectionView.insertItems(at: [IndexPath(item: count - 1, section: section - 1)])
                }
            }
        case "didEditMood"?:
            let addMoodViewController = segue.source as! AddMoodViewController
            if(addMoodViewController.mood!.year() == year) {
                let selection = collectionView.indexPathsForSelectedItems!.first!
                let oldMonth = selection.section
                let newMonth = addMoodViewController.mood!.month()
                if oldMonth == newMonth {
                    collectionView.reloadItems(at: [selection])
                } else {
                    let section = newMonth
                    let item = user.moods(in: newMonth, year: year).index(where: {$0.date == addMoodViewController.mood!.date})!
                    collectionView.moveItem(at: selection, to: IndexPath(item: item, section: section))
                }
            } else {
                collectionView.reloadData()
            }
        default:
            fatalError("Unknown segue")
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if !splitViewController!.isCollapsed {
            navigationItem.leftBarButtonItem = splitViewController!.displayModeButtonItem
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animateAlongsideTransition(in: view, animation: {_ in self.collectionView.collectionViewLayout.invalidateLayout()})
    }
    
}

extension MoodsViewController: UICollectionViewDelegate {
    
}

extension MoodsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = traitCollection.horizontalSizeClass == .regular ? 3 : 1
        let whiteSpace = 16 + (columns - 1) * 8
        let cellWidth = (collectionView.frame.width - CGFloat(whiteSpace)) / CGFloat(columns)
        return CGSize(width: cellWidth, height: 200)
    }
}

extension MoodsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return months.count
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.numberOfMoods(in: section, year: year)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodCell", for: indexPath) as! MoodCell
        cell.mood = user.moods(in: indexPath.section, year: year)[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MoodMonthHeader", for: indexPath) as! MoodMonthHeader
        header.month = months[indexPath.section]
        return header
    }
}

