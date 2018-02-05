Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34816 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752767AbeBEPvD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Feb 2018 10:51:03 -0500
Message-ID: <1517845858.3050.13.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH] ima: force the re-evaluation of files on untrusted
 file systems
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc: Alban Crequy <alban@kinvolk.io>, Dongsu Park <dongsu@kinvolk.io>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date: Mon, 05 Feb 2018 15:50:58 +0000
In-Reply-To: <1517838054.3736.49.camel@linux.vnet.ibm.com>
References: <1517838054.3736.49.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-02-05 at 08:40 -0500, Mimi Zohar wrote:
> On filesystems, such as fuse or remote filesystems, that we can not
> detect or rely on the filesystem to tell us when a file has changed,
> always re-measure, re-appraise, and/or re-audit the file.

Using the presence or absence of d_revalidate isn't definitive for
uncacheable appraisals: all stacked filesystems have to implement
d_revalidate just in case the underlying has it, but it doesn't mean
their appraisals can't be cached if they're fully built on top of
traditional filesystems (like they are in the Docker/OCI use case).  I
think the original flag approach is better.  The only thing stackable
filesystems argues for is that for them it should probably be a
superblock flag so it can be per-mount point (depending on overlay
composition).

d_revalidate() also strikes me as wrong from the semantic point of
view: it's about whether the path name to inode cache needs re-
evaluating not whether the underlying inode could change arbitrarily.
 These are definitely related but not necessarily equivalent concepts.

James
