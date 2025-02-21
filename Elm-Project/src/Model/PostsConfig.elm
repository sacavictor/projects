module Model.PostsConfig exposing 
    ( Change(..)
    , PostsConfig
    , SortBy(..)
    , applyChanges
    , defaultConfig
    , filterPosts
    , sortFromString
    , sortOptions
    , sortToCompareFn
    , sortToString
    )

import Html.Attributes exposing (scope)
import Model.Post exposing (Post)
import Time


{-| Available sorting options for posts. -}
type SortBy
    = Score
    | Title
    | Posted
    | None


{-| List of all available sorting options. -}
sortOptions : List SortBy
sortOptions =
    [ Score, Title, Posted, None ]


{-| Convert `SortBy` to a string. -}
sortToString : SortBy -> String
sortToString sort =
    case sort of
        Score ->
            "Score"

        Title ->
            "Title"

        Posted ->
            "Posted"

        None ->
            "None"


{-| Convert a string to a `SortBy` option. -}
sortFromString : String -> Maybe SortBy
sortFromString str =
    case str of
        "Score" ->
            Just Score

        "Title" ->
            Just Title

        "Posted" ->
            Just Posted

        _ ->
            Nothing


{-| Get a comparison function based on the `SortBy` value. -}
sortToCompareFn : SortBy -> (Post -> Post -> Order)
sortToCompareFn sort =
    case sort of
        Score ->
            \postA postB -> compare postB.score postA.score

        Title ->
            \postA postB -> compare postA.title postB.title

        Posted ->
            \postA postB -> compare (Time.posixToMillis postB.time) (Time.posixToMillis postA.time)

        None ->
            \_ _ -> EQ


{-| Configuration for managing posts display and filtering. -}
type alias PostsConfig =
    { postsToFetch : Int
    , postsToShow : Int
    , sortBy : SortBy
    , showJobs : Bool
    , showTextOnly : Bool
    }


{-| Default configuration for posts. -}
defaultConfig : PostsConfig
defaultConfig =
    PostsConfig 50 10 None False True


{-| Represents changes to the `PostsConfig`. -}
type Change
    = ChangePostsToShow String
    | ChangeNumPostsPerPage (Maybe Int)
    | ChangeSortBy SortBy
    | ToggleShowJobPosts Bool
    | ToggleShowTextOnlyPosts Bool


{-| Apply a given change to the configuration and return the updated configuration. -}
applyChanges : Change -> PostsConfig -> PostsConfig
applyChanges change config =
    case change of
        ChangePostsToShow newPostsToShow ->
            { config | postsToShow = String.toInt newPostsToShow |> Maybe.withDefault config.postsToShow }

        ChangeSortBy newSortBy ->
            { config | sortBy = newSortBy }

        ChangeNumPostsPerPage maybeNum ->
            case maybeNum of
                Nothing ->
                    config

                Just num ->
                    { config | postsToShow = num }

        ToggleShowJobPosts newSortBy ->
            { config | showJobs = newSortBy }

        ToggleShowTextOnlyPosts toggle  ->
            { config | showTextOnly = toggle }


{-| Filter and sort a list of posts based on the given configuration. -}
filterPosts : PostsConfig -> List Post -> List Post
filterPosts config posts =
    posts
        |> List.filter (\post -> 
            (config.showTextOnly && post.url /= Nothing) || config.showTextOnly
        )
        |> List.filter (\post -> 
            (config.showJobs && post.type_ == "job") || config.showJobs
        )
        |> List.sortWith (sortToCompareFn config.sortBy)
        |> List.take config.postsToShow
