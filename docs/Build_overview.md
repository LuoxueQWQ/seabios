SeaBIOS 代码可以使用标准 GNU 工具构建。 最近的Linux
发行版应该能够使用标准构建 SeaBIOS
编译器工具。

构建 SeaBIOS
===============

首先，【获取代码】（下载）。 SeaBIOS 可以编译为
几个不同的构建目标。 也可以这样配置
其他编译时选项 - 运行 **make menuconfig** 来执行此操作。

为 QEMU 构建（以及 KVM、Xen 和 Bochs）
-----------------------------------------------------------

要构建 QEMU（和类似的），应该能够运行“make”
主目录。 生成的文件“out/bios.bin”包含
处理后的BIOS图像。

通过使用 QEMU 的“-bios”，可以将生成的二进制文件与 QEMU 一起使用
选项。 例如：

`qemu -bios out/bios.bin -fda myfdimage.img`

还可以将生成的二进制文件与 Bochs 一起使用。 例如：

`bochs -q 'floppya: 1_44=myfdimage.img' 'romimage: file=out/bios.bin'`

为核心启动构建
------------------

要构建 coreboot，请参阅 coreboot 构建说明：
<http://www.coreboot.org/SeaBIOS>

构建为 UEFI 兼容性支持模块 (CSM)
--------------------------------------------------

要构建为 CSM，首先运行 kconfig (make menuconfig) 并启用
CONFIG_CSM。 然后构建 SeaBIOS (make) - 生成的二进制文件将是
在“out/Csm16.bin”中。

该二进制文件可与 OMVF/EDK-II UEFI 固件一起使用。 它会
提供用于引导非 EFI 操作系统的“传统”BIOS 服务
并且还允许 OVMF 在其他不支持的视频上显示
使用传统的 VGA BIOS 来控制硬件。 （已知 Windows 2008r2
即使通过 EFI 启动也可以使用 INT 10h BIOS 调用，并且存在
CSM 的使用也使这项工作按预期进行。）

使用 CONFIG_CSM 构建 SeaBIOS 后，应该能够放弃
结果 (out/Csm16.bin) 到 OVMF 构建树中
OvmfPkg/Csm/Csm16/Csm16.bin，然后使用 'build -D 构建 OVMF
CSM_ENABLE'。 SeaBIOS 二进制文件将作为独立文件包含在内
在创建的“Flash Volume”内，有一些工具可以
将提取它并允许将其替换。

分布构建
===================

如果正在构建 SeaBIOS 的二进制版本作为软件包的一部分
（例如 rpm）或为了广泛分布，请提供
构建期间的 EXTRAVERSION 字段。 例如：

`make EXTRAVERSION="-${RPM_PACKAGE_RELEASE}"`

EXTRAVERSION 字段应提供包版本（如果
适用）和发行版的名称（如果还没有）
从软件包版本中可以明显看出）。 该字符串将被附加到
主要 SeaBIOS 版本。 以上信息对 SeaBIOS 开发人员有帮助
将缺陷报告与源代码和构建环境相关联。

如果在没有的构建环境中构建二进制文件
可以访问 git 工具或没有完整的 SeaBIOS git 存储库
可用，那么请使用官方 SeaBIOS 发布 tar 文件作为
来源。 如果从快照构建（没有官方的
SeaBIOS tar) 那么应该在一台机器上生成一个快照 tar 文件
它确实支持使用 script/tarball.sh 工具的 git。 例如：

`脚本/tarball.sh`

tarball.sh 脚本在生成的 tar 中对版本信息进行编码
构建可以提取并包含在最终二进制文件中的文件。 这
从 tar 构建时，仍应设置上述 EXTRAVERSION 字段。

存储库中文件的概述
=====================================

**src/** 目录包含主要的 BIOS 源代码。 这
**src/hw/** 目录包含特定于硬件的源代码
司机。 **src/fw/** 目录包含平台的源代码
固件初始化。 **src/std/** 目录包含标头
描述标准 BIOS、固件和硬件接口的文件。

**vgasrc/** 目录包含 [SeaVGABIOS](SeaVGABIOS) 的代码。

**scripts/** 目录包含用于操作的辅助实用程序
并构建最终的ROM。

**out/** 目录是由构建过程创建的 - 它包含
所有中间和最终文件。

阅读 C 代码时请注意，在 16 位模式下运行的代码可以
不能随意访问非堆栈内存——参见[内存模型](内存
型号）了解更多详细信息。 有关主要 C 代码函数的信息
代码执行开始的位置请参阅[执行和代码
flow]（执行和代码流程）。
