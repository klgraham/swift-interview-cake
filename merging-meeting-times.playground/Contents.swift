
struct Meeting: CustomStringConvertible {
    let start: Int
    let end: Int
    
    init(from start: Int, to end: Int) {
        self.start = start
        self.end = end
    }
    
    var description: String {
        return "Meeting(\(start) to \(end))"
    }
}

extension Meeting {
    func isBefore(_ m: Meeting) -> Bool {
        return self.end < m.start
    }
    
    func isAfter(_ m: Meeting) -> Bool {
        return m.end < self.start
    }
    
    func overlapsWith(_ m: Meeting) -> Bool {
        return !isBefore(m) && !isAfter(m)
    }
    
    func conflictsWith(_ m: Meeting) -> Bool {
        return self.end > m.start
    }
    
    static func +(lhs: Meeting, rhs: Meeting) -> Meeting {
        return Meeting(from: min(lhs.start, rhs.start), to: max(lhs.end, rhs.end))
    }
}

extension Meeting: Comparable {
    static func < (lhs: Meeting, rhs: Meeting) -> Bool {
        return lhs.start < rhs.start
    }
    
    static func == (lhs: Meeting, rhs: Meeting) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}

enum MeetingTimeError: Error {
    case noMeetings
}

func condense(meetings: [Meeting]) throws -> [Meeting] {
    if meetings.isEmpty {
        throw MeetingTimeError.noMeetings
    }
    
    if meetings.count == 1 {
        return meetings
    }
    
    var condensedMeetings = [Meeting]()
    var previousMeeting = meetings[0]
    
    // meetings must be sorted, this is O(n log n)
    // if it is guaranteed that the input is sorted, this can be skipped.
    let sortedMeetings = meetings.sorted()
    
    // iterating through the list once is O(n)
    for m in 1..<meetings.count {
        let meeting = sortedMeetings[m]
        
        if previousMeeting.overlapsWith(meeting) {
            previousMeeting = previousMeeting + meeting
        } else {
            condensedMeetings.append(previousMeeting)
            previousMeeting = meeting
        }
    }
    condensedMeetings.append(previousMeeting)
    
    return condensedMeetings
}

struct MeetingPair: Equatable {
    let left: Meeting
    let right: Meeting
    
    init(_ left: Meeting, _ right: Meeting) {
        self.left = left
        self.right = right
    }
    
    static func == (lhs: MeetingPair, rhs:MeetingPair) -> Bool {
        return lhs.left == rhs.left && lhs.right == rhs.right
    }
}

/**
 * Given a list of meetings, return a list of Meeting pairs, where each
 * Meeting in the pair overlaps with each other
 */
func showConflicting(meetings: [Meeting]) throws  -> [MeetingPair] {
    if meetings.isEmpty {
        throw MeetingTimeError.noMeetings
    }
    
    if meetings.count == 1 {
        return [MeetingPair]()
    }
    
    var overlappingMeetings = [MeetingPair]()
    
    // meetings must be sorted, this is O(n log n)
    // if it is guaranteed that the input is sorted, this can be skipped.
    let sortedMeetings = meetings.sorted()
    
    var previousMeeting = meetings[0]
    
    // O(n) iteration
    for m in 1..<meetings.count {
        let currentMeeting = sortedMeetings[m]
        
        if previousMeeting.conflictsWith(currentMeeting) {
            overlappingMeetings.append(MeetingPair(previousMeeting, currentMeeting))
        }
        previousMeeting = currentMeeting
    }
    
    return overlappingMeetings
}

var meetings = [Meeting(from: 0, to: 1), Meeting(from: 3, to: 5), Meeting(from: 4, to: 8), Meeting(from: 10, to: 12), Meeting(from: 9, to: 10)]

var condensedMeetings = [Meeting(from: 0, to: 1), Meeting(from: 3, to: 8), Meeting(from: 9, to: 12)]

print("Can condense meetings when meetings overlap: \(try condense(meetings: meetings) == condensedMeetings)")

var conflictingMeetings = [MeetingPair(Meeting(from: 3, to: 5), Meeting(from: 4, to: 8))]
print("Can get a list of overlapping meetings: \(try showConflicting(meetings: meetings) == conflictingMeetings)")

meetings = [Meeting(from: 1, to: 2), Meeting(from: 2, to: 3)]
print("Can condense meetings when adjacent meetings don't quite overlap: \(try condense(meetings: meetings) == [Meeting(from: 1, to: 3)])")

meetings = [Meeting(from: 1, to: 5), Meeting(from: 2, to: 3)]
print("Can condense meetings when a later meeting is subsumed by an earlier one: \(try condense(meetings: meetings) == [Meeting(from: 1, to: 5)])")

meetings = [Meeting(from: 1, to: 10), Meeting(from: 2, to: 6), Meeting(from: 3, to: 5), Meeting(from: 7, to: 9)]
print("Can condense meetings when a later meeting is subsumed by an earlier one: \(try condense(meetings: meetings) == [Meeting(from: 1, to: 10)])")

meetings = [Meeting(from: 4, to: 8), Meeting(from: 10, to: 12), Meeting(from: 0, to: 1), Meeting(from: 3, to: 5), Meeting(from: 9, to: 10)]
condensedMeetings = [Meeting(from: 0, to: 1), Meeting(from: 3, to: 8), Meeting(from: 9, to: 12)]
print("Can condense meetings regardless of order of input list: \(try condense(meetings: meetings) == condensedMeetings)")
