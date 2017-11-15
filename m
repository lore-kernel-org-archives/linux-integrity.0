Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36174 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758707AbdKOR0r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 12:26:47 -0500
Received: by mail-wm0-f54.google.com with SMTP id r68so4525156wmr.1
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2017 09:26:46 -0800 (PST)
Message-ID: <1510766803.5979.17.camel@intel.com>
Subject: IMA appraisal master plan? (was: Re: [PATCH V6] EVM: Add support
 for portable signature format)
From: Patrick Ohly <patrick.ohly@intel.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Wed, 15 Nov 2017 18:26:43 +0100
In-Reply-To: <20171107151742.25122-1-mjg59@google.com>
References: <20171107151742.25122-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2017-11-07 at 07:17 -0800, Matthew Garrett wrote:
> The EVM signature includes the inode number and (optionally) the
> filesystem UUID, making it impractical to ship EVM signatures in
> packages. This patch adds a new portable format intended to allow
> distributions to include EVM signatures. It is identical to the
> existing format but hardcodes the inode and generation numbers to 0
> and does not include the filesystem UUID even if the kernel is
> configured to do so.
> 
> Removing the inode means that the metadata and signature from one
> file could be copied to another file without invalidating it. This is
> avoided by ensuring that an IMA xattr is present during EVM
> validation.
> 
> Portable signatures are intended to be immutable - ie, they will
> never be transformed into HMACs.

I've been following this patch series and related discussions with
interest. It aims at making appraisal more secure. As discussed on the
old list earlier this year, I tried to use IMA for that and just
(re)discovered that appraisal had too many known loopholes to be
useful, at least as it existed at the time. The main gap was that
directory integrity wasn't protected and that there was no way to
specify a policy that ensured that all files used by sensitive
processes were appraised.

What hasn't become obvious to me yet is how portable signatures help
fit into the overall system. What kind of IMA policy is it meant to
use? Is the entire partition considered read-only except when
installing system software or does it also contain data files from
untrusted apps? Which MAC, if any, and does that matter? Are there
known holes that need to be plugged before this system is considered
secure, and is there a "master plan" for getting there?

To repeat one of the offline attacks that I outlined in the past:
suppose systemd is the init system. How is going to be ensured that an
attacker cannot install a service unit file for his Python script which
then causes systemd to start that service with arbitrary privileges?

Roberto's "ima: preserve integrity of dynamic data" seems to address
that, but according to Mimi, isn't using the right approach for solving
the issue.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
