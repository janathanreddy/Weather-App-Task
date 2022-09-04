//
//  ViewController.swift
//  Weather App Task
//
//  Created by Janarthan S on 04/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView = UITableView()
    var searchbar:UISearchBar? = {
        var searchbar = UISearchBar()
        searchbar.searchBarStyle = .minimal
        searchbar.placeholder = "Enter Your Location"
        searchbar.sizeToFit()
        searchbar.isTranslucent = false
        return searchbar
    }()
    
    var _location:Location?
    var _forecast:Forecast?
    var _Current:Current?
    var _day:[Day]?
    var _Forecastday:[Forecastday]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registercell()
        tableView.delegate = self
        tableView.dataSource = self
        searchbar?.delegate = self
        Weatherdata("Madurai")
        view.backgroundColor = .white
    }
    
    
    override func viewWillLayoutSubviews() {
        setup()
    }
    
    private func registercell(){
        tableView.register(CurrentCitycell.self, forCellReuseIdentifier: identifier.CurrentCity.rawValue)
        tableView.register(forcassecell.self, forCellReuseIdentifier: identifier.forecase.rawValue)
    }
    
    private func setup(){
        view.addSubview(searchbar!)
        view.addSubview(tableView)
        
        searchbar!.translatesAutoresizingMaskIntoConstraints = false
        searchbar?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 8).isActive = true
        searchbar?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchbar?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchbar!.bottomAnchor,constant: 8).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.keyboardDismissMode = .onDrag
        tableView.allowsSelection = false
    }
    
}

extension ViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Weatherdata(searchBar.text!.trimmingCharacters(in: .whitespaces))
        view.endEditing(true)
        
    }
}

//  TableView DataSource

extension ViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return section == 0 ? 1:_Forecastday?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier.CurrentCity.rawValue, for: indexPath) as? CurrentCitycell else {
                return UITableViewCell()
            }
            
            cell.Citylbl?.text = "\(_location?.name ?? "") - \(_location?.country ?? "")"
            cell.Countrylbl?.text = _location?.name
            cell.datelbl?.text = _location?.localtime
            cell.templbl?.text = String(format:"\(_Current?.tempC ?? 0)%@", "\u{00B0}") as String
            let url = URL(string: "https:\(_Current?.condition?.icon ?? "")")
            cell.img?.loadImageWithUrl(from: url!)

            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier.forecase.rawValue, for: indexPath) as? forcassecell else {
                return UITableViewCell()
            }
            cell.mintitlbl?.text = "Min Temp"
            cell.maxtitlbl?.text = "Max Temp"
            cell.date?.text = _Forecastday?[indexPath.row].date
            var min = self._forecast?.forecastday?.compactMap(\.day).map(\.mintempC)
            cell.mintemplbl?.text = String(format:"\(_day?[indexPath.row].mintempC ?? 0)%@", "\u{00B0}") as String
            cell.maxtemplbl?.text = String(format:"\(_day?[indexPath.row].maxtempC ?? 0)%@", "\u{00B0}") as String
            var icon = _day?.compactMap(\.condition)
            let url = URL(string: "https:\(icon?[indexPath.row].icon ?? "")")
            cell.img?.loadImageWithUrl(from: url!)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 220:100
    }
    
}


// TableView Delegate

extension ViewController:UITableViewDelegate{
    
}

// get data

extension ViewController{
    
    func Weatherdata(_ locationtxt:String){
        
        var url = URL(string:Weatherurl.url.rawValue+"?key=\(WeatherApikey.key.rawValue)&q=\(locationtxt)&days=11&aqi=no&alerts=no")
        
        ApiServices.shared.makeapicall(url: url!, type: "GET"){ [weak self] (result:Result<Weathermodel,Error>) in
            
            switch result{
            case .success(let res):
                DispatchQueue.main.async {
                    self?._location = res.location
                    self?._Current = res.current
                    self?._forecast = res.forecast
                    self?._Forecastday = res.forecast?.forecastday
                    self?._day = res.forecast?.forecastday?.compactMap(\.day)
                    self?.tableView.reloadData()
                }
                break
            case .failure(let fail):
                DispatchQueue.main.async {
                    self?.showAlert("", "Something went wrong kindly try again later.")
                }
                break
            }
            
        }
        
       
    }
    
   
    
}

class CurrentCitycell:UITableViewCell{
    
    
    var img:UIImageView? = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    var templbl:UILabel? = {
        var templbl = UILabel()
        templbl.translatesAutoresizingMaskIntoConstraints = false
        templbl.textAlignment = .center
        templbl.textColor = .black
        templbl.font = UIFont.boldSystemFont(ofSize: 28)
        return templbl
    }()
    
    
    var Citylbl:UILabel? = {
        var Citylbl = UILabel()
        Citylbl.translatesAutoresizingMaskIntoConstraints = false
        Citylbl.textAlignment = .center
        Citylbl.textColor = .black
        Citylbl.font = UIFont.boldSystemFont(ofSize: 24)
        return Citylbl
    }()
    
    var Countrylbl:UILabel? = {
        var Countrylbl = UILabel()
        Countrylbl.translatesAutoresizingMaskIntoConstraints = false
        Countrylbl.textAlignment = .center
        Countrylbl.textColor = .black
        Countrylbl.font = UIFont.systemFont(ofSize: 20)
        return Countrylbl
    }()
    
