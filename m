Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752394AbeAZSNs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jan 2018 13:13:48 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0QI6ngd064142
        for <linux-integrity@vger.kernel.org>; Fri, 26 Jan 2018 13:13:48 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fr5u816xs-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 26 Jan 2018 13:13:47 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 26 Jan 2018 18:13:45 -0000
Subject: Re: [LSF/MM TOPIC] fs-verity: file system-level integrity protection
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Fri, 26 Jan 2018 13:13:40 -0500
In-Reply-To: <20180126145856.GA2841@thunk.org>
References: <20180125191152.GA11197@thunk.org>
         <1516927666.4082.25.camel@HansenPartnership.com>
         <20180126023054.GC31091@thunk.org>
         <1516942235.4082.52.camel@HansenPartnership.com>
         <20180126145856.GA2841@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516990420.29187.65.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[Cc'ing linux-integrity]

On Fri, 2018-01-26 at 09:58 -0500, Theodore Ts'o wrote:

> > 
> > Currently container images are simple tar files and one of the main
> > value adds of docker as a tool is the simplicity of the image creation
> > process.  That process depends on standard tools like tar to create the
> > image, so I was trying to fit this proposal into that process.
> 
> The goal of fs-verity is protect arbitrary files without breaking the
> backwards compatibility of those that *read* the file.  So for
> example, an APK file is downloaded and verified at the intial download
> --- and never verified again.  It is *used* many times after the
> initial download (and hence, potentially after an evil maid attack),
> and this is done by many different tools, including by code inside the
> APK itself.  So it is not feasible to change the tools that read the
> APK, which means we can't make any backwards-incompatible changes to
> the file itself.
> 
> However, changing the tools that *establish* the locally verified copy
> is considered completely fair game.  I'll note that this is true no
> matter what system you use.  If you are using IMA, after the file is
> downloaded, you still have to set the magic "trusted xattr" (which, I
> will note, requires root access since it is a trusted root access).
> So you have to make at least *some* changes to the code path which
> writes the file that you want to be integrity protected.  In the case
> of IMA, this includes code that has to run as root.

Different types of software packages (eg. tar, rpm, multiple deb
prototypes) can be built to include file signatures.  Both the file
data and metadata (eg. signatures) would be installed together by the
same app, which already has root privileges needed to install them.

Mimi
