ACPI_EXTRACT_ALL_CODE ssdp_pcihp_aml

DefinitionBlock ("ssdt-pcihp.aml", "SSDT", 0x01, "BXPC", "BXSSDTPCIHP", 0x1)
{

/****************************************************************
 * PCI hotplug
 ****************************************************************/

    /* Objects supplied by DSDT */
    External (\_SB.PCI0, DeviceObj)
    External (\_SB.PCI0.PRMV, MethodObj)
    External (\_SB.PCI0.PCEJ, MethodObj)

    Scope(\_SB.PCI0) {

#define gen_pci_device(slot)                                    \
        Device(SL##slot) {                                      \
            Name (_ADR, 0x##slot##0000)                         \
            Method (_RMV) { Return (PRMV(0x##slot)) }           \
            Name (_SUN, 0x##slot)                               \
        }

        /* VGA (slot 1) and ISA bus (slot 2) defined in DSDT */
        gen_pci_device(03)
        gen_pci_device(04)
        gen_pci_device(05)
        gen_pci_device(06)
        gen_pci_device(07)
        gen_pci_device(08)
        gen_pci_device(09)
        gen_pci_device(0a)
        gen_pci_device(0b)
        gen_pci_device(0c)
        gen_pci_device(0d)
        gen_pci_device(0e)
        gen_pci_device(0f)
        gen_pci_device(10)
        gen_pci_device(11)
        gen_pci_device(12)
        gen_pci_device(13)
        gen_pci_device(14)
        gen_pci_device(15)
        gen_pci_device(16)
        gen_pci_device(17)
        gen_pci_device(18)
        gen_pci_device(19)
        gen_pci_device(1a)
        gen_pci_device(1b)
        gen_pci_device(1c)
        gen_pci_device(1d)
        gen_pci_device(1e)
        gen_pci_device(1f)

        /* Bulk generated PCI hotplug devices */
#define hotplug_slot(slot)                              \
        Device (S##slot) {                              \
           Name (_ADR, 0x##slot##0000)                  \
           Method (_EJ0, 1) { Return(PCEJ(0x##slot)) }  \
           Name (_SUN, 0x##slot)                        \
        }

        hotplug_slot(01)
        hotplug_slot(02)
        hotplug_slot(03)
        hotplug_slot(04)
        hotplug_slot(05)
        hotplug_slot(06)
        hotplug_slot(07)
        hotplug_slot(08)
        hotplug_slot(09)
        hotplug_slot(0a)
        hotplug_slot(0b)
        hotplug_slot(0c)
        hotplug_slot(0d)
        hotplug_slot(0e)
        hotplug_slot(0f)
        hotplug_slot(10)
        hotplug_slot(11)
        hotplug_slot(12)
        hotplug_slot(13)
        hotplug_slot(14)
        hotplug_slot(15)
        hotplug_slot(16)
        hotplug_slot(17)
        hotplug_slot(18)
        hotplug_slot(19)
        hotplug_slot(1a)
        hotplug_slot(1b)
        hotplug_slot(1c)
        hotplug_slot(1d)
        hotplug_slot(1e)
        hotplug_slot(1f)

#define gen_pci_hotplug(slot)   \
            If (LEqual(Arg0, 0x##slot)) { Notify(S##slot, Arg1) }

        Method(PCNT, 2) {
            gen_pci_hotplug(01)
            gen_pci_hotplug(02)
            gen_pci_hotplug(03)
            gen_pci_hotplug(04)
            gen_pci_hotplug(05)
            gen_pci_hotplug(06)
            gen_pci_hotplug(07)
            gen_pci_hotplug(08)
            gen_pci_hotplug(09)
            gen_pci_hotplug(0a)
            gen_pci_hotplug(0b)
            gen_pci_hotplug(0c)
            gen_pci_hotplug(0d)
            gen_pci_hotplug(0e)
            gen_pci_hotplug(0f)
            gen_pci_hotplug(10)
            gen_pci_hotplug(11)
            gen_pci_hotplug(12)
            gen_pci_hotplug(13)
            gen_pci_hotplug(14)
            gen_pci_hotplug(15)
            gen_pci_hotplug(16)
            gen_pci_hotplug(17)
            gen_pci_hotplug(18)
            gen_pci_hotplug(19)
            gen_pci_hotplug(1a)
            gen_pci_hotplug(1b)
            gen_pci_hotplug(1c)
            gen_pci_hotplug(1d)
            gen_pci_hotplug(1e)
            gen_pci_hotplug(1f)
        }
    }
}
