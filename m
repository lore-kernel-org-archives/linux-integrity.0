Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:53836 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdKFUEi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2017 15:04:38 -0500
Received: by mail-lf0-f51.google.com with SMTP id l23so11869159lfk.10
        for <linux-integrity@vger.kernel.org>; Mon, 06 Nov 2017 12:04:38 -0800 (PST)
Date: Mon, 6 Nov 2017 23:04:35 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: "Magalhaes, Guilherme (Brazil R&D-CL)" <guilherme.magalhaes@hpe.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: IMA skips some file measurements
Message-ID: <20171106230435.34401b54@totoro>
In-Reply-To: <TU4PR84MB03023D92432F2AA6E9348873FF500@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR84MB03023D92432F2AA6E9348873FF500@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

? Mon, 6 Nov 2017 19:22:55 +0000
"Magalhaes, Guilherme (Brazil R&D-CL)" <guilherme.magalhaes@hpe.com>
?????:

> We are trying to understand why some file measurements are skipped
> by IMA. In some circumstances, it seems that this could lead to an
> incorrect assessment of the integrity of the host. Consider the
> following, example in which we begin with a vulnerable bash binary
> (e.g. Shellshock) and patch it.
> 
> 1. Load vulnerable bash (measured by IMA)
> 2. Patch the bash file
> 3. Load good bash (measured by IMA)
> 4. Change back to vulnerable bash
> 5. Load vulnerable bash (not measured by IMA)
> 
> After step 5, the IMA logs appear to tell you that the system is
> using a good binary, but a vulnerable binary is installed and being
> used.
> 
> We identified that 'ima_htable.queue' prevented the measurement at
> step 5 since the same vulnerable bash was loaded on step 1 and 5 and
> then its respective hash was already present in 'ima_htable.queue'.
> 
> So in this scenario the last/current file state is not identified
> using the IMA log. Is it not important to identify through the IMA
> log whether or not the last known file state is good?
> 
> Does anybody know why 'ima_htable.queue' is preventing already 
> logged file hashes from being re-measured?
> 
> --
> Guilherme
> 

As I understood, you have FS mounted with i_version option, after step 2
IMA hash was updated in file IMA xattr (plus, in ima_check_last_writer()
iint->measured_pcrs was set to 0 in order to measure changed file next
time again), but in step 5 file not measured by IMA? Right?



-- 
Best regards,
Mikhail Kurinnoi
