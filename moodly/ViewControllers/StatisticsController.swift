import Charts
import UIKit

class StatisticsViewController : UIViewController {
    @IBOutlet weak var barChartView: HorizontalBarChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    var user: User!
    var year: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.noDataText = "You don't have any moods yet"
        barChartView.noDataText = "You don't have any moods yet"
        
        pieChartView.centerText = "Mood counter"
        var pieChartDataEntries: [PieChartDataEntry] = []
        var colors: [NSUIColor] = []
        for cat in user.categories {
            colors.append(cat.color)
            if(user.numberOfMoods(in: cat, year: year) != 0) {
                pieChartDataEntries.append(PieChartDataEntry(value: Double(user.numberOfMoods(in: cat, year: year)), label:cat.name))
            }
        }
        let piechartdataset = PieChartDataSet(values: pieChartDataEntries, label:"Category")
        piechartdataset.colors = colors
        pieChartView.data = PieChartData(dataSet: piechartdataset)
        let description = Description()
        description.text = ""
        pieChartView.chartDescription = description
        
        var barChartDataEntries: [BarChartDataEntry] = []
        for i in 0..<user.activities.count {
            let act = user.activities[i]
            var values: [Double] = []
            for cat in user.categories  {
                values.append(Double(user.numberOfMoods(in: cat, for: act, year: year)))
            }
            barChartDataEntries.append(BarChartDataEntry(x: Double(i), yValues: values))
        }
        let barChartDataSet = BarChartDataSet(values: barChartDataEntries, label: "Category")
        barChartDataSet.colors = colors
        barChartDataSet.stackLabels = user.categories.map{$0.name}
        barChartView.data = BarChartData(dataSet: barChartDataSet)
        barChartView.chartDescription = description
        
        //Source: https://github.com/danielgindi/Charts/issues/1527
        let formatter = LabelStringFormatter()
        formatter.labelValues = user.activities.map{$0.name}
        barChartView.xAxis.valueFormatter = formatter
        //Source: https://stackoverflow.com/questions/44914636/ios-charts-x-axis-labels-are-not-all-showing
        barChartView.xAxis.setLabelCount(user.activities.count, force: true)
    }
    
}

//Source: https://github.com/danielgindi/Charts/issues/1527
class LabelStringFormatter: NSObject, IAxisValueFormatter {
    
    var labelValues: [String]!
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(describing: labelValues[Int(value)])
    }
}
