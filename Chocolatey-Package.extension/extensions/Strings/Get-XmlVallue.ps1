function Get-XmlValue {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $file,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $xpath,
        [Parameter(Position = 2, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $value
    )

    $xml = New-Object System.Xml.XmlDocument
    $xml.PreserveWhitespace = $true;

    $xml.Load($file)

    if ($null -ne $xml.DocumentElement.NamespaceURI) {
        $ns = New-Object Xml.XmlNamespaceManager $xml.NameTable

        $ns.AddNamespace("ns", $xml.DocumentElement.NamespaceURI)

        $node = $xml.SelectSingleNode($xpath, $ns)
    }
    else {
        $node = $xml.SelectSingleNode($xpath)
    }

    if ($node) {
        if ($node.NodeType -eq "Element") {
            return $node.InnerText
        }
        else {
            return $node.Value
        }
    }
}