@TITLE 安卓工具包
@ECHO OFF
COLOR 0A

ECHO Hello，World！

GOTO MENU
:MENU
ECHO  [ 菜单 ] 
ECHO.
ECHO. 1.APK安装  
ECHO. 2.获取当前包名
ECHO. 3.启动跳转时间监控
ECHO. 4.获取日志
ECHO. 5.截图并上传到PC
ECHO. 6.录屏并上传到PC
ECHO. 7.查看渠道包进程
ECHO.
ECHO. 8.连续上滑动
ECHO. 9.连续左滑动
ECHO.
ECHO. 10.模拟手柄操作
ECHO. 11.获取手机信息
ECHO. 12.删除指定文件
ECHO.
ECHO. 0.退出


::=-=-=-=-=-=-=-= ↓ 创建存放文件路径 ↓ =-=-=-=-=-=-=-=
::创建存放文件的路径，如果不存在则创建，存在则跳过
IF NOT EXIST "D:\TestFile" MD D:\TestFile
IF NOT EXIST "D:\TestFile\screen" MD D:\TestFile\screen
IF NOT EXIST "D:\TestFile\video" MD D:\TestFile\video
IF NOT EXIST "D:\TestFile\log" MD D:\TestFile\log
::定义PC端 截图、录屏文件以及log日志的存放路径
@REM SET screen_path = D:\TestFile\screen
@REM SET video_path = D:\TestFile\video
@REM SET log_path = D:\TestFile\log
::定义移动端 截图与录屏文件的存放路径
@REM SET android_path = /sdcard
@REM 定义路径的变量已写入具体的菜单下！此处仅供参考！
::=-=-=-=-=-=-=-= ↑ 创建存放文件路径 ↑ =-=-=-=-=-=-=-=

