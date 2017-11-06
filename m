Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:14218 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753534AbdKFUU6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2017 15:20:58 -0500
From: "Magalhaes, Guilherme (Brazil R&D-CL)" <guilherme.magalhaes@hpe.com>
To: Mikhail Kurinnoi <viewizard@viewizard.com>
CC: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: IMA skips some file measurements
Date: Mon, 6 Nov 2017 20:20:54 +0000
Message-ID: <TU4PR84MB03023D502D6D51274582EAFBFF500@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR84MB03023D92432F2AA6E9348873FF500@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
 <20171106230435.34401b54@totoro>
In-Reply-To: <20171106230435.34401b54@totoro>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> -----Original Message-----
> From: Mikhail Kurinnoi [mailto:viewizard@gmail.com] On Behalf Of Mikhail
> Kurinnoi
> Sent: segunda-feira, 6 de novembro de 2017 18:05
> To: Magalhaes, Guilherme (Brazil R&D-CL) <guilherme.magalhaes@hpe.com>
> Cc: linux-integrity@vger.kernel.org
> Subject: Re: IMA skips some file measurements
> 
> ? Mon, 6 Nov 2017 19:22:55 +0000
> "Magalhaes, Guilherme (Brazil R&D-CL)" <guilherme.magalhaes@hpe.com>
> ?????:
> 
> > We are trying to understand why some file measurements are skipped
> > by IMA. In some circumstances, it seems that this could lead to an
> > incorrect assessment of the integrity of the host. Consider the
> > following, example in which we begin with a vulnerable bash binary
> > (e.g. Shellshock) and patch it.
> >
> > 1. Load vulnerable bash (measured by IMA)
> > 2. Patch the bash file
> > 3. Load good bash (measured by IMA)
> > 4. Change back to vulnerable bash
> > 5. Load vulnerable bash (not measured by IMA)
> >
> > After step 5, the IMA logs appear to tell you that the system is
> > using a good binary, but a vulnerable binary is installed and being
> > used.
> >
> > We identified that 'ima_htable.queue' prevented the measurement at
> > step 5 since the same vulnerable bash was loaded on step 1 and 5 and
> > then its respective hash was already present in 'ima_htable.queue'.
> >
> > So in this scenario the last/current file state is not identified
> > using the IMA log. Is it not important to identify through the IMA
> > log whether or not the last known file state is good?
> >
> > Does anybody know why 'ima_htable.queue' is preventing already
> > logged file hashes from being re-measured?
> >
> > --
> > Guilherme
> >
> 
> As I understood, you have FS mounted with i_version option, after step 2
> IMA hash was updated in file IMA xattr (plus, in ima_check_last_writer()
> iint->measured_pcrs was set to 0 in order to measure changed file next
> time again), but in step 5 file not measured by IMA? Right?
That's correct. Check the use of ima_htable.queue in ima_lookup_digest_entry().
It prevents ima_add_template_entry() from actually measuring the changed file 
if the 'new' hash is already present in that hash table.

--
Guilherme

> 
> 
> 
> --
> Best regards,
> Mikhail Kurinnoi
