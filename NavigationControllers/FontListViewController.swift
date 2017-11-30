
import UIKit

class FontListViewController: UITableViewController {
    
    var fontNames : [String] = []

    var showsFavourites:Bool = false
    
    private var cellPointSize: CGFloat!
    
    private static let cellIdentifier = "FontName"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if showsFavourites{
            fontNames = FavouritesList.sharedFavouritesList.favourites
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        
        cellPointSize = preferredTableViewFont.pointSize
        
        tableView.estimatedRowHeight = cellPointSize
        
    }
    
    //utility methods
    func fontForDisplay(atIndexPath indexPath : NSIndexPath) -> UIFont {
        
        let fontName = fontNames[indexPath.row]
        return UIFont(name:fontName,size:cellPointSize)!
        
    }
    
    //data source methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FontListViewController.cellIdentifier, for: indexPath)
        
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
        
        cell.textLabel?.text = fontNames[indexPath.row]
        
        cell.detailTextLabel?.text = fontNames[indexPath.row]
        
        return cell
    }

    
}