::=-=-=-=-=-=-=-= ↓ 此处定义菜单选项 ↓ =-=-=-=-=-=-=-=
ECHO.
SET /P ID=[ 请输入对应命令的ID：]
IF "%ID%" == "1" GOTO 1 ELSE (
IF "%ID%" == "2" GOTO 2 ELSE (
IF "%ID%" == "3" GOTO 3 ELSE (
IF "%ID%" == "4" GOTO 4 ELSE (
IF "%ID%" == "5" GOTO 5 ELSE (
IF "%ID%" == "6" GOTO 6 ELSE (
IF "%ID%" == "7" GOTO 7 ELSE (
IF "%ID%" == "8" GOTO 8 ELSE (
IF "%ID%" == "9" GOTO 9 ELSE (
IF "%ID%" == "10" GOTO 10 ELSE (
IF "%ID%" == "11" GOTO 11 ELSE (
IF "%ID%" == "12" GOTO 12 ELSE (
IF "%ID%" == "13" GOTO 13 ELSE (
IF "%ID%" == "0" EXIT ))))))))))))) ELSE (
(CLS && ECHO. && ECHO  [ 请输入已给定的ID ] && ECHO. && (GOTO MENU))
REM PAUSE
CLS
ECHO.
ECHO.
::=-=-=-=-=-=-=-= ↑ 此处定义菜单栏选项 ↑ =-=-=-=-=-=-=-=

::=-=-=-=-=-=-=-= ↓ 此处定义菜单栏内容 ↓ =-=-=-=-=-=-=-=
:1
@REM APK安装
CLS
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.::                                             ::
ECHO.::                APK安装助手                   ::
ECHO.::                                             ::
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo --- 请确认手机已连接USB并开始调试模式！---
:loop1
adb wait-for-device
echo.
echo.
SET/p "fp=[ 已连接，拖放文件到此并按回车 ]"
echo.
echo.
echo 正在安装：%fp%
adb install %fp%
echo.
echo.
SET /P ID=[ 继续安装请按1，返回主菜单请按0 ]
IF "%ID%" == "1" GOTO loop1
IF "%ID%" == "0" (
CLS
GOTO MENU
)

:2
@REM 获取当前包名
CLS
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.::                                             ::
ECHO.::           获取当前运行的APP包名                ::
ECHO.::                                             ::
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
:loop2
FOR /F "tokens=3 delims= " %%a in ('adb shell dumpsys window^|find "mCurrentFocus"') do (
        FOR /F "tokens=1 delims=}" %%i in ("%%a") do (
		ECHO.
        ECHO.[ INFO ] 包名/活动名
		ECHO.
        ECHO.[ INFO ] %%i
        )
)
ECHO.
SET /P ID=[ 继续查看请按1，返回主菜单请按0 ]
IF "%ID%" == "1" GOTO loop2
IF "%ID%" == "0" (
CLS
GOTO MENU
)
ECHO.

:3
@REM 启动跳转时间监控
CLS
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.::                                             ::
ECHO.::        Activity启动跳转时间监控             ::
ECHO.::                                             ::
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.
ECHO.[ INFO ] 清空日志
adb logcat -c
ECHO.[ INFO ] 监控开始(Ctrl+C结束)
ECHO.[ INFO ] 结束后将退出当前应用程序，如需使用其他功能请重新打开该程序！
adb logcat -s ActivityManager|Findstr /C:": Displayed"

:4
@REM 日志获取
CLS
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.::                                             ::
ECHO.::                安卓日志获取                 ::
ECHO.::                                             ::
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
:: ~~~~~~~~~~~ 请在此处修改存放目录 ~~~~~~~~~~~
SET log_path=D:\TestFile\log
:: ~~~~~~~~~~~ 请在此处修改存放目录 ~~~~~~~~~~~
set date=%date:/=-%
set date=%date:~0,10%
set time=%time:~0,0%
set time=%time::=-%
set time=%time:.=-%
set timeStamp=%date%_%time%
ECHO.
ECHO.[ INFO ] 获取日志开始(Ctrl+C结束)
ECHO.
ECHO.[ INFO ] 结束后将退出当前应用程序，如需使用其他功能请重新打开该程序！
ECHO.
start D:\TestFile\log
adb logcat -v time > %log_path%\"%timeStamp%_logcat.log"

:5
@REM 截图并上传到PC
CLS
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.::                                             ::
ECHO.::                  手机截图                   ::
ECHO.::                                             ::
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
:: ~~~~~~~~~~~ 请在此处修改存放目录 ~~~~~~~~~~~
SET video_path=D:\TestFile\screen
:: ~~~~~~~~~~~ 请在此处修改存放目录 ~~~~~~~~~~~
ECHO.
:loop5
ECHO.
adb shell screencap -p /sdcard/screen.png
ECHO.
ECHO.
:: 获取得小时,格式为：24小时制，10点前补0
SET c_time_hour=%time:~0,2%
IF /i %c_time_hour% LSS 10 (
SET c_time_hour=0%time:~1,1%
)
ECHO.[ INFO ] 拷贝截图至电脑
adb pull /sdcard/screen.png "%video_path%\%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%.png"
adb shell rm /sdcard/screen.png
start D:\TestFile\screen
ECHO.
SET /P ID=[ 继续截图请按1，返回主菜单请按0 ]
IF "%ID%" == "1" GOTO loop5
IF "%ID%" == "0" (
CLS
GOTO MENU
)
ECHO.

:6
CLS
@REM 录屏并上传到PC
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.::                                             ::
ECHO.::          手机录屏助手(安卓4.4及以上)        ::
ECHO.::                                             ::
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
:: ~~~~~~~~~~~ 请在此处修改存放目录 ~~~~~~~~~~~
SET pc_dir=D:\TestFile\video
SET phone_dir=/sdcard
:: ~~~~~~~~~~~ 请在此处修改存放目录 ~~~~~~~~~~~
:recordstart
ECHO.
ECHO. --- 请确认手机已连接USB并开始调试模式！---
adb wait-for-device
ECHO.
ECHO.[ HELP ] 操作步骤：
ECHO.
ECHO.         1、输入录制时间[回车],不输入[回车]则为默认时间
ECHO.
ECHO.         2、按提示开始录制
SET /a SCTIME=10
:loop6
ECHO.
SET /P SCTIME=[ INFO ] 请输入录制时间(默认10S): 
:MyLoop
SET CONFIRM=test
SET /P CONFIRM=[ INFO ] 确认开始录制？[Enter]
IF NOT "%CONFIRM%"=="test" GOTO MyLoop
ECHO.
ECHO.[ EXEC ] 开始录制视频(Time: %SCTIME%S)
adb shell screenrecord --time-limit %SCTIME% %phone_dir%/screenrecord.mp4

:: 获取得小时,格式为：24小时制，10点前补0
SET c_time_hour=%time:~0,2%
IF /i %c_time_hour% LSS 10 (
SET c_time_hour=0%time:~1,1%
)
ECHO.[ INFO ] 录制结束
ECHO.[ EXEC ] 拷贝录屏至电脑

adb pull %phone_dir%/screenrecord.mp4 "%pc_dir%\%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%.mp4"
adb shell rm %phone_dir%/screenrecord.mp4
START D:\TestFile\video
ECHO.
SET /P ID=[ 继续录屏请按1，返回主菜单请按0 ]
IF "%ID%" == "1" GOTO loop6
IF "%ID%" == "0" (
CLS
GOTO MENU
)
ECHO.


:7
@REM 查看渠道包进程
CLS
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.::                                             ::
ECHO.::                  进程查看                    ::
ECHO.::                                             ::
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.
ECHO. --- 请确认手机已连接USB并开始调试模式！---
adb wait-for-device
ECHO.
:loop7
ECHO.
SET /P name=[ 请在此处输入要查询的进程名称： ]
adb shell "ps |grep %name%"
ECHO.
SET /P ID=[ 继续查看请按1，返回主菜单请按0 ]
IF "%ID%" == "1" GOTO loop7
IF "%ID%" == "0" (
CLS
GOTO MENU
)

:8
@REM 连续上滑动
CLS
ECHO.
ECHO.[ INFO ] 开始连续上滑动(Ctrl+C结束)
ECHO.
ECHO.[ INFO ] 结束后将退出当前应用程序，如需使用其他功能请重新打开该程序！
ECHO.
:up_one
::adb shell input swipe 500 900 500 400 500
ping -n 0.1 127.0>nul
goto up_one
:up_two
adb shell input swipe 500 900 500 400 100
ping -n 0.1 127.0>nul
goto up_one

:9
@REM  连续左滑动
CLS
ECHO.
ECHO.[ INFO ] 开始连续左滑动(Ctrl+C结束)
ECHO.
ECHO.[ INFO ] 结束后将退出当前应用程序，如需使用其他功能请重新打开该程序！
ECHO.
:left_one
::adb shell input swipe 600 500 300 500 100
ping -n 0.1 127.0>nul
goto left_two
:left_two
adb shell input swipe 600 200 300 200 100
ping -n 0.1 127.0>nul
goto left_one

:10
@REM 模拟手柄操作
REM ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
REM ECHO.::                                             ::
REM ECHO.::              键盘模拟手柄                   ::
REM ECHO.::                                             ::
REM ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::

MODE con: cols=62 lines=13

SET keyboardcode=WSADJBNYHMV1234GQ

ECHO. 

ECHO.         LT (%keyboardcode:~11,1%)      LB (%keyboardcode:~12,1%)      RT (%keyboardcode:~13,1%)      RB (%keyboardcode:~14,1%)

ECHO. 

ECHO.  ┍┄┄┄┄┄┄Menu (%keyboardcode:~9,1%)┄┄┄┄┄┄┄View (%keyboardcode:~10,1%)┄┄┄┄┄┄┑

ECHO.  │                                                      │

ECHO.            上 (%keyboardcode:~0,1%)                                 Y (%keyboardcode:~7,1%)

ECHO.                            Start(%keyboardcode:~15,1%)     X (%keyboardcode:~6,1%)

ECHO.      左 (%keyboardcode:~2,1%)     右 (%keyboardcode:~3,1%)     Home (%keyboardcode:~8,1%)

ECHO.                                                   B (%keyboardcode:~5,1%)

ECHO.            下 (%keyboardcode:~1,1%)                       A (%keyboardcode:~4,1%)

ECHO.  │                                                      │

ECHO.  ┕┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┙

:cont

choice /c %keyboardcode% /n >nul

REM ::UP
IF %errorlevel% EQU 1 ( adb shell input keyevent 19 )

REM ::DOWN
IF %errorlevel% EQU 2 ( adb shell input keyevent 20 )

REM ::LEFT
IF %errorlevel% EQU 3 ( adb shell input keyevent 21 )

REM ::RIGHT
IF %errorlevel% EQU 4 ( adb shell input keyevent 22 )

REM ::A
IF %errorlevel% EQU 5 ( adb shell input keyevent 96 )

REM ::B
IF %errorlevel% EQU 6 ( adb shell input keyevent 97 )

REM ::X
IF %errorlevel% EQU 7 ( adb shell input keyevent 99 )

REM ::Y
IF %errorlevel% EQU 8 (  adb shell input keyevent 100 )

REM ::HOME
IF %errorlevel% EQU 9 ( adb shell input keyevent 3 )

REM ::MENU
IF %errorlevel% EQU 10 ( adb shell input keyevent 109 82 )

REM ::VIEW
IF %errorlevel% EQU 11 ( adb shell input keyevent 119 )

REM ::LT
IF %errorlevel% EQU 12 ( adb shell input keyevent 104 )

REM ::LB
IF %errorlevel% EQU 13 ( adb shell input keyevent 102 )

REM ::RT
IF %errorlevel% EQU 14 ( adb shell input keyevent 105 )

REM ::RB
IF %errorlevel% EQU 15 ( adb shell input keyevent 103 )

REM ::START
IF %errorlevel% EQU 16 ( adb shell input keyevent 108 )

REM ::EXIT
IF %errorlevel% EQU 17 exit

GOTO cont

:11
@REM 获取手机信息
CLS
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.::                                             ::
ECHO.::                 读取手机信息                ::
ECHO.::                                             ::
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.
ECHO -------------------------------
adb shell cat /system/build.prop>%~dp0\phone.info
FOR /F "tokens=1,2 delims==" %%a in (phone.info) do (
 IF %%a == ro.build.version.release SET androidOS=%%b
 IF %%a == ro.product.model SET model=%%b
 IF %%a == ro.product.brand SET brand=%%b
)
del /a/f/q %~dp0\phone.info
ECHO.
ECHO. 手机品牌: %brand%
ECHO. 手机型号: %model%
ECHO. 系统版本: Android %androidOS%
ECHO.
ECHO.-------------------------------
ECHO.
ECHO  [ 请按任意键返回主菜单 ]
PAUSE>NUL
CLS
GOTO MENU

:12
@REM 删除指定文件
CLS
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.::                                             ::
ECHO.::                  文件夹删除                   ::
ECHO.::                                             ::
ECHO.:::::::::::::::::::::::::::::::::::::::::::::::::
ECHO.
:loop12
ECHO.
SET /P fileName=[ 请在此处输入要删除的文件夹名称： ]
adb shell rm -rf /sdcard/%fileName%
ECHO.
cd /sdcard/%fileName% 
ECHO.
ECHO [ -- 找不到指定路径则为删除成功 --  请忽略 -- ] 
ECHO.
SET /P ID=[ 继续删除请按1，返回主菜单请按0 ]
IF "%ID%" == "1" GOTO loop12
IF "%ID%" == "0" (
CLS
GOTO MENU
)

:13
@REM 内存监控（待维护）
CLS
ECHO.
ECHO  [ 该功能目前还在维护，请按任意键返回主菜单 ]
PAUSE>NUL
CLS
GOTO MENU

::=-=-=-=-=-=-=-= ↑ 此处定义菜单栏内容 ↑ =-=-=-=-=-=-=-=
