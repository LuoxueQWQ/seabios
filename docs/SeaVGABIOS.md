SeaVGABIOS 是 SeaBIOS 项目的一个子项目 - 它是一个开放的
16位X86的源代码实现
[VGA BIOS](http://en.wikipedia.org/wiki/Video_BIOS)。 SeaVGABIOS 是
[QEMU](http://www.qemu.org/) 上的默认 VGA BIOS。 SeaVGABIOS还可以
在某些 X86 VGA 硬件上本机运行
[coreboot](http://www.coreboot.org/)。

构建 SeaVGABIOS
===================

要构建 SeaVGABIOS，请获取[代码]（下载），运行 `make
menuconfig` 并选择要在“VGA ROM”中构建的 VGA BIOS 类型
菜单。 选择后，运行“make”，最终的 VGA BIOS 二进制文件将是
位于“out/vgabios.bin”。

“make menuconfig”中可用 VGA BIOS 的选择是
取决于 CONFIG_QEMU、CONFIG_COREBOOT 或 CONFIG_CSM 是否为
已选择。 此外，“调试”菜单下的调试选项适用于
SeaVGABIOS。 “make menuconfig”中找到的所有其他选项仅适用于
SeaBIOS 并且不会影响 SeaVGABIOS 构建。

如果多个不同的设备（例如 QEMU 的
cirrus 仿真和 QEMU 的“dispi”仿真），然后必须编译
SeaVGABIOS 多次，并为每个版本使用适当的配置。

SeaVGABIOS代码
===============

SeaVGABIOS 的源代码位于 SeaBIOS
[git存储库]（下载）。 主要的 VGA BIOS 代码位于
“vgasrc/”目录。 VGA BIOS 代码始终以 16 位编译
模式。

SeaVGABIOS 构建为与主 SeaBIOS 不同的二进制文件
二进制文件，并且大部分 VGA BIOS 代码与主 BIOS 是分开的
代码。 然而，SeaBIOS 的大部分内容
[开发者文档](Developer_Documentation) 适用于
SeaVGABIOS。 要做出贡献，请加入
[SeaBIOS 邮件列表](Mailinglist)。
