//
//  main.swift
//  trains
//
//  Created by Chris Henderson on 11/19/21.
//

import Foundation
import Combine

print(CommandLine.arguments)
guard CommandLine.arguments.count == 2 else {
    print("Expected only one argument: 'home' or 'work'")
    exit(1)
}

let northboundWeekdayText = """
Provo Central Station
Orem Central Station
Vineyard Station
American Fork Station
Lehi Station
Draper Station
South Jordan Station
Murray Central Station
Salt Lake Central Station
North Temple Station
Woods Cross Station
Farmington Station
Layton Station
Clearfield Station
Roy Station
Ogden Station
no stopno stop4:46am5:16am5:46am6:16am6:46am7:16am7:46am8:16am8:46am9:46am10:46am11:46am12:46pm1:46pm2:46pm3:16pm3:46pm4:16pm4:46pm5:16pm5:46pm6:16pm6:46pm7:16pm7:46pm8:16pm8:46pm9:46pm10:16pm11:16pm12:16am
no stopno stop4:54am5:24am5:54am6:24am6:54am7:24am7:54am8:24am8:54am9:54am10:54am11:54am12:54pm1:54pm2:54pm3:24pm3:54pm4:24pm4:54pm5:24pm5:54pm6:24pm6:54pm7:24pm7:54pm8:24pm8:54pm9:54pm10:24pm11:24pm12:24am
no stopno stop4:58am5:28am5:58am6:28am6:58am7:28am7:58am8:28am8:58am9:58am10:58am11:58am12:58pm1:58pm2:58pm3:28pm3:58pm4:28pm4:58pm5:28pm5:58pm6:28pm6:58pm7:28pm7:58pm8:28pm8:58pm9:58pm10:28pm11:28pm12:28am
no stopno stop5:05am5:35am6:05am6:35am7:05am7:35am8:05am8:35am9:05am10:05am11:05am12:05pm1:05pm2:05pm3:05pm3:35pm4:05pm4:35pm5:05pm5:35pm6:05pm6:35pm7:05pm7:35pm8:05pm8:35pm9:05pm10:05pm10:35pm11:35pm12:35am
no stopno stop5:14am5:44am6:14am6:44am7:14am7:44am8:14am8:44am9:14am10:14am11:14am12:14pm1:14pm2:14pm3:14pm3:44pm4:14pm4:44pm5:14pm5:44pm6:14pm6:44pm7:14pm7:44pm8:14pm8:44pm9:14pm10:14pm10:44pm11:44pm12:44am
no stopno stop5:29am5:59am6:29am6:59am7:29am7:59am8:29am8:59am9:29am10:29am11:29am12:29pm1:29pm2:29pm3:29pm3:59pm4:29pm4:59pm5:29pm5:59pm6:29pm6:59pm7:29pm7:59pm8:29pm8:59pm9:29pm10:29pm10:59pm11:54pm12:54am
no stopno stop5:35am6:05am6:35am7:05am7:35am8:05am8:35am9:05am9:35am10:35am11:35am12:35pm1:35pm2:35pm3:35pm4:05pm4:35pm5:05pm5:35pm6:05pm6:35pm7:05pm7:35pm8:05pm8:35pm9:05pm9:35pm10:35pm11:05pm11:59pm12:59am
no stopno stop5:46am6:16am6:46am7:16am7:46am8:16am8:46am9:16am9:46am10:46am11:46am12:46pm1:46pm2:46pm3:46pm4:16pm4:46pm5:16pm5:46pm6:16pm6:46pm7:16pm7:46pm8:16pm8:46pm9:16pm9:46pm10:46pm11:16pm12:08am1:08am
4:55am5:25am5:55am6:25am6:55am7:25am7:55am8:25am8:55am9:25am9:55am10:55am11:55am12:55pm1:55pm2:55pm3:55pm4:25pm4:55pm5:25pm5:55pm6:25pm6:55pm7:25pm7:55pm8:25pm8:55pm9:25pm9:55pm10:55pm11:25pm12:17am1:17am
5:01am5:31am6:01am6:31am7:01am7:31am8:01am8:31am9:01am9:31am10:01am11:01am12:01pm1:01pm2:01pm3:01pm4:01pm4:31pm5:01pm5:31pm6:01pm6:31pm7:01pm7:31pm8:01pm8:31pm9:01pm9:31pm10:01pm11:01pm11:31pm12:22am1:22am
5:12am5:42am6:12am6:42am7:12am7:42am8:12am8:42am9:12amno stop10:12am11:12am12:12pm1:12pm2:12pm3:12pm4:12pm4:42pm5:12pm5:42pm6:12pm6:42pm7:12pmno stop8:12pmno stop9:12pmno stop10:12pm11:12pmno stopno stopno stop
5:22am5:52am6:22am6:52am7:22am7:52am8:22am8:52am9:22amno stop10:22am11:22am12:22pm1:22pm2:22pm3:22pm4:22pm4:52pm5:22pm5:52pm6:22pm6:52pm7:22pmno stop8:22pmno stop9:22pmno stop10:22pm11:22pmno stopno stopno stop
5:31am6:01am6:31am7:01am7:31am8:01am8:31am9:01am9:31amno stop10:31am11:31am12:31pm1:31pm2:31pm3:31pm4:31pm5:01pm5:31pm6:01pm6:31pm7:01pm7:31pmno stop8:31pmno stop9:31pmno stop10:31pm11:31pmno stopno stopno stop
5:37am6:07am6:37am7:07am7:37am8:07am8:37am9:07am9:37amno stop10:37am11:37am12:37pm1:37pm2:37pm3:37pm4:37pm5:07pm5:37pm6:07pm6:37pm7:07pm7:37pmno stop8:37pmno stop9:37pmno stop10:37pm11:37pmno stopno stopno stop
5:45am6:15am6:45am7:15am7:45am8:15am8:45am9:15am9:45amno stop10:45am11:45am12:45pm1:45pm2:45pm3:45pm4:45pm5:15pm5:45pm6:15pm6:45pm7:15pm7:45pmno stop8:45pmno stop9:45pmno stop10:45pm11:45pmno stopno stopno stop
5:54am6:24am6:54am7:24am7:54am8:24am8:54am9:24am9:54amno stop10:54am11:54am12:54pm1:54pm2:54pm3:54pm4:54pm5:24pm5:54pm6:24pm6:54pm7:24pm7:54pmno stop8:54pmno stop9:54pmno stop10:54pm11:54pmno stopno stopno stop
"""

