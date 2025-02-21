module View.Posts exposing (..)

import Html exposing (Html, div, text, table, tbody, thead, tr, th, td, select, option, input, label, a)
import Html.Attributes exposing (href, type_, class, value, selected, for, id, checked)
import Html.Events exposing (onClick, onInput, onCheck)
import Model exposing (Msg(..))
import Model.Post exposing (Post)
import Model.PostsConfig exposing (Change(..), PostsConfig, SortBy(..), filterPosts, sortFromString, sortOptions, sortToCompareFn, sortToString)
import Time
import Util.Time exposing (formatDate, formatTime, formatDuration, durationBetween)


{-| Show posts as an HTML table. -}
postTable : PostsConfig -> Time.Posix -> List Post -> Html Msg
postTable _ currentTime posts = 
    table [ class "score" ]
        [ thead []
            [ tr []
                [ th [] [ text "Score" ]
                , th [] [ text "Title" ]
                , th [] [ text "Type" ]
                , th [] [ text "Posted Date" ]
                , th [] [ text "Link" ]
                ]
            ]
        , tbody []
            (List.map (postRow currentTime) posts)
        ]

{-| Render a single row in the posts table. -}
postRow : Time.Posix -> Post -> Html Msg
postRow currentTime post =
    let
        time =
            case Util.Time.durationBetween post.time currentTime of
                Just duration -> 
                    " (" ++ Util.Time.formatDuration duration ++ ")"

                Nothing -> 
                    ""
    in
    tr []
        [ td [ class "post-score" ] [ text (String.fromInt post.score) ]
        , td [ class "post-title" ] [ text post.title ]
        , td [ class "post-type" ] [ text post.type_ ]
        , td [ class "post-time" ] [ text (Util.Time.formatTime Time.utc post.time ++ time) ]
        , td [ class "post-url" ]
            [ case post.url of
                Just url -> a [ href url ] [ text "Link" ]
                Nothing -> text "No Link"
            ]
        ]


{-| Show the configuration options for the posts table. -}
postsConfigView : PostsConfig -> Html Msg
postsConfigView config =
    div []
        [ label [ for "select-posts-per-page" ] [ text "Show:" ]
        , select 
            [ id "select-posts-per-page", onInput (\x -> ConfigChanged (ChangePostsToShow x)) ]
            [ option [ value "10", selected (config.postsToShow == 10) ] [ text "10" ]
            , option [ value "25", selected (config.postsToShow == 25) ] [ text "25" ]
            , option [ value "50", selected (config.postsToShow == 50) ] [ text "50" ]
            ]
        
        , label [ for "select-sort-by" ] [ text "Sort by:" ]
        , select 
            [ id "select-sort-by", onInput (\x -> ConfigChanged (ChangeSortBy (sortFromString x |> Maybe.withDefault None))) ]
            (List.map (\sort ->
                option [ value (sortToString sort), selected (config.sortBy == sort) ] [ text (sortToString sort) ]
            ) sortOptions)
        
        , label [ for "checkbox-show-job-posts" ] 
            [ input 
                [ id "checkbox-show-job-posts"
                , type_ "checkbox"
                , onCheck (\x -> ConfigChanged (ToggleShowJobPosts x))
                , checked config.showJobs 
                ] 
                []
            , text " Show Job Posts" 
            ]
        
        , label [ for "checkbox-show-text-only-posts" ] 
            [ input 
                [ id "checkbox-show-text-only-posts"
                , type_ "checkbox"
                , onCheck (\x -> ConfigChanged (ToggleShowTextOnlyPosts x))
                , checked config.showTextOnly 
                ] 
                []
            , text " Show Text" 
            ]
        ]
