Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36350 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeIPUfB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Sep 2018 16:35:01 -0400
Subject: Re: [PATCH v6 0/2] tpm: add support for nonblocking operation
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Cc: flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153659990230.2284.5511495299744743989.stgit@tstruk-mobl1.jf.intel.com>
 <20180916120349.GB5040@linux.intel.com>
From: Tadeusz Struk <tstruk@gmail.com>
Message-ID: <f86d6fe5-bafa-d392-5ed2-f5390b6b6e7e@gmail.com>
Date: Sun, 16 Sep 2018 08:11:44 -0700
MIME-Version: 1.0
In-Reply-To: <20180916120349.GB5040@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 9/16/18 5:03 AM, Jarkko Sakkinen wrote:
> I tried to test this but I get 404 from https://github.com/tstruk/tpm2-tss/tree/async

This has been already merged to tss upstream https://github.com/tpm2-software/tpm2-tss
To enable it you need to configure tss with --enable-tcti-device-async=yes
Thanks,
Tadeusz