let southboundWeekdayText = """
Ogden Station
Roy Station
Clearfield Station
Layton Station
Farmington Station
Woods Cross Station
North Temple Station
Salt Lake Central Station
Murray Central Station
South Jordan Station
Draper Station
Lehi Station
American Fork Station
Vineyard Station
Orem Central Station
Provo Central Station
no stopno stop5:07am5:37am6:07am6:37am7:07am7:37am8:07am8:37am9:07am10:07am11:07am12:07pm1:07pm2:07pmno stop3:07pmno stop4:07pm4:37pm5:07pm5:37pm6:07pm6:37pm7:07pm7:37pm8:07pm9:07pm10:07pm
no stopno stop5:15am5:45am6:15am6:45am7:15am7:45am8:15am8:45am9:15am10:15am11:15am12:15pm1:15pm2:15pmno stop3:15pmno stop4:15pm4:45pm5:15pm5:45pm6:15pm6:45pm7:15pm7:45pm8:15pm9:15pm10:15pm
no stopno stop5:24am5:54am6:24am6:54am7:24am7:54am8:24am8:54am9:24am10:24am11:24am12:24pm1:24pm2:24pmno stop3:24pmno stop4:24pm4:54pm5:24pm5:54pm6:24pm6:54pm7:24pm7:54pm8:24pm9:24pm10:24pm
no stopno stop5:31am6:01am6:31am7:01am7:31am8:01am8:31am9:01am9:31am10:31am11:31am12:31pm1:31pm2:31pmno stop3:31pmno stop4:31pm5:01pm5:31pm6:01pm6:31pm7:01pm7:31pm8:01pm8:31pm9:31pm10:31pm
no stopno stop5:39am6:09am6:39am7:09am7:39am8:09am8:39am9:09am9:39am10:39am11:39am12:39pm1:39pm2:39pmno stop3:39pmno stop4:39pm5:09pm5:39pm6:09pm6:39pm7:09pm7:39pm8:09pm8:39pm9:39pm10:39pm
no stopno stop5:50am6:20am6:50am7:20am7:50am8:20am8:50am9:20am9:50am10:50am11:50am12:50pm1:50pm2:50pmno stop3:50pmno stop4:50pm5:20pm5:50pm6:20pm6:50pm7:20pm7:50pm8:20pm8:50pm9:50pm10:50pm
5:02am5:32am6:02am6:32am7:02am7:32am8:02am8:32am9:02am9:32am10:02am11:02am12:02pm1:02pm2:02pm3:02pm3:32pm4:02pm4:32pm5:02pm5:32pm6:02pm6:32pm7:02pm7:32pm8:02pm8:32pm9:02pm10:02pm11:02pm
5:06am5:36am6:06am6:36am7:06am7:36am8:06am8:36am9:06am9:36am10:06am11:06am12:06pm1:06pm2:06pm3:06pm3:36pm4:06pm4:36pm5:06pm5:36pm6:06pm6:36pm7:06pm7:36pm8:06pm8:36pm9:06pm10:06pm11:06pm
5:16am5:46am6:16am6:46am7:16am7:46am8:16am8:46am9:16amno stop10:16am11:16am12:16pm1:16pm2:16pm3:16pm3:46pm4:16pm4:46pm5:16pm5:46pm6:16pm6:46pm7:16pmno stop8:16pmno stop9:16pm10:16pm11:16pm
5:24am5:54am6:24am6:54am7:24am7:54am8:24am8:54am9:24amno stop10:24am11:24am12:24pm1:24pm2:24pm3:24pm3:54pm4:24pm4:54pm5:24pm5:54pm6:24pm6:54pm7:24pmno stop8:24pmno stop9:24pm10:24pm11:24pm
5:30am6:00am6:30am7:00am7:30am8:00am8:30am9:00am9:30amno stop10:30am11:30am12:30pm1:30pm2:30pm3:30pm4:00pm4:30pm5:00pm5:30pm6:00pm6:30pm7:00pm7:30pmno stop8:30pmno stop9:30pm10:30pm11:30pm
5:43am6:13am6:43am7:13am7:43am8:13am8:43am9:13am9:43amno stop10:43am11:43am12:43pm1:43pm2:43pm3:43pm4:13pm4:43pm5:13pm5:43pm6:13pm6:43pm7:13pm7:43pmno stop8:43pmno stop9:43pm10:43pm11:43pm
5:51am6:21am6:51am7:21am7:51am8:21am8:51am9:21am9:51amno stop10:51am11:51am12:51pm1:51pm2:51pm3:51pm4:21pm4:51pm5:21pm5:51pm6:21pm6:51pm7:21pm7:51pmno stop8:51pmno stop9:51pm10:51pm11:51pm
5:59am6:29am6:59am7:29am7:59am8:29am8:59am9:29am9:59amno stop10:59am11:59am12:59pm1:59pm2:59pm3:59pm4:29pm4:59pm5:29pm5:59pm6:29pm6:59pm7:29pm7:59pmno stop8:59pmno stop9:59pm10:59pm11:59pm
6:03am6:33am7:03am7:33am8:03am8:33am9:03am9:33am10:03amno stop11:03am12:03pm1:03pm2:03pm3:03pm4:03pm4:33pm5:03pm5:33pm6:03pm6:33pm7:03pm7:33pm8:03pmno stop9:03pmno stop10:03pm11:03pm12:03am
6:11am6:41am7:11am7:41am8:11am8:41am9:11am9:41am10:11amno stop11:11am12:11pm1:11pm2:11pm3:11pm4:11pm4:41pm5:11pm5:41pm6:11pm6:41pm7:11pm7:41pm8:11pmno stop9:11pmno stop10:11pm11:11pm12:11am
"""

