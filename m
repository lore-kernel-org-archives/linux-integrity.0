Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ed1-f52.google.com ([209.85.208.52]:40411 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeHOUzu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Aug 2018 16:55:50 -0400
Received: by mail-ed1-f52.google.com with SMTP id e19-v6so1256852edq.7
        for <linux-integrity@vger.kernel.org>; Wed, 15 Aug 2018 11:02:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAO-sURRBXW77tk-Vq4vZr5q3GJt643o80jC35PpjUx649L=+cg@mail.gmail.com>
References: <CAO-sURTngN_mnpJp9rvutpDfz80Nq4K8JOH4fnZG2NaTafkx+g@mail.gmail.com>
 <CAO-sURTs1dc_5iY+b34Jqj4hxZFdUj9LZxTWhDdvqM8AbEqMAw@mail.gmail.com>
 <20180810165735.GT4692@linux.intel.com> <20180810214433.GA15044@linux.intel.com>
 <CA+i0qc5Z95QD4Pb8XYGnj+=gVfGJWARqrRN8zej0zDUrcDYW5w@mail.gmail.com> <CAO-sURRBXW77tk-Vq4vZr5q3GJt643o80jC35PpjUx649L=+cg@mail.gmail.com>
From: Harlan Lieberman-Berg <harlan@dds.mil>
Date: Wed, 15 Aug 2018 14:02:08 -0400
Message-ID: <CAO-sURTJVjscq2uvM0AYxbNuj2LyTypHYK+yAOCB_x-1y-YzMw@mail.gmail.com>
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

Hello all,

Just wanted to give you a quick update now that I got my hands on an
OEM Windows version of the same machine.  I can confirm that Windows
is able to use the TPM to some extent; confirmation and some of the
output of some of the TPM Powershell cmdlets is at
https://gist.github.com/hlieberman-gov/915fda005e3297570e9e6e68e1708bc6

Sincerely,

-- 
Harlan Lieberman-Berg
Defense Digital Service
