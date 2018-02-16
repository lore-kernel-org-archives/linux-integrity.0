Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51542 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755410AbeBPSRT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Feb 2018 13:17:19 -0500
Message-ID: <1518805037.4640.27.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org
Date: Fri, 16 Feb 2018 10:17:17 -0800
In-Reply-To: <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-16 at 10:34 +0200, Jarkko Sakkinen wrote:
> Hi
> 
> See the comments below and please include this as a prequel patch for
> the next version:
> 
> https://patchwork.kernel.org/patch/10208965/

Actually, I've got another curious bit of behaviour from my Nuvoton:
 After an experiment with primary EK generation that sent it into
failure mode (connected with something else, nothing to do with this),
it's taken to returning 232 (TPM_RC_COMMAND_CODE) to a partial self
test periodically on boot.  According to the manual this is impossible,
so I think it's something to do with tpm_validate_command.  I think,
perhaps, we shouldn't call the getcaps for the command codes until the
self test is over, but I need to do more debugging to track down what's
going on.

I've also got other reports of TPM_RC_COMMAND_CODE failures during self
test, so this isn't just my screwed up chip.

James
