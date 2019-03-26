@echo off
set    WLC_RAINBOW_CMD_PROMPT_R_TIP=可执行 r 命令以更新提示符中的时日


:: 203 暗红色
:: 210 淡红色
:: 222 淡橙色
:: 229 黄色
:: 192 黄绿色
:: 47 绿色
:: 87 青蓝色
:: 111 蓝紫色
:: 219 粉紫色
:: 236 深灰

Prompt    $e[38;5;0;48;5;203m$S$e[38;5;0;48;5;210m%DATE:~0,-2%$e[38;5;0;48;5;222m$S%DATE:~-2%$S$e[38;5;0;48;5;229m$S%TIME:~0,-3%$S$e[38;5;0;48;5;192m%UserName%$e[38;5;0;48;5;47m@$e[38;5;0;48;5;87m%ComputerName%$e[38;5;0;48;5;111m:$e[38;5;0;48;5;219m$P$e[38;5;242;48;5;236m$S%WLC_RAINBOW_CMD_PROMPT_R_TIP%$S$e[39;49m$_$$$S



if    /i    NOT "%1"=="noCLS"    cls
@echo on
