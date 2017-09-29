Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750857AbdI2BJ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 21:09:58 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8T19LmV058498
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 21:09:58 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d96w9q0gc-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 21:09:58 -0400
Received: from localhost
        by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 29 Sep 2017 11:09:55 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
        by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v8T19sae48890060
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 11:09:54 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
        by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v8T19rRe028463
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 11:09:54 +1000
Subject: Re: Aw: tpm_tis_spi gets initialized long after IMA
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Peter Huewe <PeterHuewe@gmx.de>
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>, pau@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Date: Thu, 28 Sep 2017 21:09:49 -0400
In-Reply-To: <trinity-e306a773-6b97-4508-8894-89da4b67f01f-1506634575541@3c-app-gmx-bs75>
References: <trinity-d76a5983-fa13-4ac4-8e48-d94d22a80e86-1506633490200@3c-app-gmx-bs75>
         <trinity-e306a773-6b97-4508-8894-89da4b67f01f-1506634575541@3c-app-gmx-bs75>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506647389.5691.76.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Peter,

On Thu, 2017-09-28 at 23:36 +0200, Peter Huewe wrote:
> Okay,
> first error - CONFIG_SPI_BCM2835 has to be compiled in.
> That explains the 2.5 sec.

Last December we were able to initialize the TPM before IMA.   It
required commit 29c7854 - "Register the clocks early during the boot
process, so that special/critical clocks can get enabled early
on in the boot process avoiding the risk of disabling a clock,
pll_divider or pll when a claiming driver fails to install
propperly - maybe it needs to defer."

We built a custom kernel with both commit 29c7854 and building in
BCM2835_SPI (thanks Nayna).

Mimi

