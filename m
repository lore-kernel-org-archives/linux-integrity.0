Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbeJOJVg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Oct 2018 05:21:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9F1Y3hE134249
        for <linux-integrity@vger.kernel.org>; Sun, 14 Oct 2018 21:38:35 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n4fe7350v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 14 Oct 2018 21:38:35 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 15 Oct 2018 02:38:33 +0100
Subject: Re: [PATCH 2/3] IMA: Make use of filesystem-provided hashes
From: Mimi Zohar <zohar@linux.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date: Sun, 14 Oct 2018 21:38:17 -0400
In-Reply-To: <CACdnJuvrATdx2giEvddU38SMKp2oj1XjHqEbs88fuUOekHyDLw@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <20181004203007.217320-3-mjg59@google.com>
         <1539271386.11939.79.camel@linux.ibm.com>
         <CACdnJuvGp_3hs16kL1Vg9eXL4i=T=bXw9i5_7KTT0F+J4p9y4A@mail.gmail.com>
         <1539298987.11939.136.camel@linux.ibm.com>
         <CACdnJuvrATdx2giEvddU38SMKp2oj1XjHqEbs88fuUOekHyDLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539567497.11939.198.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-10-12 at 11:31 -0700, Matthew Garrett wrote:
> On Thu, Oct 11, 2018 at 4:03 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Thu, 2018-10-11 at 13:30 -0700, Matthew Garrett wrote:
> 
> > > Ok, should this just be part of the IMA policy?
> >
> > How would you be able to differentiate between different FUSE
> > filesystems for example?
> 
> There's a couple of ways. We could extend the filesystem type matching
> logic to also check the subtype - you'd then need to enforce that at
> the LSM level in order to protect against untrusted filesystems
> spoofing the filesystem type. Alternatively, we could add an
> additional policy match type for mount point and iterate through
> s_mounts on the superblock - if any match, we could define the policy
> there?

The first method differentiates between different subtypes of FUSE
filesystems, while the second method allows differentiating between
the same type and subtype on different mount points.  Both criteria
are needed, but instead of the second method based on a mount point,
perhaps based instead on a mount flag?

Trusted mount of permitted filesystem type and subtype, that is
mounted with the defined mount flag. 

Mimi
