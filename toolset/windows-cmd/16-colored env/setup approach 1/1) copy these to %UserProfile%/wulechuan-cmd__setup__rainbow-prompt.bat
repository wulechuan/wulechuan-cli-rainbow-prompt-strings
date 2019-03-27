@echo off
set    WLC_RAINBOW_CMD_PROMPT_R_TIP=可执行 r 命令以更新提示符中的时日



Prompt    $e[31;41m$S$e[30;101m%DATE:~0,-2%$e[30;43m$S%DATE:~-2%$S$e[30;103m$S%TIME:~0,-3%$S$e[30;102m%UserName%$e[30;42m@$e[30;106m%ComputerName%$e[30;104m:$e[30;105m$P$e[30;100m$S%WLC_RAINBOW_CMD_PROMPT_R_TIP%$S$e[0m$_$$$S



if    /i    NOT "%1"=="noCLS"    cls
@echo on
