//
//  MovieListModel.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation
import UIKit

class MovieListVM {
    var nowShowing: NowShowingModel? = nil
    var api = API()
    
    enum MovieListTables {
        case nowShowing
    }
    
    
    enum PresentingControllers {
        case details
    }
    
    var displayArray: [MovieModel]? = nil
    func fetchNowShowingList(for page: Int = 1, CompletionHandler: @escaping (String, Bool) -> ()) {
        api.callAPI(APItype: .getMovieList, pageCount: page) { (message, status) in
            self.displayArray = Movies.movieList.nowShowing?.results
            CompletionHandler(message, status)
            return
        }
    }
    
    
    
    func numberOfSections(in tableView: MovieListTables) -> Int {
        switch tableView {
        case .nowShowing:
            return displayArray?.count ?? 0
        }
    }
    
    func numberOfRows(in tableView: MovieListTables, In section: Int) -> Int {
        switch tableView {
        case .nowShowing:
            return 1
        }
    }
    
    func heightForRow(in tableView: MovieListTables, at indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case .nowShowing:
            return 125.0
        }
    }
    
    func cellData(for tableView: MovieListTables, at indexPath: IndexPath) -> Any? {
        switch tableView {
        case .nowShowing:
            if let resultData = displayArray?[indexPath.section] {
                return resultData
            }
        }
        return nil
    }
    
    func present(controller: PresentingControllers, with object: Any, from sourceObject: Any) {
        switch controller {
        case .details:
            guard let detailObject = object as? MovieDetailsVM else { return }
            guard let listObject = sourceObject as? MovieModel else { return }
            detailObject.selectedMovie = listObject
        }
    }
    
    func search(title: String, Completion: @escaping () -> ()) {
        if Movies.movieList.nowShowing != nil {
            displayArray = []
            if title == "" {
                displayArray = Movies.movieList.nowShowing?.results
            }
            for each in Movies.movieList.nowShowing!.results {
                if isString(title, in: each.title) {
                    displayArray?.append(each)
                }
            }
        }
        Completion()
        return
        
    }
    
    func isString(_ string: String, in Phrase: String) -> Bool {
        let lowerPhrase = Phrase.lowercased()
        let lowerString = string.lowercased()
        let phraseArray = Phrase.components(separatedBy: " ").map {$0.lowercased()}
        let originalArray = string.components(separatedBy: " ").map {$0.lowercased()}
        let sortedPhrase = phraseArray.sorted(by: <)
        let sortedOriginal = originalArray.sorted(by: <)
        if string.count == 1 {
            for each in sortedPhrase {
                if each.first!.lowercased() == string.first!.lowercased() {
                    return true
                }
            }
        }
        let intersection = findIntersection(firstArray: sortedPhrase, secondArray: sortedOriginal)
        if intersection == sortedOriginal {
            return true
        }
        if sortedOriginal.count == 1 {
            for each in sortedPhrase {
                let replacement = replace(string: each, with: sortedOriginal[0])
                if replacement == each {
                    return true
                }
            }
        } else {
            for eachString in sortedOriginal {
                var match = false
                for eachPhrase in sortedPhrase {
                    if eachPhrase.range(of: eachString) != nil {
                        match = true
                    }
                }
                if !match {
                    return false
                }
            }
            return true
//            if (lowerPhrase).range(of: lowerString) != nil {
//                return true
//            } else {
//                Logger.print("Unmatch-\(lowerPhrase) with \(lowerString)")
//            }
//            return false
        }
        
        return false
    }

    private func findIntersection (firstArray : [String], secondArray : [String]) -> [String] {
        return [String](Set<String>(firstArray).intersection(secondArray))
    }
    
    
    func replace(string: String, with smallString: String) -> String? {
        var original = string
        if smallString.count <= string.count {
            original = original.replace_fromStart(endIndex: smallString.distance(from: smallString.startIndex, to: smallString.endIndex), With: smallString)
            return original
        }
        return nil
    }

    
}