> However the situation now looks quite similar:
> $ dmesg |grep -i tpm
> [    0.727738] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> [    0.736095] tpm_tis_spi_probe
> [    0.747777] tpm_tis_spi spi0.1: 2.0 TPM (device-id 0x1B, rev-id 16)
> [    0.759162] tpm tpm0: A TPM error (256) occurred continue selftest
> [    0.759342] tpm tpm0: starting up the TPM manually
> 
> The reason is that for some reason the spi clk is not ready at boot
> $ dmesg |grep -i clk
> [    0.274759] spi-bcm2835 3f204000.spi: could not get clk: -517
> [    0.708177] mmc-bcm2835 3f300000.mmc: could not get clk, deferring probe
> [    0.708499] sdhost-bcm2835 3f202000.mmc: could not get clk, deferring probe
> 
> and the probing gets deferred (after the late initcalls?), thus the driver gets probed too late.
> 
> The initcall order looks correct:
>  objdump -x vmlinux | grep initcall| grep ima
> 80b88780 l     O .init.data     00000004 __initcall_init_ima7
> objdump -x vmlinux | grep initcall| grep tpm
> 80b88150 l     O .init.data     00000004 __initcall_tpm_init4
> 80b88460 l     O .init.data     00000004 __initcall_tpm_tis_spi_driver_init6
> 
> objdump -x vmlinux | grep initcall| grep spi
> 80b88460 l     O .init.data     00000004 __initcall_tpm_tis_spi_driver_init6
> 80b88090 l     O .init.data     00000004 __initcall_spi_init2
> 80b88490 l     O .init.data     00000004 __initcall_spidev_init6
> 80b88494 l     O .init.data     00000004 __initcall_bcm2835_spi_driver_init6
> 80b88498 l     O .init.data     00000004 __initcall_bcm2835aux_spi_driver_init6
> 
> 
> Any ideas how to resolve?
> Peter
> 
> 
> 
> new whole dmesg:
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.14.0-rc2-v7+ (peter@lamerx) (gcc version 4.8.3 20140303 (prerelease) (crosstool-NG linaro-1.13.1+bzr2650 - Linaro GCC 2014.03)) #100 SMP Thu Sep 28 23:32:56 CEST 2017
> [    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=10c5383d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt: Machine model: Raspberry Pi 3 Model B Rev 1.2
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] cma: Reserved 8 MiB at 0x3ac00000
> [    0.000000] On node 0 totalpages: 242688
> [    0.000000] free_area_init_node: node 0, pgdat 80c80b00, node_mem_map ba3a1000
> [    0.000000]   Normal zone: 2133 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 242688 pages, LIFO batch:31
> [    0.000000] random: fast init done
> [    0.000000] percpu: Embedded 17 pages/cpu @ba34a000 s38976 r8192 d22464 u69632
> [    0.000000] pcpu-alloc: s38976 r8192 d22464 u69632 alloc=17*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 240555
> [    0.000000] Kernel command line: 8250.nr_uarts=0 bcm2708_fb.fbwidth=1824 bcm2708_fb.fbheight=984 bcm2708_fb.fbswap=1 vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000  dwc_otg.lpm_enable=0 console=ttyS0,115200 console=tty1 root=PARTUUID=674b2fb1-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait quiet splash plymouth.ignore-serial-consoles
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Memory: 940244K/970752K available (7168K kernel code, 557K rwdata, 2136K rodata, 1024K init, 714K bss, 22316K reserved, 8192K cma-reserved)
> [    0.000000] Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>     vmalloc : 0xbb800000 - 0xff800000   (1088 MB)
>     lowmem  : 0x80000000 - 0xbb400000   ( 948 MB)
>     modules : 0x7f000000 - 0x80000000   (  16 MB)
>       .text : 0x80008000 - 0x80800000   (8160 kB)
>       .init : 0x80b00000 - 0x80c00000   (1024 kB)
>       .data : 0x80c00000 - 0x80c8b4bc   ( 558 kB)
>        .bss : 0x80c9306c - 0x80d45c1c   ( 715 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] ftrace: allocating 26446 entries in 78 pages
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] arch_timer: cp15 timer(s) running at 19.20MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
> [    0.000007] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
> [    0.000018] Switching to timer-based delay loop, resolution 52ns
> [    0.000285] Console: colour dummy device 80x30
> [    0.000303] console [tty1] enabled
> [    0.000328] Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=192000)
> [    0.000342] pid_max: default: 32768 minimum: 301
> [    0.000482] Security Framework initialized
> [    0.000490] Yama: becoming mindful.
> [    0.000524] AppArmor: AppArmor disabled by boot time parameter
> [    0.000701] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.000715] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.001564] CPU: Testing write buffer coherency: ok
> [    0.001984] CPU0: update cpu_capacity 1024
> [    0.001992] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.002383] Setting up static identity map for 0x100000 - 0x10003c
> [    0.002503] Hierarchical SRCU implementation.
> [    0.003195] smp: Bringing up secondary CPUs ...
> [    0.003840] CPU1: update cpu_capacity 1024
> [    0.003849] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.004560] CPU2: update cpu_capacity 1024
> [    0.004567] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> [    0.005272] CPU3: update cpu_capacity 1024
> [    0.005280] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> [    0.005368] smp: Brought up 1 node, 4 CPUs
> [    0.005379] SMP: Total of 4 processors activated (153.60 BogoMIPS).
> [    0.005384] CPU: All CPU(s) started in HYP mode.
> [    0.005388] CPU: Virtualization extensions available.
> [    0.006220] devtmpfs: initialized
> [    0.016387] evm: security.SMACK64
> [    0.016393] evm: security.SMACK64EXEC
> [    0.016398] evm: security.SMACK64TRANSMUTE
> [    0.016402] evm: security.SMACK64MMAP
> [    0.016406] evm: security.ima
> [    0.016411] evm: security.capability
> [    0.017127] VFP support v0.3: implementor 41 architecture 3 part 40 variant 3 rev 4
> [    0.017347] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.017364] futex hash table entries: 1024 (order: 4, 65536 bytes)
> [    0.018020] pinctrl core: initialized pinctrl subsystem
> [    0.018779] NET: Registered protocol family 16
> [    0.021525] DMA: preallocated 1024 KiB pool for atomic coherent allocations
> [    0.026463] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
> [    0.026470] hw-breakpoint: maximum watchpoint size is 8 bytes.
> [    0.026665] Serial: AMBA PL011 UART driver
> [    0.028284] bcm2835-mbox 3f00b880.mailbox: mailbox enabled
> [    0.028744] uart-pl011 3f201000.serial: could not find pctldev for node /soc/gpio@7e200000/uart0_pins, deferring probe
> [    0.061172] bcm2835-dma 3f007000.dma: DMA legacy API manager at bb80f000, dmachans=0x1
> [    0.062635] SCSI subsystem initialized
> [    0.062762] usbcore: registered new interface driver usbfs
> [    0.062814] usbcore: registered new interface driver hub
> [    0.062901] usbcore: registered new device driver usb
> [    0.070111] raspberrypi-firmware soc:firmware: Attached to firmware from 2017-09-22 19:50
> [    0.070757] NetLabel: Initializing
> [    0.070764] NetLabel:  domain hash size = 128
> [    0.070768] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.070850] NetLabel:  unlabeled traffic allowed by default
> [    0.071594] clocksource: Switched to clocksource arch_sys_counter
> [    0.142960] VFS: Disk quotas dquot_6.6.0
> [    0.143045] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> [    0.143227] FS-Cache: Loaded
> [    0.143432] CacheFiles: Loaded
> [    0.152482] NET: Registered protocol family 2
> [    0.153219] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.153329] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.153513] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.153645] UDP hash table entries: 512 (order: 2, 16384 bytes)
> [    0.153690] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> [    0.153920] NET: Registered protocol family 1
> [    0.154371] RPC: Registered named UNIX socket transport module.
> [    0.154376] RPC: Registered udp transport module.
> [    0.154381] RPC: Registered tcp transport module.
> [    0.154386] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.156018] hw perfevents: enabled with armv7_cortex_a7 PMU driver, 7 counters available
> [    0.158064] audit: initializing netlink subsys (disabled)
> [    0.158238] audit: type=2000 audit(0.149:1): state=initialized audit_enabled=0 res=1
> [    0.158816] Initialise system trusted keyrings
> [    0.158863] Key type blacklist registered
> [    0.158984] workingset: timestamp_bits=14 max_order=18 bucket_order=4
> [    0.167180] FS-Cache: Netfs 'nfs' registered for caching
> [    0.167778] NFS: Registering the id_resolver key type
> [    0.167806] Key type id_resolver registered
> [    0.167812] Key type id_legacy registered
> [    0.169973] Key type asymmetric registered
> [    0.169980] Asymmetric key parser 'x509' registered
> [    0.170037] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
> [    0.170160] io scheduler noop registered
> [    0.170167] io scheduler deadline registered (default)
> [    0.170442] io scheduler cfq registered
> [    0.170448] io scheduler mq-deadline registered
> [    0.170454] io scheduler kyber registered
> [    0.172017] gpio gpiochip1: GPIO chip parent is NULL
> [    0.172776] gpio gpiochip2: GPIO chip parent is NULL
> [    0.173297] BCM2708FB: allocated DMA memory fad10000
> [    0.173323] BCM2708FB: allocated DMA channel 0 @ bb80f000
> [    0.223756] Console: switching to colour frame buffer device 228x61
> [    0.254183] bcm2835-rng 3f104000.rng: hwrng registered
> [    0.254350] vc-mem: phys_addr:0x00000000 mem_base=0x3ec00000 mem_size:0x40000000(1024 MiB)
> [    0.254850] vc-sm: Videocore shared memory driver
> [    0.255129] gpiomem-bcm2835 3f200000.gpiomem: Initialised: Registers at 0x3f200000
> [    0.265101] brd: module loaded
> [    0.273952] loop: module loaded
> [    0.273967] Loading iSCSI transport class v2.0-870.
> [    0.274759] spi-bcm2835 3f204000.spi: could not get clk: -517
> [    0.275296] usbcore: registered new interface driver smsc95xx
> [    0.275312] dwc_otg: version 3.00a 10-AUG-2012 (platform bus)
> [    0.503366] Core Release: 2.80a
> [    0.503375] Setting default values for core params
> [    0.503413] Finished setting default values for core params
> [    0.703666] Using Buffer DMA mode
> [    0.703672] Periodic Transfer Interrupt Enhancement - disabled
> [    0.703677] Multiprocessor Interrupt Enhancement - disabled
> [    0.703684] OTG VER PARAM: 0, OTG VER FLAG: 0
> [    0.703697] Dedicated Tx FIFOs mode
> [    0.704114] WARN::dwc_otg_hcd_init:1032: FIQ DMA bounce buffers: virt = 0xbad04000 dma = 0xfad04000 len=9024
> [    0.704142] FIQ FSM acceleration enabled for :
> Non-periodic Split Transactions
> Periodic Split Transactions
> High-Speed Isochronous Endpoints
> Interrupt/Control Split Transaction hack enabled
> [    0.704150] dwc_otg: Microframe scheduler enabled
> [    0.704207] WARN::hcd_init_fiq:459: FIQ on core 1 at 0x8061562c
> [    0.704219] WARN::hcd_init_fiq:460: FIQ ASM at 0x80615980 length 36
> [    0.704234] WARN::hcd_init_fiq:486: MPHI regs_base at 0xbb87c000
> [    0.704299] dwc_otg 3f980000.usb: DWC OTG Controller
> [    0.704331] dwc_otg 3f980000.usb: new USB bus registered, assigned bus number 1
> [    0.704364] dwc_otg 3f980000.usb: irq 62, io mem 0x00000000
> [    0.704414] Init: Port Power? op_state=1
> [    0.704419] Init: Power Port (0)
> [    0.704639] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    0.704649] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.704658] usb usb1: Product: DWC OTG Controller
> [    0.704666] usb usb1: Manufacturer: Linux 4.14.0-rc2-v7+ dwc_otg_hcd
> [    0.704674] usb usb1: SerialNumber: 3f980000.usb
> [    0.705309] hub 1-0:1.0: USB hub found
> [    0.705351] hub 1-0:1.0: 1 port detected
> [    0.705894] dwc_otg: FIQ enabled
> [    0.705901] dwc_otg: NAK holdoff enabled
> [    0.705906] dwc_otg: FIQ split-transaction FSM enabled
> [    0.705918] Module dwc_common_port init
> [    0.706187] usbcore: registered new interface driver usb-storage
> [    0.706365] mousedev: PS/2 mouse device common for all mice
> [    0.706452] IR NEC protocol handler initialized
> [    0.706457] IR RC5(x/sz) protocol handler initialized
> [    0.706464] IR RC6 protocol handler initialized
> [    0.706469] IR JVC protocol handler initialized
> [    0.706474] IR Sony protocol handler initialized
> [    0.706479] IR SANYO protocol handler initialized
> [    0.706484] IR Sharp protocol handler initialized
> [    0.706489] IR MCE Keyboard/mouse protocol handler initialized
> [    0.706494] IR XMP protocol handler initialized
> [    0.707199] bcm2835-wdt 3f100000.watchdog: Broadcom BCM2835 watchdog timer
> [    0.707466] bcm2835-cpufreq: min=600000 max=1200000
> [    0.707827] sdhci: Secure Digital Host Controller Interface driver
> [    0.707832] sdhci: Copyright(c) Pierre Ossman
> [    0.708177] mmc-bcm2835 3f300000.mmc: could not get clk, deferring probe
> [    0.708499] sdhost-bcm2835 3f202000.mmc: could not get clk, deferring probe
> [    0.708595] sdhci-pltfm: SDHCI platform and OF driver helper
> [    0.711197] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.711378] hidraw: raw HID events driver (C) Jiri Kosina
> [    0.711505] usbcore: registered new interface driver usbhid
> [    0.711510] usbhid: USB HID core driver
> [    0.712334] vchiq: vchiq_init_state: slot_zero = bad80000, is_master = 0
> [    0.714132] [vc_sm_connected_init]: start
> [    0.724611] [vc_sm_connected_init]: end - returning 0
> [    0.725275] Initializing XFRM netlink socket
> [    0.725300] NET: Registered protocol family 17
> [    0.725401] Key type dns_resolver registered
> [    0.725933] Registering SWP/SWPB emulation handler
> [    0.726510] registered taskstats version 1
> [    0.726526] Loading compiled-in X.509 certificates
> [    0.727230] Key type trusted registered
> [    0.727723] Key type encrypted registered
> [    0.727738] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> [    0.727843] evm: HMAC attrs: 0x1
> [    0.734019] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 87, base_baud = 0) is a PL011 rev2
> [    0.736095] tpm_tis_spi_probe
> [    0.747777] tpm_tis_spi spi0.1: 2.0 TPM (device-id 0x1B, rev-id 16)
> [    0.759162] tpm tpm0: A TPM error (256) occurred continue selftest
> [    0.759342] tpm tpm0: starting up the TPM manually
> [    0.921688] Indeed it is in host mode hprt0 = 00021501
> [    1.046252] mmc-bcm2835 3f300000.mmc: mmc_debug:0 mmc_debug2:0
> [    1.046261] mmc-bcm2835 3f300000.mmc: DMA channel allocated
> [    1.102099] sdhost: log_buf @ bad07000 (fad07000)
> [    1.131633] usb 1-1: new high-speed USB device number 2 using dwc_otg
> [    1.131748] Indeed it is in host mode hprt0 = 00001101
> [    1.199303] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
> [    1.200876] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
> [    1.202471] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
> [    1.205295] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
> [    1.221618] mmc0: sdhost-bcm2835 loaded - DMA enabled (>1)
> [    1.242665] of_cfs_init
> [    1.242756] of_cfs_init: OK
> [    1.243261] Waiting for root device PARTUUID=674b2fb1-02...
> [    1.321370] mmc1: new high speed SDIO card at address 0001
> [    1.362656] mmc0: host does not support reading read-only switch, assuming write-enable
> [    1.365432] mmc0: new high speed SDHC card at address aaaa
> [    1.365936] mmcblk0: mmc0:aaaa SL16G 14.8 GiB
> [    1.368526]  mmcblk0: p1 p2
> [    1.371914] usb 1-1: New USB device found, idVendor=0424, idProduct=9514
> [    1.371925] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    1.372486] hub 1-1:1.0: USB hub found
> [    1.372582] hub 1-1:1.0: 5 ports detected
> [    1.408072] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
> [    1.408130] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
> [    1.408890] devtmpfs: mounted
> [    1.412249] Freeing unused kernel memory: 1024K
> [    1.675937] systemd[1]: systemd 215 running in system mode. (+PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
> [    1.676300] systemd[1]: Detected architecture 'arm'.
> [    1.701680] usb 1-1.1: new high-speed USB device number 3 using dwc_otg
> [    1.783873] NET: Registered protocol family 10
> [    1.785149] Segment Routing with IPv6
> [    1.785333] systemd[1]: Inserted module 'ipv6'
> [    1.789893] systemd[1]: Set hostname to <datalogger>.
> [    1.790123] systemd[1]: Initializing machine ID from random generator.
> [    1.790365] systemd[1]: Installed transient /etc/machine-id file.
> [    1.832162] usb 1-1.1: New USB device found, idVendor=0424, idProduct=ec00
> [    1.832181] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    1.835227] smsc95xx v1.0.6
> [    1.925180] smsc95xx 1-1.1:1.0 eth0: register 'smsc95xx' at usb-3f980000.usb-1.1, smsc95xx USB 2.0 Ethernet, b8:27:eb:b5:76:21
> [    2.021653] usb 1-1.4: new low-speed USB device number 4 using dwc_otg
> [    2.154414] systemd[1]: Cannot add dependency job for unit regenerate_ssh_host_keys.service, ignoring: Unit regenerate_ssh_host_keys.service failed to load: No such file or directory.
> [    2.158162] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
> [    2.158597] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [    2.158678] systemd[1]: Starting Remote File Systems (Pre).
> [    2.178127] usb 1-1.4: New USB device found, idVendor=046d, idProduct=c312
> [    2.178159] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    2.178175] usb 1-1.4: Product: USB Multimedia Keyboard
> [    2.178184] usb 1-1.4: Manufacturer: LITEON Technology
> [    2.188214] input: LITEON Technology USB Multimedia Keyboard as /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.4/1-1.4:1.0/0003:046D:C312.0001/input/input0
> [    2.252422] hid-generic 0003:046D:C312.0001: input,hidraw0: USB HID v1.10 Keyboard [LITEON Technology USB Multimedia Keyboard] on usb-3f980000.usb-1.4/input0
> [    2.317111] fuse init (API version 7.26)
> [    2.347281] i2c /dev entries driver
> [    2.621292] systemd-udevd[132]: starting version 215
> [    3.210828] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
> [    3.314163] snd_bcm2835: module is from the staging directory, the quality is unknown, you have been warned.
> [    3.327309] bcm2835_alsa bcm2835_alsa: card created with 8 channels
> [    3.496275] brcmfmac: brcmf_fw_map_chip_to_name: using brcm/brcmfmac43430-sdio.bin for chip 0x00a9a6(43430) rev 0x000001
> [    3.496607] usbcore: registered new interface driver brcmfmac
> [    3.619774] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Aug  7 2017 00:46:29 version 7.45.41.46 (r666254 CY) FWID 01-f8a78378
> [    4.058489] systemd-journald[125]: Received request to flush runtime journal from PID 1
> [    5.915121] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> [    5.915154] brcmfmac: power management disabled
> [    6.088034] uart-pl011 3f201000.serial: no DMA platform data
> [    6.513486] Adding 102396k swap on /var/swap.  Priority:-2 extents:6 across:2617340k SSFS
> [    6.962898] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of remote wakeup
> [    6.963126] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [    7.208732] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [   10.536201] Bluetooth: Core ver 2.22
> [   10.536261] NET: Registered protocol family 31
> [   10.536264] Bluetooth: HCI device and connection manager initialized
> [   10.536287] Bluetooth: HCI socket layer initialized
> [   10.536296] Bluetooth: L2CAP socket layer initialized
> [   10.536321] Bluetooth: SCO socket layer initialized
> [   10.545194] Bluetooth: HCI UART driver ver 2.3
> [   10.545206] Bluetooth: HCI UART protocol H4 registered
> [   10.545209] Bluetooth: HCI UART protocol Three-wire (H5) registered
> [   10.842492] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   10.842499] Bluetooth: BNEP filters: protocol multicast
> [   10.842510] Bluetooth: BNEP socket layer initialized
> [   47.932131] random: crng init done
> 
