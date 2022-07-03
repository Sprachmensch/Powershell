<#
    needed to create a few vms in hyper-v
#>

$VMName="test-vm"
$VMPath="D:\VMs\Hyper-V\Virtual hard disks\"
$VMVHDXFilename="$($VMName.tolower()).vhdx"
$IsoPath="D:\Isos\17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_de-de_1.iso"
$SwitchName = "Default Switch"
$StartVM=$false
$createLinuxVM=$false
$CPUCount=4
$MemCountInMB=4096MB

Write-Host "Creating VM: " $VMName
if($createLinuxVM)
{
    New-VM -Name $VMName -Generation 1
}
else 
{
    New-VM -Name $VMName
}

Set-VM -Name $VMName -ProcessorCount $CPUCount -MemoryStartupBytes $MemCountInMB

# check if the vhdx already exists
if( -not(Test-Path $VMPath$VMVHDXFilename -PathType Leaf))
{
    Write-Host "- creating VHDX: " $VMVHDXFilename
    New-VHD -Path $VMPath$VMVHDXFilename -SizeBytes 30GB
}
Write-Host "- creating VM HardDisk: " $VMName
add-VMHardDiskDrive -VMName $VMName -Path $VMPath$VMVHDXFilename -ControllerType SCSI -ControllerNumber 0

Write-Host "- mounting Iso"
Set-VMDvdDrive -VMName $VMName -Path $IsoPath

Write-Host "- settting switch to: " $SwitchName
Connect-VMNetworkAdapter -VMName $VMName -SwitchName $SwitchName

Write-Host "- dissable automatic Checkpoints "
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host "- enable 'Guest Service Interface' "
Enable-VMIntegrationService -VMName $VMName -Name "Gastdienstschnittstelle"

Write-Host "Done"

if($StartVM)
{
   Start-VM $VMName
}


