Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40210 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752410AbeBAMQP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Feb 2018 07:16:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ED8578EE16F
        for <linux-integrity@vger.kernel.org>; Thu,  1 Feb 2018 04:16:14 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S5rc2htqH-e2 for <linux-integrity@vger.kernel.org>;
        Thu,  1 Feb 2018 04:16:14 -0800 (PST)
Received: from [10.9.39.218] (host-80-195-152-82.static.cable.virginmedia.com [80.195.152.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1116A8EE0C7
        for <linux-integrity@vger.kernel.org>; Thu,  1 Feb 2018 04:16:13 -0800 (PST)
Message-ID: <1517487371.3251.9.camel@HansenPartnership.com>
Subject: TPM selftest failure in 4.15
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 01 Feb 2018 12:16:11 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Embarrassingly enough, I'm just on my way to do a TPM talk at FOSDEM.
 I installed my shiny new 4.15 kernel on the 'plane and this is what I
got after I arrived this morning:

jejb@jarvis:~> dmesg | grep -i tpm
[    0.000000] ACPI: TPM2 0x0000000079446CC0 000034
(v03        Tpm2Tabl 00000001 AMI  00000000)
[    1.598059] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
[    1.608863] tpm tpm0: A TPM error (2314) occurred continue selftest
[    1.640052] tpm tpm0: A TPM error (2314) occurred continue selftest
[    1.691215] tpm tpm0: A TPM error (2314) occurred continue selftest
[    1.782377] tpm tpm0: A TPM error (2314) occurred continue selftest
[    1.953539] tpm tpm0: A TPM error (2314) occurred continue selftest
[    2.284701] tpm tpm0: A TPM error (2314) occurred continue selftest
[    2.935743] tpm tpm0: A TPM error (2314) occurred continue selftest
[    4.216236] tpm tpm0: TPM self test failed
[    4.236829] ima: No TPM chip found, activating TPM-bypass! (rc=-19)

The error is TPM_RC_TESTING, which means it looks like we don't wait
long enough for the selftests to complete.  I get this all the time
booting with 4.15.  Fortunately I have a 4.13 backup kernel which is
fine (otherwise I'd be a bit hosed since all my keys now require a
TPM).

I'll debug on the train; my current suspicion is that the TPM_LONG
duration might be a bit short for this chip (A nuvoton 6xx in a dell
XPS-13).

James
