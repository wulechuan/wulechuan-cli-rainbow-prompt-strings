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
:: Windows CMD �ǳ����ϣ��䡾������ʾ�����޷������һ��������
:: Ҳ���޴�ʵ�ֶ�̬���¸�������֮���ܡ���һ�㲻�� PowerShell ��
:: Bash �еġ�������ʾ��������ǿ������ɡ�
:: ���ۣ����Ǳ����ֹ����� CMD �ġ�������ʾ������
:: �·����� DOSKEY ����������ġ�r�� �������Ϊ�˱����ֹ�����
::��������ʾ�����е����ں�ʱ�����ද̬��Ϣ���衣
:: ���˴�������õ����ⲿ bat �ļ��ķ�ʽ����ȷ������ÿÿ�Ա����¡�
:: ����ڴ˴�ֱ��ʹ�� Prompt ��䣬����ͷһ��ִ��֮��
::��������ʾ�������漰�ı���ֵ���ᱻ���棬�����ٸ��¡�
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



:: echo ���п�������֤���Զ�ִ�� BAT �ű������� nodejs �� npm ��������ʱ��ִ�С�This line can prove that the nodejs npm `run` command will invoke this bat before it runs scripts defined in a package.json file.


:: ���ڸ� bat �ļ��ܻᱻ Windows �Զ�ִ�С�
:: �����ص��ǣ����ڿ����� bat ������ɵ� PowerShell ��������Ҳ�ᱻִ�У�
:: ���仰˵�����������������۲�������ִ�С�������Ϊ�䲻��ִ��֮�����£��� bat Ҳ�ᱻ���С�
:: ��ˣ����������������������л���ǰ·������佫����ŵ�
:: ������ȫ�޹ص� PowerShell ����������������׽���ĸ����á�
:: ���磬��������Ϊ���ù������·����� CD ��䣬ʹ�� nodejs �� npm ������ʱ��
:: ����������Ϣ���л���ǰ�ļ��У������ڴ�����ļ����³������� npm ������´�������
:: ��ˣ��������䲻�ò������������ң����Ƶ���䶼������д��� bat �ļ����м�֮��
:: PLEASE DO NOT WRITE ANY `CD` STATEMENT HERE INSIDE THIS BAT FILE!
:: CD D:\my-lovely-folder



:end
set    WLC_BAT_FILE_TO_LOAD=
set    WLC_RAINBOW_PROMPT_BAT_FILE_TO_LOAD=
@echo on
