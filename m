Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:52222 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbdI1VSM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 17:18:12 -0400
MIME-Version: 1.0
Message-ID: <trinity-d76a5983-fa13-4ac4-8e48-d94d22a80e86-1506633490200@3c-app-gmx-bs75>
From: "Peter Huewe" <PeterHuewe@gmx.de>
To: linux-integrity@vger.kernel.org
Subject: tpm_tis_spi gets initialized long after IMA
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Sep 2017 23:18:10 +0200
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

I'm currently trying to play around with IMA on my raspberry pi3,
however I cannot get it to work since the TPM chip/tpm_tis_spi driver gets initialized way after IMA.

In dmesg this looks like:

dmesg | grep -i tpm
[    0.726551] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    3.257464] tpm_tis_spi spi0.1: 2.0 TPM (device-id 0x1B, rev-id 16)
[    3.270398] tpm tpm0: A TPM error (256) occurred continue selftest
[    3.270418] tpm tpm0: starting up the TPM manually

 so 2.5 seconds after ima.

The initcall order should be fine as far as I can see, with ima having a late_initcall.

IMA, tpm_tis_spi and tpm are compiled into the kernel.

$ grep TCG .config

CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set

$ grep _IMA .config
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_IMAGEBLIT=m
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_APPRAISE_BOOTPARAM=y


Linux version 4.14.0-rc2-v7+ (but I've seen that with earlier versions too)



Whole dmesg here:
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.14.0-rc2-v7+ (peter@lamerx) (gcc version 4.8.3 20140303 (prerelease) (crosstool-NG linaro-1.13.1+bzr2650 - Linaro GCC 2014.03)) #99 SMP Thu Sep 28 22:29:20 CEST 2017
[    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=10c5383d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Raspberry Pi 3 Model B Rev 1.2
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 8 MiB at 0x3ac00000
[    0.000000] On node 0 totalpages: 242688
[    0.000000] free_area_init_node: node 0, pgdat 80c80a00, node_mem_map ba3a1000
[    0.000000]   Normal zone: 2133 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 242688 pages, LIFO batch:31
[    0.000000] random: fast init done
[    0.000000] percpu: Embedded 17 pages/cpu @ba34a000 s38976 r8192 d22464 u69632
[    0.000000] pcpu-alloc: s38976 r8192 d22464 u69632 alloc=17*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 240555
[    0.000000] Kernel command line: 8250.nr_uarts=0 bcm2708_fb.fbwidth=1824 bcm2708_fb.fbheight=984 bcm2708_fb.fbswap=1 vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000  dwc_otg.lpm_enable=0 console=ttyS0,115200 console=tty1 root=PARTUUID=674b2fb1-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait quiet splash plymouth.ignore-serial-consoles
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)                                             
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)                                 
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)                                   
[    0.000000] Memory: 940244K/970752K available (7168K kernel code, 556K rwdata, 2132K rodata, 1024K init, 714K bss, 22316K reserved, 8192K cma-reserved)                                                                      
[    0.000000] Virtual kernel memory layout:                                                                    
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)                                                               
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)                                                               
    vmalloc : 0xbb800000 - 0xff800000   (1088 MB)                                                               
    lowmem  : 0x80000000 - 0xbb400000   ( 948 MB)                                                               
    modules : 0x7f000000 - 0x80000000   (  16 MB)                                                               
      .text : 0x80008000 - 0x80800000   (8160 kB)                                                               
      .init : 0x80b00000 - 0x80c00000   (1024 kB)
      .data : 0x80c00000 - 0x80c8b3bc   ( 557 kB)
       .bss : 0x80c9306c - 0x80d45c1c   ( 715 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 26414 entries in 78 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] arch_timer: cp15 timer(s) running at 19.20MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000006] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
