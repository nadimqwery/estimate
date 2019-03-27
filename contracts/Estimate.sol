pragma solidity >=0.4.22 <0.6.0;
import "./Ownable.sol";
import "./SafeMath.sol";

contract Estimate is Ownable {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    Event[] public events;
    uint32 private eventCounter = 0;
    mapping (address=> uint) participantToEvents;

    enum EventStatus { UPCOMMING , STARTED , CANCELED, FINSHED }
    modifier inState(Event memory _event, EventStatus status) {
        if (_event.status != status) {
        _;
        }
    }
    struct Event {
        address creator;
        uint id;
        string name;
        string dsc;
        uint startDt;
        uint endDt;
        string category;
        uint256 cost;
        EventStatus status;
    }

    function createEvent(
          string calldata _name 
        , string calldata _dsc
        , uint _startDt 
        , uint _endDt 
        , uint256 _cost
        , string calldata _category) 
     external 
     onlyOwner ()
     returns (uint) {
        eventCounter = eventCounter.add(1);
        events.push(Event(
            msg.sender, 
            eventCounter , 
            _name, 
            _dsc, 
            _startDt,
            _endDt, 
            _category,
            _cost, 
            EventStatus.UPCOMMING));
        return eventCounter;
    }

    function cancelEvent(uint _eventId)
     external 
     onlyOwner() 
     inState(events[_eventId], EventStatus.UPCOMMING) {
        events[_eventId].status =   EventStatus.CANCELED;
    }

    }