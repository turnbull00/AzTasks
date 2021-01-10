function Get-PrettyJson() {
    param(
        [string]$value
    )
    $value | convertfrom-json -depth 10 | convertto-json
}