let northboundSaturdayText = """
Provo Central Station
Orem Central Station
Vineyard Station
American Fork Station
Lehi Station
Draper Station
South Jordan Station
Murray Central Station
Salt Lake Central Station
North Temple Station
Woods Cross Station
Farmington Station
Layton Station
Clearfield Station
Roy Station
Ogden Station
no stopno stop7:53am8:53am9:53am10:53am11:53am12:53pm1:53pm2:53pm3:53pm4:53pm5:53pm6:53pm7:53pm8:53pm9:53pm10:53pm11:53pm12:23am
no stopno stop8:02am9:02am10:02am11:02am12:02pm1:02pm2:02pm3:02pm4:02pm5:02pm6:02pm7:02pm8:02pm9:02pm10:02pm11:02pm12:02am12:31am
no stopno stop8:06am9:06am10:06am11:06am12:06pm1:06pm2:06pm3:06pm4:06pm5:06pm6:06pm7:06pm8:06pm9:06pm10:06pm11:06pm12:06am12:35am
no stopno stop8:13am9:13am10:13am11:13am12:13pm1:13pm2:13pm3:13pm4:13pm5:13pm6:13pm7:13pm8:13pm9:13pm10:13pm11:13pm12:13am12:42am
no stopno stop8:22am9:22am10:22am11:22am12:22pm1:22pm2:22pm3:22pm4:22pm5:22pm6:22pm7:22pm8:22pm9:22pm10:22pm11:22pm12:22am12:51am
no stopno stop8:33am9:33am10:33am11:33am12:33pm1:33pm2:33pm3:33pm4:33pm5:33pm6:33pm7:33pm8:33pm9:33pm10:33pm11:33pm12:33am1:02am
no stopno stop8:38am9:38am10:38am11:38am12:38pm1:38pm2:38pm3:38pm4:38pm5:38pm6:38pm7:38pm8:38pm9:38pm10:38pm11:38pm12:38am1:07am
no stopno stop8:48am9:48am10:48am11:48am12:48pm1:48pm2:48pm3:48pm4:48pm5:48pm6:48pm7:48pm8:48pm9:48pm10:48pm11:48pm12:48am1:16am
6:57am7:57am8:57am9:57am10:57am11:57am12:57pm1:57pm2:57pm3:57pm4:57pm5:57pm6:57pm7:57pm8:57pm9:57pm10:57pm11:57pm12:57am1:25am
7:03am8:03am9:03am10:03am11:03am12:03pm1:03pm2:03pm3:03pm4:03pm5:03pm6:03pm7:03pm8:03pm9:03pm10:03pm11:03pm12:03am1:03am1:29am
7:13am8:13am9:13am10:13am11:13am12:13pm1:13pm2:13pm3:13pm4:13pm5:13pm6:13pm7:13pm8:13pm9:13pm10:13pm11:13pmno stopno stopno stop
7:23am8:23am9:23am10:23am11:23am12:23pm1:23pm2:23pm3:23pm4:23pm5:23pm6:23pm7:23pm8:23pm9:23pm10:23pm11:23pmno stopno stopno stop
7:32am8:32am9:32am10:32am11:32am12:32pm1:32pm2:32pm3:32pm4:32pm5:32pm6:32pm7:32pm8:32pm9:32pm10:32pm11:32pmno stopno stopno stop
7:38am8:38am9:38am10:38am11:38am12:38pm1:38pm2:38pm3:38pm4:38pm5:38pm6:38pm7:38pm8:38pm9:38pm10:38pm11:38pmno stopno stopno stop
7:46am8:46am9:46am10:46am11:46am12:46pm1:46pm2:46pm3:46pm4:46pm5:46pm6:46pm7:46pm8:46pm9:46pm10:46pm11:46pmno stopno stopno stop
7:55am8:55am9:55am10:55am11:55am12:55pm1:55pm2:55pm3:55pm4:55pm5:55pm6:55pm7:55pm8:55pm9:55pm10:55pm11:55pmno stopno stopno stop
"""

