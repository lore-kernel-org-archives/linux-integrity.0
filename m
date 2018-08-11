Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40253 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeHKWyX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Aug 2018 18:54:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so6383585edq.7
        for <linux-integrity@vger.kernel.org>; Sat, 11 Aug 2018 13:19:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+i0qc5Z95QD4Pb8XYGnj+=gVfGJWARqrRN8zej0zDUrcDYW5w@mail.gmail.com>
References: <CAO-sURTngN_mnpJp9rvutpDfz80Nq4K8JOH4fnZG2NaTafkx+g@mail.gmail.com>
 <CAO-sURTs1dc_5iY+b34Jqj4hxZFdUj9LZxTWhDdvqM8AbEqMAw@mail.gmail.com>
 <20180810165735.GT4692@linux.intel.com> <20180810214433.GA15044@linux.intel.com>
 <CA+i0qc5Z95QD4Pb8XYGnj+=gVfGJWARqrRN8zej0zDUrcDYW5w@mail.gmail.com>
From: Harlan Lieberman-Berg <harlan@dds.mil>
Date: Sat, 11 Aug 2018 14:29:41 -0400
Message-ID: <CAO-sURRBXW77tk-Vq4vZr5q3GJt643o80jC35PpjUx649L=+cg@mail.gmail.com>
Subject: Re: Fwd: PROBLEM: tpm_cpg can't request region with AMD/Dell fTPM
To: Tomas Winkler <tomasw@gmail.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Aug 11, 2018 at 5:42 AM, Tomas Winkler <tomasw@gmail.com> wrote:
> What platform is this? This is not regular 0xfed40000 address space. I
> guess this is BYT or CHT.  It's better to get dmideoce dump as well.

Hello Tomas, Jarkko, all,

I'm not sure what's up with that.  I've updated the firmware to the
latest version (with no fix, sadly), and re-dumped the ACPI tables.
They now process correctly through isl v20180629.  I've also saved the
output of dmidecode for you.

https://gist.github.com/hlieberman-gov/83fa708d41051bafccc553cf0147db4f

Sincerely,
-- 
Harlan Lieberman-Berg
Defense Digital Service
