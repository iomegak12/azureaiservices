$key=""
$endpoint=""



# Code to call Face service for face detection
$img_file = "store-camera-1.jpg"
if ($args.count -gt 0 -And $args[0] -in ("store-camera-1.jpg", "store-camera-2.jpg", "store-camera-3.jpg"))
{
    $img_file = $args[0]
}

$img = "https://raw.githubusercontent.com/iomegak12/azureaiservices/main/data/vision/$img_file"

$headers = @{}
$headers.Add( "Ocp-Apim-Subscription-Key", $key )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"

write-host "Analyzing image...`n"
$result = Invoke-RestMethod -Method Post `
          -Uri "$endpoint/face/v1.0/detect?detectionModel=detection_01" `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$analysis = ($result | ConvertFrom-Json)

foreach ($face in $analysis)
{
    Write-Host("Face location: $($face.faceRectangle)`n")
}

