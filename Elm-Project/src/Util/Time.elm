module Util.Time exposing (..)

import Time exposing (Posix, Zone, toYear, toMonth, toDay, toHour, toMinute, millisToPosix, posixToMillis)

type Date = Date { year : Int, month : Time.Month, day : Int }

monthToString : Time.Month -> String
monthToString month =
    case month of
        Time.Jan -> "Jan"
        Time.Feb -> "Feb"
        Time.Mar -> "Mar"
        Time.Apr -> "Apr"
        Time.May -> "May"
        Time.Jun -> "Jun"
        Time.Jul -> "Jul"
        Time.Aug -> "Aug"
        Time.Sep -> "Sep"
        Time.Oct -> "Oct"
        Time.Nov -> "Nov"
        Time.Dec -> "Dec"

posixToDate : Time.Zone -> Time.Posix -> Date
posixToDate tz time =
    Date
        { year = Time.toYear tz time
        , month = Time.toMonth tz time
        , day = Time.toDay tz time
        }

formatDate : Date -> String
formatDate (Date date) =
    String.fromInt date.year ++ " " ++ monthToString date.month ++ " " ++ String.padLeft 2 '0' (String.fromInt date.day)

formatTime : Time.Zone -> Time.Posix -> String
formatTime tz time =
    let
        date = posixToDate tz time
        hour = String.padLeft 2 '0' (String.fromInt (Time.toHour tz time))
        minute = String.padLeft 2 '0' (String.fromInt (Time.toMinute tz time))
    in
    formatDate date ++ " " ++ hour ++ ":" ++ minute

type alias Duration =
    { seconds : Int
    , minutes : Int
    , hours : Int
    , days : Int
    }

durationBetween : Time.Posix -> Time.Posix -> Maybe Duration
durationBetween t1 t2 =
    let
        diffMillis =
            Time.posixToMillis t2 - Time.posixToMillis t1

        seconds =
            diffMillis // 1000

        minutes =
            seconds // 60

        hours =
            minutes // 60

        days =
            hours // 24
    in
    if diffMillis < 0 then
        Nothing
    else
        Just
            { seconds = modBy seconds 60
            , minutes = modBy minutes 60
            , hours = modBy hours 24
            , days = days
            }

formatDuration : Duration -> String
formatDuration duration =
    let
        formatUnit value unit =
            if value == 1 then
                String.fromInt value ++ " " ++ unit ++ " ago"
            else
                String.fromInt value ++ " " ++ unit ++ "s ago"

        components =
            [ (duration.days, "day")
            , (duration.hours, "hour")
            , (duration.minutes, "minute")
            , (duration.seconds, "second")
            ]

        nonZeroComponents =
            components
                |> List.filter (\(value, _) -> value > 0)
                |> List.map (\(value, unit) -> formatUnit value unit)
    in
    case nonZeroComponents of
        [] ->
            "just now"

        first :: rest ->
            String.join " " (first :: List.take 2 rest)
