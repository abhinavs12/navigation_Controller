

import UIKit

class RootTableViewController: UITableViewController {

    
    private var familyNames : [String]!
    private var cellPointSize : CGFloat!
    private var favouritesList : FavouritesList!
    private static let familyCell = "FamilyName"
    private static let favouritesCell = "Favourites"
    
    //this application event trigeers every time the view is going to be rendered
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //this application event triggers the first time the application is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        familyNames = (UIFont.familyNames as [String]).sorted()
        
        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        
        cellPointSize = preferredTableViewFont.pointSize
        
        favouritesList = FavouritesList.sharedFavouritesList
        
        tableView.estimatedRowHeight = cellPointSize

    }
    
    
    //utility methods
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont? {
        
        
        if indexPath.section == 0{
            
            let familyName = familyNames[indexPath.row]
            
            let fontName = UIFont.fontNames(forFamilyName: familyName).first
            
            return fontName != nil ? UIFont(name: fontName! , size: cellPointSize) : nil
            
        } else {
            
            return nil
            
        }
        
    }

    
    //data source methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return favouritesList.favourites.isEmpty ? 1 : 2
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? familyNames.count : 1
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favourite Fonts"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RootTableViewController.familyCell , for: indexPath)
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: RootTableViewController.favouritesCell, for: indexPath)
        }
    }
    
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexpath = tableView.indexPath(for: sender as! UITableViewCell)!
        
        let listVC = segue.destination as! FontListViewController
        
        if indexpath.section == 0{
            let familyName = familyNames[indexpath.row]
            listVC.fontNames = (UIFont.fontNames(forFamilyName: familyName) as [String]).sorted()
            
            listVC.navigationItem.title = familyName
            listVC.showsFavourites = false

        } else {
            listVC.fontNames = favouritesList.favourites
            listVC.navigationItem.title = "Favourites"
            listVC.showsFavourites = true
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
}
