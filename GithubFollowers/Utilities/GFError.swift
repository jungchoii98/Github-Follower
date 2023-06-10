//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Jung Choi on 5/23/23.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "The username entered is invalid. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from server was invalid. Please try again."
    case unableToRetreiveFavorites = "Unable to retreive favorites. Please try again."
    case unableToSaveFavorites = "Unable to save favorites. Please try again."
    case repeatedFavorites = "This user has already been favorited."
}
