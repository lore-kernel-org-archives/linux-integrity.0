Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34960 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388767AbeHGU7W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Aug 2018 16:59:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id m11-v6so30311216oic.2
        for <linux-integrity@vger.kernel.org>; Tue, 07 Aug 2018 11:43:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAO-sURTngN_mnpJp9rvutpDfz80Nq4K8JOH4fnZG2NaTafkx+g@mail.gmail.com>
References: <CAO-sURTngN_mnpJp9rvutpDfz80Nq4K8JOH4fnZG2NaTafkx+g@mail.gmail.com>
From: Harlan Lieberman-Berg <harlan@dds.mil>
Date: Tue, 7 Aug 2018 14:43:10 -0400
Message-ID: <CAO-sURTs1dc_5iY+b34Jqj4hxZFdUj9LZxTWhDdvqM8AbEqMAw@mail.gmail.com>
Subject: Fwd: PROBLEM: tpm_cpg can't request region with AMD/Dell fTPM
To: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

(Resending as it seems to have been spamfiltered out from the ml;
sorry Peter, Jarkko for the duplicate)

Hello maintainers,

When attempting to setup the TPM 2.0 firmware TPM built into the Dell
Inspiron 11 3180, it does not show up in /dev nor does it show up in
/sys/class/tpm.  An inspection of dmesg shows the following error:

[    6.359382] tpm_crb MSFT0101:00: can't request region for resource
[mem 0xe7bba000-0xe7bbdfff]
[    6.359430] tpm_crb: probe of MSFT0101:00 failed with error -16

I have tested both on kernel version 4.17.0-1 and 4.18.0-rc4, both
x86_64, and they have shown the same error.  Similarly, I have tested
with both the 1.1.0 and 1.3.0 versions of the underlying firmware.

The Dell Inspiron 11 3180 has the following cpuinfo (trimmed for brevity):

processor    : 1
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 112
model name    : AMD A6-9220e RADEON R4, 5 COMPUTE CORES 2C+3G
stepping    : 0
microcode    : 0x6006704
cpu MHz        : 1367.077
cache size    : 1024 KB
physical id    : 0
siblings    : 2
core id        : 1
cpu cores    : 2
apicid        : 17
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl
nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3
fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm perfctr_core
perfctr_nb bpext ptsc mwaitx cpb hw_pstate ssbd vmmcall fsgsbase bmi1
avx2 smep bmi2 xsaveopt arat npt lbrv svm_lock nrip_save tsc_scale
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic
v_vmsave_vmload vgif overflow_recov
bugs        : fxsave_leak sysret_ss_attrs null_seg spectre_v1
spectre_v2 spec_store_bypass
bogomips    : 3193.84
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro acc_power [13]

The ver_linux output:

Linux brick 4.18.0-rc4-amd64 #1 SMP Debian 4.18~rc4-1~exp1
(2018-07-12) x86_64 GNU/Linux

GNU Make                4.2.1
Binutils                2.31.1
Util-linux              2.32
Mount                   2.32
Linux C Library         2.27
Dynamic linker (ldd)    2.27
Procps                  3.3.15
Kbd                     2.0.4
Console-tools           2.0.4
Sh-utils                8.28
Udev                    239
Modules Loaded          ac acpi_cpufreq aesni_intel aes_x86_64 af_alg
ahci algif_skcipher amdgpu amdkfd ansi_cprng arc4 ath ath3k ath9k
ath9k_common ath9k_hw autofs4 battery bluetooth bnep btbcm btintel
btrtl btusb button ccp cfg80211 chash crc16 crc32c_generic
crc32c_intel crc32_pclmul crct10dif_pclmul cryptd crypto_simd dcdbas
dell_laptop dell_rbtn dell_smbios dell_smm_hwmon dell_wmi
dell_wmi_descriptor dm_crypt dm_mod drbg drm drm_kms_helper ecb
ecdh_generic edac_mce_amd efi_pstore efivarfs efivars ehci_hcd
ehci_pci evdev ext4 fam15h_power fat fscrypto fuse ghash_clmulni_intel
glue_helper gpu_sched hid i2c_algo_bit i2c_hid i2c_piix4 ip_tables
irqbypass jbd2 jitterentropy_rng joydev k10temp kvm kvm_amd libahci
libata lp mac80211 mbcache media memstick mmc_core nls_ascii nls_cp437
parport parport_pc pcbc pcspkr ppdev psmouse rfkill rng_core rtsx_usb
rtsx_usb_ms rtsx_usb_sdmmc scsi_mod sd_mod serio_raw sg snd
snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_core snd_hda_intel snd_hwdep snd_pcm
snd_timer soundcore sp5100_tco sparse_keymap thermal tpm tpm_crb
tpm_tis tpm_tis_core ttm usb_common usbcore uvcvideo vfat video
videobuf2_common videobuf2_memops videobuf2_v4l2 videobuf2_vmalloc
videodev wmi wmi_bmof xhci_hcd xhci_pci x_tables

The ioports, iomem, lspci, and acpidump are located at
https://gist.github.com/hlieberman-gov/a718cf4aff8aa701e10eb37162bb943f.
I am happy to help debug this however is needed.

Sincerely,
--
Harlan Lieberman-Berg
Defense Digital Service
