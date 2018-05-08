Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45532 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755350AbeEHQeJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 May 2018 12:34:09 -0400
Subject: Re: [PATCH v3 2/2] tpm: reduce polling time to usecs for even finer
 granularity
To: Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
 <20180507160733.8817-3-nayna@linux.vnet.ibm.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <edb61d0d-da8a-5cbd-c21c-80823d587f2a@gmail.com>
Date: Tue, 8 May 2018 09:34:05 -0700
MIME-Version: 1.0
In-Reply-To: <20180507160733.8817-3-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 5/7/18 9:07 AM, Nayna Jain wrote:
> The TPM burstcount and status commands are supposed to return very
> quickly [2][3]. This patch further reduces the TPM poll sleep time to usecs
> in get_burstcount() and wait_for_tpm_stat() by calling usleep_range()
> directly.
>
> After this change, performance on a system[1] with a TPM 1.2 with an 8 byte
> burstcount for 1000 extends improved from ~10.7 sec to ~7 sec.
>
> [1] All tests are performed on an x86 based, locked down, single purpose
> closed system. It has Infineon TPM 1.2 using LPC Bus.
>
> [2] From the TCG Specification "TCG PC Client Specific TPM Interface
> Specification (TIS), Family 1.2":
>
> "NOTE : It takes roughly 330 ns per byte transfer on LPC. 256 bytes would
> take 84 us, which is a long time to stall the CPU. Chipsets may not be
> designed to post this much data to LPC; therefore, the CPU itself is
> stalled for much of this time. Sending 1 kB would take 350 us. Therefore,
> even if the TPM_STS_x.burstCount field is a high value, software SHOULD
> be interruptible during this period."
>
> [3] From the TCG Specification 2.0, "TCG PC Client Platform TPM Profile
> (PTP) Specification":
>
> "It takes roughly 330 ns per byte transfer on LPC. 256 bytes would take
> 84 us. Chipsets may not be designed to post this much data to LPC;
> therefore, the CPU itself is stalled for much of this time. Sending 1 kB
> would take 350 us. Therefore, even if the TPM_STS_x.burstCount field is a
> high value, software should be interruptible during this period. For SPI,
> assuming 20MHz clock and 64-byte transfers, it would take about 120 usec
> to move 256B of data. Sending 1kB would take about 500 usec. If the
> transactions are done using 4 bytes at a time, then it would take about
> 1 msec. to transfer 1kB of data."
>
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---

Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>