let southboundSaturdayText = """
Ogden Station
Roy Station
Clearfield Station
Layton Station
Farmington Station
Woods Cross Station
North Temple Station
Salt Lake Central Station
Murray Central Station
South Jordan Station
Draper Station
Lehi Station
American Fork Station
Vineyard Station
Orem Central Station
Provo Central Station
no stopno stopno stop8:08am9:08am10:08am11:08am12:08pm1:08pm2:08pm3:08pm4:08pm5:08pm6:08pm7:08pm8:08pm9:08pm10:08pm11:08pm12:08am
no stopno stopno stop8:16am9:16am10:16am11:16am12:16pm1:16pm2:16pm3:16pm4:16pm5:16pm6:16pm7:16pm8:16pm9:16pm10:16pm11:16pm12:16am
no stopno stopno stop8:24am9:24am10:24am11:24am12:24pm1:24pm2:24pm3:24pm4:24pm5:24pm6:24pm7:24pm8:24pm9:24pm10:24pm11:24pm12:24am
no stopno stopno stop8:32am9:32am10:32am11:32am12:32pm1:32pm2:32pm3:32pm4:32pm5:32pm6:32pm7:32pm8:32pm9:32pm10:32pm11:32pm12:32am
no stopno stopno stop8:39am9:39am10:39am11:39am12:39pm1:39pm2:39pm3:39pm4:39pm5:39pm6:39pm7:39pm8:39pm9:39pm10:39pm11:39pm12:39am
no stopno stopno stop8:49am9:49am10:49am11:49am12:49pm1:49pm2:49pm3:49pm4:49pm5:49pm6:49pm7:49pm8:49pm9:49pm10:49pm11:49pm12:49am
6:03am7:03am8:03am9:03am10:03am11:03am12:03pm1:03pm2:03pm3:03pm4:03pm5:03pm6:03pm7:03pm8:03pm9:03pm10:03pm11:03pm12:03am1:03am
6:08am7:08am8:08am9:08am10:08am11:08am12:08pm1:08pm2:08pm3:08pm4:08pm5:08pm6:08pm7:08pm8:08pm9:08pm10:08pm11:08pm12:08am1:08am
6:17am7:17am8:17am9:17am10:17am11:17am12:17pm1:17pm2:17pm3:17pm4:17pm5:17pm6:17pm7:17pm8:17pm9:17pm10:17pm11:17pmno stopno stop
6:26am7:26am8:26am9:26am10:26am11:26am12:26pm1:26pm2:26pm3:26pm4:26pm5:26pm6:26pm7:26pm8:26pm9:26pm10:26pm11:26pmno stopno stop
6:32am7:32am8:32am9:32am10:32am11:32am12:32pm1:32pm2:32pm3:32pm4:32pm5:32pm6:32pm7:32pm8:32pm9:32pm10:32pm11:32pmno stopno stop
6:42am7:42am8:42am9:42am10:42am11:42am12:42pm1:42pm2:42pm3:42pm4:42pm5:42pm6:42pm7:42pm8:42pm9:42pm10:42pm11:42pmno stopno stop
6:50am7:50am8:50am9:50am10:50am11:50am12:50pm1:50pm2:50pm3:50pm4:50pm5:50pm6:50pm7:50pm8:50pm9:50pm10:50pm11:50pmno stopno stop
6:57am7:57am8:57am9:57am10:57am11:57am12:57pm1:57pm2:57pm3:57pm4:57pm5:57pm6:57pm7:57pm8:57pm9:57pm10:57pm11:57pmno stopno stop
7:02am8:02am9:02am10:02am11:02am12:02pm1:02pm2:02pm3:02pm4:02pm5:02pm6:02pm7:02pm8:02pm9:02pm10:02pm11:02pm12:02amno stopno stop
7:10am8:10am9:10am10:10am11:10am12:10pm1:10pm2:10pm3:10pm4:10pm5:10pm6:10pm7:10pm8:10pm9:10pm10:10pm11:10pm12:10amno stopno stop
"""

