Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50558 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753985AbdKNPJf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Nov 2017 10:09:35 -0500
Message-ID: <1510672174.4078.2.camel@HansenPartnership.com>
Subject: Re: [paul@keyserver.paulfurley.com: PGP key expires in 3 days:
 0x7179B76704ABA18B (it can be extended)]
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jmorris@namei.org
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Tue, 14 Nov 2017 07:09:34 -0800
In-Reply-To: <20171114062354.j4nrch5xmevllb4l@linux.intel.com>
References: <20171114062354.j4nrch5xmevllb4l@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2017-11-14 at 08:25 +0200, Jarkko Sakkinen wrote:
> James,
> 
> Refreshed my key with expiration +2y in keys.gunpg.net and
> pgp.mit.edu.
> Please update.

The way this works in the main tree is that nothing happens until Linus
sees a tag signed with an expired key (which git refuses to pull).
 Then he swears a bit, does a pgp refresh and pulls again.

James
