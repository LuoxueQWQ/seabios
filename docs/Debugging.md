本页描述了获取诊断信息的过程
来自 SeaBIOS 和报告问题。

诊断信息
=====================

SeaBIOS 能够输出诊断消息。 这是
通过调用“dprintf()”C 函数在代码中实现。

在 QEMU 上，这些消息被写入特殊的调试端口。 一罐
通过添加 '-chardev stdio,id=seabios -device 查看这些消息
isa-debugcon,iobase=0x402,chardev=seabios' 到 QEMU 命令行。
完成此操作后，人们应该在控制台上看到状态消息。

在 coreboot 上，这些消息通常写入“cbmem”
控制台（CONFIG_DEBUG_COREBOOT）。 如果 SeaBIOS 启动 Linux 操作系统
系统，可以从 coreboot 存储库获取 cbmem 工具，并
运行“cbmem -c”以查看 SeaBIOS 诊断消息。

另外，如果有串口可用，可以编译SeaBIOS
将诊断消息发送到串行端口。 查看 SeaBIOS
CONFIG_DEBUG_SERIAL 选项。

问题报告
=================

如果您遇到 SeaBIOS 问题，增加
调试级别。 这是通过运行“make menuconfig”来完成的
将 CONFIG_DEBUG_LEVEL 设置为更高的值。 调试级别为 8 将
显示大量诊断信息而不淹没串行端口
（8级以上经常会导致数据过多）。

要报告问题，请使用 SeaBIOS 收集串行启动日志
设置为 8 调试级别并转发完整日志以及
向 SeaBIOS [邮件列表](Mailinglist) 描述问题。

定时调试消息
=====================

SeaBIOS 存储库有一个工具 (**scripts/readserial.py**)，可以
生成的每条诊断消息的时间戳。 时间戳可以提供
有关内部流程需要多长时间的一些附加信息。 它
还提供了一个简单的分析机制。

该工具可用于具有诊断消息的 coreboot 版本
发送到串行端口。 确保 SeaBIOS 配置为
CONFIG_DEBUG_SERIAL 并在接收串行的主机上运行以下命令
输出：

`/path/to/seabios/scripts/readserial.py /dev/ttyS0 115200`

使用适当的串行设备和波特率更新上述命令
速度。

该工具还可以为来自 QEMU 调试端口的消息添加时间戳。 到
与 QEMU 一起使用运行以下命令：

````
mkfifo qemudebugpipe
qemu -chardev 管道，路径=qemudebugpipe，id=seabios -device isa-debugcon，iobase=0x402，chardev=seabios ...
````

然后在另一个会话中：

`/path/to/seabios/scripts/readserial.py -nf qemudebugpipe`

mkfifo 命令只需运行一次即可创建管道文件。

当readserial.py运行时，它显示一个毫秒的时间戳
自日志开始以来的时间量的精度。 如果一个
在readserial.py会话中按“enter”键，它将添加一个
屏幕上出现空白行，并将时间重置为零。 这
readserial.py 程序还保留文件中所有输出的日志
看起来像“seriallog-YYYYMMDD_HHMMSS.log”。

在 QEMU 上使用 gdb 进行调试
=========================

可以使用 gdb 和 QEMU 来调试系统映像。 为此，请添加 '-s
-S' 到 QEMU 命令行。 例如：

`qemu -bios out/bios.bin -fda myfdimage.img -s -S`

然后，在另一个会话中，使用 out/rom16.o 运行 gdb（以调试
BIOS 16 位代码）或 out/rom.o（调试 BIOS 32 位代码）。 例如：

`gdb 输出/rom16.o`

进入 gdb 后，使用命令 `target remote localhost:1234` 来获得
gdb 连接到 QEMU。 请参阅 QEMU 文档以获取更多信息
在此模式下使用 gdb 和 QEMU。

调试16位代码时需要加载16位符号
两次以便 gdb 正确处理断点。 去做这个，
运行以下命令`objcopy --调整-vma 0xf0000 out/rom16.o
rom16offset.o`，然后在 gdb 中运行以下命令：

````
设置架构 i8086
添加符号文件 rom16offset.o 0
````

要调试 VGA BIOS 映像，请运行“gdb out/vgarom.o”，创建一个
vgaromoffset.o 文件，偏移量为 0xc0000，添加使用 gdb
命令 `add-symbol-file out/vgaromoffset.o 0` 加载 16 位 VGA
BIOS 符号两次。

如果使用 gdb 调试 32 位 SeaBIOS 初始化代码，请注意
SeaBIOS 默认情况下会进行自我重定位。 此次搬迁将改变
初始化代码符号的位置。 禁用
CONFIG_RELOCATE_INIT 以防止 SeaBIOS 执行此操作。
