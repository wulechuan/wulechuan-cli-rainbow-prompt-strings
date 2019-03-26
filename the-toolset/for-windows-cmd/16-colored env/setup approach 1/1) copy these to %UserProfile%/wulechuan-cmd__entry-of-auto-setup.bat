@echo off


:: -------- linux like DOSKeys --------- ::
DOSKEY =exit
DOSKEY ls=dir
DOSKEY cd~=PUSHD "%UserProfile%" & POPD




:: -------- Load personal setups if any --------- ::
set    WLC_BAT_FILE_TO_LOAD="%UserProfile%\wulechuan-cmd__setup__personal.bat"
IF  exist    "%WLC_BAT_FILE_TO_LOAD%" (
    call     "%WLC_BAT_FILE_TO_LOAD%"
    @echo off
)





set    WLC_RAINBOW_PROMPT_BAT_FILE_TO_LOAD="%UserProfile%\wulechuan-cmd__setup__rainbow-prompt.bat"
:: -------- Manually updated psuedo-dynamic Prompt --------- ::
:: Windows CMD 非常古老，其【命令提示符】无法定义成一个函数，
:: 也就无从实现动态更新各种内容之功能。这一点不像 PowerShell 和
:: Bash 中的【命令提示符】那样强大和自由。
:: 结论：我们必须手工更新 CMD 的【命令提示符】。
:: 下方借助 DOSKEY 功能来定义的“r” 命令，即是为了便于手工更新
::【命令提示符】中的日期和时刻两类动态信息而设。
:: 另，此处必须采用调用外部 bat 文件的方式，以确保数据每每皆被更新。
:: 如果在此处直接使用 Prompt 语句，则在头一次执行之后，
::【命令提示符】中涉及的变量值都会被缓存，绝不再更新。
:: The prompt string of Windows CMD environment can never be an invocable
:: thing, aka a function. Thus, once set, it can never update automatically, unlike
:: the prompts in PowerShell or Bash.
:: WE HAVE TO MANUALLY UPDATE INFORMATION IN THE CMD PROMPT STRING!
:: Additionally, to call an external bat file below is a necessary way for
:: repeatedly updating prompt variables. If otherwise we directly write the
:: Prompt command statement here, then those varibales (date and time)
:: mentioned in the prompt string will be cached when the prompt statement
:: get executed for the first time, and never change after that.
IF    exist       "%WLC_RAINBOW_PROMPT_BAT_FILE_TO_LOAD%"    (
    DOSKEY r=call "%WLC_RAINBOW_PROMPT_BAT_FILE_TO_LOAD%"
    call          "%WLC_RAINBOW_PROMPT_BAT_FILE_TO_LOAD%"    noCLS
    @echo off
)





:init
D:



:: echo 本行可用于验证该自动执行 BAT 脚本，会在 nodejs 的 npm 命令启动时被执行。This line can prove that the nodejs npm `run` command will invoke this bat before it runs scripts defined in a package.json file.


:: 由于该 bat 文件总会被 Windows 自动执行。
:: 更奇特的是，对于看似与 bat 毫不相干的 PowerShell 环境，它也会被执行！
:: 换句话说，即便是在我们主观不期望其执行、并且以为其不会执行之情形下，该 bat 也会被运行。
:: 因此，不难想象，下面这行用于切换当前路径的语句将会干扰到
:: 看似完全无关的 PowerShell 环境，并产生难以捉摸的副作用。
:: 例如，我曾经因为启用过类似下方语句的 CD 语句，使得 nodejs 的 npm 在运行时，
:: 会先悄无声息的切换当前文件夹，而后在错误的文件夹下尝试运行 npm 命令，导致错误发生。
:: 因此，下面的语句不得不被舍弃。并且，类似的语句都不可以写入该 bat 文件！切忌之！
:: PLEASE DO NOT WRITE ANY `CD` STATEMENT HERE INSIDE THIS BAT FILE!
:: CD D:\my-lovely-folder



:end
set    WLC_BAT_FILE_TO_LOAD=
set    WLC_RAINBOW_PROMPT_BAT_FILE_TO_LOAD=
@echo on