    var datelbl:UILabel? = {
        var datelbl = UILabel()
        datelbl.translatesAutoresizingMaskIntoConstraints = false
        datelbl.textAlignment = .center
        datelbl.textColor = .black
        datelbl.font = UIFont.systemFont(ofSize: 16)
        return datelbl
    }()
    
    override func awakeFromNib() {

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        Constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Constraint(){
        
        contentView.addSubview(img!)
        contentView.addSubview(templbl!)
        contentView.addSubview(Citylbl!)
        contentView.addSubview(Countrylbl!)
        contentView.addSubview(datelbl!)
        
        img?.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20).isActive = true
        img?.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant: -20).isActive = true
        img?.widthAnchor.constraint(equalToConstant: 80).isActive = true
        img?.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        templbl?.centerYAnchor.constraint(equalTo: img!.centerYAnchor).isActive = true
        templbl?.topAnchor.constraint(equalTo: img!.topAnchor).isActive = true
        templbl?.bottomAnchor.constraint(equalTo: img!.bottomAnchor).isActive = true
        templbl?.leadingAnchor.constraint(equalTo: img!.trailingAnchor,constant: 8).isActive = true
        
        Citylbl?.topAnchor.constraint(equalTo: img!.bottomAnchor,constant: 12).isActive = true
        Citylbl?.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        Countrylbl?.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        Countrylbl?.topAnchor.constraint(equalTo: Citylbl!.bottomAnchor,constant: 8).isActive = true
        
        datelbl?.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        datelbl?.topAnchor.constraint(equalTo: Countrylbl!.bottomAnchor,constant: 8).isActive = true
        datelbl?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8).isActive = true
        
        
    }
}

class forcassecell:UITableViewCell{
    
    var img:UIImageView? = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    var mintitlbl:UILabel? = {
        var mintitlbl = UILabel()
        mintitlbl.translatesAutoresizingMaskIntoConstraints = false
        mintitlbl.textAlignment = .center
        mintitlbl.textColor = .black
        mintitlbl.font = UIFont.boldSystemFont(ofSize: 18)
        return mintitlbl
    }()
    
    var mintemplbl:UILabel? = {
        var mintemplbl = UILabel()
        mintemplbl.translatesAutoresizingMaskIntoConstraints = false
        mintemplbl.textAlignment = .center
        mintemplbl.textColor = .black
        mintemplbl.font = UIFont.boldSystemFont(ofSize: 16)
        return mintemplbl
    }()
    
    var maxtemplbl:UILabel? = {
        var maxtemplbl = UILabel()
        maxtemplbl.translatesAutoresizingMaskIntoConstraints = false
        maxtemplbl.textAlignment = .center
        maxtemplbl.textColor = .black
        maxtemplbl.font = UIFont.boldSystemFont(ofSize: 16)
        return maxtemplbl
    }()
    
    var maxtitlbl:UILabel? = {
        var maxtitlbl = UILabel()
        maxtitlbl.translatesAutoresizingMaskIntoConstraints = false
        maxtitlbl.textAlignment = .center
        maxtitlbl.textColor = .black
        maxtitlbl.font = UIFont.boldSystemFont(ofSize: 18)
        return maxtitlbl
    }()
    
    var date:UILabel? = {
        var date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.textAlignment = .center
        date.textColor = .black
        date.font = UIFont.boldSystemFont(ofSize: 16)
        return date
    }()
    
    override func awakeFromNib() {
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        Constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Constraint(){
        
        contentView.addSubview(img!)
        contentView.addSubview(mintitlbl!)
        contentView.addSubview(mintemplbl!)
        contentView.addSubview(maxtitlbl!)
        contentView.addSubview(maxtemplbl!)
        contentView.addSubview(date!)

        
        img?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        img?.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 12).isActive = true
        img?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        img?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        img?.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        mintitlbl?.leadingAnchor.constraint(equalTo: img!.trailingAnchor,constant: 30).isActive = true
        mintitlbl?.topAnchor.constraint(equalTo: img!.topAnchor).isActive = true
        
        maxtitlbl?.leadingAnchor.constraint(equalTo: mintitlbl!.trailingAnchor,constant: 40).isActive = true
        maxtitlbl?.topAnchor.constraint(equalTo: mintitlbl!.topAnchor).isActive = true
        
        mintemplbl?.centerXAnchor.constraint(equalTo: mintitlbl!.centerXAnchor).isActive = true
        mintemplbl?.topAnchor.constraint(equalTo: mintitlbl!.bottomAnchor,constant: 12).isActive = true
        
        maxtemplbl?.centerXAnchor.constraint(equalTo: maxtitlbl!.centerXAnchor).isActive = true
        maxtemplbl?.centerYAnchor.constraint(equalTo: mintemplbl!.centerYAnchor).isActive = true
        
        date?.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        date?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -4).isActive = true
    }
}

enum identifier:String{
    case CurrentCity = "CurrentCity"
    case forecase = "forecase7days"
}

enum WeatherApikey:String{
    case key = "522db6a157a748e2996212343221502"
}

enum Weatherurl:String{
    case url = "https://api.weatherapi.com/v1/forecast.json"
}



