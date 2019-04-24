Return-Path: <SRS0=CieS=S2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981DEC10F11
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Apr 2019 18:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C6C21773
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Apr 2019 18:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbfDXSaI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:30:08 -0400
Received: from [13.77.154.182] ([13.77.154.182]:58528 "EHLO
        linux.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbfDXSaI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Apr 2019 14:30:08 -0400
Received: from [10.91.6.157] (unknown [131.107.159.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6A0763052D04;
        Wed, 24 Apr 2019 11:30:07 -0700 (PDT)
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     jarkko.sakkinen@linux.intel.com, mjg59@google.com
From:   Jordan <jorhand@linux.microsoft.com>
Subject: linux-tpmdd self signed kernel failing to boot with secreboot on
Message-ID: <f9ad2e46-e458-6c78-76da-b85db4601ee3@linux.microsoft.com>
Date:   Wed, 24 Apr 2019 11:30:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I am attempting to boot the linux-tpmdd kernel and look at the TCG 2 
binary_bios_measurements.

Under the following circumstances my kernel will not boot:
* Secure boot enabled
* Booting with shim and grub2 from the Ubuntu 18 repos
* Kernel config is just taken from my ubuntu 18.04.2 install, and filled 
in with `yes '' | make oldconfig`
* Kernel signed with my own generated key. Signed using sbsign, key is 
enrolled in MOK.
* It seems to be going through the kernel's EFI stub (I see efi_printk 
message "EFI: UEFI Secure Boot is enabled")

I have tried these same steps with the same configuration with the 
mainline kernel and it boots fine.

I have traced kernel boot to the call to efi_exit_boot_services in 
arch/x86/boot/compressed/eboot at which point execution terminates. I 
see Matthew has made a couple changes in efi_main which calls exit_boot 
(and in turn calls efi_exit_boot_services).

I am wondering if anyone else has seen this issue or might understand 
better than me what is going on.

I would be happy to try to repro this issue with a more minimal config 
if someone could point me to what steps to follow. I've tried it out on 
a couple different machines with the same results.

Thanks,
Jordan