let now = Date()

struct Station: Equatable {
    let name: String
    let times: [Date]

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        return formatter
    }()

    static func rangeOfTime(in string: String) -> Range<String.Index>? {
        string.range(of: "\\d+\\:\\d+[ap]m", options: .regularExpression)
    }

    init(name: String, timesString rawTimesString: String) {
        self.name = name

        var times: [Date] = []
        var leftToProcess = rawTimesString
        while true {
            if let timeRange = Self.rangeOfTime(in: leftToProcess) {
                let timeString = String(leftToProcess[timeRange])
                if let date = Self.dateFormatter.date(from: timeString) {
                    let midnight = Self.dateFormatter.date(from: "12:00am")!
                    let startOfToday = Calendar.current.startOfDay(for: now)
                    let correctedDate = startOfToday.addingTimeInterval(date.timeIntervalSince1970 - midnight.timeIntervalSince1970)
                    times.append(correctedDate)
                } else {
                    fatalError("Failed to convert '\(timeString)' into a date")
                }
                leftToProcess.removeSubrange(timeRange)
            } else {
                break // Done!
            }
        }
        self.times = times
    }
}

func parse(_ text: String) -> [Station] {
    func isTimeField(_ text: String) -> Bool {
        Station.rangeOfTime(in: text) != nil
    }

    let lines = text.components(separatedBy: "\n")
    let stationNames = lines.filter { !isTimeField($0) }
    let times = lines.filter { isTimeField($0) }

    precondition(stationNames.count == times.count, "There are \(stationNames.count) stations and \(times.count) times. They should be the same.")

    return zip(stationNames, times).map {
        Station(name: $0, timesString: $1)
    }
}