[    0.000017] Switching to timer-based delay loop, resolution 52ns
[    0.000287] Console: colour dummy device 80x30
[    0.000306] console [tty1] enabled
[    0.000331] Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=192000)
[    0.000346] pid_max: default: 32768 minimum: 301
[    0.000489] Security Framework initialized
[    0.000497] Yama: becoming mindful.
[    0.000530] AppArmor: AppArmor disabled by boot time parameter
[    0.000708] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000722] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001577] CPU: Testing write buffer coherency: ok
[    0.002001] CPU0: update cpu_capacity 1024
[    0.002009] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.002398] Setting up static identity map for 0x100000 - 0x10003c
[    0.002519] Hierarchical SRCU implementation.
[    0.003218] smp: Bringing up secondary CPUs ...
[    0.003867] CPU1: update cpu_capacity 1024
[    0.003875] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.004593] CPU2: update cpu_capacity 1024
[    0.004600] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.005309] CPU3: update cpu_capacity 1024
[    0.005317] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.005405] smp: Brought up 1 node, 4 CPUs
[    0.005416] SMP: Total of 4 processors activated (153.60 BogoMIPS).
[    0.005421] CPU: All CPU(s) started in HYP mode.
[    0.005425] CPU: Virtualization extensions available.
[    0.006255] devtmpfs: initialized
[    0.016497] evm: security.SMACK64
[    0.016503] evm: security.SMACK64EXEC
[    0.016507] evm: security.SMACK64TRANSMUTE
[    0.016512] evm: security.SMACK64MMAP
[    0.016516] evm: security.ima
[    0.016520] evm: security.capability
[    0.017233] VFP support v0.3: implementor 41 architecture 3 part 40 variant 3 rev 4
[    0.017452] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.017469] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.018122] pinctrl core: initialized pinctrl subsystem
[    0.018880] NET: Registered protocol family 16
[    0.021622] DMA: preallocated 1024 KiB pool for atomic coherent allocations
[    0.026668] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.026676] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.026871] Serial: AMBA PL011 UART driver
[    0.028531] bcm2835-mbox 3f00b880.mailbox: mailbox enabled
[    0.029000] uart-pl011 3f201000.serial: could not find pctldev for node /soc/gpio@7e200000/uart0_pins, deferring probe
[    0.061781] bcm2835-dma 3f007000.dma: DMA legacy API manager at bb80f000, dmachans=0x1
[    0.063266] SCSI subsystem initialized
[    0.063394] usbcore: registered new interface driver usbfs
[    0.063447] usbcore: registered new interface driver hub
[    0.063534] usbcore: registered new device driver usb
[    0.070110] raspberrypi-firmware soc:firmware: Attached to firmware from 2017-09-22 19:50
[    0.070767] NetLabel: Initializing
[    0.070773] NetLabel:  domain hash size = 128
[    0.070778] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.070858] NetLabel:  unlabeled traffic allowed by default
[    0.071579] clocksource: Switched to clocksource arch_sys_counter
[    0.142785] VFS: Disk quotas dquot_6.6.0
[    0.142870] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.143050] FS-Cache: Loaded
[    0.143254] CacheFiles: Loaded
[    0.152319] NET: Registered protocol family 2
[    0.153059] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.153168] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.153353] TCP: Hash tables configured (established 8192 bind 8192)
[    0.153487] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.153531] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.153761] NET: Registered protocol family 1
[    0.154208] RPC: Registered named UNIX socket transport module.
[    0.154214] RPC: Registered udp transport module.
[    0.154219] RPC: Registered tcp transport module.
[    0.154225] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.155863] hw perfevents: enabled with armv7_cortex_a7 PMU driver, 7 counters available
[    0.157944] audit: initializing netlink subsys (disabled)
[    0.158114] audit: type=2000 audit(0.149:1): state=initialized audit_enabled=0 res=1
[    0.158694] Initialise system trusted keyrings
[    0.158750] Key type blacklist registered
[    0.158876] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[    0.167167] FS-Cache: Netfs 'nfs' registered for caching
[    0.167769] NFS: Registering the id_resolver key type
[    0.167799] Key type id_resolver registered
[    0.167804] Key type id_legacy registered
[    0.169970] Key type asymmetric registered
[    0.169977] Asymmetric key parser 'x509' registered
[    0.170035] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.170157] io scheduler noop registered
[    0.170164] io scheduler deadline registered (default)
[    0.170443] io scheduler cfq registered
[    0.170450] io scheduler mq-deadline registered
[    0.170455] io scheduler kyber registered
[    0.172032] gpio gpiochip1: GPIO chip parent is NULL
[    0.172793] gpio gpiochip2: GPIO chip parent is NULL
[    0.173317] BCM2708FB: allocated DMA memory fad10000
[    0.173344] BCM2708FB: allocated DMA channel 0 @ bb80f000
[    0.223813] Console: switching to colour frame buffer device 228x61
[    0.254209] bcm2835-rng 3f104000.rng: hwrng registered
[    0.254375] vc-mem: phys_addr:0x00000000 mem_base=0x3ec00000 mem_size:0x40000000(1024 MiB)
[    0.254873] vc-sm: Videocore shared memory driver
[    0.255168] gpiomem-bcm2835 3f200000.gpiomem: Initialised: Registers at 0x3f200000
[    0.265169] brd: module loaded
[    0.274019] loop: module loaded
[    0.274034] Loading iSCSI transport class v2.0-870.
[    0.274582] usbcore: registered new interface driver smsc95xx
[    0.274600] dwc_otg: version 3.00a 10-AUG-2012 (platform bus)
[    0.502775] Core Release: 2.80a
[    0.502785] Setting default values for core params
[    0.502819] Finished setting default values for core params
[    0.703082] Using Buffer DMA mode
[    0.703088] Periodic Transfer Interrupt Enhancement - disabled
[    0.703093] Multiprocessor Interrupt Enhancement - disabled
[    0.703100] OTG VER PARAM: 0, OTG VER FLAG: 0
[    0.703112] Dedicated Tx FIFOs mode
[    0.703515] WARN::dwc_otg_hcd_init:1032: FIQ DMA bounce buffers: virt = 0xbad04000 dma = 0xfad04000 len=9024
[    0.703543] FIQ FSM acceleration enabled for :
Non-periodic Split Transactions
Periodic Split Transactions
High-Speed Isochronous Endpoints
Interrupt/Control Split Transaction hack enabled
[    0.703551] dwc_otg: Microframe scheduler enabled
[    0.703610] WARN::hcd_init_fiq:459: FIQ on core 1 at 0x80612e58
[    0.703621] WARN::hcd_init_fiq:460: FIQ ASM at 0x806131ac length 36
[    0.703635] WARN::hcd_init_fiq:486: MPHI regs_base at 0xbb87a000
[    0.703702] dwc_otg 3f980000.usb: DWC OTG Controller
[    0.703736] dwc_otg 3f980000.usb: new USB bus registered, assigned bus number 1
[    0.703770] dwc_otg 3f980000.usb: irq 62, io mem 0x00000000
[    0.703817] Init: Port Power? op_state=1
[    0.703822] Init: Power Port (0)
[    0.704048] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.704059] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.704067] usb usb1: Product: DWC OTG Controller
[    0.704075] usb usb1: Manufacturer: Linux 4.14.0-rc2-v7+ dwc_otg_hcd
[    0.704085] usb usb1: SerialNumber: 3f980000.usb
[    0.704731] hub 1-0:1.0: USB hub found
[    0.704774] hub 1-0:1.0: 1 port detected
[    0.705335] dwc_otg: FIQ enabled
[    0.705341] dwc_otg: NAK holdoff enabled
[    0.705346] dwc_otg: FIQ split-transaction FSM enabled
[    0.705356] Module dwc_common_port init
[    0.705623] usbcore: registered new interface driver usb-storage
[    0.705800] mousedev: PS/2 mouse device common for all mice
[    0.705885] IR NEC protocol handler initialized
[    0.705891] IR RC5(x/sz) protocol handler initialized
[    0.705896] IR RC6 protocol handler initialized
[    0.705901] IR JVC protocol handler initialized
[    0.705908] IR Sony protocol handler initialized
[    0.705913] IR SANYO protocol handler initialized
[    0.705918] IR Sharp protocol handler initialized
[    0.705924] IR MCE Keyboard/mouse protocol handler initialized
[    0.705928] IR XMP protocol handler initialized
[    0.706662] bcm2835-wdt 3f100000.watchdog: Broadcom BCM2835 watchdog timer
[    0.706949] bcm2835-cpufreq: min=600000 max=1200000
[    0.707325] sdhci: Secure Digital Host Controller Interface driver
[    0.707330] sdhci: Copyright(c) Pierre Ossman
[    0.707682] mmc-bcm2835 3f300000.mmc: could not get clk, deferring probe
[    0.708005] sdhost-bcm2835 3f202000.mmc: could not get clk, deferring probe
[    0.708104] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.710702] ledtrig-cpu: registered to indicate activity on CPUs
[    0.710876] hidraw: raw HID events driver (C) Jiri Kosina
[    0.710995] usbcore: registered new interface driver usbhid
[    0.711000] usbhid: USB HID core driver
[    0.711778] vchiq: vchiq_init_state: slot_zero = bad80000, is_master = 0
[    0.713626] [vc_sm_connected_init]: start
[    0.723341] [vc_sm_connected_init]: end - returning 0
[    0.724007] Initializing XFRM netlink socket
[    0.724032] NET: Registered protocol family 17
[    0.724142] Key type dns_resolver registered
[    0.724671] Registering SWP/SWPB emulation handler
[    0.725258] registered taskstats version 1
[    0.725276] Loading compiled-in X.509 certificates
[    0.726037] Key type trusted registered
[    0.726536] Key type encrypted registered
[    0.726551] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    0.726648] evm: HMAC attrs: 0x1
[    0.732744] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 87, base_baud = 0) is a PL011 rev2
[    0.734563] mmc-bcm2835 3f300000.mmc: mmc_debug:0 mmc_debug2:0
[    0.734573] mmc-bcm2835 3f300000.mmc: DMA channel allocated
[    0.792120] sdhost: log_buf @ bad07000 (fad07000)
[    0.829177] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    0.830731] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.832285] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.835068] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    0.871650] mmc0: sdhost-bcm2835 loaded - DMA enabled (>1)
[    0.872732] of_cfs_init
[    0.872824] of_cfs_init: OK
[    0.873407] Waiting for root device PARTUUID=674b2fb1-02...
[    0.921711] Indeed it is in host mode hprt0 = 00021501
[    1.012462] mmc1: new high speed SDIO card at address 0001
[    1.052682] mmc0: host does not support reading read-only switch, assuming write-enable
[    1.055545] mmc0: new high speed SDHC card at address aaaa
[    1.056047] mmcblk0: mmc0:aaaa SL16G 14.8 GiB
[    1.058647]  mmcblk0: p1 p2
[    1.086711] EXT4-fs (mmcblk0p2): INFO: recovery required on readonly filesystem
[    1.086720] EXT4-fs (mmcblk0p2): write access will be enabled during recovery
[    1.131620] usb 1-1: new high-speed USB device number 2 using dwc_otg
[    1.131769] Indeed it is in host mode hprt0 = 00001101
[    1.371868] usb 1-1: New USB device found, idVendor=0424, idProduct=9514
[    1.371883] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.372564] hub 1-1:1.0: USB hub found
[    1.372650] hub 1-1:1.0: 5 ports detected
[    1.393207] EXT4-fs (mmcblk0p2): orphan cleanup on readonly fs
[    1.394199] EXT4-fs (mmcblk0p2): 4 orphan inodes deleted
[    1.394206] EXT4-fs (mmcblk0p2): recovery complete
[    1.412781] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    1.412844] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
[    1.413619] devtmpfs: mounted
[    1.417115] Freeing unused kernel memory: 1024K
[    1.680787] systemd[1]: systemd 215 running in system mode. (+PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
[    1.681184] systemd[1]: Detected architecture 'arm'.
[    1.691647] usb 1-1.1: new high-speed USB device number 3 using dwc_otg
[    1.781527] NET: Registered protocol family 10
[    1.782945] Segment Routing with IPv6
[    1.783125] systemd[1]: Inserted module 'ipv6'
[    1.787641] systemd[1]: Set hostname to <datalogger>.
[    1.787811] systemd[1]: Initializing machine ID from random generator.
[    1.788053] systemd[1]: Installed transient /etc/machine-id file.
[    1.822008] usb 1-1.1: New USB device found, idVendor=0424, idProduct=ec00
[    1.822027] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.825184] smsc95xx v1.0.6
[    1.915315] smsc95xx 1-1.1:1.0 eth0: register 'smsc95xx' at usb-3f980000.usb-1.1, smsc95xx USB 2.0 Ethernet, b8:27:eb:b5:76:21
[    2.011664] usb 1-1.4: new low-speed USB device number 4 using dwc_otg
[    2.153466] systemd[1]: Cannot add dependency job for unit regenerate_ssh_host_keys.service, ignoring: Unit regenerate_ssh_host_keys.service failed to load: No such file or directory.
[    2.157498] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[    2.157937] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    2.158040] systemd[1]: Starting Remote File Systems (Pre).
[    2.161673] usb 1-1.4: New USB device found, idVendor=046d, idProduct=c312
[    2.161687] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.161696] usb 1-1.4: Product: USB Multimedia Keyboard
[    2.161704] usb 1-1.4: Manufacturer: LITEON Technology
[    2.173828] input: LITEON Technology USB Multimedia Keyboard as /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.4/1-1.4:1.0/0003:046D:C312.0001/input/input0
[    2.242584] hid-generic 0003:046D:C312.0001: input,hidraw0: USB HID v1.10 Keyboard [LITEON Technology USB Multimedia Keyboard] on usb-3f980000.usb-1.4/input0
[    2.341791] fuse init (API version 7.26)
[    2.365359] i2c /dev entries driver
[    2.521349] systemd-udevd[122]: starting version 215
[    3.129827] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
[    3.257464] tpm_tis_spi spi0.1: 2.0 TPM (device-id 0x1B, rev-id 16)
[    3.270398] tpm tpm0: A TPM error (256) occurred continue selftest
[    3.270418] tpm tpm0: starting up the TPM manually
[    3.377828] snd_bcm2835: module is from the staging directory, the quality is unknown, you have been warned.
[    3.441173] brcmfmac: brcmf_fw_map_chip_to_name: using brcm/brcmfmac43430-sdio.bin for chip 0x00a9a6(43430) rev 0x000001
[    3.441486] usbcore: registered new interface driver brcmfmac
[    3.548535] bcm2835_alsa bcm2835_alsa: card created with 8 channels
[    3.559576] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Aug  7 2017 00:46:29 version 7.45.41.46 (r666254 CY) FWID 01-f8a78378
[    4.064397] systemd-journald[126]: Received request to flush runtime journal from PID 1
[    5.889812] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    5.889830] brcmfmac: power management disabled
[    6.060250] uart-pl011 3f201000.serial: no DMA platform data
[    6.512328] Adding 102396k swap on /var/swap.  Priority:-2 extents:6 across:2617340k SSFS
[    6.905058] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of remote wakeup
[    6.905309] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    7.107575] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   10.527785] Bluetooth: Core ver 2.22
[   10.527869] NET: Registered protocol family 31
[   10.527876] Bluetooth: HCI device and connection manager initialized
[   10.529405] Bluetooth: HCI socket layer initialized
[   10.529436] Bluetooth: L2CAP socket layer initialized
[   10.529514] Bluetooth: SCO socket layer initialized
[   10.548209] Bluetooth: HCI UART driver ver 2.3
[   10.548225] Bluetooth: HCI UART protocol H4 registered
[   10.548231] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   10.893439] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.893447] Bluetooth: BNEP filters: protocol multicast
[   10.893459] Bluetooth: BNEP socket layer initialized
[   36.043072] random: crng init done


Any ideas?
