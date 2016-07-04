
struct Meeting: CustomStringConvertible {
    let start: Int
    let end: Int
    
    init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
    
    var description: String {
        return "(\(start), \(end))"
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
}

func +(lhs: Meeting, rhs: Meeting) -> Meeting {
    return Meeting(min(lhs.start, rhs.start), max(lhs.end, rhs.end))
}

func condenseMeetingTimes(_ meetings: [Meeting]) -> [Meeting] {
    var condensedMeetings = [Meeting]()
    var previousMeeting = meetings[0]
    
    if meetings.count == 1 {
        return meetings
    }
    
    for m in 1..<meetings.count {
        let meeting = meetings[m]
        
        if previousMeeting.overlapsWith(meeting) {
            let meetingRange = previousMeeting + meeting
            previousMeeting = meetingRange
        } else {
            condensedMeetings.append(previousMeeting)
            previousMeeting = meeting
        }
    }
    condensedMeetings.append(previousMeeting)
    
    return condensedMeetings
}

print(condenseMeetingTimes([Meeting(0, 1), Meeting(3, 5), Meeting(4, 8), Meeting(10, 12), Meeting(9, 10)]))