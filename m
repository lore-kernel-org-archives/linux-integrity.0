Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:36665 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751916AbeBAMVf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Feb 2018 07:21:35 -0500
Subject: Re: TPM selftest failure in 4.15
To: James Bottomley <James.Bottomley@HansenPartnership.com>
References: <1517487371.3251.9.camel@HansenPartnership.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
Date: Thu, 1 Feb 2018 13:21:32 +0100
MIME-Version: 1.0
In-Reply-To: <1517487371.3251.9.camel@HansenPartnership.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090805030507060205000109"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Dear James,


On 02/01/18 13:16, James Bottomley wrote:
> Embarrassingly enough, I'm just on my way to do a TPM talk at FOSDEM.
>   I installed my shiny new 4.15 kernel on the 'plane and this is what I
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

Please join the thread [1], where I reported the same problem for the 
Dell XPS 13 9360. Unfortunately, no solution was found, especially, as I 
did not use the TPM. Other owners of that system unfortunately didn't 
have time to report back if it work for them, so the "conclusion" kind 
of was, that my TPM was broken, and had to be tested.


Kind regards,

Paul


PS: I'll send you the thread.


[1] https://www.spinics.net/lists/linux-integrity/msg00921.html



    [ Part 2, "S/MIME Cryptographic Signature" ]
    [ Application/PKCS7-SIGNATURE (Name: "smime.p7s") 5.3 KB. ]
    [ Unable to print this part. ]
