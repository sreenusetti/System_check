# Get CPU usage percentage for the whole system
$cpu_usage = [math]::Round((Get-Counter "\Processor(_Total)\% Processor Time").CounterSamples.CookedValue, 2)

# Get Memory usage percentage
$mem = Get-CimInstance Win32_OperatingSystem
$mem_usage = [math]::Round((($mem.TotalVisibleMemorySize - $mem.FreePhysicalMemory) / $mem.TotalVisibleMemorySize) * 100, 2)

# Get C: drive usage percentage
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$disk_usage = [math]::Round((($disk.Size - $disk.FreeSpace) / $disk.Size) * 100, 2)

# Create a custom object with the results
$results = [PSCustomObject]@{
    cpu  = $cpu_usage
    ram  = $mem_usage
    disk = $disk_usage
}

# Output the object as a compressed, single-line JSON string for easy parsing
$results | ConvertTo-Json -Compress
