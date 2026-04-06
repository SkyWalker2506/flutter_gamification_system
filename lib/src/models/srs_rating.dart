/// Rating given by the user when reviewing an SRS card.
///
/// Maps to Leitner box transitions:
/// - [easy]     → advance 2 boxes (accelerated interval)
/// - [known]    → advance 1 box   (standard promotion)
/// - [doubtful] → stay in current box, reschedule for same interval
enum SrsRating { easy, known, doubtful }