let northboundWeekdayStations = parse(northboundWeekdayText)
let southboundWeekdayStations = parse(southboundWeekdayText)
let northboundSaturdayStations = parse(northboundSaturdayText)
let southboundSaturdayStations = parse(southboundSaturdayText)

let northboundStations: [Station]
let southboundStations: [Station]
if Calendar.current.isDateInWeekend(now) {
    northboundStations = northboundSaturdayStations
    southboundStations = southboundSaturdayStations
} else {
    northboundStations = northboundWeekdayStations
    southboundStations = southboundWeekdayStations
}

let toHomeSouthbound = southboundStations.first {
    $0.name.lowercased().contains("draper")
}!

let toWorkNorthbound = northboundStations.first {
    $0.name.lowercased().contains("orem")
}!

func printUpcomingDepartures(for station: Station, travelTimeRequired: TimeInterval) {
    let upcoming = station.times.filter { $0 > now }

    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .none

    for futureDeparture in upcoming {
        let string = formatter.string(from: futureDeparture)
        let canMakeIt = futureDeparture.timeIntervalSinceNow >= travelTimeRequired
        let minutesUntilILeave = String(format: "%.1f", futureDeparture.addingTimeInterval(-travelTimeRequired).timeIntervalSinceNow / 60.0)
        print("- \(canMakeIt ? "✅" : "❌") Leave in \(minutesUntilILeave) minutes to make \(string) train")
    }

    print(" ")
}

if CommandLine.arguments[1] == "home" {
    print("Go home (from Draper Station, Southbound)")
    printUpcomingDepartures(for: toHomeSouthbound, travelTimeRequired: 15 * 60 * 1.2) // 15 minutes required + 20% of that for a cushion
} else if CommandLine.arguments[1] == "work" {
    print("Go to work (from Orem Station, Northbound)")
    printUpcomingDepartures(for: toWorkNorthbound, travelTimeRequired: 20 * 60 * 1.25) // 20 minutes required + 25% of that for a cushion
}
