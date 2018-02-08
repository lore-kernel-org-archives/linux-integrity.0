Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:56234 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHMto (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 07:49:44 -0500
Date: Thu, 8 Feb 2018 14:49:41 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: TPM selftest failure in 4.15
Message-ID: <20180208124941.7k6zelnsorrsbgpi@linux.intel.com>
References: <1517487371.3251.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1517487371.3251.9.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Feb 01, 2018 at 12:16:11PM +0000, James Bottomley wrote:
> Embarrassingly enough, I'm just on my way to do a TPM talk at FOSDEM.
>  I installed my shiny new 4.15 kernel on the 'plane and this is what I
> got after I arrived this morning:
> 
> jejb@jarvis:~> dmesg | grep -i tpm
> [    0.000000] ACPI: TPM2 0x0000000079446CC0 000034
> (v03        Tpm2Tabl 00000001 AMI  00000000)
> [    1.598059] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> [    1.608863] tpm tpm0: A TPM error (2314) occurred continue selftest
> [    1.640052] tpm tpm0: A TPM error (2314) occurred continue selftest
> [    1.691215] tpm tpm0: A TPM error (2314) occurred continue selftest
> [    1.782377] tpm tpm0: A TPM error (2314) occurred continue selftest
> [    1.953539] tpm tpm0: A TPM error (2314) occurred continue selftest
> [    2.284701] tpm tpm0: A TPM error (2314) occurred continue selftest
> [    2.935743] tpm tpm0: A TPM error (2314) occurred continue selftest
> [    4.216236] tpm tpm0: TPM self test failed
> [    4.236829] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> 
> The error is TPM_RC_TESTING, which means it looks like we don't wait
> long enough for the selftests to complete.  I get this all the time
> booting with 4.15.  Fortunately I have a 4.13 backup kernel which is
> fine (otherwise I'd be a bit hosed since all my keys now require a
> TPM).
> 
> I'll debug on the train; my current suspicion is that the TPM_LONG
> duration might be a bit short for this chip (A nuvoton 6xx in a dell
> XPS-13).
> 
> James

I also have XPS 13. I'll check if I can reproduce this. Sorry for the
latency. At busy times I have some latency for messages that do not
include me in to/cc fields but I eventually catch these. If you want
a quicker response, do that in the future.

/Jarkko
