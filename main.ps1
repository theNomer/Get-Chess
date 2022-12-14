#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

$ChessApi = "https://api.chess.com"

function Get-Chess{
    [CmdletBinding(DefaultParameterSetName = "Default")]
    param(

    [Parameter()]
    [Switch]
    $Streamers,

    [Parameter()]
    [Switch]
    $Leaderboard,

    [ValidateSet("GM", "WGM", "IM", "WIM", "FM", "WFM", "NM", "WNM", "CM", "WCM")]
    [Parameter(ParameterSetName = "Titled")]
    $Title,

    [Parameter(ParameterSetName = "Named")]
    $Name,

    [Parameter(ParameterSetName = "PlayerStats")]
    $Stats

    )

    if($Streamers -eq $true){Invoke-RestMethod "$ChessApi/pub/streamers"}
    
    elseif($Leaderboard -eq $true){Invoke-RestMethod "$ChessApi/pub/leaderboards"}

    elseif($PSCmdlet.ParameterSetName -eq "Titled"){Invoke-RestMethod "$ChessApi/pub/titled/$Title"}

    elseif($PSCmdlet.ParameterSetName -eq "Named"){Invoke-RestMethod "$ChessApi/pub/player/$Name"}

    elseif($PSCmdlet.ParameterSetName -eq "PlayerStats"){Invoke-RestMethod -Method Get -Uri "$ChessApi/pub/player/$Stats/stats"}
    
    elseif($PSCmdlet.ParameterSetName -eq "Default"){Write-Output "Chess.com API"}
   
}
