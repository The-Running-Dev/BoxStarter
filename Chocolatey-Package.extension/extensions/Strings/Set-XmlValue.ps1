function Set-XmlValue {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $file,
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

    Assert ($null -ne $node) "Could Not Find Node @ $xpath"

    if ($node.NodeType -eq "Element") {
        $node.InnerText = $value
    }
    else {
        $node.Value = $value
    }

    $xml.Save($file)
}