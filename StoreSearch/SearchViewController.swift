
import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
   var searchResults = [SearchResult]()
    var hasSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0,bottom: 0, right: 0)
        
        let cellNib = UINib(nibName: "SearchResultCell", bundle: nil) //uso NIB
        tableView.register(cellNib, forCellReuseIdentifier: "SearchResultCell")
    }
}



//Delegate de Search Bar
extension SearchViewController: UISearchBarDelegate {
    
    //Func oscurece topbar
    func position(for bar: UIBarPositioning) -> UIBarPosition {
      return .topAttached
    }
    
    //Func search
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder() //desaparece keyboard cuando hace "search"
      searchResults = []
    if searchBar.text! != "justin bieber" {
      for i in 0...2 {
        let searchResult = SearchResult()
        searchResult.name = String(format: "Fake Result %d for", i)
        searchResult.artistName = searchBar.text!
        searchResults.append(searchResult)
      }
      hasSearched = true
      tableView.reloadData()
    }
}
}



//Delegate de TableView --> las func se ponen solas por "FIX" cuando creo el extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
         if !hasSearched {
           return 0
         } else if searchResults.count == 0 {
           return 1
         } else {
           return searchResults.count
         }
       }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"SearchResultCell", for: indexPath)as! SearchResultCell
        if searchResults.count == 0 {
            cell.nameLabel.text = "(Nothing found)"
            cell.artistNameLabel.text = ""
        } else {
            let searchResult = searchResults[indexPath.row]
            cell.nameLabel.text = searchResult.name
            cell.artistNameLabel.text = searchResult.artistName
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
    }

    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
      if searchResults.count == 0 {
        return nil
      } else {
        return indexPath //puedo seleccionar lo buscado
      }
    }
    }

