//
//  File.swift
//  crapi
//
//  Created by wayo on 24/09/2018.
//  Copyright © 2018 juanjosecarracedo. All rights reserved.
//

import Foundation

struct Player: Codable {
    let tag, name: String
    let trophies: Int
    let rank: JSONNull?
    let arena: Arena
    let clan: Clan
    let stats: Stats
    let games: Games
    let leagueStatistics: LeagueStatistics
    let deckLink: String
    let currentDeck: [CurrentDeck]
    let cards: [Card]
    let achievements: [Achievement]
}

struct Achievement: Codable {
    let name: String
    let stars, value, target: Int
    let info: String
}

struct Arena: Codable {
    let name, arena: String
    let arenaID, trophyLimit: Int
}

struct Card: Codable {
    let name: String
    let level, maxLevel, count: Int
    let rarity: Rarity
    let requiredForUpgrade: RequiredForUpgradeUnion
    let icon: String
    let key: String
    let elixir: Int
    let type: TypeEnum
    let arena: Int
    let description: String
    let id: Int
    let leftToUpgrade: Int?
}

enum Rarity: String, Codable {
    case common = "Common"
    case epic = "Epic"
    case legendary = "Legendary"
    case rare = "Rare"
}

enum RequiredForUpgradeUnion: Codable {
    case enumeration(RequiredForUpgradeEnum)
    case integer(Int)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(RequiredForUpgradeEnum.self) {
            self = .enumeration(x)
            return
        }
        throw DecodingError.typeMismatch(RequiredForUpgradeUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RequiredForUpgradeUnion"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

enum RequiredForUpgradeEnum: String, Codable {
    case maxed = "Maxed"
}

enum TypeEnum: String, Codable {
    case building = "Building"
    case spell = "Spell"
    case troop = "Troop"
}

struct Clan: Codable {
    let tag, name, role: String
    let donations, donationsReceived, donationsDelta: Int
    let badge: Badge
}

struct Badge: Codable {
    let name, category: String
    let id: Int
    let image: String
}

struct CurrentDeck: Codable {
    let name: String
    let level: Int?
    let maxLevel: Int
    let count: Int?
    let rarity: Rarity
    let requiredForUpgrade: RequiredForUpgradeEnum?
    let icon: String
    let key: String
    let elixir: Int
    let type: TypeEnum
    let arena: Int
    let description: String
    let id: Int
}

struct Games: Codable {
    let total, tournamentGames, wins, warDayWINS: Int
    let winsPercent: Double
    let losses: Int
    let lossesPercent: Double
    let draws: Int
    let drawsPercent: Double
    
    enum CodingKeys: String, CodingKey {
        case total, tournamentGames, wins
        case warDayWINS = "warDayWins"
        case winsPercent, losses, lossesPercent, draws, drawsPercent
    }
}

struct LeagueStatistics: Codable {
    let currentSeason: CurrentSeason
    let previousSeason: PreviousSeason
    let bestSeason: BestSeason
}

struct BestSeason: Codable {
    let id: String
    let rank, trophies: Int
}

struct CurrentSeason: Codable {
    let trophies, bestTrophies: Int
}

struct PreviousSeason: Codable {
    let id: String
    let trophies, bestTrophies: Int
}

struct Stats: Codable {
    let clanCardsCollected, tournamentCardsWon, maxTrophies, threeCrownWINS: Int
    let cardsFound: Int
    let favoriteCard: CurrentDeck
    let totalDonations, challengeMaxWINS, challengeCardsWon, level: Int
    
    enum CodingKeys: String, CodingKey {
        case clanCardsCollected, tournamentCardsWon, maxTrophies
        case threeCrownWINS = "threeCrownWins"
        case cardsFound, favoriteCard, totalDonations
        case challengeMaxWINS = "challengeMaxWins"
        case challengeCardsWon, level
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
