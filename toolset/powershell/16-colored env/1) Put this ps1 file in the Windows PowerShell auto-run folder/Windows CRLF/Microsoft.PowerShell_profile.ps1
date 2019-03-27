# For Windows Home Edition, run this line below, but only ONCE, as an administrator.
# Set-ExecutionPolicy Unrestricted -force


# http://tool.chinaz.com/tools/unicode.aspx 在线字符转码工具
$UserPrettyName = "$UserName"
if ($UserPrettyName.StartsWith("yinya")) { $UserPrettyName = "$([char]0x5370)$([char]0x4e9a)$([char]0x5170)" }
if ($UserPrettyName.StartsWith("wulec")) { $UserPrettyName = "$([char]0x5434)$([char]0x4e50)$([char]0x5ddd)" }
if ($UserPrettyName.StartsWith("wucon")) { $UserPrettyName = "$([char]0x5434)$([char]0x6dd9)$([char]0x6e0a)" }




$Host.PrivateData.ErrorBackgroundColor=1


# function color-table () {
# 	$color1  =   0,   0,   0 # Black
# 	$color2  = 115, 118, 255 # DarkBlue
# 	$color3  = 120, 230, 100 # DarkGreen   --> green
# 	$color4  =  51, 190, 150 # DarkCyan    --> blurish-green

# 	$color5  = 240,  96,  99 # DarkRed
# 	$color6  = 222, 115, 211 # DarkMagenta --> magenta
# 	$color7  = 255, 211, 138 # DarkYellow  --> orange
# 	$color8  = 187, 187, 187 # LightGray

# 	$color9  = 115, 115, 115 # DarkGray
# 	$color10 = 130, 170, 255 # Blue
# 	$color11 = 199, 250, 150 # Green       --> lime
# 	$color12 =  79, 230, 255 # Cyan

# 	$color13 = 255, 120, 115 # Red
# 	$color14 = 215, 185, 255 # Magenta     --> purple
# 	$color15 = 255, 245, 170 # Yellow
# 	$color16 = 255, 255, 255 # White
# }


#----- 自定义窗口标题和命令提示符：开始 -----

$WindowTitlePrefix = "吴乐川的 PowerShell："
$UserName = "$Env:UserName"

$WindowTitleChiefPart = "$WindowTitlePrefix $UserPrettyName"
$StringUserIsAdmin = ""
If (
	(
		[Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
	).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
) {
	$StringUserIsAdmin = "[$([char]0x5df2)$([char]0x52a8)$([char]0x7528)$([char]0x5176)$([char]0x7ba1)$([char]0x7406)$([char]0x5458)$([char]0x8eab)$([char]0x4efd)]"
	$WindowTitleChiefPart = $WindowTitleChiefPart + " $StringUserIsAdmin"
}


function prompt {
	# http://stackoverflow.com/questions/1338453/custom-powershell-prompts
	# http://windowsitpro.com/blog/customize-your-powershell-prompt

	$Host.UI.RawUI.WindowTitle = "$WindowTitleChiefPart @ $(Get-Location)"

	# Make sure that Windows and .Net know where we are at all times
	[Environment]::CurrentDirectory = (Get-Location -PSProvider FileSystem).ProviderPath

	# Determine what nesting level we are at (if any)
	$Nesting = "$([char]0xB7)" * $NestedPromptLevel

	# Generate PUSHD(push-location) Stack level string
	$Stack = '+' * (Get-Location -Stack).count

	# Put the ID of the command in, so we can get/invoke-history easier
	# eg: "r 4" will re-run the command that has [4]: in the prompt
	$NextCommandId = (Get-History -count 1).Id + 1


	# Output prompt string
	# $ComputerName = "$Env:LogonServer".toLower()
	$ComputerName = "$Env:ComputerName".toLower()

	$script:bg = $Host.UI.RawUI.BackgroundColor
	$script:fg = $Host.UI.RawUI.ForegroundColor

	Write-Host ""

	$date = Get-Date

	$Host.UI.RawUI.BackgroundColor = 'Red'
	$Host.UI.RawUI.ForegroundColor = 'Black'
	Write-Host -NoNewLine ' '
	Write-Host -NoNewLine "$($date.year)-"
	Write-Host -NoNewLine "$($date.month)".PadLeft(2, '0')
	Write-Host -NoNewLine '-'
	Write-Host -NoNewLine "$($date.day)".PadLeft(2, '0')
	Write-Host -NoNewLine ' '

	$Host.UI.RawUI.BackgroundColor = 'DarkYellow' # Expected to be orange
	$Host.UI.RawUI.ForegroundColor = 'Black'
	Write-Host -NoNewLine " 周"
	Write-Host -NoNewLine $date.ToString(' dddd ').Substring(3)

	$Host.UI.RawUI.BackgroundColor = 'Yellow'
	$Host.UI.RawUI.ForegroundColor = 'Yellow' # 故意令其看不见
	Write-Host -NoNewLine 'T'

	$Host.UI.RawUI.BackgroundColor = 'Yellow'
	$Host.UI.RawUI.ForegroundColor = 'Black'
	Write-Host -NoNewLine "$($date.hour)".PadLeft(2, '0')
	Write-Host -NoNewLine ':'
	Write-Host -NoNewLine "$($date.minute)".PadLeft(2, '0')
	Write-Host -NoNewLine ':'
	Write-Host -NoNewLine "$($date.second)".PadLeft(2, '0')

	Write-Host -NoNewLine ' '

	$Host.UI.RawUI.BackgroundColor = 'Green' # Expected to be lime
	$Host.UI.RawUI.ForegroundColor = 'Black'
	Write-Host -NoNewLine $UserName

	$Host.UI.RawUI.BackgroundColor = 'DarkGreen' # Expected to be green
	$Host.UI.RawUI.ForegroundColor = 'Black'
	Write-Host -NoNewLine '@'

	$Host.UI.RawUI.BackgroundColor = 'Cyan'
	$Host.UI.RawUI.ForegroundColor = "Black"
	Write-Host -NoNewLine "${ComputerName}"

	$Host.UI.RawUI.BackgroundColor = 'Blue'
	$Host.UI.RawUI.ForegroundColor = 'Black'
	Write-Host -NoNewLine ':'

	$Host.UI.RawUI.BackgroundColor = 'Magenta' # Expected to be purple
	$Host.UI.RawUI.ForegroundColor = 'Black'
	Write-Host -NoNewLine $(get-location)

	$Host.UI.RawUI.BackgroundColor = $script:bg
	$Host.UI.RawUI.ForegroundColor = $script:bg
	Write-Host '\'

	if ($StringUserIsAdmin) {
		$Host.UI.RawUI.BackgroundColor = 'White'
		$Host.UI.RawUI.ForegroundColor = 'DarkRed'
		Write-Host "$StringUserIsAdmin"
	}

	$Host.UI.RawUI.BackgroundColor = $script:bg
	$Host.UI.RawUI.ForegroundColor = $script:fg
	Write-Host -NoNewLine "[${Nesting}${nextCommandId}${Stack}]:"
	" $([char]0x08)"

	$Host.UI.RawUI.BackgroundColor = $script:bg
	$Host.UI.RawUI.ForegroundColor = $script:fg
}

#----- 自定义窗口标题和命令提示符：结束 -----
